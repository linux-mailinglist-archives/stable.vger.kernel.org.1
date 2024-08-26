Return-Path: <stable+bounces-70121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06195E621
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 03:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ECD1F2104A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 01:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97D1373;
	Mon, 26 Aug 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftqdCJhr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAC320C;
	Mon, 26 Aug 2024 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634258; cv=none; b=JFvaxoQWAvDFtZp97zxLYtZasG1vdjJk4YYxnTBNhDjCVIPALR/ZPudy6kqmrySO8yoEck//gQrogym/KN11gNT/mb25CTaTdvuUmPm9wrJ+AaSJfchYQ6CNiJR1gy2P1KxaVSgTBWc0bbGE2iCBTx7Go/GnboOc6K7TwLgyZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634258; c=relaxed/simple;
	bh=4y9O2Rmi+jwgQJpEVRFnTaJv7Isnq4isyxxYK4xlpA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUo8BBAruQ6WEPMbZqdmnl+Amrpo5iw98Zgr11MaM+PXj/LXVn5vZnFzzBgNryMMOcGhwMk8shviZirsVuQZo0d1OdPQgjOTrgyHaVbrxxGfg0Mm7uKgYFxjgLDZ93eVZ6rxK8x2bI+I7QHqBBLqTYmh3ukT1qGeQ66ec6QtmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftqdCJhr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c03c13aso27274515ad.1;
        Sun, 25 Aug 2024 18:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724634256; x=1725239056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DqxQx46gMpgxTVef5bD0yLhP3E/jz1TEfOmuqDo4qbU=;
        b=ftqdCJhr44lSCrdBFwvFpcghAVkaqcdi5NlTDZqkh9JFLbaXUsPIhBHdHE2Z9ZDF20
         p1/GPm/SiNOrQbzZtChQH5vEJkouiCoeqtmNW+PhWV7/CVZqV1h5mU/egvCGR/MZKSvD
         c6/ESavVytyF6QQeBX+yrkdoDx8CdKqH8y+akm98WtoeO30buf2HlGSxuGYefiXaZ9aU
         s2omKU75u55xvyOl50Sup1ao3MLhkKdIlz99kb69LF40/a9jjThweBm6v2puFLDzwv3W
         CPQCsWsw0QmsiRQmO32qf0j1v6ANLyNB0NGcDaTQ+Cv7qfP+CIym62/Nis01pJRAspyj
         JQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724634256; x=1725239056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqxQx46gMpgxTVef5bD0yLhP3E/jz1TEfOmuqDo4qbU=;
        b=Th1o7suovjLVmYgGJ14hxfO+KI8xF5D+ChxtPhEl3JXD+aKAAJ5njombxv4hytGUue
         2Gb32oPxG8Btb/n0581w9YoxC6AGOhXrNApWwyGho7VblJCjJqtq4o7aN8anpR0CM/A6
         rsm5hmIm053PuSIe3Lmex+yGiJYJtvXWO1mcJ6ucnVb9VKnJIk91ILw3rW3sm1utuW3O
         MxCR/hN542x6afumvtQYceqABLeIQc1K9potM5KbYY6C/tURN2HMfQpUm1rVPLP2TIuD
         SQ32DfjKc1hNxWgTaGrokXC2WMfOb+5o9W34RShBFbb2I/ROJs6lTMzOI5xRx7LWB6LT
         y3dw==
X-Forwarded-Encrypted: i=1; AJvYcCVmqZ5YnD0Wn+TZHji+hbZ+pzUvhTXq3VQ6qY2fFCr7Oh+/1iTs5yIp2fXZBnj0VBtC6rnSg7kB@vger.kernel.org, AJvYcCWHq0IfAmHRK6X0rbccsnn6lCxWPdqnyN18TIgwGN0nC8L1cTM25Syhy8/xUVTnMvwQcnQr2UWoWlELh8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxPrUAxSXd8kX893w/xSsdnCBePqBarJTHWX58kv5RSJ7sc2VF
	XthQ8Zx3jwgheRpTyIZL+774b7tqXT6eWXmunUyE96OfKxwfyBUA
X-Google-Smtp-Source: AGHT+IGWDNVeUiOcBBkuTv27DHMcgNyS/oCjZCCT76MSkvnOXcwdOMcxVs6sdpFX5bikCecmTkTUHw==
X-Received: by 2002:a17:903:2a8d:b0:1fd:6033:f94e with SMTP id d9443c01a7336-2039c62a05cmr139631435ad.27.1724634256353;
        Sun, 25 Aug 2024 18:04:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567912sm58888195ad.33.2024.08.25.18.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 18:04:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <135ef4fd-4fc9-40b4-b188-8e64946f47c4@roeck-us.net>
Date: Sun, 25 Aug 2024 18:04:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/479] 5.15.165-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20240817075228.220424500@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240817075228.220424500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 01:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 479 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Aug 2024 07:51:05 +0000.
> Anything received after that time might be too late.
> 
[ ... ]
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>      MIPS: Loongson64: reset: Prioritise firmware service
> 

This patch in v5.15.165 results in:

Building mips:loongson2k_defconfig ... failed
--------------
Error log:
arch/mips/loongson64/reset.c:25:36: error: 'struct sys_off_data' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    25 | static int firmware_restart(struct sys_off_data *unusedd)
       |                                    ^~~~~~~~~~~~
arch/mips/loongson64/reset.c:34:37: error: 'struct sys_off_data' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    34 | static int firmware_poweroff(struct sys_off_data *unused)
       |                                     ^~~~~~~~~~~~
arch/mips/loongson64/reset.c: In function 'mips_reboot_setup':
arch/mips/loongson64/reset.c:144:17: error: implicit declaration of function 'register_sys_off_handler'; did you mean 'register_restart_handler'? [-Werror=implicit-function-declaration]
   144 |                 register_sys_off_handler(SYS_OFF_MODE_RESTART,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
       |                 register_restart_handler
arch/mips/loongson64/reset.c:144:42: error: 'SYS_OFF_MODE_RESTART' undeclared (first use in this function)
   144 |                 register_sys_off_handler(SYS_OFF_MODE_RESTART,
       |                                          ^~~~~~~~~~~~~~~~~~~~
arch/mips/loongson64/reset.c:144:42: note: each undeclared identifier is reported only once for each function it appears in
arch/mips/loongson64/reset.c:145:34: error: 'SYS_OFF_PRIO_FIRMWARE' undeclared (first use in this function)
   145 |                                  SYS_OFF_PRIO_FIRMWARE,
       |                                  ^~~~~~~~~~~~~~~~~~~~~
arch/mips/loongson64/reset.c:150:42: error: 'SYS_OFF_MODE_POWER_OFF' undeclared (first use in this function); did you mean 'SYSTEM_POWER_OFF'?
   150 |                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
       |                                          ^~~~~~~~~~~~~~~~~~~~~~
       |                                          SYSTEM_POWER_OFF

This is not entirely surprising since the missing functions and defines
do not exist in v5.15.y.

Guenter


