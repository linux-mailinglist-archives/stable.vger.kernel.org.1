Return-Path: <stable+bounces-209965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BED28F71
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CFC30145BF
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04A3168EB;
	Thu, 15 Jan 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZclqijV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80148328638
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515291; cv=none; b=lKqTMcBfNOQ8H1daaYg16BrnpT1232pVZvcJaiYAHsaaBiXLwHrV0H9Umjvrimgh4wkA+qBJkHMY8LuofJuP+91m5PCdSkkgDuXt83mf1n4YbbHSIyDtzu3AZduLg5u193+w28zcbfzndRs8heTupZp+BMOQ37h8AxvzaG3q/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515291; c=relaxed/simple;
	bh=vYqybl/OXg4s7EVnnOq0Ov2iN5/Y0nfO6XmXgwJCpD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpTLwKgZGajAuH+5OGlVFywRpM2ZJv0A8Tj2LzNWVYdwo0IZZgJoteKbmXgHm8Xj9cWXXkBj1j4whSUtBEaz1ZQLAdtzPzAusJuoujTpxlWCLJ5laiyCcu+vd92rbBLm4/OPu6TYpOHARJNvInEI4XPsYg2mjrPvIZppwA6Cz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZclqijV; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-121a0bcd364so1824817c88.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768515290; x=1769120090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpivhtXYXF+CbF7riMiVosJzkbcZY0t+v9F4mqZiLjU=;
        b=HZclqijVduRzp4lMfCF6HqKpumSp/MVLvvGdnTt8QIED/jhhMRzQzwvGcrI+C55znZ
         ERNcRp5hJ2EiSu6K/ccJkf4YB7iAWOiyqA9Wn8aiQzAIWULAEs8br1jzw4T/D6L9ckPW
         5n8OxhC02GIoiMp1PEWrbpcTQW9tQxSE7D8AdO7z62wpL8RXrg042M1kQdba3xbJaPw+
         Zk3fXmmarETnjEiCrsyTAx2KGMCu+hU64zE5vGl2KFKzqrlSrpyvZvELBtBF1pJTZ14Y
         9jQnTRewxiQLsx0m0mtamVhIvvFr+KIyo5fl+mU3Ndkhr4735tcQoMT43z/geGtdpSRe
         2Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515290; x=1769120090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpivhtXYXF+CbF7riMiVosJzkbcZY0t+v9F4mqZiLjU=;
        b=GpK7yKJRWj7d6E7rGyB87o0ZaXushApIEyX2ImY9RcCtj3bVITdpLEQjB/QKS7qQOi
         2g6dba427MrBB2HY1wbLLZtYt02uEKjhaChjK4VVUam17bjRhfnVXcWFKvQ0emJ5eP++
         /SMdGjTO6Wc+MSH5+LHC1YcR+iK5vMPZ0j1lp07mOTRfzOj9kqeCvL4A3gp415RC0cfv
         jUO2msB4Qle0k9AUMwXN3o+KUZc0ZKGiTaj8YR/BYq//GMVNVjUCXCM28FnJgYWtHRnY
         ZOjYTNOG0zjM59Tp/j9kEzbrGxLU2IhbNcZBWtvTrvazSzbW5iSfewYlYcPC8FntEr7H
         nbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGdb+r7YOqSJl1sj92SiwO7JEiBwWJuu+TLUls2xKXsX1vqavTQTf/V5W1CFhhnoxRtYbY430=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrkZ/Wa5VQbuIB/YKUqRcf3NDD2enGrARq6jXD484+susVpan
	XQfzX9JjwaAkBab5nN+clIJyCIfx6/OjSVN6HOX7sF0zkktqnIkDz/En
X-Gm-Gg: AY/fxX5KNDEJL7En10YoxbFu4+TWBx4iewjxxJMQVtBj/r/JB6aocbS3jC07ZtKsyqz
	+iM05IEyyX0sTwhmAHFW0G+uFfFkWFiG9j9wX7WyCmvoiEUfHfXdzPlOglYCWftEPSCkY5AQYLV
	TXhBP4EcupQ7zgJrVan0FzKs6jEB3vlulNhHKWPy6xtTW+m1dmPRptv6AL6vdT/xo0fogq22gMd
	TfkZ8DdrB9qLAgW8KspboFEvQ8HSVInUF0GMQ5VRxgfX+3V0O1Luu/Ap835lX0vRf5kY7dmJmzJ
	d2S4la1oCobCpP8wpoUwnIjRbJNetl36TaPinav0bb6sDwKMeZZpfz7hOB5s3ClNpWakDjNyju+
	1kz3MBPiv593dupu1Vfxggzjw7/JJC6V+tW/BansH+hPWAJuK4XL3N/yE+KbgLLjEJvCVeL5oY/
	Pae7SdG47zP37LHUQNmfCk0W1kaJ3ErNHSOkruSg==
X-Received: by 2002:a05:7022:6085:b0:11e:395:7dfc with SMTP id a92af1059eb24-1244a766f7amr1197969c88.28.1768515289267;
        Thu, 15 Jan 2026 14:14:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm841918c88.6.2026.01.15.14.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:14:48 -0800 (PST)
Message-ID: <4fcad9db-9dad-4fa1-9d6c-b60e253d73a6@gmail.com>
Date: Thu, 15 Jan 2026 14:14:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/72] 6.1.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164143.482647486@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.161 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.161-rc1.gz
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

