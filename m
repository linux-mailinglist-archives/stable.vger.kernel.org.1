Return-Path: <stable+bounces-32155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B388A32E
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC7A2E205B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53C16FF54;
	Mon, 25 Mar 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+6ZXBPD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB31802A1
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358917; cv=none; b=CwIu3zqjBc9610QQrvuTBL0lDAGOfQ+w7tw5+jB7uBkbTNOvD7pMqbU6Kb+XVJm1txSRDfD5BIuYJMEDWcXFEM21h3Lo+bCciIcFDbhv07HqieKi9oui1+dOlPYKB8HjgJwtI2aDG8folwDlEy7OBST1bfWepHB0ltuHJ+XmaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358917; c=relaxed/simple;
	bh=uGQJQqqOoV40xJP1y95HDFRdz87FEyHED2qs0kLU3bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpTbLT2loJY+XFoVndzwkF8EbNcjO/LBW9Z9QZnpkDfZc4EOSKCgCJKDv4NnPSUUyhmUHqxlS5omEVQElEfs0WWOlfQXHCcIAOyierw7horWZlhncNJhLVTaoCmqKjx4iVWQTirG3BzvXbiaGQlBX5SiiUv/igd8jHeIBY1JN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+6ZXBPD; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d438e141d5so2379122e0c.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711358915; x=1711963715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5m0Gh/qeDl7am+4YY8jkZ+PZB+SobIFHIAWFvx2/qhk=;
        b=S+6ZXBPDlwwzO1ciPHumxH/ZKhaC8u3XW8FOQgQxZsqG48Al1G3YM4sQ73Wh+RzJEt
         yXC+yytqoPa8IWRDSTUJGpSrpSxN7mlPuRqYZpaGVboBSDFEugTi16kwSPoivdbb8a94
         PZQ7WvnKBOiobSUUGbAU20copVrIWcGJnsOBs052oFBorhhkIDCWqUliepKbfV56Tkql
         FdUs3kkjoxXI/UeB4H0njtF5fuWDKB2gcWi3lp8EAzarpAEE1G+cW9656wvgC+8s+OIY
         kZSOtmKSr9QdbQwC49KWWL6XhfZyT6lXQ/633DD2ZjEY3c0zxVTe3tVLfDvuWray5EVY
         58aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711358915; x=1711963715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m0Gh/qeDl7am+4YY8jkZ+PZB+SobIFHIAWFvx2/qhk=;
        b=pFvW1yIN2S2kTW6qMc5xB8vogLFW6ukZjm7ekXxNuzys+0vTshCn6yQovdhpMCEJ/u
         zCvtm9nqu3T7mMa4dfOZBtkAdNv+guHqLcmPnGKzSW6hn+G5DOWcLbvgIzFMYbUX0ux+
         Z3eNIk4uqpVvguXsGgsec49CUhqMz06FA0NhZCKPNLZpWbY4uHe1bYGNI8Lmz+1oCzQ0
         LiPIv2UOatDlCctZ6JMVWDvPtf7RQJjiJFjV/IIr6YMaAi62Qke/psehSFz9uBTKtVVh
         tPmLvq3DBPl63WhageD4EeIW6OEvN8iocJXaQU1cpAjjBTNiJxV97Mprwkz/EbrFfqqR
         UBHg==
X-Forwarded-Encrypted: i=1; AJvYcCWNw4i4HYM/yq3d6VemHgihR87kIrEzuo0kofEeQVb/+YYEO9h75YPy/iUiayM0AFpA40yKi8sb8KS6SLwZx6FapwhJ7Dfg
X-Gm-Message-State: AOJu0YxwE5pK4cuL96lPPvO2jw8nvMMF2AzvNt8fsOntz33oVShkQDHK
	UxAKA+SQbakyCM+ZvstdKeXPAj6OLgyj5c03OTAtYrhcDwYahBsmdy8Xr4WerO3YcuhNKdTiUPn
	4Wu3F7DXCdT/jAJH20UwpIx5yc/rqFO/0juDV8A==
X-Google-Smtp-Source: AGHT+IGM/UyGpUfBFfVFl91MwB4yzh9yxciE0bsa3uvnOjvb8RmeOSlIGcBZRayBfFukhUTmD2y7dkNO9tJXQIK0PSU=
X-Received: by 2002:a05:6122:12b7:b0:4d3:3334:f2fe with SMTP id
 j23-20020a05612212b700b004d33334f2femr2658521vkp.1.1711358913507; Mon, 25 Mar
 2024 02:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org>
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 14:58:22 +0530
Message-ID: <CA+G9fYtU7A1XxOS9BvmoQAjhcuUsaSPQKnOzz-qYV6ORnG9k-g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/317] 5.15.153-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@intel.com>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 05:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:34:43 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

As I have already reported on 5.10 regarding powerpc ppc6xx_defconfig
build regressions noticed on 5.15.

> Thomas Zimmermann (1):
>   arch/powerpc: Remove <linux/fb.h> from backlight code

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------------
drivers/macintosh/via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
   22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |                    ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/kernel.h:16,
                 from arch/powerpc/include/asm/page.h:11,
                 from arch/powerpc/include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:60,
                 from arch/powerpc/include/asm/ptrace.h:323,
                 from drivers/macintosh/via-pmu-backlight.c:11:
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
include/linux/minmax.h:36:9: error: first argument to
'__builtin_choose_expr' not a constant
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |         ^~~~~~~~~~~~~~~~~~~~~


Steps to reproduce:
# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig ppc6xx_defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23147157/suite/build/test/gcc-12-ppc6xx_defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9uOwIbkt3JA6me39nPospWfFL/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23147157/suite/build/test/gcc-12-ppc6xx_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

