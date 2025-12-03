Return-Path: <stable+bounces-199909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC111CA15A9
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0831E30CE55B
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0630305958;
	Wed,  3 Dec 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW1zEm0n"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09531255E26
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787884; cv=none; b=MmtI1gCDqZKhu7ZMzWP5/f+GRNiaUsYS3Jse4zKb1MC0llZ+DqwIgDzDxc/jwA6e9jpswNVkaQgQfNoXJqlcG+9K9i9m0bf12/2ro0uuHYEYc2s/b0JA/Dvy8KUh/e6V43hEVJclOHmiEH3YDBKAJ9eFE/OeBvojEUxcgHlMSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787884; c=relaxed/simple;
	bh=QXm302+o5a0ZYeYH3FaCt6FMEyJjQFcbWTFDv7BUu+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAqtk6f6mguIV7SO6TC+RKSoFAmBiXLpcdBnU8ZrHoBsUaLWgGNlLvoTlqvhzOXg04h5kXIKTJWj2zog4U6nX2MJHP3H32779rDKdVZ5BKIVG6qIwzPvwxJcsDQOMVbOhBa+2ZQkzJq2R3cDd0VVHJ7KlAhahE7XGWhxJWObgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW1zEm0n; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b31a665ba5so4499385a.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 10:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764787882; x=1765392682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vneXqvh/pIxTidxgJq0zgl3mLEwdN7DCTjPVK1bMrl8=;
        b=cW1zEm0nk5QeitvG3Kz3QhL4HkhaBbR43YEDqmLMfYHJ+1fPQKlYyvlg1d1G8P7Rc3
         sAWnvgF8IIUQ2cAV0NtXz+2tsxXyfuvEZVUT0rDqgNEV88JnNZ0ecp7HDoc4btpSMDRJ
         ADOEH/c/YcI4vFNScBS6JkelRubgsnXo9+nxFIOXjuXknv/oZ7Go4axNa7WCgHVJycx+
         kjtmek6X0O4xWH6iTVMm7pevgB21AwC5rEr/bfs/Mp/Pkemqqe3+07mlTB8GXukFwEaA
         Vvuj/eLOp+DYDaOwgF8WPAVaNvFKw5hevW7hX3a+om0qShEBfzosoFcxRwlkNkqeZUWw
         nQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764787882; x=1765392682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vneXqvh/pIxTidxgJq0zgl3mLEwdN7DCTjPVK1bMrl8=;
        b=k89mAqEJs7Z9OJh1CoCPNgwmDpe3yvLCAv//dobyKJnFkSG+kXB5I4riErFjG0zRJI
         YLYfh9jKJ2GsTcTVG4z/rfrUOb2ZhvfZcwn+Dj2auelxm9CruZJOy3NZnZd3+bUrqdby
         2Dn8HaQF35QKAzvSWaf2iLqkhdx75FwrsIWzxvJXEMjj/l1jBCro7K2OJXp+BOjyhGQk
         deMoVCcel7qTp6TIQzf+qMCivHcrw1+W340CrXZbVrw1j69mWLjEiPBDNi7pHz0v9dR5
         Dd3jB6OtLR17hEguns7OHWMt9iUC71bwb2DIII2+9ytipQufeH/rWzmJf3+qCQ0JHK3U
         opxw==
X-Gm-Message-State: AOJu0Yx2Vr5KmitU+c4acvKABt1cFq7RpZwySKblV/ZpeR+MifB2M2TV
	I0bwjRJbcSJJZzn7NIbQlP01/jvJeelNcOR8WL+DMGixzUwwOr09Hza3
