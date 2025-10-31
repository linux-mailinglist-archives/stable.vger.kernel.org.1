Return-Path: <stable+bounces-191937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A807C25CF5
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066F64F4A75
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12227FB21;
	Fri, 31 Oct 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DU0F+DiL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457818DB01
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923761; cv=none; b=gpkSgSrgTzSFAeQ4YGyPUP7Vqu/hOrr5Zk9fvNXDvgZVG/H9HY9apMo3QHJhgmXLe3B1wlSHNX4RjLrpsokXVqtpvWas66o6HfpDzzUFOsc+riXpbvfeyBht/Wr4OExwOd3kUBwZq0MbPwLo6tm/Ruex0h9goT608H2+8BKeSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923761; c=relaxed/simple;
	bh=eUAb/mo9BVisGAU17xCmrbjXymc9wy6A1ns8iz/biXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxu5Db0fNvcQG+4NP58FqILVBXW8zIefQ+eqm0l41BzgoyoGvUF5MMz9F/b98VvSBAvQlgU0gHGRxqSaiMO9H17Rb9RBUzys/wRdjh9hl0znfgwRXIXxpE96wCKwcFtx0T8Nw5iDaxMLBed6kZtaEnrYe62hDu73e1ibsVrFPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DU0F+DiL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d78062424so410666066b.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761923758; x=1762528558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+6eCwAbvkcpEZ+k/S4nMUzhai7WXLq+sSlmm2fOvI=;
        b=DU0F+DiLP8iFJxMqVPgcqSkglNA5fwpE84KTVwYR+EuRGHFumIwrepJBs6VEEEvIjr
         NlCFlbFeuvQbfjOPOz4ql/PwugztySw3HBFEuYJPzPY5ADmNt3eSMYusQo0hMLYEe2qt
         13zYOb275ZwN8rig8kyZdfrXAZ2mLXg/ET89/1+NUIpYPhdh7Ns46c49Q8d4UxQTuOG4
         u6IlX0ITISyZ8zS+JKx5A0diKGyKMMM5WsGrrtULVEixaPlCGFI/DqSyqUwGnpYS5DUa
         D3m8ova+bJDfBjShtXYCKRHZAxEo/6pswDJPUCDbB0PDfp+Lqr1p8dEP8OXidnYS+5xd
         ij0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923758; x=1762528558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+6eCwAbvkcpEZ+k/S4nMUzhai7WXLq+sSlmm2fOvI=;
        b=Xd5G1MaESXVg/J0af5HfWklHfIpNYUjAyX8gEwfkEv6pZbQORaW8IjlAujXxhD8r0i
         yqE30bBvRmxFIqs8WE9Yi2Eo8oRQTCiw17r9rJJu5gDaH5BC2tYANZmgSYv4EE9uPjrj
         KzDuhw4xjp7dKfHZTkZgMkr6ov3GzdJapA6HLxSkTtbmAJRUnbFuS7sODQdYA2MAdenI
         Cq6mMUDxnpsi+J1+flORXndD94w8bJKtKHsoJp/RP3OkQJ+mSCQu+6q1DefUiaXjl7ZQ
         o5B7s4vNAnk3w1FHiO+INCRt3D8S5yJ01bhuDMCbx3HZ04U7o6yTwdy+3OjnBGxGL+uB
         QGug==
X-Forwarded-Encrypted: i=1; AJvYcCV55nY8jvuroeyu6XOn2QhTpKaIEGqLC9juQZQoMHf4oJ6Bw+GWt5GD6QzrIxUl1nHNXqK5c3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9y41VqD3kPTTx0yt4o08XKYcx1djgF9m2Rlv9xkT56bDRICMx
	rJTBndoG60p985DGiRRHMke+e5RhVJercH1z4qwb28+Rv9nElIXYdTo=
X-Gm-Gg: ASbGncvyQ+bdddiOXFxZR1Ve9B4Azkdr4YXG83q7OeeWbNER8mIgOSdry2c5JaQDI1e
	xqLxF7XPWudBxJksFQCf3aGxGIY54Zs9GHm1uM2X0Mbq0E+f8p9nAEC2Uo5u+1V9mhjIl0Lv7am
	KE+gLYjyN94dS1c2pP2QlqEVL+rVfxt0SYb+pEv+dM6eEBYTbryCRAIWRHIFICrHxjrYfuhyGw5
	WNwEtOE7tfsPGKR+sV5QNolrl+9gT6GidCI6KHasJFt/49Y1khfnwp0V6ekofZyt+kyvNgkwAod
	esj0B2dnSIrQ6aOPq5DoK0W081xuuT8RUX2Xk2mTkew3ew4nvOatrrKBtMj0S6Qf0xu7PNRuFhf
	LkLxR89rOf89/eSjBbuTfuDuo7iYp30kB7BOezdGyoTD6wRJvcccuLjAfVjQsIzqwapHY6f8ACy
	OddRrEViIK+5cBVK5ULgS19ZttNlmKx2nxDBMePuIk9xve486tqlmykAjl0UHaMb3WbQB/8UBS9
	mI=
X-Google-Smtp-Source: AGHT+IGPWGMLVJL/jMtX6sIhhugNOjUcreKSa+uyd/bBl6uvEtvgd2LMiAjRe4eEUZQRMBEjqeEVJA==
X-Received: by 2002:a17:907:728c:b0:b46:abad:430e with SMTP id a640c23a62f3a-b70704b5147mr429242966b.37.1761923757598;
        Fri, 31 Oct 2025 08:15:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3bb.dip0.t-ipconnect.de. [91.42.195.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c9dc34sm195390566b.55.2025.10.31.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:15:56 -0700 (PDT)
Message-ID: <a72857ff-f7e5-4be7-bfca-ebfac30c37fb@googlemail.com>
Date: Fri, 31 Oct 2025 16:15:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.10.2025 um 15:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
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

