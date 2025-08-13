Return-Path: <stable+bounces-169308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91266B23EA8
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 04:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB596E7200
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8126C3AE;
	Wed, 13 Aug 2025 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E8RHMQwV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1E26E711;
	Wed, 13 Aug 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053575; cv=none; b=NPD1zLJrMsFELbf1jHjZ5B3tzWvzYweG489kT5YRCPePySuawECKfSfMHNSFUwo5Tx1TPynQ22oDNsTMA3rbPA5a0p6bzcqBqBi2lgHdPMhaaOqgvzPMgd38ivTGagTTCvHOJiiM8zQj98tXyKHpmv0LXiEL4NZGt4K2WNL4yhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053575; c=relaxed/simple;
	bh=KLXZBaq3TLieISROhyU6yYpBnfJhCu9c5EIrzguDWzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVvI0El0h8QxqZLof0tdgqzkvk4yawPAbrH2ARVSwOJnLy2yjVL5iX4S/tCb4GE5roHX4HQurX8LqazWvRvwHbECrwY0rH7ExW1s2ibpYw5+Ji81OyN1U8iExNuFLOQp3AdqVbusFEJIOXkrAFm8XrSd4gqYIlZMhU9fYHq0V/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E8RHMQwV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af66d49daffso1025330166b.1;
        Tue, 12 Aug 2025 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755053572; x=1755658372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=042+Laf4ikzkSiUo+Q4PSZALoUrhwG9sdAkdg18fh0c=;
        b=E8RHMQwV7qUQ9hFvJ8ritr1o1FKMaXcq1Bt1fc1krjUHjrZ2jyu+dNqwz6/DKT4Mp5
         Zb497cnboj5zs77Dioil6xvZpmVcQOF2093HxQlmuY7CfN8UuTaZ3DjxiiKz46coOkuC
         t9UXTnReMGA6SffUOSk9f6Zj9+NSPKPjQ+qWXT/Sk1nw0P5mokTQzdXuBmnmerWVxO73
         WJKhc6sNLs6E4riXeEIJ3J8qNZ5wYXZOL2u7FBsC1DaGLOMYX7emfNC5jXuUcWFLckEa
         vYvitA0wCjg0bFfcvQlC+cRnTxx9hCoqIaKCHvn/Y1T8r9EdaolvWxmDL6MDJRccFI0O
         rkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053572; x=1755658372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=042+Laf4ikzkSiUo+Q4PSZALoUrhwG9sdAkdg18fh0c=;
        b=L7KXIi2RaYEj+WbH4wuRWBThfpmyOiYfG56qEIXRuGloazlgN6rkgdlRTdN2/SBn7p
         PJAojzyLrPaGbRLHYP0yOIx5hZaPUX55xeivtHYFGgB2KxEKZr+nyW5gIOSVQl3t4/0s
         IXipEPOLzM9+zTGiaLX3Eo5GcsAVpLlCDz8SkuK/xur6suApzvQ6+UWLW8KOf7X+hfQR
         PmYRiAFGId0IJtkPkNnGJL/B5idEbXIBM1DzRr3eGvGsKMFzZT5ipflM9qSOv5/vB/ge
         8owJF0/+nfh0X/g/NQw/ROgTwCDJKJNHWUvA5q/CXug2QkEs2lGnn1VnQv/2VANw4WU2
         ik4g==
X-Forwarded-Encrypted: i=1; AJvYcCU5GCt9ufwf4Nuri+aavbeyZyt5w5Y5ijflm8R1iS9OD1B08M1KokQPOs453AEUJ2nQW6GQ2qDdIBiGtxw=@vger.kernel.org, AJvYcCWcOMJhz4ihxhLhdSmiFFxcP8APa8KeQE74Lg2x1PvYve5Fxf/p8NbuKL4dsD7vgWmBopLRBbob@vger.kernel.org
X-Gm-Message-State: AOJu0YxO66KdbYXtKUnSICVFoWniG5AlYqsaW0xveSpVcTiCyYlI3OQx
	/YXyWljk0ytCfbwRuC133/+5pRQG0MHVZw5vJJOr/cMue+CVAf4LMo0=
X-Gm-Gg: ASbGncs7MJgq7VJ4hzFXyehC4xCFAKi7Cr8rT5xVHFLvNwLQH7GYKm4dm9d3WTev2aY
	f9GoSI+xc25Mq12ILUUk0G00V/i+NfbYBRbw1Y7dCY+bcoTqN68VskFTKjl93J/eHgxYSXLQspE
	AkdOd4O04jGCvTmItB0iQrDvVURouAyYAHYQhNYsX0674c9pkMbxPHo9z3szBdkwsC+SyjSITbp
	LQS4xW68Lk6bMnFGqfuhI1NbsGmIp+riLeAgWFWsp8tB7+JNDDXhkJYwua1K2zgW8RL2l1Ek+kh
	OSRxGkmgN3+WMdf8avByqb/kVIhlwJBUwCiBLCumNWnDtpGnk+UvpMlebjS3hg51SFM83A0DHv2
	UYCraKto1aqVcwdLy7uR3kJC8doX4OLnt/5Ne0Xr7pu6D36iuSe7XcC6H7GmYuWVPPMbdgmStzt
	t7fVVzpgHYRA==
X-Google-Smtp-Source: AGHT+IGinuV3BWJsLOw3BMnIVMFnFkk+/iO2HAJYyI+8AQMIZAXSxQDGcKdQj7k2sochfOFf0alZQg==
X-Received: by 2002:a17:907:da9:b0:ade:79c5:21dc with SMTP id a640c23a62f3a-afca4d47d82mr148548166b.25.1755053571338;
        Tue, 12 Aug 2025 19:52:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48db.dip0.t-ipconnect.de. [91.43.72.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99518bfacsm1339330866b.72.2025.08.12.19.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 19:52:50 -0700 (PDT)
Message-ID: <0e4b2e44-30b5-4907-8ad1-5890d53bf854@googlemail.com>
Date: Wed, 13 Aug 2025 04:52:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812173014.736537091@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2025 um 19:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. Built with GCC 14.2 on Debian Trixie.
No dmesg oddities or regressions found. I did not see any of the Python warning messages here which I did see in the 
6.1.148-rc1 build.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

