Return-Path: <stable+bounces-165582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D9B16586
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD85D17B38B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD4EEBA;
	Wed, 30 Jul 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="blp4qorU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C311B0414;
	Wed, 30 Jul 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896682; cv=none; b=DIMNA89C9z1val6Ese77IDL+Cem/jpmYI+lvq6rgebgQNKQQtQyJAbdJWsjLQ20q9OvgKszvVUi059qLvhjk1okS9k0b9ZrFPQEiz5opi61z7JXeitKgrooyVZO0mrgQYyyOOg33bWc7vxyR9NJmyopXrgV3pzbtXs+dqfgWaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896682; c=relaxed/simple;
	bh=wh+OxDjm2ky6TsO+BjsktO3Xiz+K1KybX+LIivatlJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB0aaxAOKiBNrHW8HreIdOcl2XE+0MVcrgWg4+hNOgFq73WSoS15XvLDQ43UNwEyIAwb925f7pq+MDAwPNVZy6m/4exsYAchrR6Karq92MaQckXtwtuNfxIg2Bd7Ld2ODIfKvn0Z5MMxH7dAql5Ck7rs6rSjxu5xMCDSmvchXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=blp4qorU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so614575e9.1;
        Wed, 30 Jul 2025 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753896679; x=1754501479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgAezQfpfvoELnWJXyHtGAEOwJomNa/aau3M286QXoc=;
        b=blp4qorUuFv7zc99GPoSRwRMQdBBW4H8B5xUUZ5KDJywvA+HQDSXDBl5bEtj2uGLOd
         g6SnvNgI1mdEwGz1WKmFxHhhPp4j3tsCvTEui+Eca+qvL+WSRD4Dok1xR9DtNUdEAkZU
         mqQmeLKNJcyOUiVUPSG+kfEPn1JLF29ugI8haGFOZLwP5pRrxdn6H/nUDxtz+AnNaAk/
         WjcyL001YNy6zsqQ4Nm0gGRJP73FfvWAPmRyNH0oKIBeBh3hzn8f0nAbzZDwZ5WRty4p
         hP4gZdztSqdpVh9nfjffWanqtPxvqNs1iL7mWZcio336zeSiPlQPfrqJbevHuNTxvBK+
         XTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896679; x=1754501479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgAezQfpfvoELnWJXyHtGAEOwJomNa/aau3M286QXoc=;
        b=TkUd2Vi4egJjBgqX/G+JQ3g+b8SpkOgJqR1uuOefmAlo0sQf/YwbhdmEHdo0YKhoQU
         UgSjedQ7oQPvHsEi17Qb4cJ+QtkFUiVpiHMD8ZHQxzjfxIiazFurc5hFYtB8can19z90
         +TpFma6lI7SQKR/z/GD64cvpfKRb/dZOQXbRUH6eiqRtO87lv4IEHCARwsUvKNUcCAFk
         VNAEWwFelXOJLpwwE/ZbfkclEGtBZXja8HotsLJzJHJTDqk3yBJC0ckyOIoPgSfaCplJ
         msNX1mITwRWOiNrPFPP9X6LRytECMN0vdRvdhzirmJInN7SYpwG0k+dyUe3HmiO8Ra45
         pNXA==
X-Forwarded-Encrypted: i=1; AJvYcCVPWyHMiZ1CHgn2pQgBiYksOpKl40bwF/qxpkBoeBVh9SR6xexgahr/6iao5VpBlLype01YJulU@vger.kernel.org, AJvYcCXY3wkz34C/RoT0Qw46TfqcwDBFH6sEEigbha7thPKkMp5Zt8JZ06izkSlNPoGeEKGcO6dYwP6Fx39tnOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2mURARXhaFfx6RuS9zo5SMFO6Sxhqib2JK2G2sfs8EkVMLzmG
	lT0qzkiGEXGtH6MftRU3CSXwFxziDGU6b2CciY2G53fBNVcI2CkGLlfslK7ZjL4=
X-Gm-Gg: ASbGncuPwGqy6LQOx7/mXldWww69MwKN87+5cJHzKJYHiv5hEJAJqBM9APfS83FT7Nr
	573BisUiNaWnKsoITS9Zy3TkeBFDJ3w5K7DRLjthO0Fe/Zru+Secr5nrD7wAuPevDPDb+yqfOzx
	eBlwVTUPg+Gn3eIMJL0ARrEcFyXShfwfyp5cb99AWFizvwYYncR1nkt2fBulCn9g+OPa6tbJizB
	Q/3Vv0ehiC1Ww60QdRj9HeeXO3SQu+j/5IMizN7lJ/l1BtTE/z8X6R5y/qlr9VDodtxUIDTKfzO
	A9pYO5azNwUdjcCJXuW3i0v2DD66Ag1LpGIghcL/qS1XsvRnNyI00DcRGxM18e70BvI6pNgwnk9
	CdWdmsz1buVA9PJ6Yo9Y0rrOGebaAOT+NBqysxMtF+FEw9Hl6azq4WnXVqeL09lqP8eK2fEuusq
	A=
X-Google-Smtp-Source: AGHT+IEtSt2YP/r84p7bemt90c5M7i6/iVLdQs6GJqDQf54Hhh+r1spT0+0cyprZiObRj5UZUJ7U+g==
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id ffacd0b85a97d-3b794fd5940mr3365633f8f.16.1753896679003;
        Wed, 30 Jul 2025 10:31:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4284.dip0.t-ipconnect.de. [91.43.66.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04009sm16894324f8f.38.2025.07.30.10.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:31:18 -0700 (PDT)
Message-ID: <5cc15441-1759-41f0-a987-6f2c0473340a@googlemail.com>
Date: Wed, 30 Jul 2025 19:31:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2025 um 11:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built wich Clang 20.1.8 this time, boots and works fine on my 2-socket Ivy Bridge Xeon 
E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


[    0.000000] Linux version 6.6.101-rc1+ (root@linus.localdomain) (clang version 20.1.8 
(https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261), LLD 
20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)) #1 
SMP PREEMPT_DYNAMIC Wed Jul 30 18:47:00 CEST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.101-rc1+ 
root=UUID=3842ebdd-e37f-4e4e-afd4-d7eb79b41984 ro quiet intel_iommu=on iommu=pt 
vfio-pci.ids=10de:1201,10de:0e0c
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000096fff] usable



Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

