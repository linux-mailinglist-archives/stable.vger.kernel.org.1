Return-Path: <stable+bounces-144555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B6AB9115
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A19C176292
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654320CCE4;
	Thu, 15 May 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UqPiRm1S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217E35970;
	Thu, 15 May 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342688; cv=none; b=u/MBoxh2Ao8KM0O0nn+xzflI4nA9q/pw+Uu+CYQQvloJOsVJWnXqDHAj3lZEVp2Lfg4NvzNKryNunjtCt+j7Ud9bCTf5l+glIl2gij66rC5F8stuqZ4UgMumNKiVq3RThB5VzRvL2c51iGToiW5jTQCg15G5KLtP9qPG+2vqYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342688; c=relaxed/simple;
	bh=21dSqdN6f0BAIZMZuOM/DzYxEHIJQ+4lqQxhhd0kMes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkGlALfJ7Y30CT87WglCDkfvXDlg+wb5fhNj6zkV+j5u0xbvWIGREoU0THKD3Ik+QCpt1TqK2ycJ2a1NXsJraM9mkB/Ni+2YW/HO3YSue4pVc2G5FWX2Rkf2Lfo84wvslX1PxL7TsthHDg50L5mm6ZTE/z7DGCnz0ZBo8Y8LNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UqPiRm1S; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ea95f738so10663585e9.3;
        Thu, 15 May 2025 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747342685; x=1747947485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpW7hv09hrqBEEyMb/8uxWZH/simIUVzd+OZsHMzaoQ=;
        b=UqPiRm1SjwPp537VfP8WxGoFYqs0a5SAK5n7ZooUiopjIqUvZnooCko0nI4S0HmhSM
         wqvXKVmjNq2iGVk6/WvNAfv7IVI4UEABtkPFFSx+OwFdl+oqe4T4f4hSffcdqXWBi/n2
         9Y1NhcgqLMiGGa/LYUmGin++fNbu6tJkTN7BfOzbs7SRme+QVJC1Va3LPouf/6licRAe
         3Ju3E+c1Sti9PuiD4uyDWYeXfFGrgS16+xP1RvAuc+BqQxeLTUOCH1pj1udctOYhq1Pg
         Ca/c7D/mCWbMinGSNl93qe7CpGhyJhWs7pzfyfvCOYQXKr9lnX1QLQlbZyFMfn9KPKmI
         jUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342685; x=1747947485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpW7hv09hrqBEEyMb/8uxWZH/simIUVzd+OZsHMzaoQ=;
        b=cqpXxt8vP/MkvWWXQzRdFcxcvXRXs4TFpMJBZWrSnToEP2Y2juoSKUWs7tnU+AX4jQ
         pXWaxbp6MG4uUF6fb8tndlyfFi8WNF1/R3A5dIkUYie/yw+IZKdWQdDYB/5alJw4sfJG
         IUFmp/M0I8GeTDm+xvb3uO0AU8/ukOHNx03YYYBisoAwDdVstZZ+RI7P6EVGkOz+ns6R
         hj/jInYigkPcLZmBFqT2Co5Ghuw7XCH+Regcf9cktrS6RDATaPqzvXQwP/YhwCQnrtBq
         gL1oLhBjFHVx/kBqejHJyufRoQxd55rox6ICeI5VCVI211KjEC5pw9VWE4mF41JhrdPd
         TEDw==
X-Forwarded-Encrypted: i=1; AJvYcCVznntHAZCHp86Yt6gLpAaSqUlfu2JFIB1MxSRD/qvQmHV3mJsFDOif/zotIya2K7IeRD8MioRtP7c4Uqs=@vger.kernel.org, AJvYcCWMC3rwQXpvt5GyKFaNxanw8/r7T8lSycv2lGBUNVgBYuJcXPgg+9etsWRcw+a//YVmUoF3YTYM@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFAA4oCq+oynqSrNb7JqrhdKeCCsLPRZMAi8vd/l4+gxXvLgZ
	Rvim8kWv/tiYuHF8WDlr/7NnZo08wB5ZOL8f+LSl2/vKYkLdYrgPrPQ=
X-Gm-Gg: ASbGnctioDow7yNyvTXYNLWndnOt/uYuR4w/02Lp80dT9FrlKvx03dcfJhNo0Eg9wfQ
	a625T6uitvtMV6MnYtnHrmeH1Yk3twopQ43vvyeLR8kl9EjhU4Uc6P/lt3t35XaxcVXp91DVt9n
	lHzsVJLWdk+wBx1DnzN0QC96oJjTZOKRLjzC3s4iCJVOwUiof2PaM70D1vzNklrhzbsiIbydT4f
	NId2H4qiT5BgLkGbJTFzCaTO3ce3A2Py5bMLUdg1NrDBVd7mf/LDJTdOlFSCr/myCLpn+DG+RN3
	/S49xc5D7VhM4pr7Ig2gvQQ5NED6XdqDD6UaTCxS9R7u32DoEugI1kC0bB4bPYoG/I5qgBCbBsA
	Luu83/gEs5d8AYzoSodYc0ittag==
X-Google-Smtp-Source: AGHT+IHAUUDTqgPWXcXetjIx0Km+QEVH26IKZatTuvSC7MLKW1sHvOGyuyw6u/DD1/hJ1Pkuf9RRzw==
X-Received: by 2002:a5d:64e5:0:b0:3a0:a19f:2f47 with SMTP id ffacd0b85a97d-3a35c853278mr1150277f8f.42.1747342684618;
        Thu, 15 May 2025 13:58:04 -0700 (PDT)
Received: from [192.168.1.3] (p5b057603.dip0.t-ipconnect.de. [91.5.118.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d204sm611628f8f.10.2025.05.15.13.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 13:58:03 -0700 (PDT)
Message-ID: <685a60fc-d6af-4da2-bab7-1470e395ca2c@googlemail.com>
Date: Thu, 15 May 2025 22:58:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250514125624.330060065@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250514125624.330060065@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.05.2025 um 15:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
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

