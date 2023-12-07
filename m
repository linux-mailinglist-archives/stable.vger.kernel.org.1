Return-Path: <stable+bounces-4892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF55E807E31
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 03:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4D1F2194D
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D615C6;
	Thu,  7 Dec 2023 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tDCuB+Xp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C503C3
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 18:07:17 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C19E73FB5A
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701914834;
	bh=GXVe83Eb6PgMMxjnAdXPh0kjvl3Ev6LqUpbHc+MtMog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tDCuB+XpWvhmNs0TFp2lQtgIRrS+DInL8t05MNjUAITjFLCbD2EWI7HdIl+Qa8bS+
	 KGrLjKOVLs+X4pUk6x1wmlAsJu74mI9Jvhvt9wJoTLxJWzETkxJjgIclmVjxYu95Wk
	 3S30z0xOa+e9tKIiS28apBW6TvMTLPydv/sjhsKGpBzVsQWYLYbdWcN8NmjYo5tUgc
	 Ym0FmQcwSRsJUwGT4K27HW8jKwL0Q9/FpmctN5DY3SRo3jhTa+UcNZ81UrTBgL5qk6
	 UA3q4KgWMVCa+DPL9T06ee52oCy29cZxaW1Uxr4j6pLpHhRwLUZ0YPauWT/8RL/FMP
	 sGHtDrbi5OpqQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-286ef430ddfso468793a91.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 18:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701914833; x=1702519633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXVe83Eb6PgMMxjnAdXPh0kjvl3Ev6LqUpbHc+MtMog=;
        b=TUOKGVBFP7RnmxwGQHUEZRLeirTPy8Q1Kjs0z0g1FKq/Bajklo14YZYPTuP0EiYMoU
         GjKhokdcA431ogF4Eg4f4fK4COYJWthGiOInYtmTsM3FyGuPkwqawG/uVeSavb1R3YxS
         fHhTHTO88Uu6ItdKJinTG5V8lThvSTN6pT0A30XHCw+RVqhYVzT3fh8n07B3CTupwgsi
         RcDc4/qAbxdvRVc5IVktTBnDP4fqUbam9iWfchMpgRFTs7QyuvYN4bxy02qPeQxpksco
         PcaQ1UCnVU7IMZZPPDsSVF1qyVG82D9qRuPKnOQKyL+xbnEJ5qICSrvXAzkKMyxUpCXG
         Qb3Q==
X-Gm-Message-State: AOJu0YwZHDc4CMenzX+WNj/1hlQe4E1jv4EBZZyFA46Gyadc1/gwuLdM
	0OTRjzUCn2nidEBLMY+ozgpFHokxGdKtwsuAVQl8wlom21gnJMZniRM52z+IMS6qCAutYhN0Sve
	N3Dkir1+SqcmJSa3VStCDGogB5yCJU+jwnWfnZERhEmlq4/hiTNcRk0YUKg==
X-Received: by 2002:a17:90a:dc13:b0:286:6cc0:b910 with SMTP id i19-20020a17090adc1300b002866cc0b910mr1416170pjv.71.1701914833269;
        Wed, 06 Dec 2023 18:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHMupK6UEA4tuVrRDNWRzHU+im5OzP439vdfc90dl1VrrqatGHa/ergaVv3akVQ2pqkw4ogKHbSvlEErL4MmQ=
X-Received: by 2002:a17:90a:dc13:b0:286:6cc0:b910 with SMTP id
 i19-20020a17090adc1300b002866cc0b910mr1416155pjv.71.1701914832859; Wed, 06
 Dec 2023 18:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com> <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
 <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com>
In-Reply-To: <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Dec 2023 10:07:01 +0800
Message-ID: <CAAd53p6py2YdvaJBAgve3y4Xf2sayC7LqDE-JeLpQ_LNtFOj1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: binli@gnome.org, Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org, 
	Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Taimur Hassan <syed.hassan@amd.com>, stable@vger.kernel.org, 
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:57=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/6/2023 19:23, Kai-Heng Feng wrote:
> > On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 12/5/2023 14:17, Hamza Mahfooz wrote:
> >>> We currently don't support dirty rectangles on hardware rotated modes=
.
> >>> So, if a user is using hardware rotated modes with PSR-SU enabled,
> >>> use PSR-SU FFU for all rotated planes (including cursor planes).
> >>>
> >>
> >> Here is the email for the original reporter to give an attribution tag=
.
> >>
> >> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > For this particular issue,
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Can you confirm what kernel base you tested issue against?
>
> I ask because Bin Li (+CC) also tested it against 6.1 based LTS kernel
> but ran into problems.

