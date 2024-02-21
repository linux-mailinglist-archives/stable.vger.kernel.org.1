Return-Path: <stable+bounces-21771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838385CD3A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 02:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88D01F23A9D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23823DE;
	Wed, 21 Feb 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Leg9Z+x5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5051C33
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477502; cv=none; b=DkV+sOBBeVmH+bC3VqxecShJuwLVLpAyUMSVBB7WPYg1VEfoZKvZEwEnjJrO6G7uNWvqx2a6jflajtfWeT7ao/T0+FU1OGSiffIcTZ8oucdX6puibhSCsI61bMTbkWUa7l9NJ1jON+9K8DoZX+N/vIbysebeQtCf1CxMUTyD6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477502; c=relaxed/simple;
	bh=dEEluF2P2gR2xeqyp1Y02BIrtT0tj7h+zfXvTlij9gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3qkPNMGynVX8+zwCIFtv9KQHXHFi62WZRIUem3GY2eB1vjbh8GBKJtOgBY+X+9tczPHIaGWf1wQHc9a/wbZUAANF7gIGOkXVLc1d+bZH7UsapbsJhZPreAv1SNexAw/0D1AKSeHU3a9I9NSPMKBYGKVKkhXWqwpl0Fyl1TFCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Leg9Z+x5; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59fe5b77c0cso63204eaf.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708477499; x=1709082299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isNEaG2qmUnKOTH5ZjP/ZpM+OEQOzCRL1IUF9BpRXmM=;
        b=Leg9Z+x5oqTir2SvyVxj7mSbwebw8BOaA7hiDACS16WSINinY+hMRmagw/L7Am+LrL
         utG62EwVME95fX6URhi6MAL48qayFP/XvEVEpkDgdEEJGWM3KV1AXOK7WE0FJsxkffEU
         GESlR4A1t2EcaBp5aGtjJJlxJEHnEHzO3s4++HJ70HRJNUF1n6Q6oeObtjszyC+D0+oz
         LsMcMNJfJODklUolGHe3Xkol+msg4ICqLG7orzDotmh/kv8+24/gKo/aotBtHUNKeenJ
         9Bfj3cMOdoKTpbtdZOuAfbROfiuLZkVIRfb8NqARWhRfVUPv9lHr4NAZbYpg2ASSIOwH
         NJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708477499; x=1709082299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isNEaG2qmUnKOTH5ZjP/ZpM+OEQOzCRL1IUF9BpRXmM=;
        b=r7CwMEGgr6/td0KSbo0w4O7TLTjOOtYBegdfFpt/bD0muQOG0OV7oR+Do9PR1QwyKU
         jRxPOxxkufyO94UzCK966wsTbFZ1OPwYt5Uml+v9iWOlSJ8xSQjz2xuOFOOnsItz05SP
         PKbmjjryejgJuQMmmL9+saSVazx/B3e6IPjifFL/AE1dFmuH/2MCcx5uGdUlwvkquGe0
         5ni6X1iPuU/6KKcOC5cnxfH4OWfGt5UtDtuqRYOezzGDi3lrHDne5EYrcMBtH7omWfqC
         T79lLtnRKR4I23c9mAjVgn2aqm9XyvUGZG1MFV1VWTWvS3zDpUJZEIvXCRdceAYo/gE8
         6cCw==
X-Forwarded-Encrypted: i=1; AJvYcCUTEunIFk2FslAjSOaz8EfrP0ZNSd4YlBRB1QV7+Z9UwFHCofcS2Po9J6FueMknxQn5WP9I1r9CAMhW40ooe1GZAiOBlLIb
X-Gm-Message-State: AOJu0YyoQ/XPFClNaNj8M4dkpMXQsUzmN+AoRFb8z6KMjuyeYmkkeHPl
	Bhtzp926IGhi5Y9wnCDUtULSvYCLnkMtc+91gECcCti5IdqCcsTMyFmTUQIa90o=
X-Google-Smtp-Source: AGHT+IEPSYsGXwIa99frjjxu55kRc+mJZefx8BZP63xdHJTTQr2I4XQ4GxSUQa3YlEbf6wzp0j0GLw==
X-Received: by 2002:a4a:2b52:0:b0:59c:e5c8:bdc5 with SMTP id y18-20020a4a2b52000000b0059ce5c8bdc5mr15417911ooe.3.1708477498904;
        Tue, 20 Feb 2024 17:04:58 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id z6-20020a4a8086000000b0059a530f54c6sm1639833oof.10.2024.02.20.17.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 17:04:58 -0800 (PST)
Message-ID: <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
Date: Tue, 20 Feb 2024 19:04:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240220204841.073267068@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 20/02/24 2:49 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see a regression with PowerPC:

-----8<-----
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S: Assembler messages:
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:124: Error: unrecognized opcode: `sym_func_start_local(setup_g2_le_hid2)'
   /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:131: Error: unrecognized opcode: `sym_func_end(setup_g2_le_hid2)'
   make[4]: *** [/builds/linux/scripts/Makefile.build:382: arch/powerpc/kernel/cpu_setup_6xx.o] Error 1
----->8-----

This is seen only on PowerPC with GCC 8, GCC 13, Clang 17, Clang nightly, on:
* allnoconfig
* tinyconfig
* mpc83xx_defconfig
* ppc6xx_defconfig
(at least)

Reproducer:

   tuxmake \
     --runtime podman \
     --target-arch powerpc \
     --toolchain gcc-8 \
     --kconfig tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


