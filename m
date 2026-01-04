Return-Path: <stable+bounces-204569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C6CF1235
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C2D83004CAA
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223301DE4CD;
	Sun,  4 Jan 2026 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="CX33jsv3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C843AA4
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544266; cv=none; b=UYwUXG7xn9f/kZy4q5YQkbpZ4DmOZLFY3qI3UGZvYO5p0volNXYe9DEE4c9XI0qdld8Xl9LfjdYDRgwtsdOaRgngKoHKMrL3meErErR05hpj5emSvu4oczLfCAPCe5VBVzQMpDHTkJuQXsEePL5HAWPL1DNRnKQF9v9OPTlcA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544266; c=relaxed/simple;
	bh=39VojhKe9zj7ah2bM+TvuOT+/VvLsdPzCzmYvKwPtoU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qIk7vCCAKdVpBYw7DkKOW7sdUz2RFcoBITEG/4klTy//23hyvh0vEDv6xssk5Xv0InwH2HNvI/jlx1rgJwD7gGyW5HMK1jDggeJ5NhcTnWvJ0DhKLUwtm2m+0jcvE7Ev5Y89k1tecGn9UkULbs1jP4rSlSGkXLsN3paAmTZwTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=CX33jsv3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34ab8682357so1612686a91.2
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1767544264; x=1768149064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0RomknU/GCM3/OmUnsoA7ijntj4E5mkXg3iZXV7rKso=;
        b=CX33jsv3X2hJfpE7Sf5vTIJFBFsf4NMVGngcWUMjN+swwoRcJIDHmpzEhwnHgPxjED
         /HMHcCd3Zp8ImUDi+xia+6dBwsbqebJ6CXoM87DdWYck7jBobaS2vXbG+iz0uEmOURF5
         qMfDh8pyXJ3sJjSwyygjd+MIoy6fPWCQMWGELg9y3TuqQCKNRXno3ZhoEgHyIZiO6B9c
         H2mkoyGvwVSFJId/WE3vOUGhFOJryjP8v90LVpQ+ubfsj4rUbRW+gv4gFtXBPewdTIWj
         BFAxHEipkSBP5VIm62UsLDM+4xaosl1TjtTaNIrFWYt2tOfYfCz0EAtwc8mMb3ojAmbG
         Jzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767544264; x=1768149064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RomknU/GCM3/OmUnsoA7ijntj4E5mkXg3iZXV7rKso=;
        b=OXysXWZlcluXPz43ODVGLWvv/D83ERE6kI6Kx60E+B+ex0CgETad58LDB2BbIzCeMa
         MTp4l5KHBGaaumhYI5tYVArIGr8Vwp7ak0Gm/LwOGuaIjtxUfn4z3Xt4Bvt/QipyQIzY
         Scw0uTAnnpYHB6CxXU9aAyh069762mUCFxISCMsnALPI14FdApoozaVByn8rrxFB0LdT
         X8DY+BBRl0NVeMKAJLLTrYTN2On0eFAfCbh84bM9c1qnlBG0Px2RSLVrMfB6FnFnLL2B
         u6HxfHtIgvwdf80iNW46TGpeVc95vJ1zkm+S6C5uGA3bwj43zZRreETxw2Q311gZcxG0
         a2LA==
X-Forwarded-Encrypted: i=1; AJvYcCXnuRpBnOHbECypVSa3qPFCNO5tG+lpeZQ8yGJ8zSAd1nmoMvNOs6BYQK9UZaKKI3IZ2fY5r9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUFYrbwWmTE2CIYWVUdoOj9I8Ww22Q85srpFV20uuFYZ2K8NS
	VXv0qqZRr7ChsO6R+FuJxnLsKYSz+QwSY8V20Jc5Cqwc7eLlw2Ax1cC1zFkU4HMqK5M=
