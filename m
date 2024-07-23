Return-Path: <stable+bounces-61214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E077A93A842
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79573B22937
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF5143758;
	Tue, 23 Jul 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glL3xSfy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE813C9CB;
	Tue, 23 Jul 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767494; cv=none; b=tW4/Hpp38dJtw6hWWQ5sOxU7zOKqBhCjBs6xKJrIoAHtAsnji8nOlIMFAjFRAsn76kySY2JjKXLQ/UtNfFE1N2EXOQi77X/zExNSWf5Icxwy6wDiJenZ79zRgduaXEBp/zPAfH1s2xncuJiFI/HngmWObyqHw0X1LEePXJfyU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767494; c=relaxed/simple;
	bh=5eGxl2dz4vagX8F8KIWwj901p3USwXNj6Oe/yHWUyE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1w4y7nbyEeiaOg7rzikg9W63U630lfQzHKTuLcDuSmLc7KjzjNeBn7BM4m3Y3qTtZkePgY+3dfv4zNJ22yNucd87sA0gWjL2RlXx53LkxgmhPzpZxdTrxJCZPGj8TFUPVpy4K6M/N8KthH6+scee6xUfOt2a5trE4jYF9ke0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glL3xSfy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2176866b3a.0;
        Tue, 23 Jul 2024 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721767492; x=1722372292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47bKS4H+6Sl2dCqP9QIWi+FcafRquOMBAIrVbdQQ23Q=;
        b=glL3xSfyd+NcJeqsnP0e7JmXXXzQq1qH4QRb2TGIREL1JW+riJ0lTOGyNs1Ntai5B+
         DlHWFHUlr28KfM8gTBRtVRTDpJsnGDHQ59g3bMPlAZiU14tKjmX6fhebBPiCLDkQEMO5
         0r9lLGaubXFXoWtWFPmtCEHN00v+SxTL2epvFNEcYJ0ddeh9RGomNuDyQllzIPr17yCE
         qmiWbwaoiMSu1hY8fp/eLu751iLDuHQPG9jm9DOiT3xUEb6fFMmIQJ/MPdDm93l1cdvH
         OUxPaBHdVQ4YI2RnShI4pWkNQ/oEZhRfy64FolVNrdUwXOvf2qKHfRVPKPBclQNPQybm
         4SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721767492; x=1722372292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47bKS4H+6Sl2dCqP9QIWi+FcafRquOMBAIrVbdQQ23Q=;
        b=PpmdyE8mWG7LdkjIOwG3H81fiJvl7j2jrPYOm+HH8Ga200XlFpiRLzEQmEE9uJka+z
         O7E/lfoYNJuoPQQCp+EGVeYBrBG4DU73SQqq/N0a4A2pK9k9gx41eykVxVLTpq9H5qsM
         OGGNdFV493CJngbxRVYSB6GIydHNFtja534tTcWRlJ/oWwwRxP/RBhE0zJNC4YecwgKP
         +xJA8RTu9Lwp6k9zK6Ts+QFig5gjwS4DZptRZBJTznBpz6gURssit19ZChQfhi0i1x9m
         eUm5/BbKfNz5j8yZXKRjv/h/piqObMeFVkNFHn+FMz0/GKEkmtrzijYcgfY7ld5HbjEX
         G7gA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+T4u512s3AqAb2KAQ53ErJZ0UQ5gKNefYUer1dnbnLPdrgnJ3c2BbJ4y9t+RTPlkjJnXTPlRhr9Uh4oaMZPTwqko1qfOS22nFoGZs6bsgiQK0Q/7jK0iWA8tKOTRSYAtZnSa
X-Gm-Message-State: AOJu0Yx1GmxtvicQ4ZXcF3q76zNzTALuULF/zRUegbfq/DLCXgytx9xO
	hZUkjTlVSEEZpdILAeInQ8l4zOG65h1ChpDP+owZwJMkxSaNl7sC
X-Google-Smtp-Source: AGHT+IHIJ455lRhRF3pWGaiD6x9nAZcg8iqAXoATWKTb2IYqoh9OGgkLZ1hnZEjpooDN2H3LP4qGnQ==
X-Received: by 2002:a05:6a00:2da2:b0:70c:f1fa:d7a3 with SMTP id d2e1a72fcca58-70e9968fb9dmr1185952b3a.12.1721767492105;
        Tue, 23 Jul 2024 13:44:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70d241803fdsm4228166b3a.220.2024.07.23.13.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 13:44:51 -0700 (PDT)
Message-ID: <6b6244e7-6592-4611-a3d1-67ac30dc24b8@gmail.com>
Date: Tue, 23 Jul 2024 13:44:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180402.490567226@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.101-rc1.gz
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


