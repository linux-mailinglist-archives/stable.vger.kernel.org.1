Return-Path: <stable+bounces-67522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE8950AFA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D105284C8B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F822612;
	Tue, 13 Aug 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAoUerj2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06614D42C;
	Tue, 13 Aug 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568417; cv=none; b=SLDLazXDX/jx5Y6gK7KZgTpabN8P4Dy/q4cAvvwA94nvceTdEjOEsCX70VEsn4B7CMqGwh38ALb/KhcBG6Qf/Gv55UB0Ks3NKYTBVerfsmKwx5hUtX2QdzM0S3FisP7K+KPvrOXtEkTDn9EhkxVFI4x96nlMRuxpmZZeo6A7tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568417; c=relaxed/simple;
	bh=XIrCPo883vIf29bWB8QanLy2xFIBQjXDszmwWGqlqVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO7aba1FgauNfT0telvgg9cJBM9RJC8DZCQSJxr4lGN1GCtlwYqbqvXtiUmVMnAx23Hvv6GZJrRvAMd0q57RkwfSDMTysG5TENPcxTqIRftoaCDq6QCFTmtEdRTWBoa//RiY9zk9Y2TsGFuW1Yo1aG2zN/0MsBz2PgG8FF9bBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAoUerj2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921c48so4391297b3a.1;
        Tue, 13 Aug 2024 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568415; x=1724173215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuc5EsBkWIMusrD6s2rE9U/6OjYd0kLjzG4He9KIV6E=;
        b=nAoUerj2NUkWqyc27VoUuidZFlc/KsTo+aUAwF78ag6RsM2v+sKDuUc6Si3j7VkoDv
         C3oW+qdF8azIVAi6bwKGE3M49IVlUnrAj5/54O15dDiwLtcmGhvFruc6E7onGJ7BcMc7
         o/KfFoE9yGaM5MyT/2uEZ1SoB33pkgvaOiQUDgK3HrCcdt+JBhPpZUglFEiloe7ngEGa
         rSYxaWg0142UYB3/s7q7KpVWwXm29UC24uvbSvYUkXq/P6cdjEgZyWY1hCNB4cQUZ46R
         hbGbVzWZz2LK9IvMBCtQYKblhuVpd1anBIMEhrkhheAturPw16ZfT5E9Ky3sa0GF65Xo
         LHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568415; x=1724173215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuc5EsBkWIMusrD6s2rE9U/6OjYd0kLjzG4He9KIV6E=;
        b=HhqGM1HvL9eFOadMFDFVGCLB1F9fzOF+bBuEhT8ONcO53/ZCfkWQw0d7qAHedxLxGZ
         CHjJU4EqrTMiWMdoToVmPBqUCZzt3jOwGPG/LRiRXV0pDdreG/TZFBhJChrPskKe5r+8
         UzyFs4qZDMJg6DXW3TOURok3lgOShkDypP8mHVGPTbPH4X2OsCbAP3xkEKlFlcxIpMfQ
         /K1ua10c2xdzSAdyqdFtsEZ5FSOY8WJf+niaYev84YOhHmCLBYESth2xbFT9nYQyChUk
         59EBiucwrpMws8wBJpr06ev3eiQ5vFnEZ2W0E48dskzraJltBG/9gvDjDMa5jXPLS8Jl
         6XOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcEqFLavKyaTuDubH2femlSgADHQ166UjaD7goW/I08eBkLWIA1XI6rr8FflruTpeRyzEQaAy2zsDegKkun6nimOO5gHbcpk8RshZl4IcG4QsFjl9yi7sn7XOmgOxEwdRbjoIZ
X-Gm-Message-State: AOJu0Yz9f1pbV3hH4Za8W7HXKRhcDvWOvdQdD6Nse0zr+xv0rQ9gJ94T
	6jk+nCYNE/1c3VkYzXN4wGhraRBVulbBgUvHnqPZulny9r0eKvQpEvNHfQ==
X-Google-Smtp-Source: AGHT+IGWbE9/Lv1hgrChzLrTS1+FSO3IGgIpwHA3XWmcPnMqO2SvNyb5132iSQqtT1xL/ONfqI7NlQ==
X-Received: by 2002:a05:6a00:10d5:b0:70d:2368:d8b7 with SMTP id d2e1a72fcca58-7126711863emr268087b3a.13.1723568414784;
        Tue, 13 Aug 2024 10:00:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e58ae59esm5987898b3a.74.2024.08.13.10.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:00:13 -0700 (PDT)
Message-ID: <8a34ab5c-00ce-4adf-86b1-e55ec2342b94@gmail.com>
Date: Tue, 13 Aug 2024 10:00:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/149] 6.1.105-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240813061957.925312455@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240813061957.925312455@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 23:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.105 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Aug 2024 06:19:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.105-rc2.gz
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


