Return-Path: <stable+bounces-58940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436892C482
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DAD1F234F9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 20:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173114F108;
	Tue,  9 Jul 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XsDhBE9t"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E6182A59;
	Tue,  9 Jul 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556843; cv=none; b=My0aQkJhfPiCVfqS/CyxWMCNmrmH7Mwud+t3PvrTsxV+T5eYaL40r08DQcYnMiciGQoJOZbhQrHF7ja5OnrSkHjgb21OLrWJBsov7Q92K9yYNVlKh7SkJyAL+ZMMFMwWpy8mzEAmhgVsfrk1oNodALOSaLHKX01PxpeZcIJysDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556843; c=relaxed/simple;
	bh=Kr4XmoNdiq1x+7Cu3wngyAMQNWraTKt0MquCs056Yzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0POYIpEZPqoYGiNUdNlfAv3UaKv1j0VAoz+YbOPNahJ8gzLkpb8oqV2kJNXnNaNJamWgPIZjh280mps+njDUr01+QVIUjQ/FJq9YPlj7ljNcmBtRRQfp6T8w+NdKwetB+OcvHd/UTQ5kMUeozayfqpQfUzrL81mt1ZmpBlDTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XsDhBE9t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266fd39527so10985725e9.1;
        Tue, 09 Jul 2024 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720556840; x=1721161640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Go5tn3E+fiaOV5LrSumTLE44aCs4A5PSxIlDDqGg1vc=;
        b=XsDhBE9t1iLhSMCCP7C/ciorUtnpZ4eEs1c5JvnH8X9gsaqZKDY8A0EWTWenk5NdZ7
         +1l06f15ZdwMsVYahWvxmL1H36GZDWh1dklZg0lXkdyzKNefOrjmaD11eDfmDusFJ89A
         FOjoiVYOW/BigTiG/jRFCwT0TiDRXWwd38nxWAnFMhqJl3ofi8HD8p2VsmGDsTtZSuaG
         Fi7LEHsGrWbrnktf0dpe+uGkeCtnN/FBQE1/IINl25S6WPTX9yeqS6NhI3V+aXGgwGi1
         Z7meUXuawkVj7eXAu/fMFYKNIMDQfWjERDSbz+mUZ8RsDEL/dCqKbt77oA2bKCh9S7yo
         dB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556840; x=1721161640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go5tn3E+fiaOV5LrSumTLE44aCs4A5PSxIlDDqGg1vc=;
        b=P7foU5Fp68nchgoqgVcRzFwBcdWZ05WtGt3+ngL3P9XZxruNh6QBq2OS673qIExoLp
         4Cbk9BoG/FEsXLxWUBcjV10OGikotYo1W6eq6O50jV+dB7RICjXLUm8X3YLhbhvOVuHh
         H3maO2C/9u8WAhPQI4KJ6bdID6AlhMTJMygYhCgNC/vQMLcOfx0qZLJbaL93ZSbd0xpM
         6cjMn6dq5nlR3WoPzsIM8Er5s8DTUtpvf7l4s1IiRoKEMQjez97i8ffE7VhpTS4Pid5x
         4p1R+Wradwno/AAFaaDcV54UHS1mlJN3kDOe9/CbL9qwPkdzS/x8PhogURr/roDUp/me
         iJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkaY2Ir07XZRDcDJNZTluzREuwHz1L40Vyj0JzcYTtXZsOBFp33WUwfVMxPsp22iSdXZigxjD+sobDThuTrPZcRtHn9wkuhsTZTiV6niXEJAkaVYqLebpESoz2p5fLTOYctoLU
X-Gm-Message-State: AOJu0Yz9NF9ewdbubWDT67X2MAT5Hi+PXD0ZR35UWsdHKg7Jk4EdGnR6
	mB+z/w/s2Sgnkj2y1obxtN32u236p3Bk6kYv0SVFESXMj5KJA7o=
X-Google-Smtp-Source: AGHT+IH7KbG3a8D4KEZUHKMnCt6K7piI2wcUDaPBqlwlWlA2VzZGH8hneeif7F8LPtb4Iuq2M/whlw==
X-Received: by 2002:a05:600c:42d3:b0:426:5546:71a with SMTP id 5b1f17b1804b1-426705ce6f0mr23477575e9.2.1720556840270;
        Tue, 09 Jul 2024 13:27:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b0577f1.dip0.t-ipconnect.de. [91.5.119.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42793dc2bcesm3020105e9.29.2024.07.09.13.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:27:19 -0700 (PDT)
Message-ID: <89842487-8e2a-4958-87de-207068471a6a@googlemail.com>
Date: Tue, 9 Jul 2024 22:27:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110651.353707001@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.07.2024 um 13:09 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found. It ran for an hour now, and I built 6.6.38 and 6.6.39-rc1 
with it, which I will boot-test next.

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

