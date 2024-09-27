Return-Path: <stable+bounces-78141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC060988990
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843D2281E6C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FA166F23;
	Fri, 27 Sep 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ax+DimvL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232811C173A;
	Fri, 27 Sep 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457166; cv=none; b=uLf6+CEA6saBNy3rS7JaGgDeCmCHzfmGBMuBa0CvEqrcZd7H31zioVKEi2rcW2sh86V2mmHLGkwE9BSI4WxQrfOOGkldbnf0NBamz8txn4VHGbXqS8XnHVoGHRhOiv1T/RbAAa+aQrU45e9L3MDuv3OuOXCctud9v16Hn3mNe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457166; c=relaxed/simple;
	bh=/jjF3BNyT2uuFsUCZVq5e8/Ab2HvHiL2Vr+6m81Zjj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBxvQRd8BjhBclVkj42DwH4fNor11LgzCiCAOcC486JbAD5gieiCXAcgrIbzUWSStIK/kpKcdsBF/lXlzQ9S/a/itPJn9gvc3YY3anB1I7j6kNnq+A8zWq/DsZeYXIvwkONRQeX3JzEYc8PelAnwGbieDSZbmG/wilGnW849rH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ax+DimvL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so20115055e9.3;
        Fri, 27 Sep 2024 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727457163; x=1728061963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmLqxkFKdXtbMxAbTeqAObhI7W65HYdB4Pl+s1JbGNg=;
        b=ax+DimvLMskpMM5YbOzs3L1trUfaKNua20W8p1cGbnY8k1LHGzTvNCvE4zEnHNGjBd
         Y1o9syRAEi/TZuhCYoGlLMVJlp3gj/ywZdEyq/p3LLKqVimRMVRJr6hZKRI0/bzQ8909
         lSDEnlfM6DogLgC8tOiaA+ONXQx1gEIYOcdtwHT95LQqGeMgToNlpdmSEqUchb6X+O18
         C/jcgOvI7+cURfS1sjJK3E8114iWk041NtcoDiuPMpjyxb9EBteMMcryIfIXeh1fsgvE
         1Fj4xvwPx/aLE1DuJLAkqFlXWIWABYDaC3y4p7thm/IHRZKTTgDtBAp3Ui6qZgbaAHZH
         mcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727457163; x=1728061963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmLqxkFKdXtbMxAbTeqAObhI7W65HYdB4Pl+s1JbGNg=;
        b=E7kJp5BPj3/UT/u4qye0LL/Umvno0bWd17QSx+gdJj+odNXJzbrr1TkJ90uJ6qbsJC
         Dgg2eL/jF99RzR6H91inmr0RymimdIbnU8CVSEGQAggfQdyMaeISbBoJbyNiOmSe4OJu
         /dUoKbNusjX1vBpvzSBsfSIp7OpcnBT6AFKgh4URW1Ygi+swfWfFjGwyVgeGkwj1gWeJ
         VALJK2M5Z4SBWwgwarZtjwmdnrEr4X51JT9aNwkj6uUOQgSyk0eaWnVNlrz/cg9H1XgY
         r0JZCbfhRMiDwDg7xXpEaG7v98R2nlIWsZ5vT5Jactam3SW7Q4imkRU7NflAEsdKCaV1
         yzaw==
X-Forwarded-Encrypted: i=1; AJvYcCUjdb7lc5fpfei9RxFJKjc1THgLwp79OIu8/alBCXY7x2TvyqEqR3kOrqyRSNc1dW8AqDf9Os8S2imnlWY=@vger.kernel.org, AJvYcCWPn9nt1L4Q/YUQMuSnNy2dUPfzr8J5gAvvRPPR0iaouovf481sN2e4kjlfvbdp/adtaFvYlL/V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jIDKbBtQFucClrND5h343HefIJTtgiYEPCioqiixQn6C0S/u
	XDp5L16CdGmhsAnqStDshC5s3i1I8AwRA/DTCYbYpxAm3i/APdk=
X-Google-Smtp-Source: AGHT+IGgONjs1Ft/KCGwrReAJ25RRuTr1ppc2rdphHCJBObHfx99PM/ELeo2lNAWuDX3fj8o1zzpzQ==
X-Received: by 2002:a05:600c:4511:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42f584870f4mr32751095e9.22.1727457163037;
        Fri, 27 Sep 2024 10:12:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a79.dip0.t-ipconnect.de. [91.43.74.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6875sm3015245f8f.55.2024.09.27.10.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 10:12:42 -0700 (PDT)
Message-ID: <3f481ef8-2c82-4f8d-9e5e-223be478a183@googlemail.com>
Date: Fri, 27 Sep 2024 19:12:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121718.789211866@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.09.2024 um 14:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
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

