Return-Path: <stable+bounces-123118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B1A5A3C0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D293ADCCA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04E235BF7;
	Mon, 10 Mar 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OySs5+K8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400923535F;
	Mon, 10 Mar 2025 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634773; cv=none; b=bPn4ovMRU9XiknOjyBR3/UGu22KN/iqiKau3NBMGJrFUu++iMlbiRMxhl1smp/m3wJ774hjEHPXMtXNggVqIoZGkrJS2kBoikj5gkiaJ32fAL2M/cHhUtsGYjzttYWtJ6Hllp47l9veS/MNkzXwQy4Y2ZETPZzvMBLQLlH1ZTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634773; c=relaxed/simple;
	bh=Yjj61pKr03VXJiO0kadMb3Swg4rYOWvMZox9YI4R9YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2b8WnvepoJsE2PufrT8cC4J6s51nXjOhkXdcTVXIe+G2IMDMcunu6aQF6pDumNKV4PrWbS1AhIO7exJ8QlIda4Pgv645xczIAYSFjUC/vrBVBLIKJPLtEk73+/29YVflq22ENOx/wMuCuUEuiKeUvbayQlicafnSlZvgnjwBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OySs5+K8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c239771aeaso2408754fac.0;
        Mon, 10 Mar 2025 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741634770; x=1742239570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D3j2zbJSXSZhKsILHhwAmuv+mK+o4l3eDHAbl0bLV9A=;
        b=OySs5+K8AS0kFYd5cBw2KjoyO3O6AM5dXvzBRdJ3+mKiWNmdDsDsNmptdvpLG0jNiZ
         iyGjT2WsvOMTIreDJOlxyiHzXaHby9AbrA3AULIHp7FHEUCzLljCSzwnCQFZ7a0RvuDJ
         QuAmgrWeIEUq/zlru6TaHW2W/YBKuovcsj3tLq31+mC8nADa88t437uXuld2PXOGD4lu
         R7e6C/XJOoEH+vGTv5oFEbSmjvIACXBu7t678isAgnOFq1JTIqWcwMMYe64izG96Wo3n
         1yuLwCUSNB7DCJKt9dED4htICG6XmP0HwBDSFKqO6I5p/cD5trmoXHZDjR9ZHQeQ2q9l
         1Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634770; x=1742239570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3j2zbJSXSZhKsILHhwAmuv+mK+o4l3eDHAbl0bLV9A=;
        b=SWxHbIEGca8n1WsKlg2IuaAwXrQuCm8CvaOZdVD0Kci3AoWHH90K+CaqOZ+NRuaXch
         nzDieXAAnBFG0RojD+JOBh3UoBc3y8ay72VlMhqB7/mJrdSlgvHAXA4hLaw1HFnW7L0K
         1e9CIqRVLH1uNAFDeKdPRduiQMwoU+9kiry5RzINpJuiAZv36bpKccXNaNtvQvCUZ7Ff
         Fd/P0kVi3ay9nZiNkVtvmamhd/0/LaBEVGjJKzjOEEwuMR+EO//UcxhWYuejnzMSpjVk
         a11uFu5Dk+J8eCAQELiOKop7bgtpFhNk/Z/ILCx439nIseXBU9pDiMyEL4gc+3u3F0py
         kfUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKTUP3F0KjOf4V+Lmg0hn9SuS3c14h8N5aOxNF6mHJDmQnxoh7Auk5aEEgaFosQn/YMCJMX81MjJEoLcA=@vger.kernel.org, AJvYcCWH1oTwXbXXAA6f+ZgzHaWWgVDQE4BB8ASnfZRIrmbQxm3JD3Hdh6NG3s6biRjp1Vv8niXvitQD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sxBoKaUtS1/zK02mKlkd4vGp87j3Qf6iw0ZNlcmTZAuZaaXJ
	NYawdLggws8BerZ0NVOY4rMvU++kC4vbKS1OJ0e3BQ1fJrR/7rWn
X-Gm-Gg: ASbGncuHGB+rp8u2RkdeLatvDpkOqmU7BYLezuwj3qkz+XEmtOBJga7JBLovKuSPQOE
	RrY4SopdHbkdKjcSH3ZAJIYIc6ZUhvgKNbVWkj+yRZmkXgrrJMS3DmSutgNOLthbUBNhjWpt8Np
	2zMwRLC2UMpymB5xOttR9z0IIWpOx+zEKgi2hfwaY6Im5t+SmwuuQ5h1j/PwYKnfdF4SMVOQSV3
	f7m52PG3oQUAkpDfqK8GeDxxkQ4Y/+foBc+gaQSUBE7rsfQSEqVWL1T4EoYsVCMV9KDroRH1/aB
	WT7tsP+KZ2nwPteg1lM6LnGfjOZfY0zV69cWQRhdzYXHXmXY4HVNNAhYFJR1GTD3zny6lsR876w
	9AGlZI4U=
X-Google-Smtp-Source: AGHT+IE1MmThBQuLHv+YygimmkIg78hZ8PuGQSbyYKAuxYchAVYqkeazxNLdrqtxgpKQ4ZZNo5kQEg==
X-Received: by 2002:a05:6871:7c12:b0:2c2:1421:b30f with SMTP id 586e51a60fabf-2c261300919mr8178161fac.26.1741634770507;
        Mon, 10 Mar 2025 12:26:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72b80febf0asm804362a34.49.2025.03.10.12.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 12:26:09 -0700 (PDT)
Message-ID: <2403ffae-841a-4077-9699-554231ba244d@gmail.com>
Date: Mon, 10 Mar 2025 12:26:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170427.529761261@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

