Return-Path: <stable+bounces-187813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBEEBEC699
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C21519A869E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E1247DE1;
	Sat, 18 Oct 2025 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TLNBHNiu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D614209F5A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759628; cv=none; b=cLoSxCKQ6wdkEYvFkOPMfbZhJlhBC8VmvULdFL6Mn7mAO5PYc2ES+Ms1H0BGcOpXrv1h64Ai0JOLk9rGdZVgoIk+FvEh1hAb+C9Dw3kwi7+Ap32vRaWz02ZRstE23i+EH9yh+nwgyGwfNb4xGlgI4eek39T1+FPUaP5g26rrDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759628; c=relaxed/simple;
	bh=uHFmmTjt0vc02+wTfwAteN3orrvhT+UgW5yCHpFvPBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ7+6xVVWvyaHJa2TdBw6pgDOfdpZuv8DfBucVLYiEOYX7wovrqIBLdIxzOhAxq4Qt9Y91HzsKD6JtOteQ4cEhFV3LInAXnseQ5uD9dU4+LNVGSgsm0IVqJ4mK+dZI0ZOgRejWkMK216xTtlnG2wK0nFQtTmjcqUnYCwM+kRNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TLNBHNiu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42421b1514fso1574913f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760759625; x=1761364425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jL0abL7hS1wNxZfx8D6u2myeTv5rkFlq4vfgdvw8ndQ=;
        b=TLNBHNiuDzl6ihDx3oDoD3+FgWz3OTYecNKL/7eRZmU8p5e872G9S1K2I2bDP3eozK
         rWAPHCLBXGS7qsMshxRa6YSqTQCWwlFQ4qxkFgCGQRVWAofJYVTj4cjQm4dgv8/WG26O
         ddFmbD1j/dKQ2HGCoIjChZwe2vaR+LTIDJJRz3jHe08AkWdRNjuzPtuatlEuZatE+OAV
         jz/QVvOw2X73brhPQoBm5Nkjlo0jKppzlLMwWciye3onbDZDNXJxRkQMv71fCzJ2gtc3
         XdCvf9JhI3A2AIWmv0tWFhknaju7EPV5k/xtGwqXpHhINL2ikRk9eMzhzyf5Hqsor63s
         i+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760759625; x=1761364425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL0abL7hS1wNxZfx8D6u2myeTv5rkFlq4vfgdvw8ndQ=;
        b=oJTjrfHiG4IpArDCbBK0wUsJykeQjTkokjmSbq40zreojlH4US1RiJM0k7g+MIlt2A
         3fWQ63zvk3CI6tw33jGNHdSisbPI7L7BE5W7tA0A0juGzUmk6l4AuHDVlqaT3aoHh9im
         ANJHMoSRPmChbc3CtjIgXJ9XNLLKZbkXc4tBbnvfp37sPh3HxElBZOytI8koW/kylpqf
         k/cOvJR5f+kgktZXmuXfzUWQ293TvHFikoEaVcPby70ucMQipMP/inRy12Uv7Dwbla+y
         GBGjuu3PDkKuz0BVIC6suD2/0VoYxNnQ1pcEAAj++E/Rp4j46TxW/GoQ3Som//vVjm7q
         IeFA==
X-Forwarded-Encrypted: i=1; AJvYcCWcGjSiksSwcPKr2b83qQ6rdnMp9m05o18USbDmLVl9grPwhyZuwKMbiuTGgQhvOU9iFnW2YFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQbCj96jZCfYsaSvV9bhJ1Lcb0fSEwEKo6T9/qAH8iW/pmgdS
	eTCXhrMc1VN2nqus1zdChoerF2IYiEWfs7LnJRlPrlR+WyA7uxxIO7s=
X-Gm-Gg: ASbGnct/Q0eonBI9KKo5XLOmhE++ZIRWqXMs6UGLwLhuXFZM5vj/qX6iCdpcJOJEeNO
	XJ1SXbOlQ/qhxWxuQwWpxbMdKF8UJNm6jOaB7dHvphu7DjiKqiIlz0yj76POPHElIGrS0Lf+8VC
	NPfPzLiCgCpVfRz470F7YUL1jCOc16wnveSGspjqN0kmaArCt0jub4cs8oXzINhXpGZv0ZVp+co
	+CAff4k9F+553plWLhVUNUqSiL6FbAvKf9qQhOQGWq5VjgOD2Y7ICubKux5bkVaF/t8pvzvUa2v
	StW3K3zPrMqppjip9OaExLVMNKG/tGWD0yctfAzfQ2PTngUWCLQ/4e+Bf/kH2vjjhE29BfjnKvt
	MdGhdqixQY4RfnL5aaZ/VKuS1sTiQ6YMBtYzRiEpIaANE/5KvAARWnQSOsUWBtes3o+VF0/ArAN
	VpoHOwFd4jh+S7/wULSIcbcEagavlFKlIUuN0nE8zpDt9Ebav1DtO7
X-Google-Smtp-Source: AGHT+IG9plhdnHlXZGdT4B+VnjYq+D5C7vfXaHBjqJVVvO96WoRNs1XSe58bAVVYKHVYV0Bzp6AaKg==
X-Received: by 2002:a05:6000:24c9:b0:426:d549:5861 with SMTP id ffacd0b85a97d-42704e029bcmr4428076f8f.42.1760759624746;
        Fri, 17 Oct 2025 20:53:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm2417213f8f.45.2025.10.17.20.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:53:44 -0700 (PDT)
Message-ID: <54f0ab53-309f-4210-98eb-629cfbbab471@googlemail.com>
Date: Sat, 18 Oct 2025 05:53:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145201.780251198@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
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

