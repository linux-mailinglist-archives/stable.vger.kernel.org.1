Return-Path: <stable+bounces-169324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183EB24129
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 022EF4E23B2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E052C08DB;
	Wed, 13 Aug 2025 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Gef0rgUx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54878CA6F;
	Wed, 13 Aug 2025 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065546; cv=none; b=mE+rUqdhIww/v093uIgUwC0DkuePuuxLXfA1864DgF+pIl68IU7/VD8Nj3ejnPmKUPoRc+3xbUwTzF3zgjnoMSBJNVHb8ICHgIPiwaI6CfhnhlMK+cUkySagd8v1CSrTNb05311fL/ChKqM//xVpGqpnYL/Geo8/T8NBbdUQMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065546; c=relaxed/simple;
	bh=cE1DhMiYYzMoy/x/kklbqKG7x+u0x4Y9SODa2dsNNdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2/Q1tzKHhzLgkrJfRzHIaE3TTLNevfNmELhlmtGrLesZth91vs4nldU03F1ZccRzrv3Xrdi3Q4hVUr+RG0VoDXXA93AZHlxzVccryXulfW3QjDnRuObe8fSodmURd9enrLvLvMFuiMiMTXmqTVrfYz2UX+zkDNbNe/5eE2G6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Gef0rgUx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458ba079338so2922385e9.1;
        Tue, 12 Aug 2025 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755065544; x=1755670344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Swm3ErZ56eiKdwJ9pJQ9YiWefVK45ut4nIQRyp8Jwk=;
        b=Gef0rgUxjjnWT5CPQ/IhgcT+RLm2zt/C5rngzLUtxK6DwzBDR+bLHRvd9ylFDHrZUT
         vgZbjjs/nWGmXfEvv9gY/BX3RYLMpgPzKneswXur84aP2+U2PveqsSAmWqB036vKNA8r
         ErSKeXje6ZiLihNTE8HBnHsd4X/gxuh8B/wFuKGRVXpgr+b05yqspbHvXK2AEZAYmjlZ
         SfIyQxjhoa24vEEMUoFfwN7Ja1jNQP4IdpwbzQ6RokyHwKcDUyq3NvEN1nvmtZ+eKYWN
         CYwMfL0uM82iSDdjS5JWLMHh4yeQmbL4GWRMdLUNMqeRt9eF/MBGpht+0lFivVJel1ec
         cO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065544; x=1755670344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Swm3ErZ56eiKdwJ9pJQ9YiWefVK45ut4nIQRyp8Jwk=;
        b=tLvXIc1kCLkz8KOSQIQeP9Bo9GyVvDiTXpGJeLz3Io/INOe1bQFpU4XN9yW6Cz1aBB
         UklpWYTWNKiAGADf/873elxTu4PGR81AmT8yL0Dc5G1p1mKa2kR9mnR1IEWCkyecVP9/
         xKJrrJY8p2/qOXoN/YgnVatdLgbar77Wv1IbC0U8X6hj+jM2VvKxi8khIe+Rv/M7LPwm
         cyVYZUMS6VkWSsG+bqe623vWKxbu0gycnxREGUXNdydjMgRRUuBhTqdkURtIMCFI9TO2
         96w2YQsxO8lH550KLArjyap+EQZzFbfJv6Z8e1uNHmePxUMU7nsHv0D6pbJiMBK68kHf
         MNhA==
X-Forwarded-Encrypted: i=1; AJvYcCWuDGmRvJtTuXwfZ2Aao4zSsrsfMdcF/rCMwYgv54Rba/Bit2b2IIS+Fb73z6BT/2VIVb26IzyVqAIFbyk=@vger.kernel.org, AJvYcCXqmfcSoaP5VYXVuUAekZaHvHFQTm+5LtgTJkj6WEVwH7Tmve/2ZqQyM1XfAdQ8FWjMuoMIGuPf@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcrFFIpXqb8pPvQH91fJSaajcEjAgbuHFjwbAa+dyR/Q5Pw+U
	rb3WTCeGza4KaBak3zFpt/FF5ap3CWONjRDV842S7LJ6mNJ0zj+3RcM=
X-Gm-Gg: ASbGnct7xqaHhoDE0+2JbLqCyuNRRnfVzN8seReUscK21AxwRmRDpSFrnjvVcMb8ev2
	oI921nEt334Spc3LFuy8qDJ0BdzXkCwWpwRDnDId9H0OJMptjfJvYqYdbjAs7Pivv4HeQABEWbk
	S04NUdSuUmVSe/39mKxTWnvTMfgbbhZqnqF0EZzS3pX+D7F/TLiUKmXbe/PpIgmUlqrO5QZZ9kw
	4hGPUr5YZMCOp78x8rkCKtcrzA1DkEp3CJgJVNSGG/ypgYxV/c6OJfUXdxMxYZnB/OvSwgBR//l
	/Wj1L4kl+DHz/tr/tiBTU8Nh/0G+1YGxiYGHl4DtkZVl9hIikBdvD0GeCH5Gfq+a9r379BpLPs8
	hpwe0onmrUPevgwvr9JmmWjGtOx4quajnn4P1J0/zp8ydY1DB7T83ooj6WqiITmFFBlM2X/DVzh
	Y=
X-Google-Smtp-Source: AGHT+IHq2Uwf4Cls+JlFUSY5TENcVSVnqP5UV2iObb0l7RNlDG/pq6r9iUkYIeehVaA7IEiSj/WjyQ==
X-Received: by 2002:a05:600c:1716:b0:456:1d06:f37d with SMTP id 5b1f17b1804b1-45a170565b9mr6114005e9.16.1755065543427;
        Tue, 12 Aug 2025 23:12:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48db.dip0.t-ipconnect.de. [91.43.72.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b9163ae600sm2535494f8f.5.2025.08.12.23.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 23:12:22 -0700 (PDT)
Message-ID: <64d3898e-baa9-449d-a37f-2bd0ca034af8@googlemail.com>
Date: Wed, 13 Aug 2025 08:12:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812173419.303046420@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2025 um 19:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. Built with GCC 14.2 on Debian Trixie.
No dmesg oddities or regressions found. I did not see any of the Python warning messages here which I did see in the 
6.1.148-rc1 build.

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

