Return-Path: <stable+bounces-177867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2760B460F4
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163467B4CB8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66B2441A6;
	Fri,  5 Sep 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPPsyX7a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC03191DB
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094608; cv=none; b=s6zoBXd2TfyU3mCTtBayMZngZ3SyDyE6KwPZvsLz3lr8L11JjyyONyCKBcIlOzX/pV8mdJy1Mg7h1zCiGReOZAbw+3bZ0P/ayvxifZHETpwk4q2efDtMUoWvUu4v9hWQBN1/xnWPzQW3iTLN6gce7NHLSuT13OEcsfwG9PGOvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094608; c=relaxed/simple;
	bh=NEmuKua+ugeJQ99/VgAJfq4YU7FdKP7XO1jnLQfVDlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDOjq0KYTQnCbn9C9JExZMMQcC8lZ/TsE2vrYyRmoSGCRbWpuhPZkCzIABME4TXoST7U1uuPxq0yAfhpadB25Cc09EHZ0KwolZmO1c04pctn5aIYD5coINh8s81wSdsgiJXZYhBQmkwbY53Iq8PZnG/z4gd6U/XooCm6/wXk0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPPsyX7a; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ba1f9c87cso155304a91.0
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094606; x=1757699406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n00++ovb71M2DutWQ0Xw6FbHb91Ug7y+etWz6FrIF4E=;
        b=dPPsyX7aCUONJfPaIZs5/jXkJFxJ7mo8ji1yzsfwJClV0wBFP93+hN3JS4vajVVSCg
         JbKnVkUJa3fzcvPvLaj26ZM9WtRF5bLyBKF6r2mr72q10hujQrUTcgE9ItxtQDPOhr0+
         BJwL2JcdXFog/ewQNxKTy3yN06k3IyAoBF6a6SuYNQcA4PDjxx2Y0JGYMHK1U0cxP1Ww
         eg5AK/ocO8RLbhh3oPBNOGiyqgDGvMRkrcJq021XiPvILrfZKr3TbUcOITtXG9hcQCo3
         kmUl/rpQ/NVLOdlVA9fltSlcg5svTqkwv9XWOW+JIzbTnUQjYz22Qg5cvVMsQLUJDuul
         FjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094606; x=1757699406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n00++ovb71M2DutWQ0Xw6FbHb91Ug7y+etWz6FrIF4E=;
        b=vxTXxNz1jz/mDcdDKKrJ61u97N2608WuFoOhCWcwLVDuEqCYXU6IGbE2CKzx5/Wj2p
         S68s0N39QUuhGLa04ZHTs8AwJ+EtCOwEv/tF8e9Q7KczGdf96xuZHZgtJSQNdWq/TK6r
         ckyMgfWR2Cmp83uJElnAOte37yt44imT48o8g08Wm7g+MRJG3ZWXSnFL1xf3MmqOj6QF
         l2Au8rpDIiongXBUovFcWvGuZQKhskBDT7CDDxxr34ErXVy3wsmmPBLQh/8LUmzaaIbh
         Yxu6fXskWW+H0VK/Y/HoWFRkyD99TCkJFaLpzeyAnpiHjJDNxOz5dzac16Srb0p9TcBA
         sgRg==
X-Forwarded-Encrypted: i=1; AJvYcCV7kqzMo7vmYHsxzFSUm204ubL8uED2ExmLauB/rNPLFcQVV8dvOIH2b2ZIRkfZfT/6OjLvkzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/r1oZLBvaZ5ye2GbzLpNjke+GBOTsPcEp6dWVE7mL+p/kEskl
	IIlkS4TeQ2qXnRYrMwzoYWZfBl0YUmh8tUny6x9KG8dMAnpBNCLgBJteoPXNwWUAuNLc+3wtvK5
	2ch2RAMy2TphOjSAc5k+cyawfcKZ1hV0=
