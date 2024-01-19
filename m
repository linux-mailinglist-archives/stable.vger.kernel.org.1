Return-Path: <stable+bounces-12224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6D8322B4
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1531F238BA
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE833645;
	Fri, 19 Jan 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1rgVtvJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF81F
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625038; cv=none; b=C1Y64E6eNhIbTtY94qG7lx11SZ67BdxQAijLp/WWQ6ICdsPSyiPKKi/8p92bRitz43c9JjyQ+lIWWGBFKjNUyG1q4mpHxAfjfXcUGJWxucxHY2lK4ClFZ0dX8MFt2BrAdmuOmYxaKhoikiovZRn6EkqSL0T+EIRJSG20NcQndFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625038; c=relaxed/simple;
	bh=iEOt26FHv1dAFpGXqs+FEKRSjCiULGc3fJ9ltubgUvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkWk5yKfB624XWGcS04QADMtBHYtAsVSNfETR97Ks+7ZFahQH18K6h6JdjqM6oHgEk049N/A+VDAzCQ/gtN30RPIV3yrREa2MOXP1gW7dN9sEK4irrRMPUb/4Ocw3GrVlhvQFhMT2wKk3oH2MxrwiJs7Otr8O8bOpgA2zceS6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1rgVtvJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso3553839f.1
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705625036; x=1706229836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mqk1y/5vRcF2I/Xwt0pfdoXrpTt3gsfqcyccPyGpp3E=;
        b=I1rgVtvJox1Z9HGRTq3Jq8y2m/Mid1w4cQ8WLiX+LTtTYsyj8MEq/eqOM6uFLxGTB0
         KwUrPzI466Lt9aPFhNU8SqN6nAppPAAkVXBcr+P3HhrI/AVfLQDH4juqcvo5dHn+VD97
         +/oelGmFDqMNcDp8K+MZ5mYPa6KJJcR95AilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625036; x=1706229836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqk1y/5vRcF2I/Xwt0pfdoXrpTt3gsfqcyccPyGpp3E=;
        b=kmkK7mI3uzxo+NDTw9dovKIiWPdl8HgKuRsZ6/DDXGX3n/13bS1bBiwGLVsHqMSxHL
         YGNlJmezX+JwsboLyns1KvL/+2zxLVSt7NI+Pk4NSik13zOlQ32UWydYfsiIAXPqvTAj
         qLdr3tEliCT7xAGRvJ2hdAr8dopWlnDfARhqLZoY9RAbt7A24IQPT9mDC9Jo5rDDbMR2
         U8ch8/uhkU7o5ffTE469L7dMIQb5d7ZD+LQZY1EqlMrDepKFyZkUAgvTL9fDWmphzVKg
         6vyH3cyrSNr1moIygMnwjpAVxxfeVzBJZAsclJEKuKYDGvITDd9qGhnnB5ur8pTEvobV
         dl/Q==
X-Gm-Message-State: AOJu0YzVlRU4W3Xzrenj0Lql/a6gDZm2RGsz7f7hxDZnk2/98PT6OImj
	28bB+UdT3nhTOPeH17wSkrmjQ+yZk8pr06qgsjIFjShCl5itnpPDWXMx7eFAMsU=
X-Google-Smtp-Source: AGHT+IHzM1Ap52QP7u8OfoImncqXOWPvCKiXEJEsJqEihmXKRNLtszw7jjYTegV/B8ONiQog1sV5vw==
X-Received: by 2002:a05:6602:255b:b0:7be:e080:6869 with SMTP id cg27-20020a056602255b00b007bee0806869mr1122277iob.1.1705625036599;
        Thu, 18 Jan 2024 16:43:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638144a00b0046d18e358b3sm1323950jad.63.2024.01.18.16.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:43:56 -0800 (PST)
Message-ID: <beb7c9b9-19a4-488c-98c6-1fe2d8172c5b@linuxfoundation.org>
Date: Thu, 18 Jan 2024 17:43:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 03:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

