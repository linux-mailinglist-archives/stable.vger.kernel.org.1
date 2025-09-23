Return-Path: <stable+bounces-181461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E7B95692
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918791893E8B
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9502F6198;
	Tue, 23 Sep 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rbpm6plZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55562798FE
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622580; cv=none; b=Q6lQxf33hKHek/D87VkctvL15A4K420Sy+WqmHg1xIutX7S0mkbt+rskFqSaCvEa35P7FuKRjgLJ9S2gf9ZStP44CCEt1n1EdszR5b0jJDJNEJJFGwk+khytUsjlqaUQDn55Kv5TBZ0AfWMEjU8r8A2SJtbEoJKBWB6j+Yb53rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622580; c=relaxed/simple;
	bh=RYzPGdtC8EGMXt14i4heCA6P0dBRkz9jYtGI/l4OWoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q31aybk5D5neNcnOTGZPD8KEWTj1BZRhMDVqUgsbvmxLC7XCSL12L40lMZUI41wY8LRPXsA/D8VZ28uzxlVcSkzH7796aIYgnzi23yIFoblKFfHeLv5Btwdo1dU/p4yd/NHmMHpiK3gFj+O2R4zhnVC4u08NdEQ8ISxlrxPU/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Rbpm6plZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ed646b656so47087205e9.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758622577; x=1759227377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+sf++HoPCnwTrMW6zlIxHwkbmsZIiPjDZjaq8+brNA=;
        b=Rbpm6plZ2JS9egRscvNc3aWW3moyq10S96fqkAZ+B+rF9v1tWfh5iBfntQgPEtw4q3
         33MyD8xbITgOpymFAETxxS+chWRP6VxMv/wUayrXIl+v/SVsDUKcJwBQ3Z6bjqjISgvR
         1DseIYJvk0pIpVLdhVCspVeKEeipXo0iHdMZXlveA/3XEuf3tKzopMnV+Z5d9CEraCU3
         9TVwd6r5fKnn+SoqL2AMf0HWvp6gcFeFAEgu7ItYqxJpuCncfN3P4PnG9oBe7Te/4sGl
         FClmrgfcsVw/JPnAc4+0H6sR1R9Q2DWIQJQKlebualwd0JN/Y3ajR6op0xRb6CgXakjN
         g8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622577; x=1759227377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+sf++HoPCnwTrMW6zlIxHwkbmsZIiPjDZjaq8+brNA=;
        b=w1YsaSHsfZxCTdfqlVEK51VL6yu8qWhltMMycCeF6ojeMCZh+p0+0lkzVnA5eNRdXU
         m2C8V0FjGOkIPCs8dd57TRdmSUrhAFpB2h9nBBDNoNKJQmN5OSlpIRh39fi2Y4NO78Cb
         34nt5gjgD6tDNccdHnNMC7DbnRAQHOpAcJEDzSBhZWNeZSN4CGwqSdgU62qKjXTNnmqI
         QIG8YPxug3q8ooTzJ9dNfZKV5QJNbOmm7C7NHOHcx0OtZwAgujJds5QG4CYK3tZMRFia
         YYLG85auHHVJEz1G4sdHpP8rSbD8OPxFPQfgK/z8wtRGPcOHQ0I0lzzIs2+7JX6Y59/y
         eisA==
X-Forwarded-Encrypted: i=1; AJvYcCWAdpwote6ND7azuzXU+U4qTzBxpC446W8inDEaCx4FPP8BuQ1Sanaio5qEyI6aEtk3txxfgao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0h3nfZ1AAjBvqg9F94r8tOI5tR4dX5Sywu8Tw34Kvk/kj5K+
	19i6H+QDFAnj5ilo19FbcvffXZycCe8KbHqFrzFKBTwmH6Jw6J0UyhU=
X-Gm-Gg: ASbGncvzcy12i/sTiUOD5VBVIp9twEO60EZEGpUSDJVCYShjLrAsWfNCoJg6IGXMm/F
	eGRLrcXNLwjBa75GlBQ8Ac3ePojckQh9LCmPweu6lGo9SqQqkPW85bmQufm39n63K0n0SsHo35x
	vOKJ09Zo/xzUjdxMJD0mQ6+SvGlSvY7L82aAMH2YnUca0kuUf1i5BCMc9e2AywSN+tiMumxHaru
	goH7Gc/A8b65VcNT+2Sdq41fXg3apzwf+Ituasj/H+8+hi1TE9OiWCHN4E4uwqpOWpUl9hh2vUd
	P5eANLqlrkFu35IZid6lG0PzaaMz0MaDHxx/u2W8oZHQc9aiHveyDnkh/A0/H9HdA9xHF8l4enZ
	8hWTqj46/21OoCACM85ZjgBPcUWES0NPtWpK5CgOIF89OahQkaEc7nT9iyLYu/9W7fkXY3jKdDs
	To
X-Google-Smtp-Source: AGHT+IFVoBHgZs4WjGNNOI/TU/wazag77uFfteBay5mPYzOkv/vWLLx6YVSIzFhKxrqMSBUuEzeiOg==
X-Received: by 2002:a05:600c:154b:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-46e1d98a525mr20043875e9.13.1758622576895;
        Tue, 23 Sep 2025 03:16:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d51e5d863sm75027915e9.24.2025.09.23.03.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:16:16 -0700 (PDT)
Message-ID: <f89a5541-9f06-4696-8d05-961e4fd9a4ce@googlemail.com>
Date: Tue, 23 Sep 2025 12:16:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192404.455120315@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
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

