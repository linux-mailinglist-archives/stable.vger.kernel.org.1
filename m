Return-Path: <stable+bounces-199982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B526CA3172
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FC473042BCE
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C3337BA1;
	Thu,  4 Dec 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QstQoIwz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A67338586
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841860; cv=none; b=I9TjNIJmGfj+GWYgvhcTJKwWBXF52ON3P45AHCDnZ7Qd4iYIL04XmHV9sBogLezNsJ8TLLL8G4AlnIXMv9hsEauxfHHr4hkJC7no4zMSF6uVMShtC8dS3Dr43FhOqL0z5nBcDNONj0GB0ty7tVNMZZyo7DM6DHuxhLOYOwUIYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841860; c=relaxed/simple;
	bh=bPQkzS/LYZX3DsPWIwinZ7tx0DcboDm0Wmlv6w60ROc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiX3VamO/cR0V2JBUlncbLqH+nlrIUH3tjWWpe6MWbAIeauVU6g67bzVunU93g3teM+jZYo0qw/Lm4PjRaTv07cC2laMvS7hJLjFEDxdiy/P1Yb08tDlyW9dImA9TP6zD7fqOIdTEHSpQCTDRb2ChyqOB1Nh+Yt0D+saqYTSYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QstQoIwz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37cd7f9de7cso5487531fa.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764841856; x=1765446656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9+chjHvE9ul06YD015JsoH/KZJv2Loyp/J8vWXL4qM=;
        b=QstQoIwzAPLKClkIw6nFXwxzAmfjCdNgtQeMJ2mhczixQYpfI9m4gOAoPhuco+JCS0
         JCwo9YCFQUArCYk274vjZnabeRBk8A4tkVfNC/T5AbJFdderYCF017tjjE5/cAkO1ENI
         R15v7klhAQmvVtwELYxoWh7FJp7BCyF12Mj6kGjwL68YFLN78w/zdsmeqUibiD7ydDOg
         CUJamdVRKP5LVPmdStoGDNENIiB2H2EqXp12GR3YpJL7s0hLESvp6OBan/BYsQgWn3Ko
         8vCzhJWi32MT/ZsFRgmlizx9aRdEPAyanIXh/KVFggpW34uD64QYZGi9e5VG17AVPGr+
         r85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841856; x=1765446656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9+chjHvE9ul06YD015JsoH/KZJv2Loyp/J8vWXL4qM=;
        b=kuvq5iWtdxHiXYRlGRjAGi9j/ogLsnfC3sWflAC0FQ9Nd9UpGqGPDOm0MeI6VPsoSW
         BtWd0euwNGsWdu6Q6zyfM1XJ8iU5lIPzJLQhU88/iGuSTSgZpaVcEEsRL1eSzJQ30Aob
         Jh+c5RfINCell6BdIwDGF59d/ZU19TI/RIFS3J/SZ/22O/zcrfFhDw68K6DQQo0YEnEL
         zyQTWjWs702cnLmjyRPzy/SyW82tIpEXqM4ViOPME/L9AKzeeST6QB9lBjklkqhvwkfC
         g5kKnF0YFeixrbY663uHonfm0ICbRsWNCH2884WL2Af4wWyx3vOirYdDOX6BvK+ERPC5
         5K7g==
X-Forwarded-Encrypted: i=1; AJvYcCX6/n4pxD6x36m4IU7gm3TFy2qICGj+VUz5QDgn16gfl7sKIczPQOcpT9ybY3l4od+Nj8nYous=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy247qH2Nqzve88XIVIjPfM6nbEZYmN+/SZx5rzPiEXkIIDDfJY
	AmTrp71lNnoxftu3xx3t+9iyZPXrU9RCK+8lqGrolB68xJbhKRj96mw=
X-Gm-Gg: ASbGncuaibNNbMSH/pSAblq+bkLSuYlnOxGQpLJvlwRdldNqdQjIZQCrOLu9RpVHAZe
	nhcuOGW5zyJv71IxjRJNf8qN2KA9qF+Z91x2yvohrdiuHrfe/rILBYRwN8o7ziVAl/ZcTBLoVKY
	xxsihhfK0tDrOc1cLp8asebDkA/TkibcRaTGZEwRjyW3PZABXCgfZO2HMi4ez+6IbephZV+gyYV
	zOncZTCJNON82iaNykb7XzzsfebrmIqfa5771sAhQUxLMZKiXDKHYHs0aynOtoVsh6IqZ0dCaxJ
	0PBrwNRUdwg8hSIK/udCayjNizJH6nRaWIS0X5U6eIkuaPK8OTK1udjOxeUa6VY3cpLien+FE1t
	5y8X9cXql0vsrltc9VKGBedxpAZJ0S0DhvqfnbI85UZH2wG8QmePDg+1IYwy2zj8DjVuN+Ie1NB
	cdmHPMJIK3WnoC8LFvUeQv2SO3KVYezDTOFjIelkz+N48pXZ7lpvqGpbglAdI1cgt3
X-Google-Smtp-Source: AGHT+IH2i1OLto72s9lAbD/zAbRgorD/bJZEGdonc2ejBG+PJXMIYeBHuINsYgGNjne33duF6Ffixw==
X-Received: by 2002:a2e:94c4:0:b0:37b:a30e:fe1e with SMTP id 38308e7fff4ca-37e63777146mr13820991fa.18.1764841855969;
        Thu, 04 Dec 2025 01:50:55 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac6aa.dip0.t-ipconnect.de. [91.42.198.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e6fe6be02sm4288971fa.8.2025.12.04.01.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 01:50:55 -0800 (PST)
Message-ID: <428574e0-3eed-4b12-ab3c-f1f8e32d29e6@googlemail.com>
Date: Thu, 4 Dec 2025 10:50:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152346.456176474@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2025 um 16:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
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

