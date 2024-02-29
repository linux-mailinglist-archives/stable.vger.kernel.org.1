Return-Path: <stable+bounces-25591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0D86CFB1
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B37C1C210C9
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08193770C;
	Thu, 29 Feb 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJuiE59u"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937C2033A
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225489; cv=none; b=O520Pm5ObGgOnOoq+mXLYhkyvD1IPU+Q+DisqX+G2Xx/hcQRnuCUkYBFWTKQUIIbYmGrA4i4EIP39lOOxKjWdj0IScs6UpYwfCIxALqa1qTDrEeIedhXTltgrMna1tNrMo1FYgwuBem5PAJgMk8fcLf2YBCY92eaphS+CvtnuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225489; c=relaxed/simple;
	bh=jeB0jLSy8q+eh9qYQtqC3QlywNP/Xfpi3Eu7iYzC4es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9YRy31GPofdSKt0UVEJ18DxIXVIufnI949TSJwE3n6KLB2kRMtOPU/qx++g0q95WOoNWhExoOsqggmPxjWFpQLAe9hRA7GpRHWk+XIex1V4ObUg+zvzricqcGXLMVW3sOSj77zCye1q7+ydpJoOCsrduupCBJgoUxyz9x4DHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bJuiE59u; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso1565734a12.2
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709225485; x=1709830285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAGKZhcS7Vcqv+9qUnLEagGLoWPuyfJ/EEdRmEE/75w=;
        b=bJuiE59uBnxLDLwmJHZCpz8l2z13AQsOVqU3GKcWKlowbC3YkfjaV31Bwff90H+ssM
         h02luHq2+ECyGOBoj1jgmBokKY/fOF5oZ5TPzjjgmTR835WE+ioNeJ/ZDY+mvg1q1asw
         GAEb+dOStFXUu6F4zPQ5sAs02jB7KLSCHcuNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225485; x=1709830285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAGKZhcS7Vcqv+9qUnLEagGLoWPuyfJ/EEdRmEE/75w=;
        b=wIO4sQ2VTwhWiEQQaGVJGxVi92UcT1xR/9xIwIbiuz/tp/uV+9HUc6gL1Zez6hSBGV
         NMAEoX9X8nkBiN3VIx1JWUiJR1RPvKPIQEKJPTo3CvBvRYyThKWq1qBHJO/mLiROFAJ/
         qAKJ8tkNxRxy2FkLYH1UHSAObqXGLrAD5tLVadxBadaNJwK7efP9uSU9+8ejlA15u2Jp
         dkx/KcukFeKzKKYc8RrpuhXfpUGHoLcGBmx3z2VHLrvH0tfJ0Ypzzb4so6PDRwnjrGVl
         ZoVaV/fokHrw+kZfC32fMWyLtZE/OGTn/axR4yGjr2Z1h8Izxi/EMpTw/mbsryzXSzFN
         ws2w==
X-Forwarded-Encrypted: i=1; AJvYcCXWQtokNNdi2dCUBNX+As0iFdLXjFcSP2UpDzT6T6ChHunmyX5qgnzJTNrzDnvh5Rcgk+QCxG/GIQK4jV8bIhtCmyIo2Zi7
X-Gm-Message-State: AOJu0YxGmuCkgtVdTSP08OjZKDRlOcjR0lIW7RMTcLVREPhGoL/566pk
	/Yl6eV0fFSseZ7ey8/chO/mrgpd6M2Nb3H5KHVfGGk4MP3n6CkNIqjNR6Fyb5Q69Xtde7TPmVua
	jqMTG
X-Google-Smtp-Source: AGHT+IEqGj7tqNoqfalsjojX98fkw8+rj/IQSs8RMvxz0ppOJzz0KtMvnO3bOYoGGNLk/S6KzFzGgw==
X-Received: by 2002:a17:906:11d2:b0:a44:3056:1ed0 with SMTP id o18-20020a17090611d200b00a4430561ed0mr1890147eja.62.1709225485256;
        Thu, 29 Feb 2024 08:51:25 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906bc4f00b00a433634ba03sm855180ejv.43.2024.02.29.08.51.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:51:24 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso6892a12.1
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 08:51:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdCfTvdHD9XVYbXB5STp1yH7jg5SOFu/EtIOaP2vsuxSlQzg1wGmKvScN6BDIc88Vn9PODcjUnRv5zEcaufhDeBFYEVafq
X-Received: by 2002:a05:6402:34cc:b0:565:d0e4:d8a0 with SMTP id
 w12-20020a05640234cc00b00565d0e4d8a0mr153095edc.3.1709225484579; Thu, 29 Feb
 2024 08:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154946.2850012-1-sashal@kernel.org> <20240229154946.2850012-21-sashal@kernel.org>
In-Reply-To: <20240229154946.2850012-21-sashal@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 08:51:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
Message-ID: <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum allocation
 for the SVE ptrace regset
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>, catalin.marinas@arm.com, 
	oleg@redhat.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Thu, Feb 29, 2024 at 7:50=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Mark Brown <broonie@kernel.org>
>
> [ Upstream commit 2813926261e436d33bc74486b51cce60b76edf78 ]
>
> Doug Anderson observed that ChromeOS crashes are being reported which
> include failing allocations of order 7 during core dumps due to ptrace
> allocating storage for regsets:
>
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>    ...
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
>
> with further investigation showing that this is:
>
>    [   66.957385] DOUG: Allocating 279584 bytes
>
> which is the maximum size of the SVE regset. As Doug observes it is not
> entirely surprising that such a large allocation of contiguous memory mig=
ht
> fail on a long running system.
>
> The SVE regset is currently sized to hold SVE registers with a VQ of
> SVE_VQ_MAX which is 512, substantially more than the architectural maximu=
m
> of 16 which we might see even in a system emulating the limits of the
> architecture. Since we don't expose the size we tell the regset core
> externally let's define ARCH_SVE_VQ_MAX with the actual architectural
> maximum and use that for the regset, we'll still overallocate most of the
> time but much less so which will be helpful even if the core is fixed to
> not require contiguous allocations.
>
> Specify ARCH_SVE_VQ_MAX in terms of the maximum value that can be written
> into ZCR_ELx.LEN (where this is set in the hardware). For consistency
> update the maximum SME vector length to be specified in the same style
> while we are at it.
>
> We could also teach the ptrace core about runtime discoverable regset siz=
es
> but that would be a more invasive change and this is being observed in
> practical systems.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Link: https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-=
1-c7600ca74b9b@kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h | 12 ++++++------
>  arch/arm64/kernel/ptrace.c      |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)

As I mentioned [1], there's a hidden dependency here and without it
the patch doesn't actually do anything useful in kernel 6.6 nor kernel
6.1. Maybe the right answer is to backport this with the hardcoded
value of "16" for those older kernels? Maybe Mark has a better
suggestion?

[1] https://lore.kernel.org/r/CAD=3DFV=3DWSi=3D9V-Oe5eq0J-Uew45cX9JfgB8me-N=
w-iFRfXm59Xg@mail.gmail.com

