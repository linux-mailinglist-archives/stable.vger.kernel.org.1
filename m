Return-Path: <stable+bounces-199910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5179CA15CA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B9CF30A35CF
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF531A7F8;
	Wed,  3 Dec 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdXii8vA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003F31B101
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788547; cv=none; b=UTAvkkybm4ll3Hyyjb8h1k8Azj7v9bt+n/MUTCT/JQOXK+gmx028QCYAc3bMmVpZq2tcpTAJ52XAL2qIGCJAleAf56+GgBxm5hMkBRSWPYaoIbvqUBE51ljB5kKcAWtbSqNZP+iIMLsFNn0s0lBee3eoytI35xRtaGwctfGWHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788547; c=relaxed/simple;
	bh=gSUprc+56YUzj8fgsqVZWus/RKQibX8RMFDe6L0cHO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAkbt9d9U/YZfBJsULlmrXI6KP02r96Xvqj3pl/ZCDG4q2LEcL9wu9H03RvfiAKVD7kG10/lwQ0oGawWI7vYd8KqFnn0e+l8cX88yR3GLQp7XZ/wnePEym9ly0uRiJhXg9FNEj9gnuD60Io0N7trkf5+gsh24qqqA87ciPDRn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdXii8vA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88678d7ed65so317986d6.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764788545; x=1765393345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qo85Dy+/DZbtDoZowQvrUVbRsQBc0NiAo2e3EiuSU6w=;
        b=VdXii8vAPFX8pRr0jNHDKsvI4TtjjymhGOSJeaRP1tI31d5cyuUkzKQV1+GSfwutR0
         JDM9+pn8kWtOHGUziWnPbs8eDI43qrjSN7+OAIQxvInmMore8bTTpuFrH/BHTf2/vSB1
         IFU8fQGBvwRnPpNb7ihL9/wptVyA8H2oVNi4xQCmClRZn8iE3odjictgkbVrPEItWH0N
         T0jqFiUxr0Gff3f7JRBT8TbcB1wakifLWQgPEFWe0Lh+Z4JYv4tzxj3j8WL+GKKnG8pj
         jbS6Zy+BwwAvPndI+klkWSBUuy5eYJxYmdsEampSoL0oy9R1dPOBcSs64UTfph38cA0o
         W92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764788545; x=1765393345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo85Dy+/DZbtDoZowQvrUVbRsQBc0NiAo2e3EiuSU6w=;
        b=w5AHPJRZRUL/EEYbCSSDoljkFu97M+ls0AnUseH8Skzkh65dqKSKdhXvqR0WEIt8z3
         ZjX87H0VYOmFTEepq9vOde4HHa6aQlz0iZUsHpp/bimM/nognadVkZ/xhFbTAzgAkTBw
         k0QxvgYUjUVQuytCbWck8eZtX8+2V0PHPw2fcBhCsRNfhVb33C+7pKTLU4S1aM9tjQ+0
         zWsc7a2p1I5CJStM/njPR+t00z3cLtoXJGGLnDqiaOYtyXqcBBMF278Xj9LJXT/n0QCv
         IvALVBGcDdyXU8DimRCjd0o9SV63IHpuUz/FAamt99iakdATM5mX8l5YwnpIKuJuk7rH
         lOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWqiKr7YqbV9rg+1wedZJ+MWT4ubp47qbtGkkLGqIgq+j+L2EXft7HlXTrv2zAEO9ahhzmMkfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhuGZ5QOdWqZ7p5zgr4uEh2MHD7f3vBClYnV2Aq/7i8FbEbeW
	HYZMWs26nsnAjBNMtHrOswgMpCxHLz5AZgPpPzcZ78rv38yMVXPXr9BI
X-Gm-Gg: ASbGncvbbICCdY8V0x+8m1+xBZ5gtYysvcPEfmr2c0NL6Ws62xpLDiUnP3efts0TCTT
	J4utemUsIVCnR1yIPx1fwB1Aif2dPsNCje/kmt7tDuA62clXeC65HMADxrNvnCZ+yEc0ceoDVhF
	v1h+wassJZS7NFTvj1er+yXEXLSRbC+m+hHrGQOQS6iw0s562STZTV9NmnVFbnNYZvg34JRcJ/H
	IObSmnI+5aw2za2NJrAI8ziwTg5McPUOxfH9eqANXYop+GuNyO7mZoCE5Peze+lTry7lXjnaWm2
	dB7pt2X77XCuHCHxNBmAW9MAxPXebBFlfE+dIygPO6WM/rIDaJlJNusT6GEWHXEuVfWj97zjv8c
	uHliNVhi/k/OH1f3H1gjMl6rxKtqphyPZs1dOk1+Q09H4PmL6kZyritny+a/mG6+ks8ezJAAI1n
	NacsEAsYAMHNF0V7103zy0yaZ58kCKmK+XpeL21A==
X-Google-Smtp-Source: AGHT+IGZ7M5Ek+9KL7R4MHRIRNdNjbT4XVu7oyAnvEmwQDhAF/XU28LW0FKfaZ8VuQvsS5yo/iOomg==
X-Received: by 2002:a05:6214:2408:b0:882:5e6e:b94d with SMTP id 6a1803df08f44-8882489d2bfmr5970726d6.39.1764788544617;
        Wed, 03 Dec 2025 11:02:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b493f3sm132634746d6.31.2025.12.03.11.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 11:02:23 -0800 (PST)
Message-ID: <58dc6e9e-f16b-473e-b7dc-eb7a2721c729@gmail.com>
Date: Wed, 3 Dec 2025 11:02:20 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152346.456176474@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

