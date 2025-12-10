Return-Path: <stable+bounces-200743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACECB3E08
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 464B5300D301
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FD329378;
	Wed, 10 Dec 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAudeQny"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9B31D75E
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395698; cv=none; b=V4m9d9nA0sffpYYSfW4geX5+KncoAbxXTQMbUA0xEKpERDLXOQBxzoZhmSgRXD4DoZnAV9wpxnHd4bQyI4OZFweHBYHezbfgA4S7YA/p260sxRns07YvlUkJIfAgH8wLHpjuAvnVnOXDhh7lb5J/nLpwQJH9wWJOO9f073mevpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395698; c=relaxed/simple;
	bh=H2UbaewyYDxXbGPUYPl615Ee9D0OcnAn+pJ8ldB/FAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pp0LA9wwJ2k9Myqz4SM9gvrIuKPIxj+c+xis9GBuU/vaX/pj1FgXynNn/QhlXawn7cZ1nHkNGyTrjzrQlJ2KJgAP4YitFBw2qB0v1LMOfsX4jrLDtAJrMjYA6o5K2j6GrcKT+hmP9ZUbHfQP8NTn2VUPnB2ZIQ4AzRkmduG5yKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAudeQny; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so202205b3a.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395696; x=1766000496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ayWZzup3rNWWFgGka8ZcFlOv9iBXAIIL9mvMssIfMU=;
        b=PAudeQnynaCJdRj/y8Lsk3eB1ZJzb8SKvdvc1lOwwjYdqFDc/lmRW8meqxr+vhoBK0
         4JCrC7k2my01NB+Laf3aER2uPfeoVujpoOn4h+bRoKK4e8ASoQjqv9oH0Syp854BKp0w
         KJxWQxFd/B6haDJtGl0I3RXg3D1xrciItKphc7/yzjAi142+8Jv26lp+fFFpYkl5RndN
         cKaUmAdbw5EHzPfcDXlkYux2Vhm8x7GdaPzOYdsZQTS7FpGHlns3XEXE+AEIN1yPO4Cf
         FSGGy+zYVd27cX9QAicEJ8R/dLEljkCO7YuYnHehKKoQAcWpOsEKaydurOsnGRKUV+kT
         pk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395696; x=1766000496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ayWZzup3rNWWFgGka8ZcFlOv9iBXAIIL9mvMssIfMU=;
        b=FnNrnJiNFcRbpsopS9RDfIxss2lrjIXQFfRjGQe6Qym4MXabgQYIotakL8FYNgpI/f
         /AU7vencjQq06T0CGeM7nqYza8zVELWO3idz8TQi9kMvb761efdOFz3/rjBdmuq2UkdP
         l32fRXEFrO3rBnzkynL564QxXl01c/MV0bPIRI8bH4u/iIns5lVkYpCyi/jze/sZoM3g
         3u1x1Bu/hO/fW9la4Cfz0prxI/KddrbPj4V1t7t9p2n7/sOGFfqyOQfG1YTUcIjla7ik
         TRP1KvwaFdWs0KvQIjwQw5hD6Ck07SQzJe6NmE9nEX/ClTgYlegmXVYRiWIjpXs2tkxP
         JTAA==
X-Forwarded-Encrypted: i=1; AJvYcCURZLBaZwk0DEBvd0ZTJmKgCnrLXQHLBMksCxpfriWUZQgL/UBoRqjKePnUkuDw/oOiW4+j61s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVD3LStzyqjsY/0orCAbPGUy14MqtpjDvd8kB2xsUS1elNvGai
	AvHn+TF6DP460+pSHhCEwLnSyrvXsOf5G+14f+4CXWj6VwgkbR4K4KL7
X-Gm-Gg: AY/fxX5BmT8NQOR23VvPY+XqNZFKunUKLKq4SubSnYN0clNv2DBR2SZHZ4vt5E54Q0I
	IDk9QhydFiZ6siaPimzkLbVe3eemLQRRs6hFmMcYS2ci9CfBiAe8dOGHFthgC/mU/iNsBUqxyEZ
	FuOO96jZU30o1B8RN+jd3iSWEDsx2PQeHUZCoXaXFwRoreSAxSvOP+MfaJMBrBr9AbaycL8wjKK
	XD7loK23Wm942YxB90VGFS9ddIp1zAkmcpAUYI0Ylb73NySM0LlD4q7jVhzu69y1HSS3swMHgb8
	qlPvLsHTsB/35zxpM4aO51pTiZPezdSS8wNDkgV5EjSoR1fShj6VVB9bmdfTWAmuHl5qGtTXtMt
	VVdVw5gFpPZMInZos8RGqSFNf83GV7qCt6RqzaGY1B09JskYYhoQEGdoFC9LgAjgtNct3sV6z+6
	usijhVqoZA0ocKWzDWDdmuulbr6mtx1wBwHPGJqg==
X-Google-Smtp-Source: AGHT+IEPZtIv2trsU7XOKEqJGqHY/PlRFhDAgs6iI1I7+3++Yd6TxqMeakvcI33scxh69FctDHKnSw==
X-Received: by 2002:a05:6a00:1145:b0:7a9:b9e0:551c with SMTP id d2e1a72fcca58-7f22e09f895mr3415890b3a.21.1765395696493;
        Wed, 10 Dec 2025 11:41:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c509415bsm294854b3a.52.2025.12.10.11.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:41:35 -0800 (PST)
Message-ID: <a9283ec7-993d-4de2-8ff8-ee48a12a5124@gmail.com>
Date: Wed, 10 Dec 2025 11:41:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251210072947.850479903@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/25 23:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.12 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Dec 2025 07:29:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.12-rc1.gz
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

