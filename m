Return-Path: <stable+bounces-125695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8461A6B175
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC34679BC
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D922371F;
	Thu, 20 Mar 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LXhc3CRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E51F7076;
	Thu, 20 Mar 2025 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512256; cv=none; b=NZlTRO9/unUniffL82keYLJtTs8i8ApvofBGYupHBHfcw+7loE9nqJ+G1rqRpG7Tx+AjjP2jQC/kwbXLMCc5KUXH+zXQ02xp5omzaALtf1IriD2UKyDLTzjGAlz/qUanVtFP0plUvyedu/AAlCLWt1ffGVwE7q2kH8BnLapWKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512256; c=relaxed/simple;
	bh=LeuFxJWRVErEEIX1icP+0d9XKI181Pws7o9XD4Gd2yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKVMfkgAJT/xQksTFLJAMEK0E53P7x7jvE5PI5v7pq29kIri9MwiTFnhkovDh7LAgNwWA3t/+1XHxLuMTn8nLXtTsJ9olkHtpFfKbijbqanws00e9JIkkiAFOArf0DtsUuykD0LfqxH98tBsIAaNvWgvm54n67y3U/7fIF1tXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LXhc3CRg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso8901625e9.3;
        Thu, 20 Mar 2025 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742512252; x=1743117052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgGFGfd5rkD2ZyLqsgWmDoGcBUZ8fPi78OPp2DjmGO0=;
        b=LXhc3CRgsDz/Tcv9/NGeXfn9KA46BFPcDLDAri3IfPUtn+CJNiZO63F3i8TgffNIPZ
         PgnFM0iRSwI7W6DzuNiet94gFakhZpq4fCaLqZ0dhwUSosrrTdrM81OybTR72e7RDny8
         ajcFOERqoFry4QQzmAfRQ5G6ZX4iPYE1kr+dYZuth9mvSQuevJqSBC3NVEc9wayogq5U
         /CgCOBw2egc6S4D3/xyr/lErsbFjTfbj9ZVDji3+czycEMreW8twCjVudRry90ywDUin
         RGHN0mqaPlp5cB/E7EU0iVVNGLI9fKqd8S7a4jqcfbmP63vPf0FIQwgaLknT+Vqomojh
         UK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512252; x=1743117052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgGFGfd5rkD2ZyLqsgWmDoGcBUZ8fPi78OPp2DjmGO0=;
        b=Zga02tqkbqECm/v50KIL0gGU0xIPt5zoGmMZKfAfcKKRoIZhi0/zuH8xhmODq64vKh
         94kPwKcJBDLmAcuEtvSADyKDoBD0tjWzPL1RWT2HeN9fKQuURBlmHp5t9iBioWjC4/8Q
         TbDoaDhhMF2J4p9JpgpA0BzQB/QskZc3UkE4fQTgQbAtI2p/B38M6oRpxTifqWX62vQZ
         gkSD3OpKMJIN3QT0mHNyFQKgYZGkJ4s8uLJf+1qKykhyJ0e1KkMwLBNiHEuD+t02W095
         VbOVszTqjt/t+yZzmxRAOk9KMOSek2zFurjoAdYeuCxxgxB2kyOBtMqD6lL+71o1qWKQ
         LWpw==
X-Forwarded-Encrypted: i=1; AJvYcCU81sY2hPg1Jk+RFmJhCc8XXUZ5sZs+0bbiW7/0KsY3/WEZGLztwpCe3P6IiMiGQL1d5SJ8r5JB@vger.kernel.org, AJvYcCUKAqsh5VPHIlY0mxz2XwbhuPuz5bsJG0BcRSRjW3+QqjE6hLo280HruYinhgZCWGRvRMswRDLRvAKIvbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgkDXj+nnkZOORgjExqOKqCawm4VxBALUoVzm0GpCOPWjOLmS
	yFcKDL6HGLLSe4/xOwc3s197XS//CwVqvzB4THpD1VCYxfaf2e8=
X-Gm-Gg: ASbGncv6QOxfFf359xkRouYzlJQHfnDju9MfsDeiEzmjuRL9aMLYTrHOYPaDE7UL9id
	kkS14+XGWD+rJ7IxikarBMadpAahZHw04HxndoiAopghYdEpc0ijpsl5LLYpemK4+RFR1i2TPBW
	glUXBkFw+dId2syB09aZRJiNiIiQggQmGqysdSVfNfRVbmZamCs76qsUvYhAGAad1Q5alVdpCBl
	EnrYZWvzP9KVHCSSE5c4dc0BgdGSqTEa9dZP+XmVoykM/x1K7HWMnpR3lckHJzDaDGakcCAtTFB
	5wAs7PbBo39nDRgKQ/R1VIR4HkUVKJ8E1fsQ8oA0+30cWl+enQBJeQLaX0zXgfvsDCeZtf6AAeS
	abEspdzMsxCOgVVJhlJ5/cs/OqBDUOmhg
X-Google-Smtp-Source: AGHT+IHgSRQNc9Qig38LT9KP4KQaN7lHZBWnBjgmc1hZ2ApMjKgOtzBU6StHvQDTzfRESNBqk3CHVQ==
X-Received: by 2002:a05:600c:83c4:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d509eb097mr10300395e9.10.1742512252096;
        Thu, 20 Mar 2025 16:10:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b0579be.dip0.t-ipconnect.de. [91.5.121.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm779372f8f.25.2025.03.20.16.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 16:10:51 -0700 (PDT)
Message-ID: <4ce78955-a2b2-4084-b2af-5917a1d13d04@googlemail.com>
Date: Fri, 21 Mar 2025 00:10:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/231] 6.12.20-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143026.865956961@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.2025 um 15:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.20 release.
> There are 231 patches in this series, all will be posted as a response
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

