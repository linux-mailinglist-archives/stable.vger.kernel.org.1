Return-Path: <stable+bounces-100023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A909E7DD1
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B1016D2FC
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E31CA81;
	Sat,  7 Dec 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NDbBy+ny"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC21A270;
	Sat,  7 Dec 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536134; cv=none; b=hs5JiqqQy6ufy4+OCyyaOcrhaGeX33S0Ama6uhXgnnIv6Tt8wPMpIf45wa9Co3om5anQY23psLd96ogE3h1l5RbyuobQsvh+3KCEB62g2JXSewrbjAIcay4SUOsyayDV3kMfJ1IPZjymPHhInVHV2rLlq2W/epvwqfTGhDdM/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536134; c=relaxed/simple;
	bh=Zdgltk7uwxlen0gUVYovPYuPpMIbCIGOYcQyUhX0JNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii1cUmeRkmsmcP4WiA7ysc8En3rv8Fs1jp0xtZn7Cn0g4cB4grrvHA1F6yWjFpxQX/8CrcTSs5qSuJYtBZXd5M2Ft2QHD81dulzxh+qPJqRQb6t1Xzrr1KDUyx7/h+iTgBIxk5+RrhQodJ5EF+JQbyOEwtkj72SQUiw6eQsQfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NDbBy+ny; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e3953b65so3906705e9.1;
        Fri, 06 Dec 2024 17:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733536131; x=1734140931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrYd70wAC5ZjUR7n6BKKE+G4uykE0J77QcJcQjSXc78=;
        b=NDbBy+nyblakv2xQ10DEXbH4KeFfENCBbea9aAmD0kp+y/3vOAL/v6N9G2AjXp1efW
         3jz7eUBWyhuUv5K1IjknDa/ZSMNHWx+yHiAPcjX32wIMeE0CFhn/Zo1hBf0L4SjS+Cpw
         O2T6htEYeMdV2q/nKmCfZb40rWo4QXGl9pMw1hsu4Gg9WwOGZhbf9F4NXc3gg0XrrYEc
         f4VefHKt7f9I2djHfmMZ1j6FGniZOgQPT62iF0RJlnQvLi8MlV8+kksKY5jExsEbvIT7
         IAcCOrXnd/YyrH27SqIp9NrhAa5ZR3rY3J4uW+dqHtG9GhA73kp8qNEU6TvRyNkXsM5i
         0sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733536131; x=1734140931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrYd70wAC5ZjUR7n6BKKE+G4uykE0J77QcJcQjSXc78=;
        b=pXNjAVGA5jgYmMgAq8Y+mhdotf+NwOLGjTlEB1Ol4yrO+4wg0v0a/aueWas9HD10nj
         t4xlqya1P19yzw6yclPCC06dn8Yx4TJlohBXK8ECxVcxe7M59eBvjzRPVTNcIlBwVdoY
         VmhWwNo674gGtpsGJCOH5gBbCZdGbVQbv2z9pfAwLgOdxuqfZkAJvSPZ4DrnCSZyo8dM
         zD5+xm2qqFZli69hgNcGiSR9KUkv+QXi4a6fKrXFI29zNtXM0eLfzqSvzGTcdWy79AWE
         FJdvZGDTkM1XLpsnfXhLfMrk15N/hFREQQk5K9ThL8DTfB+6xkktGxY6l5ZEA1bXKCHZ
         YAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ17p5qA1lTQkdCmcNXeENTK1h6Fn2FwwjkeIQZPVwFvTukg1LJfo/jc0WGzejueVCJ2br8BP1KpFs0Og=@vger.kernel.org, AJvYcCVidDvjISILu5Tu5oq7vtjAn/vIWcBjsvB0XM9JJfIBnpoO2Z8clvdAUUvsH2bkecJg49pCxPgy@vger.kernel.org
X-Gm-Message-State: AOJu0YymtlvYHNEJ6cXyMcGe2UxmuKGUSKeImzTFBIGMm4Lulj02h6tq
	NIPT8ouJjProOaYFhcWDCr288gukPiHZ/JTfwNysAwL5q+MjU3Y=
X-Gm-Gg: ASbGncsdkk88YF/x3nSL/p71kcsDkatIEKVtwSCKVKMoRnGYETMMDTS97gh/6kKjS3E
	yzewh0HuwV0xnq2B2tW1bc/0taMJVZy3pdUI28zclbFDSyQwwAqq25WhMhc6A+SUS80P4dDsGPU
	+1+TpB1nPZtvPlq7Zd/HcI1/dqeIPc/EPRPEdYntEzqe9wm1QLdSEG5ldO3trRCIUwTnGsBuwrD
	VJ42iBqSY/Dh1B71hymbUkUymm7NXT2c//YU1UoNSl8yLVvCiRHjDlRsbHb2uRoGV/6yy/OuYOG
	5Q0l87PxmWdycB7MT5SJICbdOA==
X-Google-Smtp-Source: AGHT+IE1PrZQ4PmshzLfEKIIicbjlO0LbAc+K/ecNBX5W2XRaACydj32Q+1A32LEF4rZz9SjX0FBpg==
X-Received: by 2002:a05:600c:a41:b0:434:9e1d:7629 with SMTP id 5b1f17b1804b1-434ddedbb2cmr36793995e9.33.1733536130940;
        Fri, 06 Dec 2024 17:48:50 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e5c.dip0.t-ipconnect.de. [91.43.78.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26b0sm74258645e9.9.2024.12.06.17.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 17:48:50 -0800 (PST)
Message-ID: <1e3cbdcf-ca6c-4721-bd18-d064827107b1@googlemail.com>
Date: Sat, 7 Dec 2024 02:48:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/676] 6.6.64-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241206143653.344873888@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.12.2024 um 15:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.64 release.
> There are 676 patches in this series, all will be posted as a response
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

