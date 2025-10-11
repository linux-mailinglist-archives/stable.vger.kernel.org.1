Return-Path: <stable+bounces-184085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E2BCFB5A
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 21:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90765189A0AD
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D412820BF;
	Sat, 11 Oct 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SVysR6bu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16797222560
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760210682; cv=none; b=AntQ94uOgUBGPvrC+z3DJCujJTyuy2E7RCQpr2qxNX8uaCg6VZrInXI8gVTiTUpYFDwkGZnVvAL/7EIjEMMtGywaOTrb5U7uK6Buh/Gumw/8kHKOUY3hWtoQo2WTEI1BYtEDWkpZr/mh7ac9hxeKmyQB3ZEoFlwMlw2ortVwe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760210682; c=relaxed/simple;
	bh=HWo0rnjmqiObnqt8aaSDDNvEmppp34tQnFy/FsL8dlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okkQ+MBVyyNmP6h9fdqEJSmdGGtP4vR23iZwAekqvouQ5iog7UyA0fK0LYeYDxweG+3+pmNEo/1u2naV5cfvkCZ3OkkFTT1tDDD+F35Hww+9vakMOjWLlSBq84koTQ2BYD3Jc7TpqOAbbq06jmnzdQdfXvoYvqOG23Yzxz3G934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SVysR6bu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so15472575e9.0
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760210679; x=1760815479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eByIpXYuNkGA4vMeyFPW1nCJy+/bsqVrEyTS/rcOmE=;
        b=SVysR6bueXuYoAVuyjQv9U33ESUCh2pio55RcOkj1wSp2YYD+6CKbstv7nAxUcvyaZ
         eBCITFR/6i8DbEWiX8XfiIlt3zGfOjZPqR0TvV+um3JZrPhSo44ghhfk9ayjy99Bbyc2
         JlQKXTsdTW1ffu6w9bYSUVXcr7ZtSiFS6VQApjsHQCvzf1Bm/kHdrUB5JvzlnTWtdRRC
         p3rNvAdrsVKPZyLOxCrD4dDXwnnghuVn8IPWK01bsV5FtfQSpEVh7ABsRWizj/wXSQeQ
         lGg4gc8oi6reGct/+5kWStTFbUJanV5d5lhm61JUWVYS5M2mDcSQDAXL0JXNZmUc+Mwj
         iskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760210679; x=1760815479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eByIpXYuNkGA4vMeyFPW1nCJy+/bsqVrEyTS/rcOmE=;
        b=F9sLbHj6MVhv8I3rsfHgMTrcF3EeoKurYg1mJpJjThbndLdalTJPIAccdonbBUJTVr
         l143My34/FDgFh79Hr0dtJdRVEYqNDtD1S6RqXKCfV1VvRNALDBWS0iasDdJZ5u7l+JK
         cyHfezHhV1sp/2KnxEVWcek5Ek0dHyydv/1pew7y9+vrIpEooOlEkKHqDuahFxpsFTCm
         6/RT6BrMBnr8QRRpoZX8Zhe/vgM00okW9LFQQVfQ10F/90/dF2GEytdWq4R4VTCVe+sA
         NEJ31MmjJ4bSX22EnZpgFuaMKe1vyLqOYOh+gTI+o4qJwXcyCIcNjTl5R4z726Ts0JbW
         trdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoVqqBP3ISikgpsD+n6PKHFGpHtw0JNCzyLf/3LuhoPQWKIUdFI2WwiLGodQwMBg+OOU5du38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2A2k1xCanQHaCZGGmkxPgQapihWH97h8AYQOi9YEasg30TFC
	uvSQ0mNwk9ncPunci4wiZNpm1DKxRDWjys6plqiL9tCnU3+7uQaBsd8=
X-Gm-Gg: ASbGncsN1FG3xRTvduGk4aJeTzzkA0f92GulQiaYN4dCiBY//v9KEceiJS3PuhTAxD7
	wnB+6I0GP0WewMZTXg8vxqlzfFJ1avuA7KlymNmD6kFiByZgnL9fx6wrSh6fQlxdvfIAFStXRv3
	sgK3K6G6yhq8MJELxUvlgry/OaDZfK+2tOn66nRjIOoNw8NlB2VgcWFnj0DjILlj/LPPx9Wib8X
	kElrjnd+mF8Em5EG827SBR9l6farDIHV0nrz0D+r1xakoEPYC777w/Bi27QRsc5T1DCHzjRbQj0
	+q9hREgipqFheTb9aY9LGH4op7xQJwvf6pzoQeotiZJSgei8dR//Mixmj0MA6Za2p5Hfg8IAGal
	P3/dqXkl7TMFRnE+ejXFRc5nEhxw0EwNe9lLDwUyVPQH2CeEOkRUOQFIfZjOypxlain8Z4tysmz
	SOfq0geQB68XHq4mgH/F5jyWvXrAMkoGceqmfjsOY=
X-Google-Smtp-Source: AGHT+IF9Ep4er0sxE++lYcipoxpJCMsv+akfvA7XXiL+g3pOZ2ul1BTLiah3UVqQK13BxZKbTh7cpw==
X-Received: by 2002:a05:600c:b96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa9ebe245mr116787055e9.11.1760210679150;
        Sat, 11 Oct 2025 12:24:39 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm10016181f8f.39.2025.10.11.12.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 12:24:38 -0700 (PDT)
Message-ID: <e753c8a2-4af8-4e95-bc86-18baf7d2670d@googlemail.com>
Date: Sat, 11 Oct 2025 21:24:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131330.355311487@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:16 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
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

