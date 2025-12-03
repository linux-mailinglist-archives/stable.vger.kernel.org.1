Return-Path: <stable+bounces-199944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AECA1FC6
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FAD4300EE67
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D72EA173;
	Wed,  3 Dec 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMtpR9DX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65280296BDB
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805668; cv=none; b=pocUZbXkzc2SLJ4GQZ0bvDcCG6CL8DtsGR4bFcHIP338ZuV6lHfOkFLtQmTUeetxkhSAYNd+NnJQIvLx1iONgIIOGGHZvtQ91UQVuDZaWswQ1G/anmDUXwvJBepZ7M4UUGbCNTnKNPB1x1QiqdLVRUi5xVyAys3U/HF9EjAhqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805668; c=relaxed/simple;
	bh=gTsejU6waB4HvsDl+QP5oKKn5v8LZxLg+lNCDGEDGvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdnukSS2gNgauryTEDYrmqvdqAYAbwS9pgzLCYmFiuXU+HmelsUxasVUqskhGH1lLUeogQe1nl3y/cyQQycJlqFWqb6+2QtczwwEvEo4DQqniGkXTfAy9yt93edtoEbqIwHMO21B4HoH/wSLa2iwxPTO6fNIz8iZyi4d9Qg82SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMtpR9DX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c75b829eb6so294867a34.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 15:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764805665; x=1765410465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpEO7mPLNja/i2RVtaH3h8uU74uxJ0yZRdd7oKRDmXc=;
        b=JMtpR9DXPodVzGm0OGJmXQ6Dd8RHnrrE9quSTz6bfcNdLLvIiceynvFkZxpeyb/Dmr
         qKK2yae+2hn4GCEJKT+qkoKmEAIbSNs0vysjaEQdT0bwD3vgeP5J5xQgkSz5b2FhOt58
         +p8FkpmLv45W5d8NjBQ6q4CMIElG+atOZ3szo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805665; x=1765410465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpEO7mPLNja/i2RVtaH3h8uU74uxJ0yZRdd7oKRDmXc=;
        b=LMvKdMxVMmkP1QMe4MoGOhWkKtnrFjs4BKVVtVeHTu/x5ms+M3biQgW79jc8VsjEVv
         vREp6AmGIi5R7OdwGvqvUFPmSBLBbZyClVpGOBn7u4WC+WTQnOaJrXwpBQ9JZ/RIqcCa
         s8uJqsGM6nHJw3DyZzmiMzjFxwye71M++qoGxJoKYPpE11ygg7bdRZoGr3Lj3xshqeh0
         AEntLAIUG5NLMaxSPFWinMffWHbrEHBBR1Y66UFaOk2ROn0A74NweoRRnc3/lnxItnR8
         eh/bvOEU/rZQxPFiSZV/YioDUq0A+1uw48A27QV/3mp2qMc8NODeDQYESx5aDk5DlUB0
         e4uA==
X-Forwarded-Encrypted: i=1; AJvYcCUt8fn6qWyuDJujaen5SNgxYPAK/ZEPVppU6d2lDSFQqO4D47FXGR6OEa3KWw6Y0vW3s/DQg58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0IlDOhEgBlkWeIJXYMy6ONIxEbe24hxP3SATYUlmR+14n7gW
	sjjb5jHxBZxYxfAQPbq+9Qlh4eouocy++NqRpD0KcvZjHX9ASydHwvuTJi7D0MNwpHk=
X-Gm-Gg: ASbGncvpDNiWw7q11ll4c32p0Km6olnZRzZrOLVHRE1k7auxLXhKYaeY6EKrLzXLmC6
	7RMssdEb3cispiZbhSqVQcJvgMyYJbVjGD6aU+2QPU5pJhnk+AQmzXDgczvTOOa0GGtdf7/roQi
	faPLzIRiTMO70dZTI5ZneSSy0TzLBja7ZR0fsbowZRaMnE/LV2DOqrhvDEHoy/ToW9U+9G1HUYA
	Xm9E0GdfDWrPkw3uxLYpVxrPdwQ5okTZSheGN+BGVoME+e5o0EshW4EXrojd+iajr13di/lFFUh
	yGMxjzvyw2iNI1kO32SCBj49Yh5B+e7UPv9muZJ7A6jsS5TDtBnVdFsL6nyO91nQu7eXV4B4IVY
	C29x2CVe5fZeWEkEIbHBIsTdDrxoMKJnQhJutdu9MPp3UasWCly4tS0seHpbtRU7lfgZgICJvXl
	ohYZ2/3bSC11vcj35mFH2tVnI=
X-Google-Smtp-Source: AGHT+IEYE9EPukd88z1i5cAmvv1+8dEP0hdAZd65CqeILIvUcSKk6z1hmoGXKlyW5Nz0aDU07vOoeA==
X-Received: by 2002:a05:6808:34e:b0:450:f45e:f4a9 with SMTP id 5614622812f47-4536e3f88e4mr2143895b6e.19.1764805665453;
        Wed, 03 Dec 2025 15:47:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453170cd4a4sm7847735b6e.17.2025.12.03.15.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 15:47:44 -0800 (PST)
Message-ID: <74952156-013b-4b79-8aed-c0816b7da369@linuxfoundation.org>
Date: Wed, 3 Dec 2025 16:47:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251203152343.285859633@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.61-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

