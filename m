Return-Path: <stable+bounces-118252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C45A3BDF0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C0188CDBE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288F1DF24B;
	Wed, 19 Feb 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lgzde8Id"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A01C84A9;
	Wed, 19 Feb 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967870; cv=none; b=Bfwc665A1cn3tQhS24Dga6mhkB9DPlwOWydatA20SznREMvTwetPCJga4b1Zc7pLrVFnHrYlTd5E2fA012sJlrWKgSeOGLG4Ulw3HqRr1SzhupDWX/dgodVhwjCbGND6VKqacjEZJ47MwqiaSBoWI/+d9ECls+rOyTey1Jc0n3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967870; c=relaxed/simple;
	bh=Wvowdqymf5/Dqdnx+M8deGxluothZgxktjlHvQgPEC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7ysKD1dfH9zTocLpUY3Yk8crc30dHVOQa0AiSrBqTJ030PgPTK7eKvLcjhmaE3Vm9Pf8AVMGFTiCYtdPWOJu0QCwQQHlo8tznaBZK63VwIf17VdbtekbrZD/ZNoGO6VOwMnCgOM1uBKBfDS4Wtpis7Q3bZkGl+XkxKD9jbZIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Lgzde8Id; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4396f579634so26378085e9.1;
        Wed, 19 Feb 2025 04:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739967867; x=1740572667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYKifUeShoq6767eZBZs5H40X1Lc9yEO/hHyexjEF2E=;
        b=Lgzde8IdJ64gXVRoF+BiHcsiRiHxw7NaMF8CPGYfI8lymirj1ciNvSkOhrFZ4AgGDE
         cVvHpqfImbSJ39fcFwz5vvRv+8S5Qg8tqAhkQDpci3YGnAXjk2qsg+zbUQ0rdKuD0I2H
         gNrFADaAtCCUoV8F8pRUrJEm2RMAR64Qy2xEnvKeHh4dRJLdwJ5iHKv0rNHwa8Kqw2m6
         7nJqDEejZ+ZJ8uhM1hTViRinVEanXjWNwQ5DQPODmNnqslRtORdOQ5nU/Y1ba+OGYJ07
         N/TUXCVCBI55ynMTBVXePzz4JDQkfowuyktrApYe2e02DFsHGwxcLl1ym9E744Ld+FHF
         5vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967867; x=1740572667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYKifUeShoq6767eZBZs5H40X1Lc9yEO/hHyexjEF2E=;
        b=TQIuS72F68b0FNJEAjh8H3oD+F8H0RNe5KDZLIrZYPMoux/K8LH4O+C7+iOq5PHBjM
         9mi6ADPWw170Y9reY1zCgl8lHrzuOEKqaLKW5X54CvW5EqpWPsOqXdwSFLb5ixd4ZExJ
         e8L4zdF9z4rk5j6zOBdcVRXDX0gl/ebaiZKNB+FSmWHO9YkVOrsx4rLUNHiFDLrSWb3U
         pOLS+bUzp175OHss9BCanZmEZEXr1gxheHM91tO1iJ7aZEkoKg7qD9SW1exuCk3jxGkt
         tTgdl+K+ydZgUp4gUF+D7aDZ60Flxh8khXIsdKTCJmzuT030gGmTjCFFvxlSaa8WuGfu
         JP1A==
X-Forwarded-Encrypted: i=1; AJvYcCVchWmo36zeE6q5awa8Vto2xHWAa87VGoZE069x++DQHlLYB2OgO0x5MkU2OdxZCQZqx8HxqMPsc7Eh0RQ=@vger.kernel.org, AJvYcCXMN2n2EskPUSGAII1n1HPQ0cYBtjoKXeCZ8XwewP0sR5Z3k1puDPRz44hPEOU6wIUrMAjNfLL7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2m2fi05UE/763OQ8uwzJY5NbavM6qMSbPKKWYmkwFV4LHKlJ
	Bu6HVkEqqNI642O7NZP1W5u2EiqiK38mkLXXwLjbuH98hXRcMRxwj+xJUm8=
X-Gm-Gg: ASbGncvmcETC8VspFKDgrwZrUe4lQB34lq1O8/xgRYUGUn/aX2IzPEtIGAxyxR9fnal
	HvSEvHO+KOYBlYFWqtI8lgEBH0uT9KbgIO3Tty8DUZOyHOZfnIZIazLIs5opD2YTGwySeo0LUCh
	frS2bNcTKpUa/vh1tIgayQCwzq3V/nkfXvIwysyVPDpmIz+sYRrg5T4p984ZE3ZstKu0GAtAk40
	HwB0xaQKRFC50xTsFeVx+VhwgJRSU12LhX1cQzTTjaQnuUhHBGVixN+NKYM1hASU2KP2kiLFQnH
	VfnpFvLt+9MTh8WvT8f76/sD1OaBvgOH3endovv8LrQnCALXZd+0i9wpMS6euFNssr4D
X-Google-Smtp-Source: AGHT+IECUoOne8WCiWHuMOBx74a4ScsTJCgDD8KlsTM6vvMn1KSLw2JesZOIE6aOV7faWfyLfsUaAA==
X-Received: by 2002:a05:600c:1c21:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43999dd21a4mr23992985e9.19.1739967866834;
        Wed, 19 Feb 2025 04:24:26 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e7c.dip0.t-ipconnect.de. [91.43.78.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm218515835e9.40.2025.02.19.04.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:24:26 -0800 (PST)
Message-ID: <a53ecf4c-ab0a-4434-a329-0d2e917fdcd4@googlemail.com>
Date: Wed, 19 Feb 2025 13:24:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082550.014812078@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.02.2025 um 09:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
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

