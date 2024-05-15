Return-Path: <stable+bounces-45223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF38C6C84
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDB41C209F2
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D46159568;
	Wed, 15 May 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Mlxkhx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D5159571;
	Wed, 15 May 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799426; cv=none; b=H+Qu2ZlzN9pSoqa5jB5HMMQpxg42e2PGvuYwxQNmo1JOEjaP04BVe+AV2l2zEQV0Y1/fehn6ckHbmZ8yxcPSoXA345gqH+SZuKquVHjMay+9IuVFDTMUXJzPeDVjaRlB1ts/xdUKLM2QCuQxYj5dQbH2vGs+l/vwXc4GXt24E1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799426; c=relaxed/simple;
	bh=U6QNWqrHaDjx5k/0VVV+rAKJx1AodK3L6iYTiYAq/8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzVlUyjWxumSadXkDZcSwzHY2D+llaELNonN1CDoPSGfFg0b2suRuzX00M/hWFgnTEdYMPiHLpqXPrTbBEmvuy98JV+9F1ZC5QxOn1QBwtY80wdu9AMyvB+tLNKLAQsNu6TZwSGkkbJyBiBMf3pgEV+XzSDwl9o1gNT43LErz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7Mlxkhx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso105361b3a.0;
        Wed, 15 May 2024 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715799424; x=1716404224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGfD3BKBPRGgjG+X0s3W41syNi/RDQiIO3WMxL7HGtM=;
        b=H7MlxkhxQH1lCMxACB3hFTaTdsZdzH1Sj/UZ6VSiBxHqQdQsXDWbTnFIlWbonf2niM
         NF74PVe3cW3r+xcaeGiBSXpae/g4rqhmpXM9FT/kmTao1Qu3QLAlsI/i6zl0neIIXVNd
         yITtpfHHcWv6/w9eRiBPVcaPCUMrXqcswj6gsxJg2uhYi36d9dWmukuqz4K6hgl+TyJD
         eUUwTKu6c3WaQGM6j63AkChyyNcg7qK+3U853+bUuO3aQDRTTu4lvgd3XfUxxsOiAsEA
         64ntBeLjvhUoSDD90245X8Z8S2xzfGsMjFFDXhwM5ZiNlCu2wtqcfENxNOsN4nbByIu4
         cM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715799424; x=1716404224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGfD3BKBPRGgjG+X0s3W41syNi/RDQiIO3WMxL7HGtM=;
        b=WFj2zi5v92CqvL5N7Aqn5Z5pvGPy1Q1cfdhCwhU5sHYJwXua/bvBdpIsFuDq9iDDUf
         d2+h/4xYuz3V/2WL0hzJoVi3gmHcICjiov7HEVepHlYIZX4Xa1Yh2vzeZmnIgSqoUd4j
         A7QwEh5cOBiBd8xZ93IyCfTYTN8LPqghLBrlkj+S90Fg6uneCvuphZtY+dVXrX00phUO
         uphfYq8X97lKciuJco1wfE0w99Zh85ZTt4tVXQb7eCqFaZJnqhGNnxpTc24LAkyj1EfL
         PmLYipQsozSvBg9p0Z4P6POvLv3Cg1uYohgG7RywchF6XbOL/TIMZD3HFZlb4KYiF9ZE
         aWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAWMHmlLe0tbWh97UhzSiqlVbDtGkc+e9pOimwHOEn7TWHuVjnY8XlpzW0F2h9RgNOPxDxIPUQrACg1sAKp+qj03k5Fx7hZrzC9YquSug4fVADZYr/pXB3qk6Rp1+qdtqsW8rq
X-Gm-Message-State: AOJu0YyUPlLz2on5jwKkXYFcyYK7axDEhXS39F1TOWPNc7qV1/MReyse
	YNKjt9MTJdhWRzTODOyyrkx650wGsjUPxk38q3gjA0bK2AjSB6Y9
X-Google-Smtp-Source: AGHT+IHlzmXACKbJQgWGMcU3gDFefSiM/uoRJ8YLQfxc5H61GBO1gLglVc82KjByrMxWoXQutd87UA==
X-Received: by 2002:a05:6a21:788e:b0:1af:a5b1:290a with SMTP id adf61e73a8af0-1afde0a994amr19114043637.13.1715799424354;
        Wed, 15 May 2024 11:57:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-65913e309a3sm48260a12.32.2024.05.15.11.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 11:57:03 -0700 (PDT)
Message-ID: <2cdf39bd-c4a0-48f6-9337-73a00f765c82@gmail.com>
Date: Wed, 15 May 2024 11:57:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082345.213796290@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 01:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.1-rc1.gz
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


