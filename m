Return-Path: <stable+bounces-126800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87527A72017
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 21:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C6189656B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA91254AF7;
	Wed, 26 Mar 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EG0wEoF/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353818C00B;
	Wed, 26 Mar 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021872; cv=none; b=b5ysKCHlpAyi+L0Gs0I9+L7bkyf+L64B8yEni/ZdB36BcYzT/kbSb/4jgL/hHvTZDW72pXDESEgyDJ2alUKAzwCjqiTcmwcyEoZiuRB0c5DOH5c9iFGbwlbgQ2SoYY51YdEaxpjkH1g3QhRnyxIJCbYhv7zM3aBx6hU4aqtmSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021872; c=relaxed/simple;
	bh=g//N0IrGfLT13tbIdvSmMzlmGx9e3qigUl8AcPpeR50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aawW6dtkKORVHVfyNsJpQYcQ9G8ITSAmM3n+B9+riehC6AcP6L/XXj7kVkyL433+sGwXDcj3ehTeGIF1ZhSgyk0NGphytsFzrJdyYT0W1qKOqTXNsKtSXfoEJmsax0nO1qZ2WURhnBzK1f3le01JDi6mE/v/g5bwMexnXlKiQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EG0wEoF/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso1836725e9.0;
        Wed, 26 Mar 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743021869; x=1743626669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzroiA3DdY1mmxM19Ga6jmT6lbdk6d02D0Ys+Q3T2kM=;
        b=EG0wEoF/85H4hS53wNSoNdWGSfFtn7MPzhJ4HZzv+lazjr2peQW9O27g7CnqyUTzLT
         zMuLiR2qXY8PtcDwHSFFl6YGT6APGcHTp4U/KlwPab9dqHblgo4JbYFrYO3HL8B941bg
         rKrQ0m5KjnPVTGvP3cco+I32BiLG3elqt0QSZe9t9xV5fPUZG5MacGMrMX8GzbSoeErR
         jP+CUYsjKdy58oWpFBB0HEt71cTwFJBby9v5tCmgQWSFI1TZbjKG9wl8YDpLZljLe0uK
         bQtm7YaCjPazG+G7uf/dUuvFF6/8HXJVNDo2d0IBiuLBjl2fWXJeKdRU4noL5vVvZ19p
         iykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021869; x=1743626669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzroiA3DdY1mmxM19Ga6jmT6lbdk6d02D0Ys+Q3T2kM=;
        b=RaSK7JltudBmB5xpfBaI+8jhJ4Gyvi+6F3XcwkJ98u01HJK4nXoCuwca+r11P28ciM
         1tLWSoxbhf/7M5b3xQ6IbS7Q+FNE4w//dULErfFDRevX/SuWlbIEi/5X4iGBqOhF3Ogf
         7OCV4hHZo7iPjjHGFGdZgCAYbsPAg5stzimI+HPVlDV6hQPFN8Otnd4i7mb2R/NfJKMV
         xvZSPUKcH8lptdjV6zzH4QHi6/d5EfdfnnK7wVOPeZAjjMskSpcvUR1xRWogJ7Bc6l1I
         ZzgKMP4QzCm7Zn0CjDxU240nRomIcJPKHR5z0Yntjam8oij2emnRGjCVNn8OBXFR1pdl
         usnw==
X-Forwarded-Encrypted: i=1; AJvYcCUi7OvZbOD4d104TfdSl7cwH5JV3Z4bWKC9t6meDsEiKLrGSasUH55ict2wqfDX6bnumJRbUEy2@vger.kernel.org, AJvYcCXrfX0YJDdyZLzdwlJ8D+uS5N8I9ZrkSVc+zjVs3lvWqJQU3JbeQNuyxPOS4Nb/+E3zI1dPlC27srDxB4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe68CB83qnhDctZAMMlIUdohWX26B4+qYkXNUTzVB/W3xbJdaD
	HTr0txnRHBA/sNi42bo7fLI7fUDxUG9sXoHI9rgKZGC8nVEg3j0=
X-Gm-Gg: ASbGncsl1pBnn1kbM9bMUGdBYtQK7QGOYHs6LDA4/vEOYMDevhd3TTM2INE3O1OeGGE
	bHNss/AOcp7uOMvk/Cfj7LEBHtTcg3i2gSQx72QaYhaJk/msbJ0bTvjbyrPdHA93hyeroc2oyUN
	RPJcVar9QTkvLabDPQCXg8/rwCQ/GMdNpZ3uNXWwOBHKnLdATD+1sewcFTuFaeEAa0KXzDzO/m3
	/7opkeWUMRK5mG3r8JDDkv8q8g4iPlP33OABBe2Pv+6mx+i1CeUEyFEX003mwJEItXTvZ3+81VX
	jvK5GPcxtSv68IJT2afj9ivCFiOEHepZeKasa76rW+UQItw13s6AqaiD0A1xzkrEa68QJa50p8s
	8LrbK7EW8WNKPaah2U0B4
X-Google-Smtp-Source: AGHT+IFIn/5O+GJWIEYHRBcJK/SGhnNc1/rveGzy77iS8kfb/uPpf0KJWaUAcFjw4m7l+ZGWiB3cbA==
X-Received: by 2002:a05:600c:1f94:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-43d77643432mr55561185e9.11.1743021869132;
        Wed, 26 Mar 2025 13:44:29 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a21.dip0.t-ipconnect.de. [91.5.122.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm17650135f8f.25.2025.03.26.13.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 13:44:28 -0700 (PDT)
Message-ID: <58a1ccf9-2da4-4fb3-9310-78eb2d4ccb3f@googlemail.com>
Date: Wed, 26 Mar 2025 21:44:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154346.820929475@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250326154346.820929475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.03.2025 um 16:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 76 patches in this series, all will be posted as a response
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

