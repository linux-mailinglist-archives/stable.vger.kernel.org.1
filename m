Return-Path: <stable+bounces-110218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01269A19868
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA070188988A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3D215F46;
	Wed, 22 Jan 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXLoFT0t"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F221578F;
	Wed, 22 Jan 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570294; cv=none; b=SZUpnFE1sdhsMEhsq9lVb/wVniDNUls7djXBMsXMQGi6oDBno+wz4U80NiPkL+MzSzC61xQlIqVQLCpbGEB/jnFHpgBNC2/6At5zw7C293lXW3igoD9KsR4S0hSyVh2tc9ybeExxgoFOmzoN/FTKHnNJKjtSeUz7HmaB++Acaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570294; c=relaxed/simple;
	bh=xh7zLoMQOjcaM/STUaHGtXRn+vPaUHEN15K4WYtdl6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVhcSJVRpkIrhBtc9MrKEAgVkts+TsFAz0YWMNHpY/R8X4FFDco+kpqDObGusZLxUHXW1QVnQTJVj+pBuNLnzKI/xzluiekAWeOkTTQF/WkNuHA2hf+tLigSwlGJiztSrqSU/QDbcpQ32VqaKZwuGSgB5HIQRfAxk/+ZE+DP2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXLoFT0t; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb790888c6so33115b6e.2;
        Wed, 22 Jan 2025 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737570292; x=1738175092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cswVlj2rHirmLrWsg4FzAzYo8xKtur9XHV+F/JamivY=;
        b=JXLoFT0tg9OekV2L0ecJlhiVlLOkuepH8gNpbtsZJY8wkobVrhQHLDfFL5ZDT9rsND
         r2AwJ1bEHFuMszICU2+RpIhv5WPxvV68mVJTMJ6+g6TSc17cUVQScxhzQVrluGvzqv73
         AIp/9wR3VfAKZ9TVfcnyQMRkXY9LbiVDKXsiXto60gJ5aQk5wlqowvAY6MfK8DZSw1ZN
         qv9MafS312JcP+x5tZSAYWUaWFVdintDlGPBSxMeQFvVGfvlzusdm0SY3A9HTxRrsP6j
         E6tazH1Zm+PzbXA3OxjeUQDrMrdH12jTmJF1uN0I/AeB2h0vLKqpXNoo62TAIdFhjrod
         Ydcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737570292; x=1738175092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cswVlj2rHirmLrWsg4FzAzYo8xKtur9XHV+F/JamivY=;
        b=ltag/1qTt7BG7ztyTeaOoi8QT3boOD1ZebWT9HLeSaO/VTT2Tsgi8v1GtTJYxQe1ZY
         Tb0YgY8l4OFDqmaL8wGZB1TtaTMhOUst7e876ipuw8WYUW2LemR2JM7WttWkC+FqYpsU
         nhWH0pYJIDNXc7O/hrlXC2gxgwCg6q5UZogQCr27yEQqmu7x0SXD7ZpDRGKIblc8x/B2
         r87qTBU9zwOr4xbMkcLLpU7P69Cs0ZMKCxGA+j2Lzm25PLkuYtZ2T4IIIUM5rmmoTwc7
         1XOPtC+XQcvce96UHk1A+LmU6amPImO5Ss8TWDSLPM1GMX8efY7hobSa1RhQOU09JmsT
         DziA==
X-Forwarded-Encrypted: i=1; AJvYcCVv49qW/40B41l1QWBIlJdx22pnqsfaqwUDohVq2TFds+c8bIW7pv5oc0B1yiu1+/xeRuBam/X0nqaJLdw=@vger.kernel.org, AJvYcCX3ORWNJnBwCJ6YjMrDWqSX9cbghtdU/GW/g0Tn7pryfEv7/UTRan5UNKINySNndhz2dEDJAhpr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2l1bfUzbhnJ0znbXkcI9vpt6rPuockBI+N427uexZQpwTeAJi
	CQF2twOHUWPxSk8IASJkEKhaZ6Lo+vSninqgaHHz1YAYEb9fMDYC
X-Gm-Gg: ASbGncubbwKO5b8a6r8UJKd7Z+0AWXW4pyrM0+n2IuiQiWMjZwSBKoe7/lorf+2AIcZ
	Vmm+BDUXYPrAms8zahQg3IaEk84NT1QLlnd+sCL7qszqNpJ4ur/t7gCkl9JsPsm+7vr0aTi4rgl
	SF1C4Omn3UHljG9DCmnNVMxjurFwls+SDPd4CRsZd3WqiO43h6sdObyhPrLL8ssGk6dmvg+Bpsw
	JwYcS/iLZQz6WUv9TWXvHOa/oGaHwm2pD2gS33QPE5/vzxCoDvwYX28jrCvabP8+pb9Op8afL+Y
	Hjv7VShM08ipFf2qfaJDz9dbBsuhliIv
X-Google-Smtp-Source: AGHT+IGM1J6k5OkVgtSoFl4ZTZ2W7kVZ1aY/iA3q1cI69tm2o+kqsEmEAUf6PO8Mzcl5FnfNB6L10A==
X-Received: by 2002:a05:6808:398c:b0:3e6:5761:af3 with SMTP id 5614622812f47-3f19fc7d842mr15416836b6e.9.1737570291933;
        Wed, 22 Jan 2025 10:24:51 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19db9eb8bsm3645425b6e.49.2025.01.22.10.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 10:24:50 -0800 (PST)
Message-ID: <c0b51920-9575-42d9-93ea-6047e1061939@gmail.com>
Date: Wed, 22 Jan 2025 10:24:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122093007.141759421@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/22/2025 1:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


