Return-Path: <stable+bounces-177606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97676B41CF5
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B561BA4FB7
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015572F4A1B;
	Wed,  3 Sep 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e92HU45K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044A2AEF1;
	Wed,  3 Sep 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898580; cv=none; b=oulXGOivLnPU/3S7SHH0sr0wg+K0PgOT+pVul2l3dSNVX/W28ZihWonPKgM+9AGjWuUD2NN0dSxh5ofY209xW99h8Y25neKYO221mAyXtEAO1+ZxOFEhS0BeS+f4ERCctADS6KVpSGeMtzlRtW64IAnUiWRhiLJ5YSkF9B2kj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898580; c=relaxed/simple;
	bh=ry81iS0pGaI7XZRk71tdZS2K88TXryKY30M0BvG/iVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoYnuhp2YJhCRs7AScVzendJTuBfT3oo9QzTPJg9etRYO0HPJySRpqedrdSthWvsm0/jSZ4/91vLwmmClwC9rvwO4JZQ3zHi3Zz56SAX9I7fXDuNHPpIpAx2Nig9x5ftRwhJDEFtQZADp5T/UM2OFOpRW8y1NP2KkPOmMEpQ3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=e92HU45K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so3636178f8f.3;
        Wed, 03 Sep 2025 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756898577; x=1757503377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5e1JnjYPgVVn9KqEgl99sx2QQmKXXKL0ffJeLfTd2k4=;
        b=e92HU45KqFnPWQ0M2BVodhM+w6j//hH1irL/RiVfxI4Vxpsw0cUZqhgVqgqoo0iA3R
         1QCrWSiVOQY4EKFAAOkrfvSLj+RR+mB02hOKsLgNDOYb9z0cLX/igg+JvUSukrym7rwX
         wCuK8eFnsshJzZTGUn3HcmXtpvRHqHyMMPbUpSmGR/tBUbJaw49oHNN0d0ZhT858uudK
         RLziAmRTpMdgnrnuUYzAqBETTnc91GVUbxGzBQ6bBJHkn9yeimtaOS3qjqzxqZgwvyRm
         UWPy2WlKdZcYVXz3qyXGq98/sz55mUO7sxXj7fX3mIbuxXSk/OJRziGhvMLZuox778j+
         VCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898577; x=1757503377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5e1JnjYPgVVn9KqEgl99sx2QQmKXXKL0ffJeLfTd2k4=;
        b=bopiGU7Kq1C8i77gMslG2pBFi/j8tqbBJFF1T5wVW7WFoz/YOyA6QX11wKJ+0gwTaB
         g07pXWHN7EiGY+iMGGPyM5mhKa7rsuUQ/FB+ppKIJZtppXTRxxHDqwxOgAcMRhOjXa1Y
         84glO8dcBtZBSU4kfV99wHNsa/m/7Y/gyWGqtpjOjvqzxlTjELQ86b9R8XvUryMMaNxs
         zhHk3Ub90NXEiuTt3BXbWqv/BoDzBuP4MgvYzIae46RremU/86PAJZ405fRe12BM34ry
         558ZfWoZACYvLhdsqSbJDqfwrjJNBhk3ayr2erB35/h+ZWC02iRp1+j7GzuMGctsvvgX
         YMaw==
X-Forwarded-Encrypted: i=1; AJvYcCXtiHsLtKhz5AMfCkhF6NwyZ4yWK0I7bn44fycvlQeacC9t0j4QuEDWdGq86vrOL71eqzsPKpbrOuzOVio=@vger.kernel.org, AJvYcCXxZ60KfujA5zHzg70es39GbrCnnHKPCtEoPyq9xHb5k96/9tIwt0WKnrIwgFtUHUxeByezQ7P1@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtBmXai987iGwQSGLnEdHkVbBxi20nq8u8JvVJJ5Y3oeILkS6
	SzCkfnxZV00vOUj6s7MSfez3UHzwlBfu5A3XQ+TWWvnEGriV9+sbU7I=
X-Gm-Gg: ASbGncsGJeXiDsfenM4U9cGwIl1pdlIvmds0S13CTPWJan7WDpTRfP7rnD+iBD3ll/T
	RLXAi6wlBaWVorGYxqq+FK5RdRBx0X5+qH4CzFcmuBmD6IHtRR4F0KRiHBbrprHnsOLMBKO5Jp0
	ER0HlRddga4i57uk3lpXfxkXAarwhkSE24r3MI8bH+KoT8KDn+Ybo79pZ7ggL1qbJMil84U8J6A
	VCeYgSuumayao3zayiaCwJG7wiutGfLedfzIqGSaDJBCEMa9sP64BdFo8EIEQWCaDx9ISKSRI0a
	Y726k81XZB5a/FM3NDbq0rRqHcLIm72FmW1Mrkpg0tg/lkJUss3y39lpuwEyV3k9j/vZblbDDdE
	43Y0iTi/NXyCbVuH3DV1GTAiUK+zzrLYLY3kqe5oCyVYhHGmEtRLOFrhV1fmjDCHErciN9UdJK8
	uLIe3p5c/G
X-Google-Smtp-Source: AGHT+IHXczgoBb7IZ7vMKaLTiee6/vOOSD/DZ/9p0i8RJKBiMKtefvnzDC6HuJZHVEN1SVqxNlH9Nw==
X-Received: by 2002:a05:6000:22c8:b0:3d4:d572:b8ea with SMTP id ffacd0b85a97d-3d4d582029dmr10150571f8f.34.1756898577303;
        Wed, 03 Sep 2025 04:22:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f3e.dip0.t-ipconnect.de. [91.43.79.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm240541555e9.18.2025.09.03.04.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:22:56 -0700 (PDT)
Message-ID: <bf34b0a0-9945-4823-abba-5ef568fe2152@googlemail.com>
Date: Wed, 3 Sep 2025 13:22:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/50] 6.1.150-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131930.509077918@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.09.2025 um 15:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.150 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

