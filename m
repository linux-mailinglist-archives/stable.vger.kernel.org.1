Return-Path: <stable+bounces-184089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAFCBCFCC9
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 22:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F2240463D
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F27283FF7;
	Sat, 11 Oct 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EPSOard7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27878234963
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760214851; cv=none; b=NhiLVH6QJTV0pTgMRqIsUbwwmRxX9vuclY88Edt3t2PttV+4zZl6olNj+NXjpkNTGNLDGjMiTdFAa2lQCqGYO6QJKwSRP72O5FLG3v4o2m2SrFtIyY5Zx3EJgEOfbFZjdIpYPUoU4tC8JiOSTQZfFIMcmqG1Qq0XPRxZ46leDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760214851; c=relaxed/simple;
	bh=uiS1FkGG+yemWN7mZxq5ONbvirHM2tWtK7mDT6LdM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUwmOoEAzfMJY/BC3CZQOI0sGDR/MDM+ebLODDd37V3fqcgJEtTklTFH58wUXgkvEKC9ZLjCwfk7qLrBre38ctNpJIfjgI1sfxY+RufX+FFZ+4jUQf7xVub+HdJTks5bsUDAtUZmLwzdWaiOrlrmYuVb8jM6ce8QG+RS1blA4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EPSOard7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so563559366b.0
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760214846; x=1760819646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9gwbJotZOCrW+prxIpkEfE0iubkb2OROKcfJ2ha4J8=;
        b=EPSOard7HozLNXnevkjKYErhe6OlisXx+xSomFGnb9Tka1E+Z3tPS5E++bjlyDSam1
         EDZduHLlsCSlHzCQxm1LXnykzSsPdOooJdwJbIRzpIMQVYkyYv4d5DnZcYzTiMjT5tDT
         q3bE5YsA9pHiNSdSn4Ov7gX08hUx3vwlCb6OAeX/fG/0gVnmTjsp+fcCJYbehHXJcQU7
         mJG7BLEBhtI8eFmZkH6Yp1Ewv25nQfps1DDtgswtiDruwUNX4vIA0q+P2XzUeqi2/8+c
         cRsYYfUfuIJ1RKW9YLH43WUS96IQ/flzLFvPACmmzZudTxnOoR+0kjPApNQ3CJrtsPXu
         ZrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760214846; x=1760819646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9gwbJotZOCrW+prxIpkEfE0iubkb2OROKcfJ2ha4J8=;
        b=aUWJIXJIVPXAyhwiAT6xMNHO3Wkyo4deGmVe6LcJww4x1Q6yHTJzDKDqGbXcX5lb2k
         y2lmpmRUMu7AAm5wI/Jm4RV3l4CF3FyhmOqPYaL+ivFNxabxE81cEi1H8BM+qT6dGVzn
         zUqcy7AbvJFsFKmJ2nsysPdbgRXu8xtOG3DNFxRRCYZNaHfiqR3GfK/J4uLP3Hay3pDB
         1SNWjTUvE1vokpcxWXmERP7wBNKNnX/Kn4elE8z7SUa5WrC/NLr1SK/aPha3x5Dm6lV+
         5Yr4OLowf1O+NQagdqaJl9R3FYMoWvgK+R06rXfbrNN0ybSzQQ64BB95gXfpV3vYbA/u
         kNWw==
X-Forwarded-Encrypted: i=1; AJvYcCU1p9MuhuLQUMVEVEyXwXUGzGyrX3ZN967LPv4+2Av0ZhDIN7y1+CAukEkDGuinFBGlnnXL/9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cC/29SYuxb6WXDGQ4m06ubWRqSZfXJtoUMFRavmK0aNx2B3O
	jAOFYoEgGkmK3L++puL4wHsVVYqqh+PQNPKKwMeyx7sV2Lazsxqcj3E=
X-Gm-Gg: ASbGncsEckVJezXc4QRcDb2v/WrDgfpg3wrXpKRp+Qy1gOLRiyVKSAkvKTUauSu8fqL
	hT0zzWR2A8LJbUIPpRpyMOScZPxqv5SGCDa3RZ/o6F+DMUCjwoP5EU1M2PgrDIbYr7pA5Bdri23
	NS5mg4A7szPFcGIzxzV0T+WTVc2ZNKQH2cYKTYhRxTVFQlRV/P91Zp540TqRdvDFYuGUjp2WwV2
	kODN87B2mhgO7M5mZdCdbUngcSipMhHkakET7x/btaplPGXsYlrb2kY9kGcc6wbiXSLZi/H5AzX
	WM2i4IsavJA4lMe8wnJFdgWwLhm/zjId9fjMchDQIz28WvlNCgJjHhn2zzG3SVZsrCnd79NL5Ew
	VidimzyCJOOuKO0NlbyNxsrCUmxYkpvSgzWaYBtDCGc+MVqCHJFSfIWahsqkk9cRr2I2ZD7wlq+
	iKKDE2N+l4xY9XvOR6Tw==
X-Google-Smtp-Source: AGHT+IFUGLVBIVIYHcomGPL2XT0ezPYzLn2d7BMGCM1cqedqmfG5bPAhYq81N5HIov9FmaMCMAxvfA==
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id a640c23a62f3a-b50ac7e7627mr1567961066b.44.1760214846173;
        Sat, 11 Oct 2025 13:34:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm557575466b.35.2025.10.11.13.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 13:34:05 -0700 (PDT)
Message-ID: <50922be7-e209-4578-881a-16a533470e8d@googlemail.com>
Date: Sat, 11 Oct 2025 22:34:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131333.420766773@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
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

