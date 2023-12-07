Return-Path: <stable+bounces-4950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63880915F
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DB628176F
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD674F8A0;
	Thu,  7 Dec 2023 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgk/cEK1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83D10DC
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 11:30:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so1724171a12.3
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977425; x=1702582225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q48OiF/lVPVtmeNyCTqSSEKXn8DDTHHhml+BMoIRLy8=;
        b=Dgk/cEK1TXYF+w2KsBBV5+aOMN77z7dcaeJ/IGZfR2bo1PBp3KlLbtxo3VO/T1rEV3
         6Y86vkl2Jh1RY4M6N/raD1A5+m/bXwi8BE1A77bLVvpTqA12G55ZhXlB/7HwL3yEsUmz
         kEBMyv8K9EdDCSlqRV1V141AgMQ/IiFc9oe84abUDmx74bcmqlVslB3KigXHLRR2Q5wj
         OyYAzNr7tcmat2BaUXe00350rs4LQXhu2tAd5HqY3yer+c6mF1F/U2Sqr4FQnpOH5366
         YdW9EcjqswwxunNx/zR/QIgAlbLcdvRHrqHR1l3A6PNWLHPeGeINk8vQ3vAJLCuG9D4o
         WZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977425; x=1702582225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q48OiF/lVPVtmeNyCTqSSEKXn8DDTHHhml+BMoIRLy8=;
        b=Gtg2GnAYzwCxZLbTl1sfgvZnyReQjvrgDB/v0i6e7gbdfOwy1LNCu+RoNUisl2z+06
         HgS49si8cdbatI/tGnWnqMIg35/YuTbIKVaV84djPFY4kmAbaCArBuM2a5LXirVptYXU
         LuY1WCGWdQGdrprg22PkF5ozEEImOTWg3QvVwPWEVvkq2VwPapA078rKOynKM8FcPwuX
         E/yBGDL2Nk+1JUOjpeoiOKy5leR2zgpPWma4pIrZcod4lBuc6qhtWDwTXcOzE98/cX24
         7JzZeYKmedyvBupWfEzNdWQcyV8ivT6/wCs/vmoQoQpHvjJwFwMHzhjP3CR6+K19xzwT
         cJKA==
X-Gm-Message-State: AOJu0YzUzcLgg3wySWrDDXs6pif0d1G3TY71B2Ipil750V8eWRQZEMRz
	JExvZOFPy/ZaFmB60E+ff/7vo9YXMDwFhIxvT6M=
X-Google-Smtp-Source: AGHT+IFO2W/Tsba8mLbIR2TuZGFSrj7b1RB5EaDc4fZr14vH2kCpyGnEl8oaH8gZrPquoIIdjmOZr3Aq4DR6s8a1X10=
X-Received: by 2002:a17:906:fb05:b0:a19:a19b:c736 with SMTP id
 lz5-20020a170906fb0500b00a19a19bc736mr1781633ejb.134.1701977425265; Thu, 07
 Dec 2023 11:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207182532.19416-1-xaver.hugl@gmail.com>
In-Reply-To: <20231207182532.19416-1-xaver.hugl@gmail.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Thu, 7 Dec 2023 20:30:13 +0100
Message-ID: <CAFZQkGzOn9L+qmDm=_0kBrkX1H0obqYsjpyuOzMuO8xS1Bm1GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix cursor-plane-only atomic commits not
 triggering pageflips
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, it looks like I sent this too soon. I tested the patch on a
second PC and it doesn't fix the issue there.


Am Do., 7. Dez. 2023 um 19:25 Uhr schrieb Xaver Hugl <xaver.hugl@gmail.com>:
>
> With VRR, every atomic commit affecting a given display must trigger
> a new scanout cycle, so that userspace is able to control the refresh
> rate of the display. Before this commit, this was not the case for
> atomic commits that only contain cursor plane properties.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Xaver Hugl <xaver.hugl@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b452796fc6d3..b379c859fbef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8149,9 +8149,15 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>                 /* Cursor plane is handled after stream updates */
>                 if (plane->type == DRM_PLANE_TYPE_CURSOR) {
>                         if ((fb && crtc == pcrtc) ||
> -                           (old_plane_state->fb && old_plane_state->crtc == pcrtc))
> +                           (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
>                                 cursor_update = true;
> -
> +                               /*
> +                                * With atomic modesetting, cursor changes must
> +                                * also trigger a new refresh period with vrr
> +                                */
> +                               if (!state->legacy_cursor_update)
> +                                       pflip_present = true;
> +                       }
>                         continue;
>                 }
>
> --
> 2.43.0
>