The patch was tested against ADSN.

>
> I wonder if it's because of other dependency patches.  If that's the
> case it would be good to call them out in the Cc: @stable as
> dependencies so when Greg or Sasha backport this 6.1 doesn't get broken.

Probably. I haven't really tested any older kernel series.

Kai-Heng

>
> Bin,
>
> Could you run ./scripts/decode_stacktrace.sh on your kernel trace to
> give us a specific line number on the issue you hit?
>
> Thanks!
> >
> >>
> >>> Cc: stable@vger.kernel.org
> >>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
> >>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
> >>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
> >>>    drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
> >>>    drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++=
++--
> >>>    .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
> >>>    4 files changed, 17 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> index c146dc9cba92..79f8102d2601 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plan=
e *plane,
> >>>        bool bb_changed;
> >>>        bool fb_changed;
> >>>        u32 i =3D 0;
> >>> +
> >>
> >> Looks like a spurious newline here.
> >>
> >>>        *dirty_regions_changed =3D false;
> >>>
> >>>        /*
> >>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plan=
e *plane,
> >>>        if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> >>>                return;
> >>>
> >>> +     if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0)
> >>> +             goto ffu;
> >>> +
> >>
> >> I noticed that the original report was specifically on 180=C2=B0.  Sin=
ce
> >> you're also covering 90=C2=B0 and 270=C2=B0 with this check it sounds =
like it's
> >> actually problematic on those too?
> >
> > 90 & 270 are problematic too. But from what I observed the issue is
> > much more than just cursors.
>
> Got it; thanks.
>
> >
> > Kai-Heng
> >
> >>
> >>>        num_clips =3D drm_plane_get_damage_clips_count(new_plane_state=
);
> >>>        clips =3D drm_plane_get_damage_clips(new_plane_state);
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/g=
pu/drm/amd/display/dc/dc_hw_types.h
> >>> index 9649934ea186..e2a3aa8812df 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> >>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
> >>>        struct fixed31_32 v_scale_ratio;
> >>>        enum dc_rotation_angle rotation;
> >>>        bool mirror;
> >>> +     struct dc_stream_state *stream;
> >>>    };
> >>>
> >>>    /* IPP related types */
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> >>> index 139cf31d2e45..89c3bf0fe0c9 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> >>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
> >>>        if (src_y_offset < 0)
> >>>                src_y_offset =3D 0;
> >>>        /* Save necessary cursor info x, y position. w, h is saved in =
attribute func. */
> >>> -     hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
> >>> -     hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
> >>> +     if (param->stream->link->psr_settings.psr_version >=3D DC_PSR_V=
ERSION_SU_1 &&
> >>> +         param->rotation !=3D ROTATION_ANGLE_0) {
> >>
> >> Ditto on above about 90=C2=B0 and 270=C2=B0.
> >>
> >>> +             hubp->cur_rect.x =3D 0;
> >>> +             hubp->cur_rect.y =3D 0;
> >>> +             hubp->cur_rect.w =3D param->stream->timing.h_addressabl=
e;
> >>> +             hubp->cur_rect.h =3D param->stream->timing.v_addressabl=
e;
> >>> +     } else {
> >>> +             hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
> >>> +             hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
> >>> +     }
> >>>    }
> >>>
> >>>    void hubp2_clk_cntl(struct hubp *hubp, bool enable)
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c =
b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> >>> index 2b8b8366538e..ce5613a76267 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> >>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx =
*pipe_ctx)
> >>>                .h_scale_ratio =3D pipe_ctx->plane_res.scl_data.ratios=
.horz,
> >>>                .v_scale_ratio =3D pipe_ctx->plane_res.scl_data.ratios=
.vert,
> >>>                .rotation =3D pipe_ctx->plane_state->rotation,
> >>> -             .mirror =3D pipe_ctx->plane_state->horizontal_mirror
> >>> +             .mirror =3D pipe_ctx->plane_state->horizontal_mirror,
> >>> +             .stream =3D pipe_ctx->stream
> >>
> >> As a nit; I think it's worth leaving a harmless trailing ',' so that
> >> there is less ping pong in the future when adding new members to a str=
uct.
> >>
> >>>        };
> >>>        bool pipe_split_on =3D false;
> >>>        bool odm_combine_on =3D (pipe_ctx->next_odm_pipe !=3D NULL) ||
> >>
> >>
>

