Return-Path: <stable+bounces-85086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66F99DD68
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939591C21E0A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 05:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63549175562;
	Tue, 15 Oct 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Oge2smce"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F06166F1B;
	Tue, 15 Oct 2024 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969199; cv=none; b=rMKjPd6eBEDoGyFwnNNiAhn+4OS4gWi696mROs9NSt+PVq3y1ffV7iMnLVNwR9B84pkn+WlaYkWcewU4Tutl//smWkLjP3WORv9EVCZhwhpNNNJtJLEqJ5zGVlV3FfP0A0ItN6lOGgYRwG39BapwTreYg4pP0vPtsp6UH8xH6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969199; c=relaxed/simple;
	bh=3uI3OWuZrMmEXJ8l28iAIG1EYkp1PvXzt0XnXFDbBLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0OVRUnTi+GE/5v42Z6IuuNhgl3oNtWbBWJyc/xtUDqGwA/dPNLcDsWWMVv0G+C/pvVdKFEUzppBpiaD/x+6qIHEcmRt7nQ9jnw+H5mByb6gCQoagWb8GWRIns6ms/oCdVUcl1KsElMrYRmMd73erkywwgsIuvsZemklNgo4b28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Oge2smce; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-430558cddbeso33201725e9.1;
        Mon, 14 Oct 2024 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728969196; x=1729573996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHik4U7KOw/4dIRDWl5VwjxD5vspBFtD0hwaXOoLj+8=;
        b=Oge2smcedozPi+ww0MQuM6XA/D1JjAAajF0gTJDEnTkqTHL+AbaKK+3tYNG/JcMTgZ
         ZOajsZ2LLRIuJEzout9DVkCi7NsOI72HNpnU85BZ/C3tK0NtE/UXy0xlGhyP0HStmfga
         ViMbcGRxYRcSahFC9x+rGn9weMCH3rl661fAUqHN+fLg99d8L2rn0Syr8QvtOxaUYKtM
         Dsr+/hI5Jj0zRq/jxJOBOzfd/eUAhm/zixx1MPvtv7IhT1XhLhLBmwEM7NZOEAh0vhD2
         S54/OwoEN5t8BxSzAmAZo7uhj0tpdFHX9QRoxAzwLEh6wnL6/cYspIsATJbqFrTT8xMh
         D41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728969196; x=1729573996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHik4U7KOw/4dIRDWl5VwjxD5vspBFtD0hwaXOoLj+8=;
        b=YuxqlKA1w8K+hQK0FClLAdVZfvl4yj4UfaCLJyZXviIe7y5vjblIswVLfnersVD75A
         DgBc+SUFWqdIIQHlF+4R2ERm5NTOdGbDBq+EHg1hG6L3vItHNKw3l/WahEsGGeKANt0k
         cKSWFRxprNOI5Poisxx+Bv1qtVP6MRvG6SKsIN6b3Fgsb0+GXgJ0ohAWlrWrwNPcdHYl
         HQiVWMO5l3RRckTHEVafqjNON6FTygFQQWP72h6GdUAQKU7NoXAE7TewkUxl5gbp4Mto
         VksUJt12lA9Z9O6R3nGoArZRcYXwCLGcn/9JCpIiQdPgax+P+tyOatpV28o2QgzufVkr
         2Vjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvZAGqAgNhEO1RJqIKem2ZnTJADCDxFkXP3opuMP8ijO9RaYty/EGLLpQxvcf4W2W6zlhlD0AU@vger.kernel.org, AJvYcCV0jCcl6OA5LDcP0mw9mFx+UdCnwT6io1H/sW5poiB6dRkV9QBRvHy0ZjTH4vGaXEOWJS1FbTsYwlimWPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFkW8rrr9NVPAePGvLc6UydzCdUT7SpvfIkrH/XAGXeJnP2sQ
	ZbDvi78AsYJyT7HyGAhUlCyRCSpJYRYezQPOVNKDOFylAS2CkNI=
X-Google-Smtp-Source: AGHT+IFYKWFkTetC2jsHx2cuWQS1f4EkFAT2Xy1LYi9zn5BWKEWr8Mg8OO1edr31ys6yhXGXTilGkQ==
X-Received: by 2002:a05:600c:4e8e:b0:430:4db2:2b88 with SMTP id 5b1f17b1804b1-4311d891c4cmr103556005e9.5.1728969195718;
        Mon, 14 Oct 2024 22:13:15 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4546.dip0.t-ipconnect.de. [91.43.69.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55deeesm6519045e9.8.2024.10.14.22.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 22:13:15 -0700 (PDT)
Message-ID: <09191ba7-304d-4e2d-b5ae-8ef0818e7675@googlemail.com>
Date: Tue, 15 Oct 2024 07:13:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241014141044.974962104@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.10.2024 um 16:17 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 214 patches in this series, all will be posted as a response
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

