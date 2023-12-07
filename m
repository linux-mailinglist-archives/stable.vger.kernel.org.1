Return-Path: <stable+bounces-4916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A710A8085AF
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2254AB21A6C
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4419447;
	Thu,  7 Dec 2023 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gnome.org header.i=@gnome.org header.b="liN2UGKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.gnome.org (smtp.gnome.org [8.43.85.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56173D57
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 02:38:35 -0800 (PST)
Received: from mail-lf1-f51.google.com (unknown [209.85.167.51])
	by smtp.gnome.org (Postfix) with ESMTPSA id 9FDEF2804FDF
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 10:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.gnome.org 9FDEF2804FDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gnome.org;
	s=default; t=1701945514;
	bh=G4U4HVSMVp/EH3yKTeNUgJY+ATui49lv7v4gkD2t6WU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=liN2UGKTWFcpbeOAnCAVG6QGDOQjjRNp7VucDsBfnxE3th+E93avyhlV42MMh80Iq
	 rzhoeD2WHEKPPmnvNf4ueO/Ss/KXc51Pu8KaXrlqYfTDtoc0S9FkL77GTJ/BN7ptNO
	 XhJ65j+s3YcdDidQkLINfONAn3804Meci3t08jL0=
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bffb64178so587013e87.2
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 02:38:33 -0800 (PST)
X-Gm-Message-State: AOJu0YzKoAkOS/sOTl5fqOibbbkVoIvqMyesagU8QFAN+NVcpw9v/Fzg
	obyUATGodcRtbLbMsMTxc3IQU0c5eL5tD7k6Nqc=
X-Google-Smtp-Source: AGHT+IFv2bc69xPJa1RO5Pi4mI3IImhqw9u3f6M413zY054vV0IMetM45X/cZyIx4QvAhbrA/XoPxv2Y6PuivKgnKZA=
X-Received: by 2002:ac2:5a59:0:b0:50c:18:4557 with SMTP id r25-20020ac25a59000000b0050c00184557mr1313644lfn.60.1701945511245;
 Thu, 07 Dec 2023 02:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com> <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
 <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com> <CAAd53p6py2YdvaJBAgve3y4Xf2sayC7LqDE-JeLpQ_LNtFOj1g@mail.gmail.com>
 <2c350488-0110-4b29-bdf3-b2018e723b5b@amd.com> <CAAd53p6WypOSURpcL=C9p2M5K4zai33pPhkSSa_EWvSf0QV-1A@mail.gmail.com>
 <CAGBH1r7Tn7vHbUeL4R1hBj-65yD+JWMho52nJ2WfK2R=9jhi0A@mail.gmail.com>
In-Reply-To: <CAGBH1r7Tn7vHbUeL4R1hBj-65yD+JWMho52nJ2WfK2R=9jhi0A@mail.gmail.com>
From: Bin Li <binli@gnome.org>
Date: Thu, 7 Dec 2023 18:38:18 +0800
X-Gmail-Original-Message-ID: <CAGBH1r6Y7cbNTw=Vekcq_iJOJ1Rmt2-Ot6=-WygXZb5kuzioSA@mail.gmail.com>
Message-ID: <CAGBH1r6Y7cbNTw=Vekcq_iJOJ1Rmt2-Ot6=-WygXZb5kuzioSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is enabled
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>, 
	Wenjing Liu <wenjing.liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Taimur Hassan <syed.hassan@amd.com>, stable@vger.kernel.org, 
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

 It's a false alarm from my side, after testing the 6.1.0-oem and
6.5.0-oem kernels, this patch works perfectly fine, sorry about that.

