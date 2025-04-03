Return-Path: <stable+bounces-128149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D52A7B084
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B52A189B930
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D0205AD2;
	Thu,  3 Apr 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RMaebZs5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756F1F4626;
	Thu,  3 Apr 2025 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713548; cv=none; b=bPWmZjl8qOV2n5sJG15RBkB22hBwn/mms8xU2X7T59KXgADYC7ZdeZFFcJC8AUccFcSWb+gFKk6pbXwCqFPtRKkm59OlUPNr3FY7sHRHmZWiFRr5nKl8gjJmZoLPGb8sRApIcVQDL8Mfqnx7Ln/wI1dt0UZiWjwBJ1sqZMvk3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713548; c=relaxed/simple;
	bh=wzaX8x8CN4VuzMeZu7Ro/jNwfZNPTLEs3cKtF1c9NmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsLRKYJLOubPS4p14jggGylLNzxqMxYojhE97FO4j9JM0UFC2X1HfknCa69eGw/nEC6M9eLWBVb691vn/VNSmz/LkFQ4gHgMJcP7+2GXbo4dVZklXawp6zw+CYFYIzHVAvyI8lt5wlmrTfm0oJdCtaI8dvuH4kruLEne9QcWOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RMaebZs5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso9531525e9.0;
        Thu, 03 Apr 2025 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743713544; x=1744318344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dh1lmyVMoTxI6QhxvGlPI3b4b7IHb16ssKSrLJcEUZk=;
        b=RMaebZs5YH+Yl3fSLOl3g5eSmBiH7D+4vNquMC3HL23N4iPz+M5WgqYt6Q8Vbzpjhm
         Kq2QntN+IwJnXyUU4rqvighLnppep9DtrDwPypdCoFiD1VSMxD6fSc1RhsC0GSzrDIRX
         PtcMWf0F01OhB7+ZYTg6fehVc2CRliw/eyzC+pgpqhRm1QejoOXRC38nlhn6KWxQbSAz
         suLTrgkr7OuXbqnMEuGfTA0pBdgpBtnJaEffRq8WbkxAIC/fNRQXO9PplmYJIuQpT1BS
         PDnsseg0p5/CnYhwzVj/N60T8JC5Kf3yI7qDRhBFg1eUmTmR6rvP6xdp4aq/uhSGWe8L
         vrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743713544; x=1744318344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh1lmyVMoTxI6QhxvGlPI3b4b7IHb16ssKSrLJcEUZk=;
        b=p98xcRzMjatTFXK00mUs/uVlhsFxYSDLZEFLGFeslIorJcCjeC2W8kq7Y9gn2MqNo4
         DQwL5mChchduGBMjGQNat684kNhkTxL3llz04TeQqLsjK2FTlqR3UC9CtHpVNVvBqlfn
         oExWFfRFJuZYUdXdx6omCcFc/dupx6MKb3FjpFHz982VAXD18J8/Ih7k32El7DEbLyyU
         EuWi6fqjiWxp2o0Pnf2DdMEqqvVzljlzRI5AyJxQksSWrh+E4KDLRogySRd7oC/hMNbN
         ce/CKSGrnG+lEwSh9EL+40k10euArQol3aOTFUIIW1oQUn3/Yd/MTJMCeR9mMrjcZgie
         rjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUpQatugA09+Hcpiue//6S3lU0xs9YEWI8/z5cDsNPZUXRjmVkXpSiN2TPsh0khG3+9fcSGSn6I@vger.kernel.org, AJvYcCUulv1LyCcgtgMdq4U46ZWeUykPRYlejhXZsXWRAIhdqu30btDsrM1HExgQw2W1PkZVTJyQTGFJgX0uDYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkDGYd4DvyOl3JCVyFJAVN/C35PvGtr4d/P2kaWt8UAmV7MU5
	ccOONw8ajTTdFQdE+YR1rlupZqVG31fm4YiDami6exRkJQ/0Ltg=
X-Gm-Gg: ASbGncuXUeXp5CYFiEbpsVWQFciYcsg58G8+QpB4sC/c4gHtJzyesShMk/hrzJ29IDK
	Lo97+Gx96crmoy/mDOdsQoR+XNrsAGDeVFwT1Mw9UV8Zkr2oL7+y7gywqdM3hSdACwfxmS3qcKo
	601rIswHX27huxJd7uvEpY+TvSuNyN4Z0yMe/IGurG/hAIxkgJKq/WJ45IQXeidfwIlvDN/KT8o
	wqAtvxWthMyYtw8fN5BRStprHgbizA6SCNPpSzUFc0weT/s/C5HYkzegZAQQEsr5/UrE+p+upj4
	LIHuRTzNlsaXrygLeemFU/KDxwftMnLZXMj5a1JlqfdDWC4yUWnBqH/fN/x0gSXdWX6jB8ZRut5
	dZmWZOnBpoM1sCTfGy+czdgI=
X-Google-Smtp-Source: AGHT+IFKoqfuumt404ay/WdLI8M3vO1YnKQYh/NFzH+vQ/dp43SsSpIIC6flE8Gw/mHBQqDnya+SQg==
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr3445025e9.20.1743713544422;
        Thu, 03 Apr 2025 13:52:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac393.dip0.t-ipconnect.de. [91.42.195.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226acfsm2618227f8f.88.2025.04.03.13.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 13:52:23 -0700 (PDT)
Message-ID: <0d22ae96-d1ba-4925-88fc-3a225743e468@googlemail.com>
Date: Thu, 3 Apr 2025 22:52:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151622.273788569@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.04.2025 um 17:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.10 release.
> There are 23 patches in this series, all will be posted as a response
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

