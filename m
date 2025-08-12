Return-Path: <stable+bounces-169290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C129DB23A69
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA9E1B64854
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D8274B29;
	Tue, 12 Aug 2025 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLF14kgK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59B20C469;
	Tue, 12 Aug 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033223; cv=none; b=FQcR6SVRNzeKHsGoFUheIt+u7RtUiY1gFi/J8q1RqjasbFH3MbS0g8665m50rYneSELav31agtVWEhCwlipOA+NBjYeIbDP9sngI7P3qEEjekK/RxO7dFJjl7qjW77z6GxRMTJCaPzlD5wafdFqV1ltwuJjq6sJbUpu6uvqRI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033223; c=relaxed/simple;
	bh=89HORkpnLHhTglgmgflGAu9nmJZk/C8g3RYgN5/yEMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chrrGyyDtfLA5KEYPFJ0IlwW/KFPKWcIfinojsyA/CJNKFqAOShsxfUCkAYIlyGuDq+fJpioRc8nqSwE3zxcEWz5Q2lYNZcm0X7EMPJ/A1g5DcPFdYYPS8ygjyWyLLyLkeWFzUh1l0n9BCKvXits7DrHThSr7Z+KpzGqUbdjTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLF14kgK; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6199bd724e1so1415248eaf.2;
        Tue, 12 Aug 2025 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755033221; x=1755638021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kw/KFo/LHx26cL0RFRltD6D4t8qDEavgai3uT6U0q6k=;
        b=fLF14kgKQKAAGV1TUIG2E+3B+BsupHqUXEscTzW3rLyJmmcnLi9c0FAkw/GIWy1sk6
         ZsapmiEWK6lYz3Bh57NN9J/4Bo4kaqvhVRaLTF9gXS+KLDmonUCEA7/S3fv85Bemam0e
         lM08NQHcOdmeS8xPBh8tmod0O2YFsL5NfBxTYlt9WqTL26G4u3YwyC3yBVg80uAIlBEa
         SFQ3n2YouBiSX52yMCFWjf6NSKW7QqSJjWHsUGVoLLcQsexJYa3yH0YBicVahauIbTos
         J346fd9jD4wsDr6VcSo/bES39lgT3I++qfK61lEKIpG+mMDcysQVBoEtTpcXMy9Op38s
         lxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755033221; x=1755638021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw/KFo/LHx26cL0RFRltD6D4t8qDEavgai3uT6U0q6k=;
        b=Mn+ZJcVR6VRHYFfnluRhXlYJA/3UX6GsxmfM6uB3Di9pJZcNN9lg/WEwaY+n8eG5sm
         xJMhZmiJyNfCgs37D3sZBfvJWkdfOr6l6RgpwQtU2TcuPM3OQ6FJOQXhuK/XMCWcgJmd
         dg5d+X1O+tsGHdIvmcUr48+EWi8RFSg6xfaBoFL5YqBY3uONPU5UsUCNPu0xSY5dQr3b
         EeUX0qqUI1FbULZdMwZBjSu8m3NrrgnND81aGRQ79QhVLaxlCzEVFgDHjL65IlXGPWFK
         XPifbe52+fEGZGcnqlowv9PnfPLYGIeeZGkCqT5xXk2zNDjjfyyO2HokakJ/UciS4rhn
         r0gw==
X-Forwarded-Encrypted: i=1; AJvYcCUTajevWchukjkjPUvrirn+B2Y4zi1WmlbS0m5yP5KtQiOAZ9dhFmczpmsg23Cj54SChLzMjPjJ@vger.kernel.org, AJvYcCVluUOGPv94DJrS5WBiQL0DaQIror3chA9VhGm1Lhn/orhVAnVim0wkrIY64qypOJgvb5VrYVMrIvgtefo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58nYab1zrpF70E//4cmSnoDxGR7jstlHdZHegl6mf/paKmJr6
	KMykroEv4zUFilBH9gAxKhBP/ECAw8DajaR5HiPMKrCgr+cQmyrpcj+s
X-Gm-Gg: ASbGncs67XeNkMemqtjsBs5MjzAAwBViNwHpkurnexBlDXLOdQFtlk9uxf1d3KJV8LS
	QpkDtEi8AQFgJdDf7LDyC69lYC0nX/eIsC2truB7IcmJMo3wz8TRuvljR7BKmrYIycjCmEy1aH0
	xbMNL0pAxvTZuijvnMcEZmEX0f3baPoxqjs58tADg3NGoCS4fHHSphCeUtUt5BG99Lh41rJazH9
	j+Hgp4ih/xOqo9F0bZl6HGdtjeZ2KS8C8y+b6bPzfRm1E83xEnj6yjbykSP++yt7FCM6uC5DeMJ
	wJmjgzNr5lEHzN5ZCStlmbRn+v7StofT+H+IDv6sh/jri5DY+AN6EeOE3yQEurFxGey3WAKdUww
	HHrgAgwoQx3QfCsriyRYC/bUmcIRD8OyVaYMVu+mq3pfV
X-Google-Smtp-Source: AGHT+IEzkJqt8YXtZQ5APn2SJ9WpGNWkWGrefioWYVPwmQVZTE3E0t10Zwz+RfT3lsAU4t+v0ZuSVA==
X-Received: by 2002:a05:6808:5192:b0:434:39d7:cb11 with SMTP id 5614622812f47-435d4165486mr499491b6e.6.1755033220795;
        Tue, 12 Aug 2025 14:13:40 -0700 (PDT)
Received: from [10.236.102.133] ([108.147.189.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce700cbfsm357925b6e.6.2025.08.12.14.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 14:13:39 -0700 (PDT)
Message-ID: <5f5bcc37-ff5c-4cc8-876a-b99e89e3e894@gmail.com>
Date: Tue, 12 Aug 2025 14:13:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/253] 6.1.148-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250812172948.675299901@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 10:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.148 release.
> There are 253 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