On Thu, Dec 7, 2023 at 3:47=E2=80=AFPM Bin Li <binli@gnome.org> wrote:
>
> Hi Mario,
>
> I found I missed the part in drivers/gpu/drm/amd/display/dc/hwss/dcn10/dc=
n10_hwseq.c with kai.heng's review.
> I will rebuild a new kernel and test it again, and reply later, sorry abo=
ut that.
>
>
>
> On Thu, Dec 7, 2023 at 2:58=E2=80=AFPM Kai-Heng Feng <kai.heng.feng@canon=
ical.com> wrote:
>>
>> On Thu, Dec 7, 2023 at 10:10=E2=80=AFAM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>> >
>> > On 12/6/2023 20:07, Kai-Heng Feng wrote:
>> > > On Thu, Dec 7, 2023 at 9:57=E2=80=AFAM Mario Limonciello
>> > > <mario.limonciello@amd.com> wrote:
>> > >>
>> > >> On 12/6/2023 19:23, Kai-Heng Feng wrote:
>> > >>> On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Mario Limonciello
>> > >>> <mario.limonciello@amd.com> wrote:
>> > >>>>
>> > >>>> On 12/5/2023 14:17, Hamza Mahfooz wrote:
>> > >>>>> We currently don't support dirty rectangles on hardware rotated =
modes.
>> > >>>>> So, if a user is using hardware rotated modes with PSR-SU enable=
d,
>> > >>>>> use PSR-SU FFU for all rotated planes (including cursor planes).
>> > >>>>>
>> > >>>>
>> > >>>> Here is the email for the original reporter to give an attributio=
n tag.
>> > >>>>
>> > >>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> > >>>
>> > >>> For this particular issue,
>> > >>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> > >>
>> > >> Can you confirm what kernel base you tested issue against?
>> > >>
>> > >> I ask because Bin Li (+CC) also tested it against 6.1 based LTS ker=
nel
>> > >> but ran into problems.
>> > >
>> > > The patch was tested against ADSN.
>> > >
>> > >>
>> > >> I wonder if it's because of other dependency patches.  If that's th=
e
>> > >> case it would be good to call them out in the Cc: @stable as
>> > >> dependencies so when Greg or Sasha backport this 6.1 doesn't get br=
oken.
>> > >
>> > > Probably. I haven't really tested any older kernel series.
>> >
>> > Since you've got a good environment to test it and reproduce it would
>> > you mind double checking it against 6.7-rc, 6.5 and 6.1 trees?  If we
>> > don't have confidence it works on the older trees I think we'll need t=
o
>> > drop the stable tag.
>>
>> Not seeing issues here when the patch is applied against 6.5 and 6.1
>> (which needs to resolve a minor conflict).
>>
>> I am not sure what happened for Bin's case.
>>
>> Kai-Heng
>>
>> > >
>> > > Kai-Heng
>> > >
>> > >>
>> > >> Bin,
>> > >>
>> > >> Could you run ./scripts/decode_stacktrace.sh on your kernel trace t=
o
>> > >> give us a specific line number on the issue you hit?
>> > >>
>> > >> Thanks!
>> > >>>
>> > >>>>
>> > >>>>> Cc: stable@vger.kernel.org
>> > >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
>> > >>>>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS suppo=
rt")
>> > >>>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> > >>>>> ---
>> > >>>>>     drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++=
++
>> > >>>>>     drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>> > >>>>>     drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++=
++++++++--
>> > >>>>>     .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++=
-
>> > >>>>>     4 files changed, 17 insertions(+), 3 deletions(-)
>> > >>>>>
>> > >>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > >>>>> index c146dc9cba92..79f8102d2601 100644
>> > >>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > >>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > >>>>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm=
_plane *plane,
>> > >>>>>         bool bb_changed;
>> > >>>>>         bool fb_changed;
>> > >>>>>         u32 i =3D 0;
>> > >>>>> +
>> > >>>>
>> > >>>> Looks like a spurious newline here.
>> > >>>>
>> > >>>>>         *dirty_regions_changed =3D false;
>> > >>>>>
>> > >>>>>         /*
>> > >>>>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm=
_plane *plane,
>> > >>>>>         if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
>> > >>>>>                 return;
>> > >>>>>
>> > >>>>> +     if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0)
>> > >>>>> +             goto ffu;
>> > >>>>> +
>> > >>>>
>> > >>>> I noticed that the original report was specifically on 180=C2=B0.=
  Since
>> > >>>> you're also covering 90=C2=B0 and 270=C2=B0 with this check it so=
unds like it's
>> > >>>> actually problematic on those too?
>> > >>>
>> > >>> 90 & 270 are problematic too. But from what I observed the issue i=
s
>> > >>> much more than just cursors.
>> > >>
>> > >> Got it; thanks.
>> > >>
>> > >>>
>> > >>> Kai-Heng
>> > >>>
>> > >>>>
>> > >>>>>         num_clips =3D drm_plane_get_damage_clips_count(new_plane=
_state);
>> > >>>>>         clips =3D drm_plane_get_damage_clips(new_plane_state);
>> > >>>>>
>> > >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/driv=
ers/gpu/drm/amd/display/dc/dc_hw_types.h
>> > >>>>> index 9649934ea186..e2a3aa8812df 100644
>> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>> > >>>>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>> > >>>>>         struct fixed31_32 v_scale_ratio;
>> > >>>>>         enum dc_rotation_angle rotation;
>> > >>>>>         bool mirror;
>> > >>>>> +     struct dc_stream_state *stream;
>> > >>>>>     };
>> > >>>>>
>> > >>>>>     /* IPP related types */
>> > >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b=
/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> > >>>>> index 139cf31d2e45..89c3bf0fe0c9 100644
>> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> > >>>>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>> > >>>>>         if (src_y_offset < 0)
>> > >>>>>                 src_y_offset =3D 0;
>> > >>>>>         /* Save necessary cursor info x, y position. w, h is sav=
ed in attribute func. */
>> > >>>>> -     hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
>> > >>>>> -     hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
>> > >>>>> +     if (param->stream->link->psr_settings.psr_version >=3D DC_=
PSR_VERSION_SU_1 &&
>> > >>>>> +         param->rotation !=3D ROTATION_ANGLE_0) {
>> > >>>>
>> > >>>> Ditto on above about 90=C2=B0 and 270=C2=B0.
>> > >>>>
>> > >>>>> +             hubp->cur_rect.x =3D 0;
>> > >>>>> +             hubp->cur_rect.y =3D 0;
>> > >>>>> +             hubp->cur_rect.w =3D param->stream->timing.h_addre=
ssable;
>> > >>>>> +             hubp->cur_rect.h =3D param->stream->timing.v_addre=
ssable;
>> > >>>>> +     } else {
>> > >>>>> +             hubp->cur_rect.x =3D src_x_offset + param->viewpor=
t.x;
>> > >>>>> +             hubp->cur_rect.y =3D src_y_offset + param->viewpor=
t.y;
>> > >>>>> +     }
>> > >>>>>     }
>> > >>>>>
>> > >>>>>     void hubp2_clk_cntl(struct hubp *hubp, bool enable)
>> > >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hws=
eq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> > >>>>> index 2b8b8366538e..ce5613a76267 100644
>> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> > >>>>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe=
_ctx *pipe_ctx)
>> > >>>>>                 .h_scale_ratio =3D pipe_ctx->plane_res.scl_data.=
ratios.horz,
>> > >>>>>                 .v_scale_ratio =3D pipe_ctx->plane_res.scl_data.=
ratios.vert,
>> > >>>>>                 .rotation =3D pipe_ctx->plane_state->rotation,
>> > >>>>> -             .mirror =3D pipe_ctx->plane_state->horizontal_mirr=
or
>> > >>>>> +             .mirror =3D pipe_ctx->plane_state->horizontal_mirr=
or,
>> > >>>>> +             .stream =3D pipe_ctx->stream
>> > >>>>
>> > >>>> As a nit; I think it's worth leaving a harmless trailing ',' so t=
hat
>> > >>>> there is less ping pong in the future when adding new members to =
a struct.
>> > >>>>
>> > >>>>>         };
>> > >>>>>         bool pipe_split_on =3D false;
>> > >>>>>         bool odm_combine_on =3D (pipe_ctx->next_odm_pipe !=3D NU=
LL) ||
>> > >>>>
>> > >>>>
>> > >>
>> >

