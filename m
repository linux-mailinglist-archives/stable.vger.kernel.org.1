Return-Path: <stable+bounces-61296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53793B35B
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4451C22B31
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAC15ADB1;
	Wed, 24 Jul 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ggM0tgVd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CC155739;
	Wed, 24 Jul 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833761; cv=none; b=QyOoFgh7q3SDMFuRJ3gtc2xWx4JfIJ5MZPEO0YhGovauMWSWhsn4kSjH3y2zlNJJ3xTeU6lvjspMFen9LGaYkj+eJJNwxHJNj6wcreJ9zB4E2bqcNh9LtuU2cfnbRznAfusBzCVc12Xc6aoAzSBwtqes6cUJyBR3ApyknnrIgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833761; c=relaxed/simple;
	bh=e+T00QYZKezNCUrQ/yC1u4Cds25lLnfftKUX6C+B4SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enG9h6P6qfOGHRcsx99KWvqSv0mR+ucv6Klsdh9U01fRCL7O4A4W2f4YfRXdiAlUS0gXDSy67Ql9Aa0X8nFJsK9YO8vmES2X5YLpFBgrRt18nWUxVITYvW7pdhul717PfcRdbRAm/i8fTjzqCaMXhJ9bTpPLQwHaO9b8I24iWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ggM0tgVd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so172407766b.1;
        Wed, 24 Jul 2024 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721833758; x=1722438558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6pFD8lMY2y6AZAQlT+K+Y0TFebcOoG5ZdhGkDtJVwM=;
        b=ggM0tgVdwgpWo4hHz+BzBBpgZHm8spIeiHOAV6gDhG8l3Ex6HoZGMCdZXP+Ro+bU5t
         7y1BZzNW9w4Pmwj2Ja8jMYzjwV6ys7QZZGmlPwA159A5pK3C8XMEuOOX6MU+UMvIQqWG
         d8zNybdqgWAirUZBEz+hKnNjBsqDVv2Tv0K+vtiVSPEUepLpgwhJnKQ/HmFizGlZQC+S
         u3QoC7/NL5Redq94Waw9tVy8dJ7MEvjKr5j+k1UPiiwlNypooaU60Tno0TjL/P2wecUZ
         oR4phXcL2YmONa//c4gfulDRTZbubQHwobSWXr2BX7KHYATWYQmbJflWvKCDigj8VRY+
         d0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721833758; x=1722438558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6pFD8lMY2y6AZAQlT+K+Y0TFebcOoG5ZdhGkDtJVwM=;
        b=VdeemrnxJEZ79Z1NUUC+sB/ZKx2JyqIQSca3XXND+jKn96/SKvGjGFsd+Cx40dPZMa
         BaEHDapI1WyvZK5yaM0yZMi4ItRWCfI7fYmClmuzNjUvfTQreFX12VutNoQ+MD5Zmo3z
         bQhF9rOUBi0HC8Ga4mZzrFU7wXblap3NIJNgcGbtOwdygL6yo+r28ej0OSHiOXyVFaT3
         T9k6iyTdWGvZBFtvt8I+mFwlGw7v8BNY7BlVjXNf5vyiLrAuGSfOOIJWR1hxFIW+9nCk
         d1ii7Rb6gSBVo69HIC/kYW8Lqd45joBYTkz5A1RQdzQRiCtf6qfevyMLRMlxLpgzhQjP
         1U1A==
X-Forwarded-Encrypted: i=1; AJvYcCXjgEmT+giO43GiksqVpebxDcXxsdPHUn543XEMdtlVkEeZYTzNu/dV2AXBU4b8qJgjbBI4M/i2NNGx8eeO0kYeeQSNcuNqMdR/nAf2nWRwFDH4GpImfX5txgAP9btk5DrOdpwW
X-Gm-Message-State: AOJu0Yz56RoaQ/Hxss8WaO432OMNBwmrL3ER5GDHlTa4zeTDoaYMIbZ7
	js8UsKVeCJlMOW5a6y+h4Ti56ih2RE7yjfuqGfcRlel7f7gBjQk=
X-Google-Smtp-Source: AGHT+IE216cUStduxqsRJC5ItkiDD7My1lRhgMj0JEHbhShAjaC7eI8OtGGhSKCCTI9YQamdbK1jvw==
X-Received: by 2002:a17:907:9694:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a7abae8f633mr134242266b.42.1721833758124;
        Wed, 24 Jul 2024 08:09:18 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b1e.dip0.t-ipconnect.de. [91.5.123.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa08b6f18sm162798866b.46.2024.07.24.08.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:09:17 -0700 (PDT)
Message-ID: <109bd280-a1ef-41a1-914c-9fe6f96c31e2@googlemail.com>
Date: Wed, 24 Jul 2024 17:09:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723122838.406690588@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.07.2024 um 14:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
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

