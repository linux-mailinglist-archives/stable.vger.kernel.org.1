Return-Path: <stable+bounces-69386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC486955781
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE40B21156
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5203149E1A;
	Sat, 17 Aug 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VjG5ENY6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05112256E;
	Sat, 17 Aug 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894864; cv=none; b=RkEWevgVh4Q9O4QaJViHb+FnZXbSRc6BLNjiV1WV157ijVi1EiZWBnX4iK7yGxclCtfotOMa9vF050xXXSPsrY+e/ZJpi62vA3JegEKDzoq20HWxDvtk/5LmTnFciQm+Egj+zUJWF8jleKo7jxE3f+x99csR9D2YFYgYM7EYgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894864; c=relaxed/simple;
	bh=pHb1cd/bM5HAeb2aNJlmyYZrkZZKm2iDpqq5ciaa690=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCGpbBJ9JzWCR6TwOQ5epwcg/r3G/wXq73CDRg4cYwQevBnrRRiXZgLvvQVX4DD2sZyu+ijMl8EVcfze5GJacqlay7V8OuMNpECDCJ819cMQNeCtc18ZYB5UkGrGSfRnGkSTrL0e59f5ZtUqDz4iWfUlTwjSPlW+OgAVRtvgqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VjG5ENY6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530e062217eso3682346e87.1;
        Sat, 17 Aug 2024 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723894861; x=1724499661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRpUQui6KEL9xqbOs0Ea/v4MaqiDAscFoJmUDj6bZgo=;
        b=VjG5ENY6zeMmHwYARA8cB50dZ7mfDKkqTdbIZ/Vb8FNvCF7MS1GfhsTv7bt1cqBf/s
         ipDKghtF2DgAqe1cEsDMIwGcr20rZrMGtM8F9BZM6dPV5UJsv9QKDVXQb5/UxVKrmvaW
         8w+PQBOOp3ftnCuWuUzqjAyxwnjGKSSi4TPgHpuQoSJm+Fd+hrjlQ/mVnECh1Fi+QFhb
         lOdJ5SaMd+Qt7so2BUXdyKEUHuy67EEVrJBGIlDiTaVH7OK5n6MXenG1/Bzv6DJRkd7p
         2qe91DqqyiqRiADezp0wglAjHOZjlr/0VB85kfpb8tWcVzPrOGKlnli+VYaii17EG1mz
         MYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723894861; x=1724499661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRpUQui6KEL9xqbOs0Ea/v4MaqiDAscFoJmUDj6bZgo=;
        b=TOZOtKrOrEcvdpTsVLKkKEcFHyRGtM8oJJ24Hdai/eKIwCsWlVuIA0Yz2/ZB0wgLFe
         pvQ+HK7vVSryS7726q0a2ubXddqpJg4v8MN1Z33XBHFu1PAkUzQO3gGL8gkurc5Cu//Y
         60j+aC7BOLmPgJreKJ5ExNEx4bnxx7DP+7Y5URo2vRj6QdtfRZCOGmh06ek/MJPcBuWQ
         sKP1ZreRd2zvKhqzLZ0uxzKFPP6vPH6tV4S1uujQ6hsklA707pl1NWbQS1xMtIp/iEaA
         pT1oHKvyG0O+0+PVqECNMsX0eRSy8GjKHrKxzqCv1k/9g023mPy7Oraw9xn8PTQua+MA
         xNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcdjB+bNr2Ea4LXZl4YaTEZPNvGdlKrCno4wOBiZ59qkEN7GMh7boOZ3N7v7ciC0FDF2QaLiJwow20/Z1zwNVO3jGFUFu0OiUeXUJd8PN8h01l38gAfYLBDW31V0iRXDCx+IYb
X-Gm-Message-State: AOJu0YxWNLnO3fXUlCDQ2nriz5Dirbxeo91S0vd0YFhdnU2xXmNIxnlL
	3mpv4gQ771kw/LT4/DEhykk0S4mscSwWjxMf04g1MzRK5+C+Yaw=
X-Google-Smtp-Source: AGHT+IFRrGmUNhCYwUr6r0aNdaQyrpw2Zl2kgseXIhOIL4K1vn+dS++NFAIzpV6T7Gr+tD4HzXyacw==
X-Received: by 2002:a05:6512:1081:b0:52e:73a2:4415 with SMTP id 2adb3069b0e04-5331c6dc95emr3852777e87.46.1723894860555;
        Sat, 17 Aug 2024 04:41:00 -0700 (PDT)
Received: from [192.168.1.3] (p5b05713d.dip0.t-ipconnect.de. [91.5.113.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5331c98c77esm622664e87.250.2024.08.17.04.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 04:40:59 -0700 (PDT)
Message-ID: <886e729c-d3fd-432f-8fce-6f6926b1fdbc@googlemail.com>
Date: Sat, 17 Aug 2024 13:40:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240816085226.888902473@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240816085226.888902473@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.08.2024 um 11:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Now I'm a little bit confused. I saw you announced a new 6.10.6 RC and I wanted to 
(re-)test it. Your subject says -rc2, but when I git fetch from the kernel.org 
linux-stable-rc git repo (which I always do) what I get is -rc3 from today, however I have 
not (yet) seen a mail from you announcing -rc3. Forgot to send that one out? Anyway, -rc3 
is what I tested, and as I already reported for -rc1, it is fine on my machine, too.

I tested with running 4 QEMU/KVM virtual machines for an hour, and did not find any 
problems, so:


Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

