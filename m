Return-Path: <stable+bounces-156151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E33AE4BF2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB317AB506
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C92C15A4;
	Mon, 23 Jun 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MLIA2Gzc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34A2C15A7;
	Mon, 23 Jun 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699912; cv=none; b=rhDKMTWuhRnCbGwa/lPRw7mB4cu4u++E0+CvFxhouBkRhuDA/KgrZ8vHalRx39w0nJ4N9W3w6PSCBkxrdfbe5qNOua04CvpsOv3d8PXvcOtrHxpUxlASrTFfiNnENC409gEuzjZqse4OVdVtZ1rT/vUQueTGMIV3xb+v6fjD538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699912; c=relaxed/simple;
	bh=nWtDx19qO1yQn0z/BLKg3vt79Bfpsoue6Vz1+cHMPuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhKM91c44v9zVHmIY4wnqeTm5WJ7tOAAJKmmvIwD5rSpX38j5SicvBowY2XK5pC22Uujm+u0nb33hIOWxvPQPKwBuJDBN/oeoXgcdHT4hdVJFjcq2v7D4uRuk6NxLMyqNbJ5Aj1KPwaSjg3kmDtkF+mGbskynOimEZYN9F474lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MLIA2Gzc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3523829f8f.1;
        Mon, 23 Jun 2025 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750699909; x=1751304709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+M8UQ5pVdsk3/Nz5oGllvjtaHtID4N9yBkzQVZz05g=;
        b=MLIA2GzchS4awAyXcTSeRkOzcaLTFCMsacCk4xVxFKGEME/GK5ODbGjYnufeeMqfkX
         i7QrgEPsW1gv0wJTHIyAp94yR7WURl9Wma0Ivtjqta5FIM7BtN7azhkMtrhpV1sM8qPo
         K5b8dwaTUtpgbrmgJjsSFh4BbqBlxf0fDh2p9Om0IA4N3xCOZoFRRIFGC038brwE5mVH
         Aml0hucTBVDhyPsgv0ID9h0IRb/VxABYXx+exmnwVXkHg1qlHCQA7d1QPj/XWqwJZb7u
         hiZ53MXXV9dfdsQFg8Ozw+tnbw1y23UoiHABd7aB6YW8fUBPgLAikfRKe+iE53J2HQPF
         Mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699909; x=1751304709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+M8UQ5pVdsk3/Nz5oGllvjtaHtID4N9yBkzQVZz05g=;
        b=r5fOKX3T8blOcSJJXZyFZ68LM0K7DbEd2cEwv9WFR9OEB5jgDfDfvcWdOcNWw3n1Wj
         NmgkrOXBUk1WaIyyWBXY9hUgxcWZQQZoUzYCVbqYKXHYN4lrr3zmLlzIdsC9hS+aPMeK
         k+rUwZ0jtp0DsyrM/IVXS9MdwXlvshar9wzYKlcGwZPfoGuzdOmeZcOPpTKEeRv2VQTZ
         kMWxoMM/sBOeL93bVYCtQrFY9/4+7eKmbX7w0clnl5L4P61ETwlvwzFX2RWvNp3s2Ijc
         MeyRIKfzmY9yhmsGrvJqvQDiTMKmLTD8Ah2ujhgy1hyxvO4HtTbUFnAiXMtjhNsG7/u6
         VnEA==
X-Forwarded-Encrypted: i=1; AJvYcCU4VUtOttfW468lOyWnFPWIWsNkwC9WIvN+/rOGjcr4QrE9Mo+s+m+5BA4uXCEOXGL0SjDy9D3I9qXj0dk=@vger.kernel.org, AJvYcCWskrL0AsV3HWtVSHiAF7MoiScK0x3FvhYYQ4O0zyUE5V8SAKI+hWUR0UPtzDdM6KWUJOCwq6/z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxav+czYZyGjOv5aUkpI3xc9Ev0f2MKOWWPAcZp6Psf1c0lgtkX
	zg40FbZY/hlbFtoCmAhV+CicqrxtUcZj247lYS2sRWUaM3scw9PoDmgEkUuj
X-Gm-Gg: ASbGncsK/SrdqAsSz/EumopjD9rON7kQ94A7uOclJdxUNDuvZRM+gaN+VorV2Ip9mo3
	sR26vXWGX7Q1LDAIN7r8A+q6jF4jdLiewnTqQ2/Vy6DXApTI/yAbI2/ohkh1FWGIlxQ2CaFZNb6
	QFomIq+Ik3ESJOK2jcJH2R5X1Nmupw0/9z+Emx87ivDE5Lov5w7B0S3UdRN9aC5U59pHiFvlf/k
	ABbI4ecw1Ago2kl3HqpKWRPmpclyKz4HnaiyZHz9Zb18VYLx6zLv205hJQLtYKTvGzT2KchbW0+
	GrE00le+BIVxNy9ZJw2zb1ysdZqeXrT2CHZ5EyBO1pUNyJVMgGkB0kDngI92HAVnURm6VPdIMU9
	uQUdwPWdjn6DnbAJBIbGK8bnQIgYiL95aQr1tEC92
X-Google-Smtp-Source: AGHT+IEpwTqQzCdzAa+M03XSw+M3DXPs7MrWEPzz0q7cQJ9OstRIhzf9DfL4k5eJMC4QQfTYBvucVQ==
X-Received: by 2002:adf:9c8c:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3a6d1318226mr10562515f8f.59.1750699908816;
        Mon, 23 Jun 2025 10:31:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac778.dip0.t-ipconnect.de. [91.42.199.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536470371csm115405335e9.30.2025.06.23.10.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 10:31:47 -0700 (PDT)
Message-ID: <94c90344-7611-4422-a77e-d28c9cb4df4a@googlemail.com>
Date: Mon, 23 Jun 2025 19:31:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/508] 6.1.142-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130645.255320792@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.06.2025 um 15:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 508 patches in this series, all will be posted as a response
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

