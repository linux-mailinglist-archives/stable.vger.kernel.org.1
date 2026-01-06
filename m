Return-Path: <stable+bounces-206043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA8CFB43A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FA13069D68
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AE2E62B5;
	Tue,  6 Jan 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TUqjE1bt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B262236E3
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738530; cv=none; b=gOPWIT5KwcMLd2hjBfI/r5Q5Lpsa9tIjzxV+g5Iq5Nexjj9D6kF5FK2wEVh2prpzUsQak+PbTggib1/GrvuBg6oH3T6PVdFysr7A1NSoZKSw3M7UguqAgcD2bsp5SOTIVBzF/2L1gOr69f2vjvEaRVHEcbpJEls58ltRNjdNYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738530; c=relaxed/simple;
	bh=fiUa9+4ah9DWIuIkyw4v3FPI+9MXlGa6tQTBT2A34Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArtR4L2UMF32uwSdIfSX26kK025LyOa3jSn/PlPgEU7RRzN7bJtvLRsFSfV15vfyXoFqm/WFLv7v/P0evW3eAx6giMIlSmJ6qOUEI2/Yg2LMMnMQFY8dK/TZqqM3LU5//i9OICO0dDOBBsX0ngNeYhUZlkqSHkC8ZNd7abysdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TUqjE1bt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so15043135e9.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 14:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767738528; x=1768343328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhKQiAgmpaUu7Pmj+SphJI1wQQ/oieAC9N/LlUuuh2E=;
        b=TUqjE1btndrcUlRQnqohbVUDSQgdUQfdNsdxP/q/x1LwIir+habTy/8d0oZ8gYBKmP
         rrtO3o3dqCfVc1vZMm5UPIuxPEUh090RBKaqz7TCVscsv3wD8z5yMHBcA6EXAnBrUJJV
         X+NzGoRLVcF/prxUqE06MW2UHHRozz+zxJmRYRyj2IMmOpYmRVdvCcEM3BwRyEKDhhEJ
         JtZMfOM5EAi+IAd3sr7XxPFHmtMsWQgisn5cP6azwsil6qC4XVkBqCcvyyO7Nq+Vc7oS
         Er49Zww3dXF2Xsi+ingYS9H9mRGWjedk/DSObnMAB6sgX4aM8qMmXvuPunvnuUDAoPUf
         K8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767738528; x=1768343328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhKQiAgmpaUu7Pmj+SphJI1wQQ/oieAC9N/LlUuuh2E=;
        b=DjTi/oLy1vQ6vYCSbfKlXKSZrUb8I2I50ybTtXw+n2AUwEL+KoCioycs0saBAQd2oR
         CCTbImI5+kAWG5LpAWtaWt9AiEvuht9RqG14wBGGUtNh+KakB1RH5tjPksnKptIJc5gE
         Wde94e50m2NzqkQ+B3VScpi3zMLXWuKsI+1dMK7irGLXvXA1y/tiKCP6yDPhdU8UeDSY
         Zjp30sf0sEE8wuQfeavOMmYucAn6xPjsXRr730KSX64uJ4Q7MlKowZ2eFPkyPrMHKLf3
         sKDzXKxg8bAmKyGsNqVQzAdpfFqGja5J3sBaWTDL8J7VwJOF5AHSNoFSZQ4ct3Tzg72P
         SJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7S69z/7BS9frKG4KCUaMuZzxS3cCGaq0mtPsW4/rkQvJYpxmkqNwn1DjszXAqhN3Q74t6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8znh0UwC9HcYEUQ2sMXSZYL9ZeO2BxbiPr6x216A1EZOg+q4
	Ya4k+JKSH9u9PNjJYSuXDQQ9v8bWJ/7PNLbj1HRTlpPgm/H0lfU1LL0Z+twkiqA=
X-Gm-Gg: AY/fxX4RtV7G2j3fCqNWwZlhEr7qlpWQxhFrJ6r8vXxgJGn34V3Kj37dszIyqCAQFMR
	4bypiRVE6i3d3KZoF663zhAFRdfX6eq9UhaU3ndrMzNr395wM8j6k38JP/DHFAV4f5BSOzCTB3m
	D2MYjXq62HIDCZ52WBphcAVCK89aAgg1+wCeUQmcdsyKmNdlx7bT+MZprKq0wyuMWctNy9OyMnK
	g6/hQd2W8c4NIa4bB5JrPs9/VKeOD7+EGSfjd9RZuKctSePUaBwYXDF6ywb1415eihkCfjRELny
	NgxCS2+QHbN/mLX+gHs141JYvozEUhYSp7RthB5cph6s6vaTZG69ESewJdgv6VxYBjjvHMcO8UX
	RtIFP6e3dekVsPAonVInZXSh0I5u7cpptz3v4CeXSk2CB/a7dxDbP326jrNJyKfURB6kEoa9M7h
	dszbTwPEjSlZXxahSXcZYLzmjN2aix0C2DJWT94fjdkgfgZb7FBwC4o3b3dD+7rg==
X-Google-Smtp-Source: AGHT+IFTg58Hc67yxrabF4gmXSpJwCzyINMfF68sQMqsId1Bexf2elW3nlgqMdXccABqdGrOZ1P6DA==
X-Received: by 2002:a05:600c:8b0d:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47d84b17a7fmr5479495e9.16.1767738527515;
        Tue, 06 Jan 2026 14:28:47 -0800 (PST)
Received: from [192.168.1.3] (p5b05725e.dip0.t-ipconnect.de. [91.5.114.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7fb4c451sm29545485e9.5.2026.01.06.14.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 14:28:47 -0800 (PST)
Message-ID: <d008868b-3db1-4d7c-b488-51d46c69abb7@googlemail.com>
Date: Tue, 6 Jan 2026 23:28:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260106170547.832845344@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2026 um 18:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
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

