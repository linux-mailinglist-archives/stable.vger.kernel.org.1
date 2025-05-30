Return-Path: <stable+bounces-148328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D263EAC9670
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14374A426C8
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACB25228E;
	Fri, 30 May 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewxXCnek"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D901465A1
	for <stable@vger.kernel.org>; Fri, 30 May 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748636063; cv=none; b=DGhPe4tG/gNCkUuh/2RRDduShMX5YRfk6J6RBj10zvgVbapZHcTUOJgS6UBX6pSVP9ThsdZzjn8nDmNpOdzu1wHsR4bopFC3TFFW8EYCkBbceg1LGucq9Ypwyg/y+4V9/Nq57mBv0yq+d3BmqpmcVqcB5pEZ6Hl9EHgihRz3ZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748636063; c=relaxed/simple;
	bh=Q5QPnKuN+HERGfE3scoPkPcKr5ZcZE9tdrA4e66T378=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4sRQTvyXjUB/czduyQL2E8IEYxZMaX+a8/mz2OhsyR0lPVxuizhjXjqlAQ3yzNRNRFSyIvyQUtMv4dgLCc92imaLvOoThiOWQSRgVs/YTuEImV0Z7nMMgY7I7Jwn3k2Mvzc4gRYZgrMzskkXKADKJEu3UGlLrrHVkNU4SniE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewxXCnek; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3120dd42103so226094a91.0
        for <stable@vger.kernel.org>; Fri, 30 May 2025 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748636061; x=1749240861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM+lnhBUmkTObnK2FAz+OEfOPps59EVDPM3etw76l6g=;
        b=ewxXCnekyKluPhOEcunCbpi6t9kZw/x9qlhUDQX9SbVCsbAJatzICdQTlRjKcucLP7
         0R58layL9WTC7LMfHmdOb6U9jk/cob40cQLOq9fpO7GNhDhNca2K1dSd9Z5kU0x9MC9g
         590YoWdTTx0oBLdHWc2995BEaTw/AaV7ee55lJeBrYpwXOYz/AGRQL5hrjM+7L62rJAF
         c9YtG78xL7sNoGThBbYUC6KnvAkLXqr3nf7qTqc8zsNG35Kn05EL/DuqTqu3QgYjFXPn
         XuRNesK9WmsnuS7PrS7djAxTalACvZJcNKdcffU3YLWEzwtZbMqjHkGJZDwoS61uLmG9
         ChEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748636061; x=1749240861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM+lnhBUmkTObnK2FAz+OEfOPps59EVDPM3etw76l6g=;
        b=YtCXk0Lwk1JcIg7U50P1B1jggCgLhWfqxS+PdzjRdNdEsa1aq1jJY08kQ5KXMTZAnZ
         aRsKCkpCsx/FnB5/nR3QGSK13nZjqM6aD+/zzZxR7mp7ynPb3ItkVP30raU71UveDMr2
         zjY79kttCW8/0q7CHqW1PlG2PLXe43tyjop0zEKq8PEcd68z+6EHkZnHPAgpwkIq+CyT
         IxU/V1yW7/hDdl7oQKrKadXmvKj9hPzxKHGmfp23FPwk27UNVgjZUC4Ax/mZC1rL3eFr
         idqUYOv+S++aZAV5xDjrB7zyVCm7cG67hA+odt/1I68i+EPdhTwe1auxxM0bEAfuwJmJ
         Efzw==
X-Gm-Message-State: AOJu0Yyg/4RybuLB1g0U/HY7y8kil8iL8WJfbckcUcO5wTdvfnIpWf7k
	2Dv9/SX8Az1eaI78bCxiebVjmEaOyrErn2EN2ksuntsbUfo4ayN9BdjKfjgRRznEGSQLSy06e53
	gC8iZunlxM+9pP6Px6enx4mJS6GkxGmY=
X-Gm-Gg: ASbGnctZn890oJ2HIGpmggn4ya9tUoBmkdd85aplejvFtp5EyIdMpEJMxiUzpuZD7rp
	luERnMc4RKVo7UvmuoL6aQEtrnEXiFHmR5EXg+dxPF4yAt1LmO1GOYQcNUUnMuQbzADSAvJawwq
	wFeifVTxY5Sb+zs2QgxA8GZofYWnJim54TOohVkjuiInoF
X-Google-Smtp-Source: AGHT+IHYOzTch/LhUjwqhA6V26SWYmzQQkTjGcxttIP/GnJvdvVhh9DW5rsvZWzVJL+zEo1yTPPs6I85/PMQ4Qz3e3g=
X-Received: by 2002:a17:90b:1a8f:b0:312:1dc9:9f5c with SMTP id
 98e67ed59e1d1-3124db0a69dmr1980577a91.4.1748636061507; Fri, 30 May 2025
 13:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250530200918.391912-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 16:14:09 -0400
X-Gm-Features: AX0GCFtFEO4nUgx_pfrPfpjaUBoi_k0QrFNUcbi51QSLFivPeJ67aUzFT2U8PrA
Message-ID: <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 4:09=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
> causes regressions on certain configs. Revert until the issue can be
> isolated and debugged.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Already included in my -fixes PR for this week:
https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.html

Alex

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 90889f6867aad..9f2e26336cccf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -676,21 +676,15 @@ static void dm_crtc_high_irq(void *interrupt_params=
)
>         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>
>         if (acrtc->dm_irq_params.stream &&
> -               acrtc->dm_irq_params.vrr_params.supported) {
> -               bool replay_en =3D acrtc->dm_irq_params.stream->link->rep=
lay_settings.replay_feature_enabled;
> -               bool psr_en =3D acrtc->dm_irq_params.stream->link->psr_se=
ttings.psr_feature_enabled;
> -               bool fs_active_var_en =3D acrtc->dm_irq_params.freesync_c=
onfig.state =3D=3D VRR_STATE_ACTIVE_VARIABLE;
> -
> +           acrtc->dm_irq_params.vrr_params.supported &&
> +           acrtc->dm_irq_params.freesync_config.state =3D=3D
> +                   VRR_STATE_ACTIVE_VARIABLE) {
>                 mod_freesync_handle_v_update(adev->dm.freesync_module,
>                                              acrtc->dm_irq_params.stream,
>                                              &acrtc->dm_irq_params.vrr_pa=
rams);
>
> -               /* update vmin_vmax only if freesync is enabled, or only =
if PSR and REPLAY are disabled */
> -               if (fs_active_var_en || (!fs_active_var_en && !replay_en =
&& !psr_en)) {
> -                       dc_stream_adjust_vmin_vmax(adev->dm.dc,
> -                                       acrtc->dm_irq_params.stream,
> -                                       &acrtc->dm_irq_params.vrr_params.=
adjust);
> -               }
> +               dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_par=
ams.stream,
> +                                          &acrtc->dm_irq_params.vrr_para=
ms.adjust);
>         }
>
>         /*
> --
> 2.49.0
>

