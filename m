Return-Path: <stable+bounces-52249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59535909579
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 03:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C411C2121F
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6258440C;
	Sat, 15 Jun 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C/0J+Hlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12124D26D;
	Sat, 15 Jun 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416749; cv=none; b=hwp+e7dDXsco6HSH2Y8Awfa30Avlm4OAmUDm/bD/Gw4HQVG0t9ni/TmcJgkWnObnmUVpDIFBF+Vz0V3cJ81vMyNkXLRQo3vsgi1h7X1X/kWLZvap6572Y/YhRv7K0uOtz8kWAJ+Q82LnVNQm9nW26wsMr5YkTY74uA5BOZz/kEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416749; c=relaxed/simple;
	bh=ww37zaOiEY4YoIR9AYfLzK6DHmdS62JS+qyuTD4w/uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPiiz8H/iEp6kzK4C3iYPSFrcCJBOYV7a/0Hlp7KeW7YvrQpxQcq2tX2FPJBuGRw4ko/s7aDwc8cP8ecmuUYTxlnJtibWaqHHwbpADt+sx13tBozn79vWKxCKPibQDhm4aVSJarHYPbrGLKBURutCp5OXswjRwoE6uKfIp9De0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C/0J+Hlf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so3217302a12.2;
        Fri, 14 Jun 2024 18:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718416746; x=1719021546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnBuema51sIsa2QQpd+nX2kLoAJ6QBxAxGuxApnIuVQ=;
        b=C/0J+Hlf9vLVjkZYqKa0bY4Onw8L1/hJJxz58LH1U2MFnIZX7PKvd17VCgK6sQlGYq
         0KYY42iO3sGdL7ZU5N3+2RyysrJigUThB+jJIsKR9q1xB+vk9piCOe/aX8AbKaSnioaz
         5T5/PeoNWLzADEfBQGLW/r1bASsRS2KzOEIS/gtx8HKDDn3pIh8B6b5/Xx3BBNvfID/d
         ycuHmAijKyVIVxgNS8zjGI1FWLBruyrODoF03E/Rru08uuILWimqa+e9ghyCbRjQUq6V
         v99cLfSGgKr/uVbPxIr0g6Osj31IrAXg9ruRAwA6EiJXNaAYpZiRg1rlP5U9E0Sm6qSM
         ScLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718416746; x=1719021546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnBuema51sIsa2QQpd+nX2kLoAJ6QBxAxGuxApnIuVQ=;
        b=DRdVcZa7+A0cW5FJSKxxPwwvCzd8fiA3QCwTJrcK+7csWzNHijJ83syZ9aBizag+GO
         AQNvTEAZY6U12GH92mTP/GE72/j9BJahKTGZDF/Vmg787d52Ap8xUegYgvfhVH8Psy2W
         M2Wj6vN+35rbMpld9i2wCIpbSRTcMNWXBmXp1ESQK5t0q3yKEseLQ2VUQXBue/jHaNoM
         Yrf9njfbZA9n27uOO10t+z300RbyDcZCzLZM2CcP25/e+XNDZW2TRip/oahvFNYcKHHp
         zWU873+7YgYjR6eM46sxbMv8rXDvaYcRpEP3oqVxVp9Edk/hBCYSvGnSIj53kCArJztj
         Zkew==
X-Forwarded-Encrypted: i=1; AJvYcCWVZ/dOJ1uU6kYZYLeH3WtKswWvFDCdOx1YUgHvfmXCBlTJ/ddZfUHOScpIB/DOvqC0Jm7wHpMaLD78kCB/QbfkDRABQqevWvjrrrh4kHaRcb7IMBxcJXU4xN6yiK1lE8UUvSqe
X-Gm-Message-State: AOJu0YwbdVkRGbJdiSfWWKSdty8hFQWa/m/tRl5nZtcRsfl3gEAEOQz2
	C6WbBHeHuL3vVlWmOSoTCPz10tkX097zQMdLK6dQsAKHBn4Cmuo61YMA1C0=
X-Google-Smtp-Source: AGHT+IGqfx4zl8pmHjaMX8jFrVGJShYsFAvAovN1qGxCuTlQKDG9mo2UcglhTiQR7gmxLmyHs31J0w==
X-Received: by 2002:a50:bb64:0:b0:57a:2ea0:406d with SMTP id 4fb4d7f45d1cf-57cbd652479mr2588820a12.8.1718416746031;
        Fri, 14 Jun 2024 18:59:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4225.dip0.t-ipconnect.de. [91.43.66.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e70dsm2924217a12.62.2024.06.14.18.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 18:59:05 -0700 (PDT)
Message-ID: <d8e7a445-5918-4049-ac39-ad222536ca6b@googlemail.com>
Date: Sat, 15 Jun 2024 03:59:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113227.389465891@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.06.2024 um 13:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works fine w/o regressions on 2-socket Ivy Bridge Xeon E5-2697 v2. 
Everything looking good. Except from simply firing up 12 VMs, I have not done any serious 
load testing this time though.

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

