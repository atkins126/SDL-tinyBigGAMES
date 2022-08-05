{==============================================================================
   _____  _____   __
  / ____||  __ \ | |
 | (___  | |  | || |
  \___ \ | |  | || |
  ____) || |__| || |____
 |_____/ |_____/ |______|
 Simple DirectMedia Layer
       for Delphi

 Includes:
   SDL
   SDL_image
   SDL_mixer
   SDL_net
   SDL_ttf

Delphi Header Conversion

Copyright © 2022 tinyBigGAMES™ LLC
All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software in
   a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

2. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

3. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in
   the documentation and/or other materials provided with the
   distribution.

4. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

5. All video, audio, graphics and other content accessed through the
   software in this distro is the property of the applicable content owner
   and may be protected by applicable copyright law. This License gives
   Customer no rights to such content, and Company disclaims any liability
   for misuse of content.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
============================================================================= }

unit uExample;

interface

uses
  SDL,
  uCommon;

type
  { TExample }
  TExample = class
  protected
    FWindow: PSDL_Window;
    FScreenSurface: PSDL_Surface;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Pause; virtual;
    function Startup: Boolean; virtual;
    procedure Shutdown; virtual;
    procedure Render; virtual;
    procedure Update(aDeltaTime: Double); virtual;
    procedure Run; virtual;

  end;

// Routines
procedure RunExample;

implementation

// Routines
procedure RunExample;
var
  LExample: TExample;
begin
  LExample := TExample.Create;
  try
    LExample.Run;
  finally
    LExample.Free;
  end;
end;

{ TExample }
constructor TExample.Create;
begin
  inherited;
end;

destructor TExample.Destroy;
begin
  inherited;
end;

procedure TExample.Pause;
begin
  WriteLn;
  Write('Press ENTER to continue...');
  ReadLn;
end;

function TExample.Startup: Boolean;
begin
  Result := False;

  // init SDL
  if SDL_Init(SDL_INIT_VIDEO) < 0 then
  begin
    WriteLn('SDL init error: ', SDL_GetError);
    Exit;
  end;

  // create window
  FWindow := SDL_CreateWindow('SDL Tutorial', SDL_WINDOWPOS_UNDEFINED,
    SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
  if FWindow = nil then
  begin
    WriteLn('Window creation error: ', SDL_GetError);
    Exit;
  end;

  // get screen surface
  FScreenSurface := SDL_GetWindowSurface(FWindow);

  Result := True;
end;

procedure TExample.Shutdown;
begin
  // destroy window
  if FWindow <> nil then
    SDL_DestroyWindow(FWindow);

  // quit SDL
  SDL_Quit;
end;

procedure TExample.Update(aDeltaTime: Double);
begin
end;

procedure TExample.Render;
begin
  // fill surface white
  SDL_FillRect(FScreenSurface, nil, SDL_MapRGB(FScreenSurface.format, 255, 255, 255));

  // update surface
  SDL_UpdateWindowSurface(FWindow);

  // wait 2 seconds
  SDL_Delay(2000);
end;

procedure TExample.Run;
begin
  // Startup
  if Startup then
  begin
    // update
    Update(0);

    // render
    Render;

    // shutdown
    Shutdown;
  end;

  // pause
  Pause;
end;



end.
