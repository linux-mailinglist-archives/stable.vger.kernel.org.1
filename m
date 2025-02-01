Return-Path: <stable+bounces-111881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A8A24924
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 13:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FC23A5D49
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799ED1ADC6F;
	Sat,  1 Feb 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z4mv9BOP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27C10E0;
	Sat,  1 Feb 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414384; cv=none; b=LHe1EtrVlhfH2Qag+rcUY25hVyUUQFrBQU/sHa+/Uw2B5Baxw6h2uzd6hkoy8OlIvaM/8ZcZ/Jaux/xC63YFg87hiJEoEcaxeZM950SDEfCYhWUtaX/ZzO8XitdgFFT9e8M31VpVOsAUUzDxinS3B3XaFB9WDTvrxAf3A6VFJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414384; c=relaxed/simple;
	bh=B0TIGEWdZpaL3Lol4tNzKJ12SBSCVyy6C3L/uyc1s+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HICEsZg/PavcBYGu7qJkUAtdTSBwrgQA//qm5FPwLpMk32qvhrwMcitGQQ44I4PqFXnMVHhM0w/I7OQRvzpaMdKuMBkmygDOVnC4p+1QV9CLZAVHelvNLDDhwcAqm4zcJW7LCm7v3AzaTGqz9om2YUDEUvzeO3kLm/qY1tR7+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z4mv9BOP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4368a293339so33416715e9.3;
        Sat, 01 Feb 2025 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738414381; x=1739019181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGsxzwmsm4FqEEWuqRJ4yrtu6EGS8XgJezR8MjxJnBo=;
        b=Z4mv9BOP+VUczQQ+BvqKcVynWtcPVRkTyGaUCDWnoAs4qXqYjfrb52tLakihavtyyk
         OILHmzLi+LwVAQ0BqOELw4IuMMEk3j7O5PXjM2nlik/Pq8j7LlF763yRupQ/8O3ulE9R
         7B4K/0p5wz1FQDQwZ12PYKyZdhqVPXDZEcsQsiIGYER1YnQ/mT7LqzR24TlTBPXG9PWc
         EHHZFLLwT0NC1jxpxWamBO7c4Tg3myoz/9MZPmGZcnHOtlrd9FVxyyHZq9wBf3EvoM8n
         3VIJR5SkRHakB0cOSYSrCpteGIfn0Uo16YEKQ+5H82Oe69YZU7k5VuSxrbbX1Mk9fArV
         qYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738414381; x=1739019181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGsxzwmsm4FqEEWuqRJ4yrtu6EGS8XgJezR8MjxJnBo=;
        b=HaE2C5tHvu4xg9rMup1W7C1cle4/e04r4iiQVqTuaNjik3op/gakRRWaCsl4/K8ZU9
         JnrlRZwSTQ3tfN+orDQ/GRDHuzqGMtTM73iAHj7xMB+G6Y++arconZIaICOwviUhnT6p
         Ag3V397SYF7qaPE/Ljx3FDzr/tTD8+zZnmC8JIcmZH/KVHuzunBRL7gQMcD3WyXf3jWF
         eIJwpxdwAaai1GeEQVojRfwBGTmg6cbwNfzCfNMxdOaYmnWGSmWwMfxzj9C2xnbrALfb
         neZ7QWZr5ZZuUwcADcDVzeUweZ20nb1A6lxpO+ah0Iy6ANLk7wi+UVPGaW9vj9qoLXcI
         mIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkP41e2bjiNLxVb/UnVohOZD+o2xQvMNZ43oh47QoezqN2CUrNx/R4XbANCA4Kjvs2vK8F/WSY2ju5TI=@vger.kernel.org, AJvYcCUmi4aSbRCEWcaQTv+h4PMQ6demsMdRoRjDbsnP9DfbB9I/5jQNzBgSb9YByiJjyzzfjVJpoTB8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq/JDzTlMz3OdP2vMPtgzXxEDI4LYSlB4+yVWtnXrqdDt3OmK
	Gp1JMqMuj6gUrOrNL7oWdTKFd/RgClGg2I9aQ3e93NH3IrlL1II=
X-Gm-Gg: ASbGnctAUW0SMUOPwPSd2LDC1CBb8L7D+ucqPVkx5RkPiQPL1JwOCLW7uTPYYi/ol+t
	9IhzFkI9I3RhBWcGVYsbePiEKrqHAAs0fkOcz4Ma59qXX2hpGjUJgXSkuUbhQgS455536Xr8QKV
	s6Rktt3aMFJksqzGp52pCDXAjN8i2c82kOXgp/EKgKao7zarXF5BFjvGcWmdHbl6yF7ZS1qqpOy
	QMK5D2W7nfDQhZ1En/VQ+ebww0rlDho13D16P3LppJN/a2MARlw6ef523hdl119Mx5c1ZfDsP/I
	coEzDlP1kaJo4IE3T/Uem8yryko2qes+H/BM0F6db9rfvMOFwnM5RG0Zc8gt45MQVOaN
X-Google-Smtp-Source: AGHT+IGCEfyjj5b9m0JsQ34ThpMuBHu2HSDT2p4ga66c/LCQW36I9RZZqckINSMYQRGkgTGzxtY3Hg==
X-Received: by 2002:a5d:584a:0:b0:385:f72a:a3b0 with SMTP id ffacd0b85a97d-38c5209664emr12028127f8f.55.1738414380613;
        Sat, 01 Feb 2025 04:53:00 -0800 (PST)
Received: from [192.168.1.3] (p5b0573ac.dip0.t-ipconnect.de. [91.5.115.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ecc80sm7385784f8f.16.2025.02.01.04.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 04:52:59 -0800 (PST)
Message-ID: <b1fa39ca-be06-4f64-8595-75b6626442d3@googlemail.com>
Date: Sat, 1 Feb 2025 13:52:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/43] 6.6.75-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133458.903274626@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.01.2025 um 14:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.75 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

