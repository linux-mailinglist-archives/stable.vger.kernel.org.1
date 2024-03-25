Return-Path: <stable+bounces-32244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9788AF9A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B928801A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F90134B6;
	Mon, 25 Mar 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzUBb6zY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD8EAF1
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394135; cv=none; b=drIiKC+Wtdya39278OvE9hRh3Ix61atdXLm4ZHWQfOizQWcwwusiZmJGa5esOIVwTys5vYltSYK13ouzmR2mx5kecBGEVb7MFPXBLpIq0OAyzJdDStMxsd7YLLwVCzGnuBFPEAXxJdm275RZExlVMOKs3mwG0q6ZC29b7IE5RxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394135; c=relaxed/simple;
	bh=2LcEueyo4zA26fmlVXxYwpG3RmYVcNHHj8IIZYyADhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfkfw3zmq5twNmqX5phRLtzJUZOVO+0MR+aOG1dhzGEWo8PgR8ie72nF6HTrVQBrV9R2ExeKkD+uFyuaDxUMmQyu6/ioN4D9C9puEqGDgD26MVq/S2Fo92E2Wmvl35tvmxV+U+L8YM5raWn3UGonDJ7RwlQ+PM7lQh4YTb9MkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pzUBb6zY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6ce0702c3so995435a34.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394133; x=1711998933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEBbhuHQkbU+EMQNmZrROufmbPoDerb7a6WhSXk365c=;
        b=pzUBb6zYR6GFO7jSg9QMkxJ8zJvscS9ug5zumE1YsBLJ1aJytDySkX+Pe56DEv0I3Z
         MzNgYI1EgX7UcviHJnigRKKe41DH59OmN53PjXuEWTC+H74cxYBBZPN1ga6341I6Cfzp
         F0jIZqNr5bAqJCGGLrcztbROeCiQHtsRpXDLDU4h6MEtrDiCKfIbWtLaLFiKyKNnafdH
         s/40urRHyjL6NNk3pdqNssOEebLPtvZ1cd4Y+NjcUBqTJzSdY4z1K52WTfhNXLYvyH+q
         t8hvebTGk9y+eZypCwcLjlYEJGoYh2ZcL7UH3IJzgbBvsxIEwfKvQMJGRcbE8x+kSpeo
         UXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394133; x=1711998933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEBbhuHQkbU+EMQNmZrROufmbPoDerb7a6WhSXk365c=;
        b=sLSPL1qTtu0rSq6ZCNMV0W4WCVxZMVOmMzOnbX3O0IgYCE5VWrLo0n/YJOVuljdXD9
         kGZDzpeM898irxnfS+Q73DlmERIPKuU5Yib1htOQ8cVXmMxe2t4cSkNl6lGNYmcPm/Tm
         P1bqnR3g1aW3kV/950+X9/Z57NJvzvRpaUH5k0bGCZWqzIDVqZsB1nPSyX3WqIx9Tm2v
         h3i8E6kmd7y3N3RudmoYaZsYzrs98I/QF6rgU+OExZE0pRR0G91JcSTv8GHnvygu8+Kf
         2GR1qXrHaxokpe/ns5NQ+uM0lxFuQVA+gDyDkTRCHYVbcupD/bmqTHDywN6+Y03F4fgB
         PZlw==
X-Forwarded-Encrypted: i=1; AJvYcCXUGzj7VEH3creIIg3Zt94FQmBiXT04qVj4qL8WifGvgkiez27nV2wS5UDQGr/+9lrUfWA9y0xH4RwT7DFMz8OkzjhA9emg
X-Gm-Message-State: AOJu0YyzZjJ/zCFU5Xgb80CBlLYiDEAwycLEa4IyTBUjjs68cvdqoEVM
	RFlUiwrFFx4DsyrMwhUG+1r1/TZy4qi8Ae6fiSWan5YagxeaIbp+qQZjUa+J8Yo=
X-Google-Smtp-Source: AGHT+IEU0VeMb1Dhv4HYSXBYZW0Ce+GyLpusfcP5u1BmlbKM+F1qrauHDnpF45Egdb0z8vBFEZHiXw==
X-Received: by 2002:a05:6830:328d:b0:6e6:777d:70e7 with SMTP id m13-20020a056830328d00b006e6777d70e7mr9764633ott.7.1711394132839;
        Mon, 25 Mar 2024 12:15:32 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d4707000000b006e6b203c93csm1220301otf.72.2024.03.25.12.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:15:32 -0700 (PDT)
Message-ID: <9b3d2eee-4e42-4af8-9650-7a4b6eff6626@linaro.org>
Date: Mon, 25 Mar 2024 13:15:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/237] 5.10.214-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 stephen.s.brennan@oracle.com
References: <20240325115920.1765410-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115920.1765410-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.10.214 release.
> There are 237 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:18 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.213
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see new warnings here too, on Ar64, Arm32, x86, i386, MIPS, PowerPC, RISC-V, System/390, SuperH, SPARC, ARC, on multiple combinations of toolchain and kernel configs.

-----8<-----
   /builds/linux/kernel/printk/printk.c:261:13: warning: 'panic_in_progress' defined but not used [-Wunused-function]
     261 | static bool panic_in_progress(void)
         |             ^~~~~~~~~~~~~~~~~
----->8-----

Bisection points to:

   commit 290ee7858f46d6f007150bcd90cee321cabb8545
   Author: Stephen Brennan <stephen.s.brennan@oracle.com>
   Date:   Wed Feb 2 09:18:18 2022 -0800

       printk: Add panic_in_progress helper
       
       [ Upstream commit 77498617857f68496b360081dde1a492d40c28b2 ]

Reverting that commit makes the warning disappear.

Reproducer:

   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig allnoconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


