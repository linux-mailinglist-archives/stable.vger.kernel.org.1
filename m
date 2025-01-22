Return-Path: <stable+bounces-110215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C594EA1981B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4D11884EEE
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D3214813;
	Wed, 22 Jan 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhGRM1kI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24D2147F0;
	Wed, 22 Jan 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568521; cv=none; b=n1OavIU7EbCOp2yhkymV6qOswg6kgoSvmm8nDEkKVhPu7GYB7vhR5cG0sepHr+eS3sNN47Qrpf7AibN3etRXB0YIYhuLaYnoTdV6rDgVdfADy3lt9qrkVJ7xupLUsCWC0FXmysxPlpPPud6RBqv6GNnp6b+3wewltHbWk7oQgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568521; c=relaxed/simple;
	bh=FiKvQhWWcgzjNg2WfDfPY2XGbpoyGRFUq5zQ8wcvRMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCUNFSKELfy02/1MrHEU7KDvUGRWx15K+5jVVAJ8RNoxtiuJCfQUVxlLKPuGi7Rzdh+b1MRMAspCKPISZUwvAhmVNSPEtizWjOJXUADPLi0L1JJYvRYeTcVvvnrZtt0mMMSNPefW5BNaMmvshQFYYIrGkKgGlxgNJSVX2I+yxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhGRM1kI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21680814d42so118441795ad.2;
        Wed, 22 Jan 2025 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737568519; x=1738173319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAmirg1CIyb5YzEX1B8dmfqHpOOsy++HekRqtBIlcI0=;
        b=HhGRM1kIhSycshttnV05lrHE+v4J3Aq23Qn+pJcG0gcCFxnXG2WGnHia/44CNkamwq
         A5ExZQ15ebh6XozL9EWh4zpy+F0cb714zdGeHAYBLLiIubGm/8lTuWckayajG/Lr0wNn
         JJK68pjZo72V55Lxu0zNXRJd/hYhDIKPh56T7+CrAP4phhklSA7U19fCwfGhOgYoky7A
         UdnE18dWfGPHM0b2iW6ubtrmd4HZl4UCjQ06vXfAOcz0NlwRsyYtQrzPe5JOWhudgWY7
         RrNVAHwGtF3uF2MTjz1ohJZFCNqqBK3vKR8W5oVK4Qx2E8BEAEeSdW/0hjtMRxtNlhJA
         uJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737568519; x=1738173319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAmirg1CIyb5YzEX1B8dmfqHpOOsy++HekRqtBIlcI0=;
        b=KTH5gi62fx601bZGQPCnKs+BvDYsej0QFS3SKL17ynn1B0pUi7SxljNcH8mhK7sV0+
         WpruFj3pd1qZGJDtL1su2t+E30mARTu23PmGeMfgnYDoMPudC/igYv+5O/ITC29NEf3m
         2jbvZg+M0HIrViz0ilHaJP9NgIsAZyGtLZ7mCmRFC/le74TeglrQgWuw9e1xk0Adqkpq
         0SbMbFgVTXjE5VqV+X9+m0N3Bdnn9ANvLyfzGT/5/djkF+F2scq0KU5NvrhycAEaJ22U
         ezTmtPILUmPtMZCjrfUdOubksb75jFS5krRVyfm8WCp5WahOFDE1y51lS/LXf+BucSeQ
         FaYA==
X-Forwarded-Encrypted: i=1; AJvYcCV6kHbGg//fGCprHyHtVcZbaKED21qaCIwEX78HFHYin/hFLNhflCfZ7OTKLR7U/LQYIucIYVNN@vger.kernel.org, AJvYcCWlWZpVLVmplm4tqDxKli864R9hpDuRUSvCHvq+rfbmNWbztTekwDLCeR5hBM0VYGwnENdUkARZrFnZetw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYXLvOw/zA9aUVz48YH/nPVS5hlVkjzVTHSi0QuFIrFpWQvKm
	H94nK30EVlrYRTHhtHk2DLEqZ37cPAPmygGZZEQTpM1lSYiT2DQd
X-Gm-Gg: ASbGncs3KcqQh0zQ4yR3QMehspQ33WCsGghErmn1DPRnpLm8vMlBQOMjPyyBP4Y+wcs
	sFhxmIMXAlLgSr2Lrcp++FNs/OcIlEm2VXO/8Ss26IENvRC0UtGbJig8T+YI83/r/92jWKDa1ht
	3rLa4D4HRl0/AZpf5fNiBtCN7mk4O9RPAgOp2fsodv7hINsc8Cbe8VBpR1qz4jFC3vCUawRmI+e
	5+tTcLaXjhLqfRpDy/TPI5adVRkkQEq4ZmfZXz05XL9KGoI/jzQZQp1T4hWEKacHdi983CjnLXr
	wGex3w+Gmn0QPfu5dXOd0y7OXeJH5Sdr
X-Google-Smtp-Source: AGHT+IEdGAGQ50OumXsr2JAd0xVZ1mHUrvK9F/0nSsdNgSw65VOA248e1RtT2fdqEeMcxlGB4NF9Dg==
X-Received: by 2002:a17:902:f54a:b0:21c:e19:5692 with SMTP id d9443c01a7336-21c355c43famr330708385ad.36.1737568518886;
        Wed, 22 Jan 2025 09:55:18 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9ee18sm98968985ad.52.2025.01.22.09.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 09:55:18 -0800 (PST)
Message-ID: <2e6d1073-2b31-4ab5-8ce9-050ec05f0c54@gmail.com>
Date: Wed, 22 Jan 2025 09:55:18 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122073830.779239943@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250122073830.779239943@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/22/2025 12:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2025 07:38:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


