Return-Path: <stable+bounces-111752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968BA23702
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E891629B3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7401F1535;
	Thu, 30 Jan 2025 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlA5xeun"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED85191F92;
	Thu, 30 Jan 2025 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274321; cv=none; b=k56iV3vAGVB7wNVMzsFuLa6xNzkTb7Cm4xxnxw0lYV0W/GFUWgmrczH7eHb8cAQWQItXFgIXCwoN2YAgNheY66w1RQC7Gv3GJND6f0fO0/Q/EkbenG/V1c0mbpYcwvjSX1iKxBOVuAmXaugaWnS07syZcT4MDOcpthhftXlpkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274321; c=relaxed/simple;
	bh=koBOY6WA4J7SvINAk61HqnW4fSta3hJHJZsswInLOLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGAXfQ+OKx9+IKyePpaX26rmTOPHQjV4Z9s1ysiDJ1b5O19cXjXzsZZ/tCjq4lIihs36VH0Ej+SZdivM5ZBLE+v0R2+UeI3yooZMQi0fxJNdvbDbFIoykuetk2mEM+zwEKL7FxQL6pdxkHFwOgBdt3DjF6va91uLp8TjdA6R0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlA5xeun; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb87127854so318754b6e.2;
        Thu, 30 Jan 2025 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738274319; x=1738879119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=45H8jazX3FnWTJ7rFH/v78Os4zB6WXeDsIdcS1O2AL0=;
        b=WlA5xeunkr8UdkFvfaJwgSUpVTKuxVCKP0Gk0Ztpr4oo28Le2fRNCtWEHaypIVgL4q
         Q19yy+i7YAMbPKeHGg9z0zzMVphnYFN6siCBDxN5+iCgRY1PwjtbIHoDE2PCycRNLFVf
         fBQv4tizTRzBSiCR+pxoKbT9RB8Wh+BWmg9WkTp6F3CzVKF/93f0+7c7hYKjFmHVyBlv
         tBorwo0MNiRoUE4/hs1vgabYjWHQE6fOSmA8KRqXhoTdIV7+2vhuCCW+Qt4faP6/jHuZ
         bolMd/I7cIlOwXBeMKslq1tPHMptNyIsCmEd6UvrGHSRrC0mSS12ymyDA8eUg5e6ARbA
         h+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738274319; x=1738879119;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45H8jazX3FnWTJ7rFH/v78Os4zB6WXeDsIdcS1O2AL0=;
        b=h5q5rugAIc+ToQtBAOJet5sI3HJnwW3vSjB5vCNGxggo1qj3B6bLUkRtZUlgPYFzHh
         9FEjOaemkx2P9fgMTxosHFY4BGcXB/wmjgA8++WhfwFhnxspfBqS8tqnKt1A5MjSULmy
         qbn61oSgAsNiPLJFo/p9qy7iw/yVBmIhALTMiLDNbezHI20Xevo61zDBQffewrrABxxy
         2u6ni8N7YLmudhqxIa8dBtQL5ZUCiE8AFs/jFMaBrAxu1QX+5RKth2oenj0ejIMJgRAf
         4bzPBpXDEHeGfXVoAmnCfaqh3bhJ74b1x3WO3sKob5WvaqjnK2zzeOWYbFwhlRzgp25z
         3V1w==
X-Forwarded-Encrypted: i=1; AJvYcCUUPATXOX8KZY2T8OHqIGO5Nrm9fmtbETBnCNisIomRZgvxbqv/ijrZdBYgJ0A9AgwG1/x0tnvO40lLK+k=@vger.kernel.org, AJvYcCXFpE30pMDVhpzsX9cw3AAHqI33zrkvJY25+GA0zq8NmdndTJJuTiaxQ+sosjnJIbfuZiiUOelr@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpeHpCT6JZ69AnSGi9dRwZiDoikG+0nW3VYEOpV50yQrjy8lh
	IlsKNfaYGEW8Gtq+hfVO4EMoVNwi8Z1XdCuRj9QyYwAZ9uVycf2H
X-Gm-Gg: ASbGnctfitPS7MiQ4FKQ5M41RkWRCraiBQ0EYxyqkqLwJAEgyLnGR+qdQdoVUl5SrvH
	dN5O3BDEXvoLYGOP0TNGfc5qbKXwtUFjNBJu4vO5CwutyUFYh6oA7ChFFuTNn3Kagx0yEVnDm/l
	Ro8b+UFLo5WYpnYlho4ISvSY0f7aLWq2Ruvru8VP9HmNKu9AjjZvJCgfOfHnYjIXSRlx3JS+Ppk
	On31impDSmbKCGEG6MpZDRngATq0ClAnoKWe68okZI7Zm0AOuVNFkwIufkMFVE83lGE9QmcKxYo
	pMVhl3qfxjvG1vGYjGI86V4XyAWOD9242HJ1bffiM+Y=
X-Google-Smtp-Source: AGHT+IG/5qmEC79tM3LwUKI+aofohBr4/LVVWbjCOfUPG82ma84IxgHWdr5ufZGuFw1H+G50YrLrhQ==
X-Received: by 2002:a05:6871:5e04:b0:29e:6bdb:e362 with SMTP id 586e51a60fabf-2b32f12d880mr5671552fac.17.1738274319477;
        Thu, 30 Jan 2025 13:58:39 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3565b64d1sm649809fac.40.2025.01.30.13.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 13:58:38 -0800 (PST)
Message-ID: <461f1fb0-2dc0-48c5-b35d-e7425e5c9d3a@gmail.com>
Date: Thu, 30 Jan 2025 13:58:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130144136.126780286@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 06:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.12-rc2.gz
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

