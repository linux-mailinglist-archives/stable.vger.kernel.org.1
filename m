Return-Path: <stable+bounces-176429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B02B372EE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A79C1BA3F80
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294142F60A7;
	Tue, 26 Aug 2025 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TLptLfNd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAD274FD0;
	Tue, 26 Aug 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235903; cv=none; b=HfifTpgd2ezksTKUnSAXTu/nMXl/JOcTuaGq7b97TDICVjk9Kv8GTjesuvpPrV0sl8c3QpU6bzidB41LGBmvIXhzMiRkiQlITaNpwea8jPjBNb6U2ppMK/6u1oHNlQSmML3t7l4B2UYYcOx6EgGdzaiGaBMQPUjutkG4dLazuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235903; c=relaxed/simple;
	bh=r4n9AlJI9GSrAECXKbJumCIgbljlrp0PpU/p5zYJvXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVCJwE6v9Pzog/EGwa4I4p3ftDz2MA+ootMblUkkt7OjTAKxN09s5d+iJ5bqWSgC1ef8TXnER/nV5GTNittYrXq4su+74SIl/waCG9D4RvOy6esz7TPQdHjAItLsY9YRuTjwcSWlh6FLMZcHq9J4hE0j9i7GZVf33L25FN7q4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TLptLfNd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so34810595e9.1;
        Tue, 26 Aug 2025 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756235901; x=1756840701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrQoPThZjJ7Y9Fz9FPppmTbdMlPby6bxNAJJKC56oKU=;
        b=TLptLfNd57lms8TlZiOs9YoX1y9bjkKmOIO0ntZ+MEUM4+M4cfKLXdq7EmuJRVf8+W
         IX86GUDzdo3fjGi8d+DYmSDLElT1UC8zejtzhGtp4EQig5RK/ZRdARWQtdjhRqYADSBB
         c8lKzr8qmRHdndaOqWt8zAGfKc33N597T9HfphpZJB6pWegHrvLIUj6kmXdYkwspSf5B
         YAvu9PLBwQ3iPGHGlLptYDzdhGPxz1GySfCkjHOEMb/TzbTCtCNfjX51N3/ubPKLZgx/
         DDmh9qU3vY9WytUs+xl6IcfAM4VIrQ/qfhrmfZxDi4Pw9jpGSmbogXOOeB3zguwb7w9I
         LEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235901; x=1756840701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrQoPThZjJ7Y9Fz9FPppmTbdMlPby6bxNAJJKC56oKU=;
        b=NmEes4c6tpWr4DkIS4Gmkl27B/8M8hCs1dB6HigVOb6FwES2lQOlJtgMCAvA6Jdh2H
         gGnREC5nVFYHGgtQ9TcS7JKyUftcZI7OwRwoMgY+q3nD67wLgtYEbSTUs8ASGSJmTUbZ
         4td6krdfmkfULzD6WD1U/dDQlwkoIyz2mtf8fPyDu4h0em/AQoyPGDllcV3uiAZNUveA
         QSLPppmrWU59G9CK2yppOZ5VrvtU7mcKzYtPsL2F8cN20H7t38KuzGdhVi3R7+5Aw8Ud
         WySzKoFAJYGqHR8/7kFdT3gQfsX+DuXTWBPAXDzZlIVmmPP626oP6DrA2MJ/B9GKAe28
         G4bw==
X-Forwarded-Encrypted: i=1; AJvYcCVhjwRqki1+BjbSmVbnojHtv15Anj98E1p0+Rl3B/dAH6TZsYyf0ARcmMYJkJpR/ltyguhRvxX6U1hU+Fc=@vger.kernel.org, AJvYcCWcFabGm2V1oEfMCPDN7voxisKcqQvhlxdbbO89RLVtVmOJJ1YlDduEoCbxltzVdSqmsSGBm74u@vger.kernel.org
X-Gm-Message-State: AOJu0YxQitC+JcEw/S9Efvx1isZFo1w3vAKsgEhH4eQmo7U2xdeA+vUr
	VsghRkjzFYV7hDZUztnTbZrB/RQb6r8NZ8tGaBnmZmQ6Lz/Y7p4vcjY3COqOwJU=
X-Gm-Gg: ASbGnctgeEaamgt4xkNVJKMnu9KZd0i0+SEkt4bcaD9de/sHCCsEHhCt1R50Q0GHSMt
	o5VmYHToDHCbGyYBcRf03MNMA2TC2JCQs5dS8W78b8YcUlPwd6gcnV4WFmHdIeFrGtIBgD9SbNI
	y4i1g3MiPX0LXl7NzCURfRENaUPxQlXGdG0VFLION+y87BJoWpiBVZzBxsUc3/C0/es+5Pllda+
	RJAzDNogItDUcx9oRNLQ4FxGvvS3B0W7j0DQKlEUu7Xv0BP8MmXpn+IEV/3IWMPTQxegUeYbApa
	M8JRGg8E1nUjQM8leOyzYEqExwFKEje2o3HqdU4ZNjHR/qG8Jj/IqTRe2OQSvTfVWJ4ayBYpHnV
	YR3pHo8RKKr0IfR2XMO/Iu5xWrNhFMS7E6f03xE35VGjy4Je75VxStFU50IFDt5AN8JJPkQ1WA1
	Jop8mFkha7eXQtF+auaPg=
X-Google-Smtp-Source: AGHT+IEzVl8BZCib+8G1pZUV+hzUECdFSzGakztyZIS9Nsbt7lyHyXZ1qO9z0MNcP8N/hRARQjADpQ==
X-Received: by 2002:a05:600c:c48f:b0:459:dfa8:b854 with SMTP id 5b1f17b1804b1-45b5fbee605mr76053925e9.5.1756235900446;
        Tue, 26 Aug 2025 12:18:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b057219.dip0.t-ipconnect.de. [91.5.114.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6c53dff9sm4672385e9.18.2025.08.26.12.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:18:20 -0700 (PDT)
Message-ID: <e06db79e-809d-408c-a862-a6f90c6a35e1@googlemail.com>
Date: Tue, 26 Aug 2025 21:18:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110952.942403671@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.08.2025 um 13:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
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