X-Gm-Gg: ASbGnctR6Q6VY4g6/cExFYuW6Y/m9tDp7st/anCUtlgKxdjwfKDfYm4cpF3PE4wS2MC
	nq5VLMwhqU19auxcLTPOP4SPE3keK0IEtPYMflNs22sCh+gwm+4eyFyJ0WMXG4KIHTEPPNMLj27
	LU4NzY8PJM1xHR9PaLUC0vBP56sT0JFy8WNtH2i4bWHV5INHMPudYWeseXWEIRX2I3NDDbGXdVZ
	Wo2MdkVPORzAJQxpw==
X-Google-Smtp-Source: AGHT+IGDUKR6dY8wwS5BDPdNyjhlLyHMa+vdj1VVCCzIMiDy/WxAxC43PXmjuk7TW5KL1F0j9H/rg3+AqqR3hdXUIhI=
X-Received: by 2002:a17:90b:4a52:b0:32b:92d7:5cb2 with SMTP id
 98e67ed59e1d1-32b92d75f3cmr5550209a91.1.1757094606346; Fri, 05 Sep 2025
 10:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905174118.3493029-1-mario.limonciello@amd.com>
In-Reply-To: <20250905174118.3493029-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 13:49:54 -0400
X-Gm-Features: Ac12FXz4FOdXxfQy80sm3TMmCgXpeLKP8-ppcmFDOgaVwEtbtdIQWNL9IbwYkdw
Message-ID: <CADnq5_POMonCMXc43eJXOuAvJX1B_h-dVG5xpJCGrYKKa++Pkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop dm_prepare_suspend() and dm_complete()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
	=?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>, 
	Kalvin <hikaph+oss@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello" <mario.limonciello@amd.com>
>
> [Why]
> dm_prepare_suspend() was added in commit 50e0bae34fa6b
> ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
> to allow display to turn off earlier in the suspend sequence.
>
> This caused a regression that HDMI audio sometimes didn't work
> properly after resume unless audio was playing during suspend.
>
> [How]
> Drop dm_prepare_suspend() callback. All code in it will still run
> during dm_suspend(). Also drop unnecessary dm_complete() callback.
> dm_complete() was used for failed prepare and also for any case
> of successful resume.  The code in it already runs in dm_resume().
>
> This change will introduce more time that the display is turned on
> during suspend sequence. The compositor can turn it off sooner if
> desired.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Reported-by: Przemys=C5=82aw Kopa <prz.kopa@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/1cea0d56-7739-4ad9-bf8e-c9330faea=
2bb@kernel.org/T/#m383d9c08397043a271b36c32b64bb80e524e4b0f
> Tested-by: Przemys=C5=82aw Kopa <prz.kopa@gmail.com>
> Reported-by: Kalvin <hikaph+oss@gmail.com>
> Closes: https://github.com/alsa-project/alsa-lib/issues/465
> Closes: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4809
> Cc: stable@vger.kernel.org
> Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspen=
d() callback")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> NOTE: The complete pmops callback is still present but does nothing right=
 now.
> It's left for completeness sake in case another IP needs to do something =
in prepare()
> and undo it in a failure with complete().
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 -------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e34d98a945f2..fadc6098eaee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3182,25 +3182,6 @@ static void dm_destroy_cached_state(struct amdgpu_=
device *adev)
>         dm->cached_state =3D NULL;
>  }
>
> -static void dm_complete(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       dm_destroy_cached_state(adev);
> -}
> -
> -static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       if (amdgpu_in_reset(adev))
> -               return 0;
> -
> -       WARN_ON(adev->dm.cached_state);
> -
> -       return dm_cache_state(adev);
> -}
> -
>  static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -3626,10 +3607,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs =
=3D {
>         .early_fini =3D amdgpu_dm_early_fini,
>         .hw_init =3D dm_hw_init,
>         .hw_fini =3D dm_hw_fini,
> -       .prepare_suspend =3D dm_prepare_suspend,
>         .suspend =3D dm_suspend,
>         .resume =3D dm_resume,
> -       .complete =3D dm_complete,
>         .is_idle =3D dm_is_idle,
>         .wait_for_idle =3D dm_wait_for_idle,
>         .check_soft_reset =3D dm_check_soft_reset,
> --
> 2.49.0
>

