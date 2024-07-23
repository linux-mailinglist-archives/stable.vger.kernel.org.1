Return-Path: <stable+bounces-61216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E993A8B8
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB41F2333D
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8306142621;
	Tue, 23 Jul 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsVn6C9a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0C13D503;
	Tue, 23 Jul 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770234; cv=none; b=KRYiq6IPspsN1o1XtgSyCpQVc9Mk7cy5sCVB9W+S4FHBXyZMqJFGI9/tLFxM+LOKAUq1ud6rMVQbfsopyWcC6yDl3Eq+7lSw9DzIZsggr9J+TgcOYU/4Yblna2wbLYeEa2HnPIlEpz0uupnPv+M0jSjEf2FocrOCx55bspdLqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770234; c=relaxed/simple;
	bh=fJdNLJeK498HpfUGwQRCMcC+1DgcJHW82eyWYubI50c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJNoCb3z5dWbJqhzP07BCRUjOtXEjR64IINunEJlYihglpVOsyqWSDa+4wAb9qnAGFFOjplgBo8jNSW956rD2wbxlpOZEeO0b20liNs/KH9HixOODeqdA8aUrGVex2i5sFhNxy4fWJ+5Jho6lsCvLKnTM21de+sICCXE8H5Vytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsVn6C9a; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so211864a12.0;
        Tue, 23 Jul 2024 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721770233; x=1722375033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4de4vuoAzGU+SJJd8nCBnpgurzTAF1hcwQExoCwyjo=;
        b=XsVn6C9athTJVcSw93ftE9/qa1iC56Xgd7fFVgzcWR6tZGUEZ0qJLwnir46wjZpgfC
         pYbR+Bs3/9Xd4q2HxqVCzPRr7DNj5LZpdFYeYeREW7iGwlibYcyrJpr8zdGrB4FOROws
         mNrgVaRqDMvk8ibWp0l8rMf4zVz+rjYQ+NHEkiDNa64N6fnLCWxYK9DzHMljOlQkPdaT
         5NwiGRZb9g/xiYWTXPeh4bOnIyRVAu4i//fDSJaJk2I3ynOlkHAR3E6ay5Jci9tk9nuO
         r1iTsFK/9n42hf300vnO7z7MfqJ6WyxEda+elVZWfWrKfhA7jxGHcNoH2asDy8LNqJ3d
         KbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721770233; x=1722375033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4de4vuoAzGU+SJJd8nCBnpgurzTAF1hcwQExoCwyjo=;
        b=xK9MVdw243lLwCgi9f1QoPpfZId/ggeIx8fvahbDOiWkSy1xJXLY/cHe5bGQot8K+7
         GJgRcCMfpIpl+s3DFGSvlKG5hn7miPvpqYiyGdoc4H9/6nfYYnVK3OJrtjdDpOkxPVwa
         L6VNUO9uUolZJt0MQJxJ0gStAoTUPsqG+1JW0Wyl4h8i+bEveUG10/VUH/fFBowBOGep
         ik10ZJEW5A6eVkG6Xt8FVQtWNMbCQcOTZNs9p2eCDPT8ys5yHhkHThEdYROYyFXh72IN
         AUz59qgv73GwDdhncO0CkveNR4QRHZmqAp6WnNt6gf4HGKzu3PNcqMo885uzllpfDacy
         ndKA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHNKK00QWR2FuTypnY2bIVDzE+LQW8It3RCYjZzr2NntFkezTY+0FsTN0xBNoRCQA/6dKtI+hyhYODFZugR3Akzibl08oj6lBmIBqFblJq9JyLDMmdFy1i6nRoYDTx14+5tZT
X-Gm-Message-State: AOJu0Yw/0JJk4jG2f+lC9RsmhuOjVr2RXC/ZulYHO3VfMK46Fmzfaod/
	FaJDqATFZgcug8aH6fCwHyCh+O1/umJS7tUrIWeCkQVI7fuvxYV0
X-Google-Smtp-Source: AGHT+IEZPydGcXkIKzmVjkgsWjzY/dfGnczk3SL53btNvASl3GMszGma1sYiHacdObWCOH0ZwWZltA==
X-Received: by 2002:a17:90b:1d91:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2cd8d10a8b4mr5452982a91.15.1721770232546;
        Tue, 23 Jul 2024 14:30:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cdb73d8897sm67669a91.17.2024.07.23.14.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 14:30:32 -0700 (PDT)
Message-ID: <ded16d98-696c-4481-894d-1ebdc1a019c6@gmail.com>
Date: Tue, 23 Jul 2024 14:30:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180143.461739294@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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


