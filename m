Return-Path: <stable+bounces-179090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294CB4FEE8
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED95A1734A7
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AC34DCF5;
	Tue,  9 Sep 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Cgozukb3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7134AB11;
	Tue,  9 Sep 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426934; cv=none; b=Umkc/2NBlr0RVGenfzkmIVH5MLBXqA7ihckv0cQ/Yc4DYmmOmO5f5Y+8CcpS0d68gQbePpuPSuJItiHMrq8gLadbPnS5D1ovdj+10itAc9clJcj/A6J8xfMx6/PjW/A1woVcpMeRa18QTEk9kfIbt62J28QnLrAc8VexQUd9F+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426934; c=relaxed/simple;
	bh=sNnWLL29rUT0pKNPRkt2AG3hxp/8N4KzCnviTWEG84A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOPUfTsbICTGjSGhmxxAEnJ1pdk7JYpu3wQs37oOc1zuuJyOL6JFhHdz5hyfMNrZrHp03hshOSwqpfkFuwoY5bNZJor1kdc4dG2LXm2l3VAqwGZ0zZRavgDjXtKbJ0oyDZP/WIiHTVgvGmMOtuCZ8o6aDlY/2Bxd8Wh8kVwy8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Cgozukb3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3591380f8f.2;
        Tue, 09 Sep 2025 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757426931; x=1758031731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcsCbWoN3iCLFYC0GWMkt8bPrGz8pyO9oA3ZfhNfrEA=;
        b=Cgozukb38vMXe1iSrc/Kt800INoYXblpnCby3Xur/6z1IPWkWC3Hr0iQuVylnyC3KJ
         ZJeAPcc2QndmkqfshWEU5PaL9fPRIGoWAWismXpUaCU5mEHpVyfIVsB2Te9LV7/grvC6
         Vx87Qrz8SNvLtM8+CvQX+o+r+2GSBLkC05BFxes3emNTokyMn0m5ivPyF6HDaaabFDJ7
         5g0sgxA34rL9pcTnFalkz+4wQnug59VhzWNfy5R+Gf3xGCnJ5fjoTs++fwd9CFyZBHvA
         VhCYPgMZF7HRd7bIyijtkhPxu0nKxqE0cn5wvl1JyJ7ciIm1dFpj1vsxoHavjgUjDlfb
         ouow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426931; x=1758031731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsCbWoN3iCLFYC0GWMkt8bPrGz8pyO9oA3ZfhNfrEA=;
        b=jPH8R5slSjjONlXJ0DHT/NrlV9kh1PhH/mVBIdqszJN+YAm8tpG31TuZcMIzgW/X4x
         ONTEm27pLlH6/z0W84+Ol2oguynczKhDFKpnHhhgnjbb9ZzwKJ3Dyhz2eJroYVAPLS1K
         7dP3OB4jvRhjTWK8Er5DRfGIVw9RLXj2hzaDq+4ff0vX+26zRDBBhDIiSYN7D5gVCGro
         8Q1s3YM98nifxthAKEiWo60QMivxP0r/0xcSV3VnMzBCmX6ehvnIATACQfVkg5Cefi6h
         KrVN2/aYlo1cCIRl0HhQZaUmsBDbKlSErdpqtR6TyrFrDY27C4E1C83oJ9uysH4ESzHy
         xc7w==
X-Forwarded-Encrypted: i=1; AJvYcCUhdHYPk+F4MefoVfCIysLrXhyzRipBmA+kdhfbZlMm+zH7ktAMy1QVDf1jYTAJwVg4iSBfN06hSJriQIo=@vger.kernel.org, AJvYcCVpsRop+5MYttxUYEqUWzh4/DOaUv9bBgspHII6Ud1GoC8CJcREmkmx8WYydids3eG0qAIHavdc@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPKio76JDQjc+NX5aIByUFY1bDNJbeJZm39V34CxXgLO9a1yg
	eU6L79XlKUj0LgYLIHIjEeqMH02xcIOJrIuw4IFWVCROJ4xjWI9JeAo=
X-Gm-Gg: ASbGncsXhTuDzzi4iCNclug/KwWfNhbam31+Z/AaraDxQZakt/YPsRLCqZ10ge1Dlf/
	Bsplwxt89M7+Llf11juSHtKU2jLWgDb9e4ZKmAi08nlcuPUQZwYk2p958QNB4O5P3P006NL6mg2
	iRfr+hOVMMKuDHZEds4dRUVpYgSffxX4WqrI7X1JVcevrOPchT9ABHfw+oq0SyJKQghfEp9G8HS
	/Lay5Go8IK2eqoiTC4WtRF+DuytKFKdXokgnGxkWj582Hg9aPbgNJ4sEmX9nGpN6Y2JmRiziMg1
	UXSsEoYytwUvK9uNyDXdvLww7FN0BY6p4jalTELFTDXA2bocT7cebojh5cOv8L3kyLXabkLxdkR
	4BdbV2ObbruPvBaKsFkFXsw+12wZUsXxz5Mb1/UaIuWxdUrHlHsgdotQGz1TbGV+B8DJfpNKDRQ
	==
X-Google-Smtp-Source: AGHT+IEWWpTkOQ1mRMXr+JVzPNgGbgKVdcKr6veRQ6y6ofzrdD9M/cpyO4YaQuUO8aZE+eAwdHTpUA==
X-Received: by 2002:a05:6000:1846:b0:3e7:44c7:4bc5 with SMTP id ffacd0b85a97d-3e744c74d83mr9153674f8f.25.1757426931164;
        Tue, 09 Sep 2025 07:08:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b057250.dip0.t-ipconnect.de. [91.5.114.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf610sm2814855f8f.9.2025.09.09.07.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:08:50 -0700 (PDT)
Message-ID: <a423706e-b5da-42b0-a759-1aced1775402@googlemail.com>
Date: Tue, 9 Sep 2025 16:08:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/118] 6.6.105-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250908151836.822240062@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250908151836.822240062@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.09.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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

