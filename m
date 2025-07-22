Return-Path: <stable+bounces-164292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0358B0E3FD
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4133AA1F7
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C7B644;
	Tue, 22 Jul 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFFR2ij5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439027B4F9;
	Tue, 22 Jul 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211818; cv=none; b=de5yb7F0WJiPTpj/TOptFivcYIwGa4Zih5XbAf22dZhSDL3Pu7VC/SJPqoflNoksKB2211nK7jerrjblMNImvqdooafF2wAvCOsGPrA5Hef+Pdk0YeZnLcwhcZAUycZj6YJkmMIcGKnm/6CTDx9Y5t2vkbfVBLGTwIk6zQxlWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211818; c=relaxed/simple;
	bh=dd5RGWofHC4xPOJvaPYCb1csWyG+efVlR+JerfWTlp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXPbV+f/jMeHvzoUNXP5oxuixDPRPkc4ngalBd/42fgJR0u5iPgF6OKkhxIkBbOLNa12v62Hz8iVvVs0nD3py9ZOeJyzXxAkq6x4312PK5hHxUpx9j0smO4zcPuP+q5wdnzQE/LnbI/G3FfnfGOD9UJnm8zwEbP1UIs3bCM8AyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFFR2ij5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e29d5f7672so525707185a.3;
        Tue, 22 Jul 2025 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753211815; x=1753816615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HezAxjd9jV3el2JNP/W7rwAM9i6vSfM2srD0goJbh5E=;
        b=DFFR2ij5x7GfLNLHq0uQn98QPK1nnSKGjw5dZ7kTSPR5WiN1wxhhywfmF2l1ndKviZ
         FAA6UxduA0V6JU4Mibs5h3Gsk5npiEgcg597Lr6oAf3Ce5uZP5HCwNrqHxynkqJAV3kx
         szGkNZRaPAUwEOJgCE75GmKS5q163FMHImopTkw7NdmHsTVsG97TorAygmp7vOI8n+V0
         uvIjdeio+xCVgIaodGbJwBYXvoysFOhIABtAPEUXqgW08MnIX3bqjTtBtKq+0+Q6DCcM
         GFUAmHwUO3JPvMMjf8ZwA5gmdm1GSOBRT5RDGZRvysrLHh+TwD/HqenrHqsrH2UkTOtd
         gZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211815; x=1753816615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HezAxjd9jV3el2JNP/W7rwAM9i6vSfM2srD0goJbh5E=;
        b=YAA5MWw8LJ0Gt3xsbBvi3bHw8+s9IZLD5KomUfpnl9EUu6Q4aF6RNO6BO16qMjk481
         GFHlN4mGUlCbqKVK0qnjO3jNn+bDb/1BPTh9pZxExeZ9hdTPOk7nSQjt3LPtW0Gg3qGs
         ewx3XoerGfgVY4OK6J1B84dkxIJZGs6pmroGoI22TpFsZ9PKheKdETZpR+ig4xpa9StE
         1PL2Lk2m9jrMnImgHvw4wpJmSiL2tWVnlgqbob0Vsn8atY1qkDMuFVQePyi3h2m7OSAP
         yIle9JI4WjqSQaBSf0dJEW7V6z4EJFRb5Dzg1F0CYsdudESlIl/R9ciLKI1zithpVu9L
         nuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT7pV0SzCCA0xmmfqP1KUGucklW2vFSsm5xW7ta1Cf/zenGYMpMnoiVG5u83E0uT5X9fVCh6T8@vger.kernel.org, AJvYcCX+1h7+hQ1VAaaY9h0MxuG3R5IedHyyoxkVMRYnD+Gy3Gd7JvLYYh4J0m52fGX6Q1pLO+R0h2olHe9TgVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjCMQoQawgOHFdP30KvgFea61ZqbWxm4oPfuPE5i2+haq9WMk
	R9crhuW52rSWLjPJmfvz4FEEoU7phwtOpKwntS6QED7USkEuReEQ4iQx
X-Gm-Gg: ASbGncvme0UlHMnjJ5mr56mVGmy1GY9vbi9TjjlKnQ9tzMYP5nDGX+Oluh1tvNRMzeK
	1J3Ic1XSW3ilth4/RYoqS43CERkAADs9E96r3FRjTD86DIIGdUjYih8NHeYcbtILnIxcWUbd8aq
	Ey6AoECQA1e66qqjeoysv+TMEhjcWLRQefnOTC0Hgb7sjbp+nrGbQLrtLHREyn6F3v1ciPrQVj4
	ihP58sqhTu+9l2K5CGyXeG3oiBysfD+CJHhyOXRlqXI03t7CFnZNsAmqoQ12C4Hn4IfywCELUQ1
	robsD3Kpmo6VZYj3W704iF6zHgHTDLmEPAqjiEhs7VN+Xk+EJWfDe5JOH5kVv61PbSgRWvagm4r
	ZCa1Y15DaXxmOflHhXCSStCd1p2r+zj6WEFmdaeMTqLEhoyJCPA==
X-Google-Smtp-Source: AGHT+IHQ/cixMvkcUt9nivXutdja90YGJTdFNISD6ryZBEuFB6UrhR8v3P3q8XPTO9cbxX4eKkqjrQ==
X-Received: by 2002:a05:620a:13da:b0:7ca:efbd:f4f4 with SMTP id af79cd13be357-7e62a18d3c8mr53078485a.56.1753211815067;
        Tue, 22 Jul 2025 12:16:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e623ec39b7sm92654785a.79.2025.07.22.12.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:16:54 -0700 (PDT)
Message-ID: <ebc60d3f-ab92-4ec9-9955-d22046caf7f7@gmail.com>
Date: Tue, 22 Jul 2025 12:16:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134345.761035548@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 06:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

