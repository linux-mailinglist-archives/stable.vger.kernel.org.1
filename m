Return-Path: <stable+bounces-150626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A4ACBBF3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F119A170327
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8C413BC35;
	Mon,  2 Jun 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FxoRIPnj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481117B402;
	Mon,  2 Jun 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893900; cv=none; b=sbK10P9sCf5w3RK1RY6rKXpR6HpuHBqXZn5vJmIDZsoEn9JI2ANz5IJ1snDjwS17rc0Qv2GGA8d/MxJ/h/TqUh/2AHpupdvKbYXG507U7skCgpnHgrcBjmSOnqQxrsA7+wWUCxMcVSh9YyPtAUJ3mTzjKcZy9Qbyxe382YwMGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893900; c=relaxed/simple;
	bh=PDxgwHxZ2fv1zHkhlESn3ZqpBz71BeATIeQYdGAevYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t37NY2+i2ucpg8dOP0nCbTvu3USCnT/83bFXQjevj1PJ8yMLORSTiIpi/DqJWQdAfnxMJj0jfdqgVq0o0VbTGwLiIPAvKzMKwAi/y5W3jIZ5o7RHcetDIsk1n4J5LsppP06ZxWcHJclzSMYCsQ1wgTN8ZuNwT3T57hEfPKBjLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FxoRIPnj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so310451f8f.2;
        Mon, 02 Jun 2025 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748893897; x=1749498697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdQH+gYaWiAPPdu29kvcsCjEWq2JnvTRRl0+eDrbZLg=;
        b=FxoRIPnjxmj5Cu8bQrYH7M0D/FetOW4RGvSeB3tV+UTNLMJrjwbo1ifa6aK3iZgEzq
         SHUut2DySh2Ojv3Mw3zdUAI/PD7V1CcQfbsczTDlf2Tz3xnHCHimrpR27pr32m3Oh0ZX
         cTfPZUuxnWAFXvYcERxTfjdNbIca18/0WvuJxMmFqwxD5D56aZVurMgQZNaNSGoxJ6rq
         R53/1pD8mNlrVRdwUVmz8txnWSbe1P/haTpr++JpUFp2+OxQggziJoza0lDRAJU8micI
         4AMDmJlsc4cvaARTTHCH+UuxVMHvL+cJyMReVpMFMNKCjZwHN0gWSUwsWVq3bYoqm4fj
         4i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893897; x=1749498697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdQH+gYaWiAPPdu29kvcsCjEWq2JnvTRRl0+eDrbZLg=;
        b=uoLi+42SXfUEQGeeSnpc53cCSVDxtYpZGOex6b4hnWL38wWX1cNkbuEiPUhEwOy6ba
         YF+PZC2AhDwi3BeZsh87NQEsIMvOKtCppTwMpQwP5nyqObRXz7l6H7qAkC8wci5ZmhbE
         WOL+SbzkTEa7ukJQikljXBOqvs77MrwFneH/oExRRDlemUjsq7movIcWsth5HwYPILyf
         +WBTjnkPwG8FYzvH4LDHG7w3gE8s6DbuqCHB856+CNeWZP7yQNN077Eb6UWM+Xlv7v9K
         jVglKAaR4qh+TQc7wtmqeRBYFR5Leg7PJoaqSzE0HNvIM7B4fgRneqBzFC75Euzv/wEw
         8oWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTpzMa20tBC//3E6LlVihSi6pSD/VGuQNWRBBeai/+sDCcX27/VCaiaYHipWyRdsMHokPyhVC9@vger.kernel.org, AJvYcCXs7T6ifBVKCHedhlqSUaCHmXr07nQSCthMYiDn4FzPDcQOXrFGCL+tTHlBXmoKVpbIv75sl2reEmCBXoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwlO7rJeSof6CimqpOo0oDjjeKO7y6blCO/G5JpvkpNZXSlRa
	bg8fTpB78l4ItkeRwMpC3HQX7d5zQaepys75/XIG9aXmqQM+ia5FG64=
X-Gm-Gg: ASbGncsDyX4O4CLTa7dfRZa76O3bP0dxWvKa7MjV6uHFnnSN7O3qPCPotQWeTUTOXhI
	AP09qnxwKBBTBRje6tovNC46tXCnpWgWOPFPIw3C8jRYu4nxE+ZpNIMMGgP4cCVxEXJfrY9FB2R
	F+HU5de67Dyc0sg5KxMb/yJfrknlat3tLUkuF4+CgkCc8J5AND6O1QKuAA6CIWBmZfG/x0PCKeP
	l7QR3bG0LX4y9guDTht4FfNrZsi7sxW8LYjMCAiwodw68kDvzBm9knTcMf56Aq8nqMA+Uo2Jfv4
	jUB80S52RZHgnJkdIJG4zx40zCwo9THzQJlynJ1AY6vm2ZFKI0xvT8HeJgimIORKqL9tUcaxLEj
	4MVlETX/8lPzOuznJ5I5qmQue8KEd1t9dUUhgdg==
X-Google-Smtp-Source: AGHT+IEMS/aWQ1Ihl6wDJsvQbfZi5zg23IDKIRWgu57p786dbUitQSIW7l0HnT+yNLwD9jcz02z9ZQ==
X-Received: by 2002:a5d:5f88:0:b0:3a3:7bbc:d959 with SMTP id ffacd0b85a97d-3a4f89a89f7mr10855462f8f.18.1748893896920;
        Mon, 02 Jun 2025 12:51:36 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d53.dip0.t-ipconnect.de. [91.5.125.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971fasm15693615f8f.77.2025.06.02.12.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 12:51:35 -0700 (PDT)
Message-ID: <b86b9c0f-0a3f-46cd-8f09-a30ba7f2fc67@googlemail.com>
Date: Mon, 2 Jun 2025 21:51:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134237.940995114@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.06.2025 um 15:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
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

