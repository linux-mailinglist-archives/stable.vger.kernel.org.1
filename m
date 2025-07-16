Return-Path: <stable+bounces-163177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7734B07B02
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1D03BA5E7
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E52F5465;
	Wed, 16 Jul 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bZikQeNn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382E264602;
	Wed, 16 Jul 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682765; cv=none; b=C4p92F4BpRojx5m2I7b2IFTw2s17ZSxk0Blkr/djK/8b5oodNkOVtTqc40z++h7EcJwrvpITGCbdW+8snBIsAScF7j3luLY0JRXtDkzDy0x7PCtxwoAnDB98cKOKezozY4m5aIdh7u7pPPkPnv8zP3vC/zIsPgeosIxCwBAu164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682765; c=relaxed/simple;
	bh=8L4LG7VxNQXVKV54uJhPhTHvc9J9quvcGW5uC03hr1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXvBHFOHFjHYhgxnV3R5cdGuV3eUwKBPhAPTDVmRV6BsPMga6gm39JONNM624lxoBOmgioyPY7sahy01Jum2Pplrqu/BYCluv5smYcKjUGmRR1z2cot9xBP6QDbcvYJKrZ0wdGeCpingrsMdqHQW+5zrHRC4aC3BfHU8r5Jy6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bZikQeNn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so255425e9.1;
        Wed, 16 Jul 2025 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752682762; x=1753287562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4dkzLjjbhNvGJlyZbi1BiZarcYWuRg5LWjzLiHJJbs=;
        b=bZikQeNnNuBmODXxNYdX3FLmHDXeP3i3ZqYndXH04Ppi9Uq8acbSS0mJBkUlO4CG+a
         lnEK2XaesEmj8VIbo8XGi0YeLC6bJCN+qmiApKGS33cbGzNrxon4fQIW94vbQ9acXF4h
         C2LXbocerd1r2L8XpT93X7o3s4BtVXiraQwRvMBNehWCSayzvBkgNRGBaY+pS0rP+1TU
         lCHybZh+5AUq3T8lO7AmN/elGHOwgYpJS6BWDaO2EzEqqXL5uyWzsfn9fuFiop42VBOj
         NLxSp9L5U7YXYg+J59KkAo7VkLYiuqLFs0UnijibKU4RwzKU9aIVFwSoEewbr5b5wb+l
         WDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682762; x=1753287562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4dkzLjjbhNvGJlyZbi1BiZarcYWuRg5LWjzLiHJJbs=;
        b=EtU1TPF6SJKMu66Pg0Z4VI5gtLCSHGAMVF5Fj2j8L/Rz5l8x4wN8YNaHMFlZiywdAg
         0CQT6Te/+uapqEB6B7Us9jSgweB6fGoEnvoy2j3x6lkDl1BRdNao+VYoadOSbnf6vjfS
         ZUKwidmztLDrojx7toj7S0bA2LpzuwRaCpje37ZrtwVLg8y9AS8QAq24BPYzCHJ/TLRV
         nSPzdKISB9LgdwG7VwkGRIQOI6T6AxwF/z4WPidlp7aeJTB4uiwiVE7KtUeJITGRwVgT
         QR30EE2L5RuM29sJqG8eFzZQxMZ1dY3NO4EamkLhm0hX2A7gqbFTeGYHOaLPh09T2JHL
         pYZA==
X-Forwarded-Encrypted: i=1; AJvYcCV/8U6E8VSYcozYwAme8m7+oIOxIzhv5SE53g4y8mtpOdD/deqaTBOutXYhhbHgjrSdxWYYNaO7bCImxlw=@vger.kernel.org, AJvYcCWHSa/1UQze8Ldol4f+JEpOvbNu52hataWLrwOuIoGsE5U7tVBCd5BSIVz1T4w5BuEYndgu51gu@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiI/QHtYA4Xu0ujv26gfAxhuLEau5v06NO5wvFrD7yJsILKum
	Zp01V/1B9hjamOfBO6miMWRmVqYDNCxpf3uu/cFhz788IfbOa3nYqqA=
X-Gm-Gg: ASbGncv4MPF0ql/Be33qEn5gu8gchDKvbZroRmxdyObS1zZ1tW8ce5xhTnAVeYazQ2z
	1UM5xe9xoxUw4NHQLaG33sd9apb80B8wNNRpN6Ai1byIFncdqsQLxr3qDhrzAsQu9d72J/qa6Na
	LyyLBpUi+HJQ1BSlhar9PgmG0uCVtdO3A+RvdvnaLQj24SXXos4H1jpyY6R97acGJ5P+GrvGH1L
	MCSRX6m7gGLQ/VN9d24aVWW5UNHpKdF1Fn4e1xznpAf5sl/6IJkwjYRT50Q5F6g6HV90XyJMCCN
	nFyhpnkzZYGzGXDPhrpsutAFVX+9njN31i28nFPBIeFKoRSeJwiYHZteldPJaDWTsiZsJCIh4ec
	gQm9t4lVnHZHcpcTfz38CtQGjZzon2ylqlttTN88ZgSaSUrbu2ESlGz5QXNkYVZC6M6YmSoGaZG
	hX
X-Google-Smtp-Source: AGHT+IFjsCW/j+z9V+0qi3pXWCj1korkJ9Tpgx1scJIAt2ZMhEJkziqtQAOuMKyegU35oRlN7oHuGA==
X-Received: by 2002:a05:600c:a00c:b0:455:de98:c504 with SMTP id 5b1f17b1804b1-4562e2bd5a8mr42946605e9.0.1752682762431;
        Wed, 16 Jul 2025 09:19:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac571.dip0.t-ipconnect.de. [91.42.197.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e57sm25590115e9.6.2025.07.16.09.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:19:21 -0700 (PDT)
Message-ID: <f188e72b-231d-4523-a804-92fbf539886a@googlemail.com>
Date: Wed, 16 Jul 2025 18:19:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/165] 6.12.39-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163544.327647627@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250715163544.327647627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.07.2025 um 18:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 165 patches in this series, all will be posted as a response
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

