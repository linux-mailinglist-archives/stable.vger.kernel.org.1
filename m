Return-Path: <stable+bounces-164402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD3B0ED88
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583FB5434FE
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C8281351;
	Wed, 23 Jul 2025 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QTgqo/O6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D0281341;
	Wed, 23 Jul 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260267; cv=none; b=qve4/RfywHZaYnHLAKm2AijOpklkcfr7LLhbMU64vGG11um0B0RPa89uhRm2xwdOEAP8U5pGhnKsNCY/qodg6RChqG2DkrsBbflDNPmS8IGd6dHOYqoIROJSCLEE0+vm0hHjCoPa/0NXLfZBS4aUjS4g+pEjEmmWpRLwqzheEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260267; c=relaxed/simple;
	bh=DgxWQJW5l4LePsfcKPDjk3i/+2FITa3Jht3/1E+WjsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNypWE+IrzEmU65lL6LlXrEGsoVbxkfp6eQPAEvwcgqllIXptWcm62nzsjMBbw2Vi2UIjvjKHMYpSngVZaX6e+colB7jqEOG9Eax2OqyGFle9grkcebd0OKUCp0Trv00iWjkf7IDtjP3Amt8zo62k1XX+BLlhpHSMu8g18VAIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QTgqo/O6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456108bf94bso45350455e9.0;
        Wed, 23 Jul 2025 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753260264; x=1753865064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHJOQcM1lG84uA4i35JDleDtG0EIf41km2GDbzT/6cA=;
        b=QTgqo/O6Vk6pbLMg93x8iW0dVOcAKX93XQBf9Uz/AG9ZzRRgueldDB63/nvqpWD3zP
         dYVYjvrJIlcDGceIOXHIqJn0geEhPNTcW4q5xVM/X0+R6AulNYQCNZelH0yB7XGGzC0B
         l29yfI1CSZREtsyYrsM5ZapT9oydglqY/NzTC8yT8dVavebxBHfpd44dTQM2KL8ivvNT
         6e7xUR5UaT54EOzpLW9/NF9rGWexNqd9Aweuyfsrs8qxK9GEhcHcYGgPPBsRSz5a5A5b
         oh/bUrY10ckaufTv8YNRrh91zzC6MKV176n6QFpAZgOWqwwkxGdNxuOb2yN3wpzWYBdg
         h2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260264; x=1753865064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHJOQcM1lG84uA4i35JDleDtG0EIf41km2GDbzT/6cA=;
        b=I9oQUb93O4Vi/eZc6ZiiAlmf662BEStrN8C1xrYiZoSANS/yHjKHNNeMyOj9DO2c7D
         EoCFdTqXhn1MbdyZ64yR1AgegeTKzNrTgje8uUXJBMq1DM6Tcxc4puglefA5sh/RTlMd
         +JovGUmc4lPsiGi+27C9xei48z1LvFZbwxAt2W9XK3iGaIXqYmy+CTRTz11eu3KKujNZ
         meV+EZUjw7i5stfY/nqyfOhkbAnojxAYmLbAtodrvQXA4bUwfp3d0jFIzlHIZW9ubBhL
         4evtWIW5hTM65Gb1eCzd+Xo2Ql5+67AEnbk/uJ9tNR0ICgT/ayxA7Iq2GaTj1WMJsXJ+
         kjpw==
X-Forwarded-Encrypted: i=1; AJvYcCVWpFP0LyYHwrhTvbjQwKBW+vTmOjQfjDP1cXe2q7V4jXh6Ko1X8cMEjeLWOWucdtOpPDVN0+OBExIaK4g=@vger.kernel.org, AJvYcCW4TZEXXria4Ys9i2ilfSlhUmJxEiYc4nTNvndyuOzves7QIr+CiIO+WS/LJHquDXR4TtzFnXce@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/XstL4ijmVmfibnR6Q8zMlm7fP4k4YeUquz25+uc+SUUh4XI
	jkUUkRLk50L6RafhKzA2SAwpcUX4svkWTuq1Xn5QZjGC/SkujUrAtLU=
X-Gm-Gg: ASbGnctnHitSu2YSRqflckdCQvcxi9YMUSRQlb+l9VVbGyKI7b6LG5XbMUmRPecMU+d
	x4VJNLsyWG/XEzEmCcc65pfZHjvyIM1keh7jj0k7b62slvSXtqhN2LGPuObbi2mj3//IbyVI+nx
	4G0Z2acQv9sH6WAlZBXCDDmJ55KhWa8n//bt4I6BuMUKHbBeGggGQJzE5L6ljBr4H+RySIjaMzP
	902Twogw8/vxnRnAlYIPAe33gJH6yQe9NfHLGTtoKOJ+BxEfLc8EBchYzxxf4mO/pFQGZ23iYk9
	sqZETKN5AhXIxwpe2O/qfQN0U/OuzqqEsJjFtMBykhRB3N703Vg//aJkVh0/0RV6JprLARCVEJ0
	EoTl4PA/C2XZac4D672Uw0lhCXBY1IYgQV3glSMFu1G+s7ho4O58lHL/dKhLcx/sGfaPFA3QkOO
	vj
X-Google-Smtp-Source: AGHT+IFZfB8IgD+HLvld7HTIKQ+DyeqVqAVunEW+9LuQWRwpmq2NB0dRTMuV1a5xK4ZAPv1csjbddw==
X-Received: by 2002:a05:600c:450b:b0:456:1abd:fcfc with SMTP id 5b1f17b1804b1-45868d304cemr15087635e9.25.1753260263563;
        Wed, 23 Jul 2025 01:44:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7d3.dip0.t-ipconnect.de. [91.42.199.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691abc62sm15924465e9.26.2025.07.23.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:44:22 -0700 (PDT)
Message-ID: <14340824-5434-49d2-9d23-860cc3e28948@googlemail.com>
Date: Wed, 23 Jul 2025 10:44:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134345.761035548@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2025 um 15:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
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

