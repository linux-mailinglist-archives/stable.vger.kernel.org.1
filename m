Return-Path: <stable+bounces-92950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F6B9C7C19
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 20:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050D0B275E3
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8B20402C;
	Wed, 13 Nov 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C+MA7WGX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3D202647;
	Wed, 13 Nov 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523970; cv=none; b=L912us9UZuD9T2n9Roi4MxLOpKuaw9ZgPdYIzqef0s+5LU+JYGIuyjyZCFdYipwVctNH4iYXBiEidGwfmx4Eu9QulNBpaBdWsiDBKoX6UB/s8n21YmWh7ncjX+k2m50fMurc5Z63g22ytYTyFXDXYyWYEKAFtnBzULphAJ4a0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523970; c=relaxed/simple;
	bh=y76Nso1T2M53V4Eeii+aDzTYCp9de9LzHPJbPMrvWZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqRADifPvEAaPBk0BsVAv9PyiL1ERJjRavfFkJqQoXfwiTTzpMFMLUiN9ff44KpFBc696tiEhn37UYUVVPc3uIqQCk+lKd4rZ6ISifjGatJ3ppcTWKNG+pzENc0T5Gxqiy4kuJpPUmw4cdI/eTWZkmZaBJ8kRoyA24Fq4NMPr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C+MA7WGX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so68789575e9.1;
        Wed, 13 Nov 2024 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731523967; x=1732128767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRWZv4RhJ9lTHI4u4MgLnmELohU8mmM5r3pe0UhLjsw=;
        b=C+MA7WGXDpwCOiwipK/HEMcPAahTSgAOfl0j9aR4fuzbOzhcO7HlUMMoHBGvXQatcB
         6cBTtou5RkH9ePyVvvvKT2cUaV/eHslOi6czFLAkY+OuQP713dks/AanxpHfYDIxD9wT
         WshD3bN/lY3wKmMHYrJ6N0rmweXgMkbLXJrqSEtOs6Ehbld9rgUyOx2xRKme2xz/EUmU
         C8jA3rCrcofnMrMKtoHcwy/JaQO+0l0/9rtqi75nonxBO/oWqvpkYHGuXCCjmOoiMrLt
         V+m9i3GlY30PvV1OEo47QQhQHdyN3euFQhU1JjjQSrelxJSFhNfDgt4exUqRaPWaAJf+
         d2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523967; x=1732128767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRWZv4RhJ9lTHI4u4MgLnmELohU8mmM5r3pe0UhLjsw=;
        b=aJ1in0WRe5UCK3Z4GPITr/YoBbDwkGGOI3GRwQsE/W3dzHRjGTYjpsBV8NHdnY4htl
         d0ojxoJzJH+6PKXXUHHiUIdnyz3K+YYQInwfnB86qM+38oZ1/MxUIv3fJVuMXkDoCdle
         0mHwydtQ+Kv4zddRR2EYhBESwrlHy9n82/pWvbyaIqQfy/yYuWMkf5Gj6u/Pz07jjuvB
         Ps3kYOE1ZTNSTd6aC990k0A8qavjy/zP/VhiUxAgU8WwGFWPcWOKpakPE1Wz+OBwpJWJ
         jpPTgn/hOMTwm3CWW7OMQlBy5s6U70LHAYZaZeKhhyCKvoqpqb68/YR9azXTa7fIkK3L
         23yA==
X-Forwarded-Encrypted: i=1; AJvYcCUAHGJVBjSaqwqgz+cHsWPDjUp1PfPU1iPn5ReUUEq5TLRCmftNKuAOsL9h+0tVdSj0M6fzyK5B@vger.kernel.org, AJvYcCVBavas6vKFA84Gb1Dey62MPlcDSY2hoPgnlf8xwNCfEr6/b/9J/TqKJwMKvBWlYn//dA1Lu1PDq9eUgo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYHKy1WMR2PQx552ppKwLD5a0yszdJ0qqytrC6RBKx+IP3Y79
	8gywuKCiq0Bapg1c6KyaEkRRLCm/h3urm3lycpqrDjqsKqXKs1Y=
X-Google-Smtp-Source: AGHT+IEWNXC5afJvRa/+8LX+fS+5vNLc0NYIBcQrz9GxYov56SGAiHdFsUILOP3GIYogiLBfzA4m+g==
X-Received: by 2002:a05:600c:3d14:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-432b7507c50mr198707125e9.16.1731523966537;
        Wed, 13 Nov 2024 10:52:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4ca6.dip0.t-ipconnect.de. [91.43.76.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5541824sm33198225e9.31.2024.11.13.10.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:52:46 -0800 (PST)
Message-ID: <507efbc7-daf6-4812-ae4b-1abd294cedbf@googlemail.com>
Date: Wed, 13 Nov 2024 19:52:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101848.708153352@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.11.2024 um 11:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
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

