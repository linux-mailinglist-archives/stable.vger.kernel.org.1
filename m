Return-Path: <stable+bounces-207921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C948D0C930
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629273028FE2
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBD33A715;
	Fri,  9 Jan 2026 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iv3forAY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4C33859E
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002979; cv=none; b=fbLg+YIAhfa0pIcMr/JTCNlrWiKWsIz2mwMAZEwaRVq1mbflDlNuHt7C3Ryz5I6UIiuOJ2Gk8ckAHAVspEn3n5U8jN5Mv070XGOKxR8pZTSyIu3McYJ9g8k7DgJQ8BOm4yC1CiJZBld/Jp+jhHKNwVBvNWPCoeYvyivCty9nfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002979; c=relaxed/simple;
	bh=WH0dp1Wx+KEOW2dk+QuvFMsYYMNoKuK3BCTZY1ds7kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry6NLOecEJ7k8AGlV2sM2rNgk/jp0o0GkD9QYhSxHA+4Y3hGMjmiebSffVVBpP1mbJd4L5r78RraHFZyGZL+V2KHPtcxyCnCnSoyOrRNnaFnXvuloRhGcaYyo6PtGartLeZkR4Yu36GNIg5zfvUh0S2zLZ6YG9YGl8A7PCFHz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iv3forAY; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-457c1148a5bso1733768b6e.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768002975; x=1768607775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vtEiMwF95PgxbG4PPVBhcGfmlHI+Wo1hj9Bl9Dc5vM=;
        b=Iv3forAYn04cgG9PmrKMKVy224dtlUwfVTWHb2qRuRnMrR9HfSPz5SJ1A/6tqIkdI+
         iyWLgWoAjz1IJeS8UX5J0fIHehRwJ2Hbj+MnEURcVxEk718GJFF+nvOb0sUFfOuyZXBI
         S74+HNbGy2y35yl4AphS1YLLtOuZIENaFDWWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002975; x=1768607775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vtEiMwF95PgxbG4PPVBhcGfmlHI+Wo1hj9Bl9Dc5vM=;
        b=OtTvO0U+1+CgEmc1LHEtjgjCbj80BqFJOwJlSF1NgFX+RCJnuj1M7zA9zPYxBG2UlN
         0Eq2l4UmxwxnADnzeU+53DLhtadTCn4E7CVSYXvXEoX1Uumu8qsLzhXK8W27Ort3qlg1
         uZts+eCo9xD+Bx0o9MYjpQmRQoBVTvhLvfgEJzznUL0RZAxZRhHgMERQBJWLezswyv3f
         v8b+uMqBnXlQ6WZulaUNqkGFHhkkZIxc5X8hDnwkzw35UzN7ifvYTo2e+cVXgCfJ4uBQ
         hxMzIBaAp63yWfgVvnhVF1EaadE+0tBTxGJwew9SvZAL/bNnuiRp4PhvivzhBfCgMxLm
         lu1w==
X-Forwarded-Encrypted: i=1; AJvYcCXc5HTystKOHxvOAbhF4JPKEMOvXBEaLDidCmg6/7rNG5lcUCIhAYn4K0Q9eRbcJXwqBnuV8Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrHosZwtemZG0ZjPWKcE6mWKy+seeN+8/eQfE2dpcUyuGKqqK
	X5vlOJy/Qc7Dk/dmx3R2eWrA/W0A0fuVUhZAyyhYavUprcnQuwktt+dAN6gAOdeuzLo=
X-Gm-Gg: AY/fxX4U4ZSfz4imNSSDz2CjpAGViPdm+ziaHXF5U3Z+wHRXDQZP/26CWuDYhnugU93
	unF6IaKCbP2jmLYay/Xvl0ufJmqcrDkzmlznadlrGE0RC6De4VxIwlndy9Pr/zPunWOTquwuzcN
	cRTBnUqjLncnZJtq4H4x3ox5UIn51PUm4bTmtoaK/na3DOBknIwk0tVi3Xj59SlwRqiHz0ydWve
	Mbab70X9y73Pd9e1JhlvhnOJWcLbifhEe4/FspIHyghVhnRTYC7zaLidE0cbx49Iz2SUg6nWMEA
	eZAqKDCsCM7Hw6fEZ04A6HAyYCjJ3+dhvVouRZLQR9iGHUnZyO9sLNIFXxV6t61R5bBDdouoiVc
	po2MYod3RaObB+h0fgFxIkxt+olwad9BhIsudA4K2ir1q8MCJNwfxjyRHsaC4ma9pe+sTLnurbf
	8MKD4NSEXOl+0nhdE5dMiSM4w=
X-Google-Smtp-Source: AGHT+IGb/ANQW4oYo23GB+o6gOePNPs2Ss/ccbhGWa2b92/2fOZzyHf2JqsPa3t+fNKo8+RvX8+XVw==
X-Received: by 2002:a05:6808:300f:b0:455:ee1f:e1c3 with SMTP id 5614622812f47-45a6bccb5a1mr5652095b6e.13.1768002975643;
        Fri, 09 Jan 2026 15:56:15 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de539bsm7728174fac.4.2026.01.09.15.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 15:56:15 -0800 (PST)
Message-ID: <965f2405-cfb8-4d03-92ee-4c5bfd35346b@linuxfoundation.org>
Date: Fri, 9 Jan 2026 16:56:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260109111950.344681501@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 04:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

