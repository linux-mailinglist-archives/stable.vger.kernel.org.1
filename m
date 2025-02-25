Return-Path: <stable+bounces-119551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA5A44A4B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB4421391
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB320E6FD;
	Tue, 25 Feb 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="QR//+EyH";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="iB8MwbB9"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A461A5BB8
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507899; cv=none; b=UJhOQ+OQ3NSlfurFU2v/ZHXnIiC6oQ4eOCehFi/bufwOZQ1rvGAJ02b2Tnrb3fvqv+GKpzvMjuo10MxGdh/RUK3gkczUm/8zJNzz0SbHVX0Z2Ag8sPfa5WkK7r04S2gDHfJ4RyfOv34x9tEvqpOvJNBjUJvKTMGjNZt3p/YCBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507899; c=relaxed/simple;
	bh=iaATjlHw3bgNn21HkdEj8ENv2eXuMLNnP7ErX/r4HX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5wRGLP030LTRRKJUBb3tz1d4a4sU6m0+JvM6Wr4u9GhF48JgfNEcm9zJw8TqCSWlSB9HD5c/wEApo5xaGXbL1Rr74WOlxckYblZjEw92Eq5dZg5K5h0xjkifIzhEH7PciLESv0KRU41Ik9uVlJr5sXn2k7xm4qct2D+Xvxx6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=QR//+EyH; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=iB8MwbB9; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
 b=QR//+EyHJ7GX3lk4e/xxvIwd69YF8khMAXS/JI3TYUveIPt2lWGwshDMEgvahttoXalpxAFGT0IduR/MuG5kJT30P4OG9OmLQleOxheRLiriZ9Vl4e5d5rjxuqNJa5ghiSkX1RqURqWh8grI99mJFxcNIRE9XZfD6MIOcAR7nWfRM3IPCms1zsx9YNu+Nf+hMrxZ2R2n7ieQus/QAIFmPeI0BBraPqU7Mm7LIjWX5Gte9F/4C0IPV+K8ml9e4zViFk2TV6tw/ZzDPmvPgjECvyYqAxrkrcZZadmdlj7ZfkCWUN75zz1yH/CZrodlbBf0l2Lx2tweckJQH9yU2BsMUg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 642BBC40080
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 18:24:49 +0000 (UTC)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e6a94b6bdfso113392126d6.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 10:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740507887; x=1741112687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
        b=iB8MwbB9+OumtIVEqO4Q0wJHMlaUaOoWW7O3cEKCBOUnNMX8tysTW5BG9BlMjx3fsd
         HRTFqDcH4iJHwHe8Pu8Va/8ClhcmvzwYqpnsDOfv7qXd7RC8fmgjF7jCF/hjSUxiM2we
         P1QXrz64ltzRiLRvFW3IMTkdj8uMT/x0MDuI6Opz7JZ28K17X44ucSl5FP/kl1hXVJKn
         97G5yRnKfbzL5dichvIEy3nOipm2Z4Hx/sSkLOW0D7tm3o/9Vz2lTeGm91Hud4icekQs
         VPF9X1vRbc8yB3mpgQHuJev/9IhroFySuZFpZ1EiEcVrTFZBmHpoYd4ynrfe0Tlriygd
         cIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507887; x=1741112687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
        b=w3K5rqyQ2rpZ6RjV/2RXYwxNcq0rwyCwEshxzGoZ2/ocHWI3Ywq2NhlJz5zRvRVwLa
         Ao2lFdJNw80U/8qBPDc6HaQjomxcfzYmE3TLvFVmv/QzymMLjHsqCLreGq5i66uA4ZLk
         VzuBopwKoo6bXpt0CJ/+/Kvt0n3uEM19PB2cEgrAx8L9jCOt9rVsK4IIVbCyPCAIvf5h
         EYP/LA9H57wbftOO4DtKqi6u1zd7mJQTO8DtJr03vePnuP69YfV/LMwtJ1U5u+KjxC8Z
         wGl32trOIUXCTIRrXKEiNVWKy2L6hEaiNpGZq4SNYFwX7HC6fQ5vxNUXJkWiKQpOtgnI
         plCA==
X-Forwarded-Encrypted: i=1; AJvYcCUXjMycA6moys+3RcCpmxjNcPKfOYVGD7wyFJNePQ0cxTcwi1RBxOge5/ZUsYQJZ2NfUTzYX6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLceyX1tGEbH1tuqgXdKmwTQGxJnXRaCqgkDdRLjJ1i18GfYDS
	CjFqiEm3MAqRB/60P9n0wHIbmhc6DANWuF5HssFNr4MowsiRwcrzNoWPVYFNsKXmargJEu2UDMg
	6x+8ciOdPZIdQkd+NQkQkdiHz3d4bRLUk201YcMj43zv/yMNixdbJyrJKuJU9xVGEXtOBSRT1up
	6fFDasPx3uwg==
X-Gm-Gg: ASbGncuwOT7wOJauzGr6K85U5fm4I1mlr9I2crsbTAWpxI9xFWlBLQrZVwiNLUkeLu+
	sOYn46ULY30WTJxwsCyI/9GXJyhU1ed/CVyN6tnkTqh+yWoYJaHfWATSTvYOPWT5WdK0hd3NFYV
	NowtBHsn+ZExVZ8+IM02OcoLN4pnqJ7R8ECPl+oXJ1rBuJJIi3Fh5hPXf+1E97fD166pBXJAMn1
	p/Z0lwRqsiVM+u7hNpXtw++jABCNCkG+VBSYgMZL3Nu19gwsa9/lkmxxeBhNCz7a9rb5JXIcPSP
	RpISxMvASEf4aClbZ1CBsP0NEfT3hs0YLey7IV9BYv0W4rMQ9f/xTJl923BYROp5khyxTu89AYc
	z+RLXNSRn06aR8roWc+GM4cVdY2ImrFLBVpVD
X-Received: by 2002:a05:6214:19c4:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6e6b01d7816mr281052546d6.38.1740507886688;
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ZNnvyi/eJtx6eJsBbumH8T1fTQzPvXG7ciwKqR2L/Gj19h/DZglqhJSSfN/X1QoEIlljUQ==
X-Received: by 2002:a05:6214:19c4:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6e6b01d7816mr281052126d6.38.1740507886368;
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b17103bsm12158536d6.94.2025.02.25.10.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
Message-ID: <25f0b81c-21e3-4021-ae53-cb54b6c06324@sladewatkins.net>
Date: Tue, 25 Feb 2025 13:24:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064750.953124108@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740507890-nGFnz5i2CeSa
X-MDID-O:
 us5;ut7;1740507890;nGFnz5i2CeSa;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/25/2025 1:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.

Hey Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-slade

