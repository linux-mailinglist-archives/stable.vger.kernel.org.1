Return-Path: <stable+bounces-106715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16605A00C5E
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716EE7A01AE
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAC1FC117;
	Fri,  3 Jan 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gu93XmBr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF938B
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922828; cv=none; b=miUHferGtP8JYYiBwCUwJB+e7beTtUyCTUmECZ6ozP986TRt0BYEFEOFBe4//vpQyipPNh4YUh/FD+8Libt7wMN4cX3MPz+LneFAma8px7nANq9plHtaATXxIS26H9Bg7i0fxq3XnuOvfxQlvtZTnFIrdWuge2JErXdiyuEJic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922828; c=relaxed/simple;
	bh=m7qp9fTT636KEfP5XR7gKLkK6ofVHujrpMEDrTxp4M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYhnDXvloNFp/n7dvZtOFVGPlG/N53w4RXHOj0ebnzQNHSrS4+HG6EXNvKavU1cOVwXzZA2jgMDPMdZDxJBMVPCTaHsZFS+g/4yI5jgpoB/caehog2E+zzrvKlV373Iyr/M/orXs2ZfN67xucfh5bgBBi09qK4WTKKsjA/7R0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gu93XmBr; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f4ce54feb8so6143727eaf.3
        for <stable@vger.kernel.org>; Fri, 03 Jan 2025 08:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735922825; x=1736527625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXRmjGDnWqpOlwm2IfIXeCg0w4HEW4vPwZrYnuu4vcs=;
        b=Gu93XmBr/u83kPlyR8ZoM51lOGjsgdRRasLeqzH7d3PK4VPAxmjA8gClqTaNmfGZRT
         56J5tTi3agbB2Se+gUCT6Lpnsxs927y6y3STYW6uFMm5L8GdDKtRYWkON1Te2z4lTwEu
         gMPHzP90wKHqhMutgLkIOKP6NiUcVksBwpQP9OCEQfpCrvb0Drf2UR08h1DWbGWEvH1m
         BTZr9rMyP3hbCfERaUmfydYf+hVJWDc4iANEgtWUUJjZTi86va4uR+OFGfwKPMNBTo7D
         qBes2m4sTC5ImU5lVd4HsTLAFeuU/JIZ12ZyEr+ctQJcDN0mHt6k0bDZTBxGjLP/zgzE
         5yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922825; x=1736527625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXRmjGDnWqpOlwm2IfIXeCg0w4HEW4vPwZrYnuu4vcs=;
        b=atudVeUKpesdhzXOEUxTAiX8tzonk2oxH8IZ7afaSVn1M8KhO0fqWafuYdmT+HBU+R
         jMqQ3E3K+zLbpCht/XJPBGgod/rj7kx0rlrMnpfos2HlzaLUJgPxQyQ0nr9vY9Yt/FyZ
         /rMlKXm6fD1cc3TMuSlVzSqnHRDxoReRXQBxgQec7kkX5sgKtedd1iRgL1Tyi8L9I1+o
         0bGHZZtlY0s9OYb2JfgBDXLPZib+7WZ/+46s3Q9HWE/m9DV5RVoJks3dvERkBL/+eDIg
         GJP88G4D1OLfUqbgfeEun4SGSUuHA9YdokEGyx4DYGAyoMBbUWYvLhuNx/Esl8sIL05O
         zWDw==
X-Gm-Message-State: AOJu0YwgyL561KLC8sjEwqVaH7Ggn6Dal6+q/JOKpdDNRWzgNQu6kSbz
	CsAYYid9ua9g8XOsY2xj41SGbMTiEuzzCdVbAWfs1py7dd90PP7x/9bScef7xlzkGj0yTc0xJHO
	o6s+mNVlUC6R+91WWL8R/OciaZ84YXiLIX8pHjJJL2/Xze6xB2IM=
X-Gm-Gg: ASbGncvu5c+U4Gppk+HspPRn0PQX58/f6dBmfYve4V6f6v4cdL1g+S6+t/yTk2mPpSe
	GnBPfPl2yAjOHv6kouZKcpK4acPZHSN5y0cD6yvo=
X-Google-Smtp-Source: AGHT+IE/mFLw2lOHGAwZmVM4vNUjIXQQrzPAlhYrqP7V4gCf88sDGtQ1ENBVDq3dKh25MjtBSmEpU2nOP5EUTcHoWxw=
X-Received: by 2002:a4a:c88c:0:b0:5f6:334e:8d6a with SMTP id
 006d021491bc7-5f6334e8f9dmr18884886eaf.5.1735922825206; Fri, 03 Jan 2025
 08:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103004519.474274-1-sashal@kernel.org>
In-Reply-To: <20250103004519.474274-1-sashal@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 3 Jan 2025 16:46:54 +0000
Message-ID: <CADrjBPo_oiqboE4jAemR_2AjxJtSgMLpS8_ShWcX8wJLB4rszg@mail.gmail.com>
Subject: Re: Patch "watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle()
 for PMU regs" has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

+ cc stable@vger.kernel.org

On Fri, 3 Jan 2025 at 00:45, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      watchdog-s3c2410_wdt-use-exynos_get_pmu_regmap_by_ph.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

It doesn't make sense (to me at least) to add this patch and then also
add the revert of it to v6.6 stable tree, as it becomes a no-op. The
only reason I can think of is it somehow helps with your automated
tooling?

Additionally the hardware (Pixel 6 & gs101 SoC ) which these patches
and APIs were added for wasn't merged until v6.8. The revert is also
only applicable if the kernel has the corresponding enhancements made
to syscon driver to register custom regmaps. See 769cb63166d9 ("mfd:
syscon: Add of_syscon_register_regmap() API")

Thanks,

Peter

