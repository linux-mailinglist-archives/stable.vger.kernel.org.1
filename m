Return-Path: <stable+bounces-32242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639288AF7A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D792E3E74
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB712E47;
	Mon, 25 Mar 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZjcYO0x"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1A10957
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393895; cv=none; b=TD1Cy6kf8krtPg5mvGF/vjBe9ZXVPZPOVKPpnSH6vzofDTbhlHqYANjEyiC9s5T9Um35s/e5bYqcTEe0uKnyN4GL/5o/oZE2pYMso1rQMPEHsspHww/GYA37Wz4YOaJSMlfmeuxBFJpdDfTbuuPJ1aLCPMXjQ93NMQEA2Kbc6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393895; c=relaxed/simple;
	bh=Vi8HxAd7A6IWSux/onGa3FeKfLdzruWS6T0+YUExDH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5jZDs6Pzn5kAPhj2Hde7UihDq1d9Jl4PgdmL3bQGHux6xl7cCofbXQj6xQffWWa/0ICjmHpeF9bmcgFN5a8PA8CqPLZaMc652PYRBHntl7RB1yOnYLZ6YXKJb/22StZtdYPG+yez65m+cVq+lPhYDFeStwdVzdW8KmNFeZgr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZjcYO0x; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a470320194so2504355eaf.3
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711393892; x=1711998692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSCEfymtsbEAwFlN5wT0NVwopTsLwBAlwphs0JJFdOs=;
        b=WZjcYO0xZiy55qop347jNhuBM8TRXbI/mVtHvOjzPrXFPSO0w7EmpC53G90MDa9eT7
         Hw0APfptOtAb9tullqbYdAJVZKHFnUNrroKGC897hwmT3F9tH14/3ATGJuoL4kVGZeok
         mwaP3TwHvRuvlfab/DofMlYLNLqSWDDfieqtjuZdpriiFK6PaKBxCRPuaSt5oUsVBOX6
         40ROnsJm4vOU+vWgGFcSqmdZIuHqX0tfIrFCgzbfl+zznWqDHDs1agVZ2pKNMxe92UUJ
         3vFgZ28LgMj4BLds00RP1SiLs0RSQOwJ6olujs4U6QZlt8FYVH7pcTViKuYeD8tE+R3l
         SSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393892; x=1711998692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSCEfymtsbEAwFlN5wT0NVwopTsLwBAlwphs0JJFdOs=;
        b=RmhCmf0Ldne9eFddT4TLM2K00cxWzocG8CayvBzqT5wAzrAEEzlTpowqkeqkqUVaVU
         n2iFzHJxp+aTO3xcKYUmP42nBcQzzXBgPQdGuoEHxhsLhr1fo9Awtp5C6gk/xVNnE+XW
         4bgbrMIgDWI1fzbyAEcsXXMoiBJrYcs+CPz/eMMaZV1UHsGQDH2IxqaSUd6NA9W+bnew
         O5ggQP3Rt04dpm7MBSLMVs4fFI/yKKGAY76JF3uZPS8rS3ITfujKMy/WPoYiJeNmmxRn
         tggNsa3l0009w3iipw2fMhVyDnW7m665CTp5pp1ufB1pN6w4Ca2FF3LEsxNxM+s9T8cz
         04lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LYI8LaZaQrF8oZVsbzqasML69XhCuHN3V2N56RMm7Blt9QvQB0ygQC3mPe0mJdk6JDtSTJx5Nifx3CNJk/cxCkjh1nsh
X-Gm-Message-State: AOJu0YwZtOCikKdAvlU0m8xUprHNDaxsmBpiQIyLkCGNSuUBbRiEM1d0
	5FZudh8h1bZxW88H10uMLd7WNGj2MLthK0zXzKtZ51tUjLUbJ8t+6DyHUlmtVfg6gqqhen8SKsE
	7N8s=
X-Google-Smtp-Source: AGHT+IEtMFKcLACXoldlhmST1l3Jk5e+Rl85AcJMkgIfftyNJy10nWG2uhpU31GystsnXBXmygfs6A==
X-Received: by 2002:a05:6820:1b13:b0:5a4:71b3:d090 with SMTP id bv19-20020a0568201b1300b005a471b3d090mr7791853oob.5.1711393892163;
        Mon, 25 Mar 2024 12:11:32 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005a53e6c7209sm941635oob.28.2024.03.25.12.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:11:31 -0700 (PDT)
Message-ID: <1ca89b68-fe6b-4963-a33c-971fd7e1f0e6@linaro.org>
Date: Mon, 25 Mar 2024 13:11:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 stephen.s.brennan@oracle.com
References: <20240325115928.1765766-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see other warnings here too, on Ar64, Arm32, x86, i386, MIPS, PowerPC, RISC-V, System/390, SuperH, SPARC, ARC, on multiple combinations of toolchain and kernel configs.

-----8<-----
   /builds/linux/kernel/printk/printk.c:261:13: warning: 'panic_in_progress' defined but not used [-Wunused-function]
     261 | static bool panic_in_progress(void)
         |             ^~~~~~~~~~~~~~~~~
----->8-----

Reverting this commit makes the warning disappear:

   commit d3ba3bc06ffa68aac04cf4f102ec882890a16015
   Author: Stephen Brennan <stephen.s.brennan@oracle.com>
   Date:   Wed Feb 2 09:18:18 2022 -0800

       printk: Add panic_in_progress helper
       
       [ Upstream commit 77498617857f68496b360081dde1a492d40c28b2 ]

Here's a reproducer:

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