X-Gm-Gg: ASbGncv0LoEQWEKVx9qRdZhXp2uzScRpPZpRtC0bRDkTHdbcIwZzzOR76itINNwlLij
	PS8m3aqyJTa8Y6NZbyAGBGIuPjKid+6q2tiJ3cKQob6V2fW71b3cA3RHL7Xn5Ubu1zsIBwRsED3
	AqDOomja3j9uYmvLICqothLpHvCwGtZOeSUmGvTJpmdG9NI2viOw9AoImBMtujh4IyFpVb1DDdg
	EE8Mosuw8bYsxmeLtr67BGhe//z5On7j5/PbxUHVJmeSivtaUMZJKmn3pUvmvEqAPbst1MeKpNh
	D4brz4PxWIzC3Z3vky21XHjLcbIeEYN8KJbx4tgr2tD1Hf7VsTy+qYlHsUaS+Sf2+YH4aQAx509
	MnUYdJ0AfdYsILkmmjcW+LFlZdZf4/uGgtEcvENBDg5jUeFRl9FaHJ79PTK3DunxQ4MCBN6nadQ
	skqcR6yJbKYv2cnijCDieOQ1PV6nrMZyqih7iBpg==
X-Google-Smtp-Source: AGHT+IGab/pTxYMr3TuHQAKMESlS+5teSINCikkt17TTEDl6V4+8NTN45syRoK4GBSjTEsnDs4AjGA==
X-Received: by 2002:ac8:7d89:0:b0:4ee:4128:bec0 with SMTP id d75a77b69052e-4f023af7a5fmr3142921cf.69.1764787881872;
        Wed, 03 Dec 2025 10:51:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f018a76c0fsm17172641cf.14.2025.12.03.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:51:21 -0800 (PST)
Message-ID: <b4d4d33e-07d8-4868-abc5-4161a63bb948@gmail.com>
Date: Wed, 3 Dec 2025 10:51:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/392] 5.15.197-rc1 review
To: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152414.082328008@linuxfoundation.org>
 <41e4124d-8cb3-44b9-871b-8fa64b54b303@sirena.org.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <41e4124d-8cb3-44b9-871b-8fa64b54b303@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 10:46, Mark Brown wrote:
> On Wed, Dec 03, 2025 at 04:22:30PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.197 release.
>> There are 392 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> 
> I'm seeing a build failure in the KVM selftests on arm64 with this, due
> to dddac591bc98 (tools bitmap: Add missing asm-generic/bitsperlong.h
> include):
> 
> aarch64-linux-gnu-gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu9
> 9 -fno-stack-protector -fno-PIE -I../../../../tools/include -I../../../../tools/
> arch/arm64/include -I../../../../usr/include/ -Iinclude -I. -Iinclude/aarch64 -I
> ..   -pthread  -no-pie    dirty_log_perf_test.c /build/stage/build-work/kselftes
> t/kvm/libkvm.a  -o /build/stage/build-work/kselftest/kvm/dirty_log_perf_test
> In file included from ../../../../tools/include/linux/bitmap.h:6,
>                   from dirty_log_perf_test.c:15:
> ../../../../tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsis
> tent word size. Check asm/bitsperlong.h
>     14 | #error Inconsistent word size. Check asm/bitsperlong.h
>        |  ^~~~~
> In file included from ../../../../usr/include/asm-generic/int-ll64.h:12,
>                   from ../../../../usr/include/asm-generic/types.h:7,
>                   from ../../../../usr/include/asm/types.h:1,
>                   from ../../../../tools/include/linux/bitops.h:5,
>                   from ../../../../tools/include/linux/bitmap.h:8:
> ../../../../usr/include/asm/bitsperlong.h:20:9: warning: "__BITS_PER_LONG" redefined
>     20 | #define __BITS_PER_LONG 64
>        |         ^~~~~~~~~~~~~~~
> In file included from ../../../../tools/include/asm-generic/bitsperlong.h:5:
> ../../../../tools/include/uapi/asm-generic/bitsperlong.h:12:9: note: this is the location of the previous definition
>     12 | #define __BITS_PER_LONG 32
>        |         ^~~~~~~~~~~~~~~

Yes this also affects building "perf".
-- 
Florian

