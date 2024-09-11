Return-Path: <stable+bounces-75892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53F975962
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DF5B22D69
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084371B4C41;
	Wed, 11 Sep 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ri/3t8sM"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00A1B3F3D
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075709; cv=none; b=AZGtnhbHz03Mgpiop4zlxPak3NhD1Tn2fjQRNvy3CcPDyvYIDRGv5fHPJvpVV5Ihvks8n67hR27Z7zxXJmCRVln1HNcX3rSW8tDRf+HtuLRHzDkko0HWoJDG89dDFzRbFo12N7e4fA2/rKfnH/tdYyz1saMgUOBQykG2VsH8epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075709; c=relaxed/simple;
	bh=I2lSwbBoSxfLWPHBpEDCm+PIm25NtmqYiCU6qJVvrVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4MikNLwf2D8nv3UN23N9vzHoCrqQakWP7IjIw7oQASVO1p6fs7Tep18y++zD6HWfVR/b+lOn974oT+tIFTFdKN2k8hE9sv1F1lmmCwC7na6S33j4RuYPgLIWx75QUT+N3wLjV1Y+9AuNFuWHTYxAZYGjXPb+boRybb2cXKXlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ri/3t8sM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82aa3f65864so1679739f.2
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075707; x=1726680507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9xFRDO32s5hrf0vuo1g4X5zViAPdgBVeN7fh3GcQd0=;
        b=Ri/3t8sM8OVfiVkx5O9O8GCQTzgo0WtR6klF0FKpWTc1NnsmkR3aMWvAegolQGub2d
         DwiXM2LcJSYhHHWvMZBSKc4fwobfXn2nxFkZNxcL25Bm1WWE0hxp+Q0C/the/s/o3Zp8
         tWYlOPt+ZzKmWxCKWJusRDJVP1KrierPmsy2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075707; x=1726680507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9xFRDO32s5hrf0vuo1g4X5zViAPdgBVeN7fh3GcQd0=;
        b=RPQgG5dI5dsNTKxjgdC2IH+kSL3jLRqHRxEItm6oHXVjcltyliNcEpMTQavp8Xxej5
         9G/jUv9YrOix7Sa4q7KBotIE5If+HtNntfA/mLUMtOBg+XT5s/JFGtdv2ouO1PTyIJik
         LkxJkKXhkK1fqtSzeAitXAPx6vXQszl//43ziNXY5Yxi8FXXQhP2iFWfVMsAtmeVetUI
         ImjCwG6SBRosfEJcTDGp7xg8h3ZYDZS7Tlh7FfPsxJqz6zDpnGu5IQcwoKvH5JlMCGPa
         3VL3PXMDALsyXKxULaARk65SAGKW8SFYARevZQAWhXPrw26ZLcqYFTtpVR+6xXY9Lk2k
         tNAw==
X-Forwarded-Encrypted: i=1; AJvYcCXqKmElOB++Wetz3ZmEB93Jwo5qJCDZL525ipLgJm6f0JufvH2G1f7AoSMVwbzZjmy16zcQSMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoABUHRWEJTasCEcmqgMBWHA7SxQkts4OL9hSWQGysH5YHR6SN
	//uXaNNwSoSQkTu5kMI5gJENbF1mUici7I4ZDuureCuUNp3iQPw460S7EEvg+Ok=
X-Google-Smtp-Source: AGHT+IEAyEGZhgRzi2A13WFyJTv9dc9wjNfkWHIOb+ncIxw/rl9qf+hd2RNXS1chcDosl0OSXhY3Jw==
X-Received: by 2002:a05:6602:13c7:b0:82c:d67d:aa91 with SMTP id ca18e2360f4ac-82d1f8a7fa9mr43556839f.1.1726075707421;
        Wed, 11 Sep 2024 10:28:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f43445esm96620173.11.2024.09.11.10.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:28:27 -0700 (PDT)
Message-ID: <7ca4ccea-9bbe-456d-b7f7-692df98c6c73@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:28:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/95] 4.19.322-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910094253.246228054@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910094253.246228054@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.322 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:42:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.322-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

