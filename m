Return-Path: <stable+bounces-78142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E99889BD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4111F21F44
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD615A8;
	Fri, 27 Sep 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QIQ1KzMG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA823B0;
	Fri, 27 Sep 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459177; cv=none; b=qsXiL+FdDtZqcyqm1cuL9raC0r/nNBfg5bBSad8hNMQ1I7qGZXs8cVfUSYpQ+S2/4bHmtVB3HKuO2vTmmuITLj48hk0zjb/gwLCiQRBvwkfed/co+igkaGlSuXUAJiNOFkKr0JVfOsMzWPfDzT15Encd//Qxi8v5jzuA+Py+5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459177; c=relaxed/simple;
	bh=pXke/yWzF+iJL2atwV88Fvb+TbniXvK2xmpVa+iqKiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4n6WWZVRZ7Wjp3tYAF5+SXcElwkSJIwT8sube0LLy2bhti7AmkyYwTAvzkVqdNCtZMobChcN0l5P2NBYsQ3ec0k/i/c4zWQptCSub7XAQKAdwD0Zgy+TIBYJ9SHqFMQzDQy0Vqt1CZ3tzTMg7Bz49Se1HN15IEgUh6hW4+BIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QIQ1KzMG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so20550525e9.0;
        Fri, 27 Sep 2024 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727459174; x=1728063974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wD0JXAsG8Ubog6V1ie1Srm+ox3RskQ7wPF8YhVJa+c=;
        b=QIQ1KzMGlBlmu9U2mlUm1y87ki/rNt5Zb6U5C3X2VhT4DBh4y7tugVtAUrCvkxjrKo
         mmi6z+6b2ob1gU3/+LUmSQQF+v7VX8Xcuj0DiUF0pcsrVJLy66ACnnsfLuZV1aKCh9Wp
         cU1JSAHHCj6m4VOC7Focy4afKIE7LjKeK3H0z7tu7IGyxeRBObpqaePwCmFJQ7wuTQdt
         uB8Fq60eXTKB91uAAcH7vEQSEuvTN3CrUPU13LQrNS+2ZBp6LOwGEQ7nYbhvP30RI1kN
         rlus24H60O/zRVd/YPCmqa19pKk5lIJvYA5CM4mzF2rmhZL9fGDF7U7r9O+lfdKqCfwQ
         UDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727459174; x=1728063974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wD0JXAsG8Ubog6V1ie1Srm+ox3RskQ7wPF8YhVJa+c=;
        b=TuNbuj68xkvlYV4tITYIYlrqXjkNO5c+RmmRWmTgXWpb4uFBisv1FZ6yCWyCv2yZgv
         yBZDtML/WeF0SbJXIvRi6fPWNKZIStgb4UjmTKaKo9KSlprsdhb+Tk6WGr085C3F0iNY
         5mJDjYMWj8Gfne8cCppD0FawBGCDEMJApuNGu1hM7Kyoz2HSF0MaUIEaGKd19SOtGEg7
         NUnh95YjS1UBpZENAVSW89B51jhpAUuLfaSu/wdxamJKhvDXxCKKEzJFsLQtKit5pKRp
         W5vq8CjVaJjQr9NAOSGxRnmQv0VTSUx+gSMLtVsL+BJNKZlcItXX3s1tHfT0WfP3FgZM
         4zvA==
X-Forwarded-Encrypted: i=1; AJvYcCWT7CDNwmZwI8Jt96gPDuxLl49eX+KvuI4dkcg/uTQkqr+dg4O7cX2sXWhztOnSnAO6Tof2joYC@vger.kernel.org, AJvYcCXPQfyejqRwhPDWmNLh8710NdOkP6AQsBxdWM7QHLUAHbRMH8qIFTpl87MXLSlVTdiuornR8uQ3XTUGwI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5aKwvCMA/pd/H+DTGVBvHs4TW54dT/oOr8dLC4J4FrfSr1Vh
	FNUnH5J0SImQxS8EZavS3Jr0gIRobafTmpkcUm2HaR2uUxAt4eM=
X-Google-Smtp-Source: AGHT+IG+qzHQSB19j5/MztmCoLU8f4n03yN+xoDvvFyMvuaBjGnJfLXyLv6BjpOLkikweamwi1uhcQ==
X-Received: by 2002:a7b:ce8d:0:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42f5849939fmr32498185e9.31.1727459174318;
        Fri, 27 Sep 2024 10:46:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a79.dip0.t-ipconnect.de. [91.43.74.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de120esm32907965e9.17.2024.09.27.10.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 10:46:12 -0700 (PDT)
Message-ID: <933ff11d-1475-42e6-a7b7-799510df5743@googlemail.com>
Date: Fri, 27 Sep 2024 19:46:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121715.213013166@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.09.2024 um 14:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
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