X-Gm-Gg: AY/fxX52SOrHSnG+bf10QlcJumq9kKtIHBT/8dEfW9yjlhUYydsP14usp3cfM40TTsI
	ApiXSo/BLuWq+oG87iw47eNz7Xzxhy5DtaKgwAf2bo2Kp9nSrP8hUUyWt3e5HHsk+f+0CiUiXLS
	nwUSHZmuRRpOoA75/TGx3KoUPSqP8FkJYhBn6spe7WkfSn94MUp/yb5cHoAiFj6G0VCaSLgAlp7
	HFzwlmvb5lMqLGGAVObNh3iSBr2cEp2JdMp2ufsaqkWHTu8E3a2ro5L5fYpqjAiVr7jladJUQ8S
	AtjXtCERsenqtNK4g9l5Q14Nww6IbdiBsT5OI2OFb+V+BuzskBe7syU/4aSbOw/gN2IHDfB5tq6
	FoYHb+olI+NTIEeiCsh7NBmf36Jbq4o8ISwbh0OnuGBoos/DbE2CpzMW25v1gSCNlNsQYfL0T4X
	/Ppc5nSmuMD6ptK0HVELR1lPo=
X-Google-Smtp-Source: AGHT+IEyphB/ajEv2v7vYMeAencSQ8aaOId7S4htgyUdFabRaNSn/dlZEal8wFMrdx9zCnvbBanWcw==
X-Received: by 2002:a17:903:2348:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a2f28360cbmr324555775ad.4.1767544264522;
        Sun, 04 Jan 2026 08:31:04 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5ddedsm422272885ad.79.2026.01.04.08.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 08:31:03 -0800 (PST)
Message-ID: <73aa598f-4af2-4b92-b2fd-1d8fd3dcd784@shenghaoyang.info>
Date: Mon, 5 Jan 2026 00:30:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shenghao Yang <me@shenghaoyang.info>
Subject: Re: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB
 disconnect
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251231055039.44266-1-me@shenghaoyang.info>
 <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
 <938b5e8e-b849-4d12-8ee2-98312094fc1e@shenghaoyang.info>
 <571d40f4d3150e61dfb5d2beccdf5c40f3b5be2c.camel@aol.com>
Content-Language: en-US
In-Reply-To: <571d40f4d3150e61dfb5d2beccdf5c40f3b5be2c.camel@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ruben,

On 4/1/26 03:18, Ruben Wauters wrote:
> Hi
> 
> This does work, however this ends up returning 0, which implies that
> the atomic check succeded. In my opinion in this case, -EINVAL should
> be returned, as both the crtc and fb don't exist, therefore the check
> should not succeed. I would personally prefer a more explicit check
> that does return -EINVAL instead of 0 from
> drm_atomic_helper_check_planes()

> As a side note, I'm not sure if there's a reasoning as to why
> drm_atomic_helper_check_planes() returns 0 if fb is NULL instead of 
> -EINVAL, I'm assuming it's not designed to come across this specific
> case. Either way it's not too much of an issue but maybe one of the drm
> maintainers can clarify why it's this way.

Maybe this is a result of the atomic conversions? It's possible that
now we get passed NULLs on hotplug and display disables. (I didn't know
enough about DRM to be sure and didn't reference that commit in the
previous email).

I think a return of 0 should be it - both exynos_plane_atomic_check()[1] and
virtio_gpu_plane_atomic_check()[2] return 0 on either a NULL fb or crtc -
I've tried returning -EINVAL and KDE can no longer disable the display
because the rejection is being propagated back to userspace.

I'll respin this patch to return 0 after an explicit check and include
another NULL dereference fix in the plane update path.

Thanks,

Shenghao

[1] https://elixir.bootlin.com/linux/v6.18.2/source/drivers/gpu/drm/exynos/exynos_drm_plane.c#L231
[2] https://elixir.bootlin.com/linux/v6.18.2/C/ident/virtio_gpu_plane_atomic_check

