Return-Path: <stable+bounces-210007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C895D2E98A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F3C30B238A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1FD322B8C;
	Fri, 16 Jan 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N27ESqhM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B031DDB8
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554889; cv=none; b=YhnyWVZVhiPvd2ZRmLLCQE2WA76Z8rMxhTFNYGs2lF7fMiNqMv/rM7kbXQiZv1TTg0i+biBkcuyWiAJEx+o+zwb78UDRtP/pQEXEBnDHmrLBH6noxQ/WzNjGiGDt0+sCtseYuVGeBT3JYHBNsYFpTMah1EVjS0vLo70vOargKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554889; c=relaxed/simple;
	bh=qkrxZVaIq8u/ULsagBD6RpwPgBipJU+x9xSTgkJmnz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK0Ox3QCp7xxZ49MIekqmzAnKVDFGK3N5mcrkeWJ8aJCF+fsOUUsGoRgRW61pt9gqeeF68Sl9ahlhfaNiO1w18KttbVJMayMIwpf4mbsH0gqjt12gMI0Tx5/desLs8mbUmjExJEcwIOwp4bgGN8BAjpHNPBZaWI7C4gZOLixi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N27ESqhM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d28870ddso936190f8f.3
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768554886; x=1769159686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZRvucjqJSUAPELpYM57ftgOzdeRyS0xf9BHStfw3N8=;
        b=N27ESqhMb1hmQuOfd42hJd6a2NR7TEfgYUxmt0iiJ+AuQOGS6NmmebTVlSKyCRC04r
         aVWWpnmkAbTBn55BSZ8GvUHw2b3t8pfG89Scj5qbm0SuWdvsa6G3uDgJ2uvFaGWt+d5X
         3RjYjBS3h5oCxXWZ2SZ6moSLN6eEnf2owJGWIWE7iRPXw5XkdPRarYuNDHqVh+tp3YCB
         k5FQuxfQvHr1kC/lkTL5rySwFr3cjxoMn7Va+Vi3PBKL86/oksYxrfhZomMk5+qoWSIe
         +D7/N/ynSFrepYrV0YVwsJuytMV5jBx8rfH/oFfJiYJaYc7419IHU7tNB7C05XzJmYAd
         NcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554886; x=1769159686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZRvucjqJSUAPELpYM57ftgOzdeRyS0xf9BHStfw3N8=;
        b=K1PTguUy2aEJ06A6lGWJBqclMKx84PGvtdyM5O/AaRCkZYofPHIGYlp9N+XPytr/we
         yZmne5iqO5kOiyyxvx5KpeszePbMG4FJK5YnrY1aTYiNWCEii9Lfs8pLRmWyODoXgW0H
         +Gi/ItCM8hEC1vAIrwXCirQQfdKkOvKVk596aeukyLv0JoUtJx0KEeUivpGmGPeeMgE8
         Bqc0ohY3B3cZK65HSVOFKk0DbVplH2YD1s2NziR6ubykHlZOK4Aq3zxWx9WOb/Ml6aPf
         8mU2lHqQrR5RBLDHM//NzN5ZyIdkG8bKaMbXZ42FmJiSa4HKIvEQc/cRkjNGcP6IxFaI
         eUhw==
X-Forwarded-Encrypted: i=1; AJvYcCUfRwZFpR/ruOE9uK8Wy5WG1yqLpmuTI79LbzkLolz4w5mvd2XHcesi37BrycKPBX9zdbJomho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqdSyLETKon6Vu+rV73OhN2gnKe0kM+GEjeOyjVYsp2I15+1Q
	ObxdHHUzQPy6X2C/dZuHSZ36zXXHYffmD45k+uyVXGNHrkfx0JhAYug=
X-Gm-Gg: AY/fxX5/M2FVUd+gF3Q1FF8D5WnyFIv15okEel09HTd9DVCGXJotKYHMSp44DLMO2jR
	st0oXr87SpvvaN+hOwFxzZVI+PQ3ngC8v7qOpPiSq0c5oxNrq2z3N45K1y6wWBbbuzLW4cXsLPP
	/BxPXyjJbxX6aFluiQYdf3blEz8P3SGKBelU8Yn8XO6i6FDGYiynpRKDlz8T4XR6XE1zD97/82w
	MGl361Kfz71aorQ7ZGfUrxU8092tkSgxSQo4S+rs3Z/sOXTWrOLqC6TM/ECGDca7tHzBckvlh5j
	Dmci+ifQfujTcvqBVeNDkPiK1fmDsXFCyk4UMpiG5JNzR41dtaO2UQG7epMxwHBfkBp9NuyGmnK
	JF9giOwGGKarTvQonFPaja+484DBzYWqMTPCPJYo6fRAf42OQoxB9wWEIA0o3es/sWjM3WzgaEu
	0bMzLlOWKWOQzGJcZ0Jht93gMHHUD0iAztGodES2JUELNhu4oPovXlAlESTo3tvUFk
X-Received: by 2002:a05:6000:2484:b0:432:8651:4071 with SMTP id ffacd0b85a97d-43569990a1dmr2173102f8f.18.1768554885574;
        Fri, 16 Jan 2026 01:14:45 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac8bd.dip0.t-ipconnect.de. [91.42.200.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm4071341f8f.42.2026.01.16.01.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:14:45 -0800 (PST)
Message-ID: <88058798-4a8b-4224-9f19-34b92acff783@googlemail.com>
Date: Fri, 16 Jan 2026 10:14:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/72] 6.1.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164143.482647486@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2026 um 17:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.161 release.
> There are 72 patches in this series, all will be posted as a response
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

