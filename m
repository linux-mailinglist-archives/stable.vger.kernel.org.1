Return-Path: <stable+bounces-179279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89DB536D4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD5AA05B7A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98E30C367;
	Thu, 11 Sep 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI8E0MRV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADC2A8C1
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602884; cv=none; b=rwLwqLisdZ2JZHLGAj9vwrp+OeFo30wffUTe5j5Q9J7duOhV9laZ2EzpDdlx9kTtC5KsbsBGVP8ZylTUa2eRWg4jJW+UVx/I1syIJusoudohNbGCdka4Ic9vOUVo8DkPgNFZ8LbSStBbY47WTTbOfMgBLuMP8RrMov+nj399JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602884; c=relaxed/simple;
	bh=0UUZlclblYMRPHSM3M+oFHI+0Rw3DyMdW3tFFmgm/vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG7BdTes2zITCHba+zND33DUDt1X/Qyej/gwHoEnoMQlfxfG31knvoeBZ1qkEzmrMjKdXDo+MwDIuIxJyF451057SM4XJCcBLt615N3aew0OrmeV45e1hkg3ObeIK/7bf2FmH85FtioXCJxltYM69rGOObd/WDSQmgUtTCoD4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AI8E0MRV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9bc2df29so766345e9.0
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757602880; x=1758207680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WHL5LcsLI9dIOkErscuPn0aXfUSWi6A2LqSujMYzR68=;
        b=AI8E0MRVnH2JteYkhlvZ3hWZUFjyjPtBlkpJcOrTQ9Vsn2sGatckxxahki1cMhouG2
         +NtF82Iq+cCneYb25r4bGTHMca6POz4AR5os0mH5SR7H7a7Ihp6ptq06eL9otnRAAhMu
         d81EV0aDPVEfQr2TkbLaX4tlJNwUvRKgyVj5wK2cvJBay75yzzgllBLb9GbFQd/r63bI
         ywNxhJGA/1ZNxLa5NiMfB1jE++jPmmVa34Bw57hPS3MZl+SCRp6KbM/yKpuio8BVXdYc
         qOq8EbsBOlLNcoGCkeEy195yyY6fULRE0qbJSlCBDKNquUwWJgJ6XR45bJIca4FHYe5V
         WlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602880; x=1758207680;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHL5LcsLI9dIOkErscuPn0aXfUSWi6A2LqSujMYzR68=;
        b=d3WNkdROGaSEN6GFcFTeUCGC6ULMMz2Mc/4Xcly3p/xXccUo55GwxOgmAFCepVZhve
         7kiM7ZY7t8EFYL0NayiD+tFwnqx2Mky1qoHT3pQ7enaHSmzPHTx4tBDTUK9X/7NV4WoE
         KB886Qh5bG3+0Bz7k84/CRZ4BPpr+qVFiYtc1D5skOvHDVL9gKo8JtwAHBl9KIapuoad
         YgHX2eowdInJfmbZtjzcKzO+RMHkPob2flWQAVVrgkZx0CvIdZPjAXVkX/5/IKt3/iSa
         lSQA9l7RtKK9vI3NMMIyvq4V22A1QPZC8I7QRhLf9hSQHyvoHt8T7fcDtK5Guxry0brl
         HY9A==
X-Forwarded-Encrypted: i=1; AJvYcCULSm+voN/gPP9ttYcXX6sUpl4EgBxo3hs+auKCcc49Kvid2jTfPMkDZmCBsfyVJt6vlNqHc1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a6OFeD0gAc9yzTUSHqliJ1mHwgC8TyKpdX75PexemE0RGjoi
	uRHBqRJLsN6mxgRwjHFRnHltRV4ou96JEUOePugKU51ouCLVvRZEaIQEBqPSatAqhvw=
X-Gm-Gg: ASbGncuFuOXtEdPU4yyqs//A1ef5fEpy1Y/cZCUfC/zsAsUnAfxfK4gACOBhUQyzoQ2
	kkrV4koaJEdqSzkxwQAuLyBMLO/za0h+X7KgjobjbbitItxV0aWu85dTkoD1ittTOd2Hn6J7rNS
	cRu35+XkNCyVT9J78KqvJVN1EE1DJNCfJbn2GpTprdaTI25ms6YxsxWB8KUhYdZCVZHpk9kwWQ+
	dYfLG94CJph4QO7e6Ia0+p91Bc0Dj0OniF0+gHg1H5zjDdN4EdnyP+0KVC2JDOqRXV7vfjx3cMM
	ytpMgvB+3HplJ1LgxPm4JmsSzbENLdF5+e3HnlTxyWPsJj3GE0/wCwMunF0GmLVXkomUw4+O0YK
	cTxXaTquG6PrawNPjPP2OF2mpXqlgI2WC9LgeCSLiCWg6L7ON/xOOgN460UbhXvQJ
X-Google-Smtp-Source: AGHT+IG/d1aWzZ0Ltu8iCu+Yk7Oxm2T5kOcTdTAB1ZLqJif8CiH/SJeBlnAzTppkpTuXinpQ1q86sw==
X-Received: by 2002:a05:600c:870f:b0:45d:c85f:5030 with SMTP id 5b1f17b1804b1-45dddea1c78mr91523505e9.2.1757602878916;
        Thu, 11 Sep 2025 08:01:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01865ff7sm15772975e9.2.2025.09.11.08.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:01:13 -0700 (PDT)
Message-ID: <386a9d77-f708-4a47-8318-b83f862d5c1d@linaro.org>
Date: Thu, 11 Sep 2025 17:01:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64 defconfig: remove CONFIG_SCHED_DEBUG reference
To: Mikko Rapeli <mikko.rapeli@linaro.org>,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org
Cc: arnd@arndb.de, stable@vger.kernel.org, Jon Mason <jon.mason@arm.com>,
 Ross Burton <ross.burton@arm.com>, bruce.ashfield@gmail.com
References: <20250911144714.2774539-1-mikko.rapeli@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250911144714.2774539-1-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 16:47, Mikko Rapeli wrote:
> It has been completely removed since v6.14-rc6 by

In the future please use kernel style commit SHA ("foo") style.
Checkpatch probably complained about this as well - are you sure that
you had no warnings here?

> 
> commit dd5bdaf2b72da81d57f4f99e518af80002b6562e
> Author:     Ingo Molnar <mingo@kernel.org>
> AuthorDate: Mon Mar 17 11:42:54 2025 +0100
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed Mar 19 22:20:53 2025 +0100
> 
>     sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional

So all above is not necessary.

Anyway, this was already sent:
https://lore.kernel.org/all/20250828103828.33255-1-twoerner@gmail.com/

Best regards,
Krzysztof

