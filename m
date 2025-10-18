Return-Path: <stable+bounces-187745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BABEC2CC
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9494A1AA2C7C
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7A1A23AC;
	Sat, 18 Oct 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5cbu9XU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7A19995E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747941; cv=none; b=EZ7Q3lTZ4bk7DoZFeCKFnPHHkOrBVhYhH6E4RYOl4QkBK4i1Y+DQ4wanF0mbtmhKzAkF41ZjbQ3pgFpBFfdkIOZFoCoG7EMm3ZjLpX1ugP5NeEkszXW2+YDpnk/LEMZAYY2mJ3pZ9GLUrF8iYcMkTq1wD8Eip0PKiuU97MlNcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747941; c=relaxed/simple;
	bh=TfkrOdViFaSEovMzB0nSzeBVuPcuZ5Q4h4pTegO9HiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiPMNrYhrGh0T3RJA+D87vMHL+v8OX/2HQ5oLbtjzUJYSULdvBA1BOSbvWwx4xq5cJzIFwEegzrUKJ92SZ42X4z2MCYcrBvybOC8QmWs7OosRdrc4vdqhkJen4O3Slb8I0zWaX3sMc5XpnUvE/HBos+WnEql8/PSSXO7/Fm8eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5cbu9XU; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso9474975ab.2
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747937; x=1761352737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6Kl7ZV/gVS/yfGRDqrKMc7VJq5dimqOMeIoI+yFLws=;
        b=E5cbu9XUb++DG0FY1+V/PqCwyPWCFDNb9eYu27dTLwgRj/l3aWfn/FGVa4JresnlSK
         kI/lAiNWUit32niVnlNr8nAshmJwtDxxMzPyNyFLL9VQWWqPV3TZw+FPUdxOimlp2shR
         s6N3yLpCMEhkny4dGxy4xEitbUDeYoLRdMWGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747937; x=1761352737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Kl7ZV/gVS/yfGRDqrKMc7VJq5dimqOMeIoI+yFLws=;
        b=iXESdg+nHMQQEsGeyfu+KMTomqRuQMhN3/pVTojcBjdy43+1mKWxI4XalQfFxKNdm4
         EC5BkBT9AA268Vs65qBVtHB+2Rj7frKgE+eViy+LLU9kBkQZqAD2RYIG+rAqHYcpm15C
         2YLQCfCCawYmvpt8FEmIrmt0hmzy8HtjUxtnum+yVE0k81HMc+yGjJCdLiG6OHQm1mXp
         2oaaAdtuLaUOGe7A8tqjQCGq6ZmArTaqvy2uIxklDvJ6bYn75yH6CM5iD8jGKNXqEgDl
         Y8MxSObw8YIWjJTeQgwt3oUjRVks7PBbE6zW6N/Z9lLBS3oXyZW5lzm/7hrnNjpgGSrA
         0MNw==
X-Forwarded-Encrypted: i=1; AJvYcCXKU3NbX/DZotgkVY5B5a1YRdRmdFcli13VEjGWBVwLuB/ZlSSe+Hbd4JFQxlwqvDTG+Aqnmmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnZz6ZRDaXrBNZr4SaT1UxCnV8lTT2bIB5IILx5IRHg50TdVf
	3PbeemCnnksBrqDcNftpZIkpX8w/b5rA4nweDOw3las5ev1h/C00l7bvqhV7hmhCLUA=
X-Gm-Gg: ASbGncseUoY1+T43zemcB/gKHiqz3FdJSrH2RqGjxs1PvW4P3VWdBvBeHEztHc5Sd7z
	iME778d7ksgAs0mYbHP/ka41HuPKwoMNr9FTpzMojgbYDtuVUlzUQLd4/cDAoEQeaElLG/1tURf
	bl4JXUQQlCeSv0XzpeQNfbW3NbbXvGYEJuQ3hcZrZYewQx/4ZvFTYPclCDJWGjQ1zsZsPaRkTN/
	KNUeicHy0IG6bzXg3p/ZTS+HzflwbTCFh14Pxn4v6Dfp9INOH01rXXL6PKS02GYLo3jNjphimme
	NQeA1d2Sfa7tF9D9gW0g8pclbhvpx8v7k7F8cCuEPHcJKDw+zpOyBTfC/FVK5JYjwB9LiPjQpDx
	+aaR09ThwMtKe5cplnY+qUnmpOHsN2V56iPbalYqQPg4jzQNEnGJMYtN3IptsFB/TrrJLerl/Z3
	JcCnbt6DFYb/rBCE6H5CEi3P0=
X-Google-Smtp-Source: AGHT+IFQ1arpM4XiIHOzegBMIippzM4fh8WNlEEgxxDEdrMw5sQl3E/rQ4YiBNkwMyu4gNlwkvHgmw==
X-Received: by 2002:a05:6e02:3e06:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-430c524fcd9mr83643375ab.4.1760747937361;
        Fri, 17 Oct 2025 17:38:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b3eccsm5151775ab.28.2025.10.17.17.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:38:56 -0700 (PDT)
Message-ID: <95598231-ae6a-4a0a-8697-7ff273b6124e@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:38:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

