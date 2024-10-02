Return-Path: <stable+bounces-80610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14098E772
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 01:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FFB286AE4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC814B972;
	Wed,  2 Oct 2024 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apyUOVuO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63271991BD
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913425; cv=none; b=pPL0UTCwBm9IAWnd/8UaC31YZG7OqoWE4WSLErkDkl5kybBsfh1LUjKn5S+LonUBL89OC+Rz3I3RKHQlCsFyOohaWstSNSpoGrqBrGTiAX+Wxy6SYQn+l349Jl9afMUKmllaK2CADvNdt5J/gem8DV997yCVZSQLgMholtRdBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913425; c=relaxed/simple;
	bh=YSX9f0KPIXq8iPsOQ9VblraJvhf1rUMHCzbKCRGyTjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEXyN/8K7KkpbEio1Uaga8QbqOw6zUlLjCNDUit8vK8FsUNRenTCRWYvr8xF8Bfoaw71kV0qLVgkr488fKav/sWgIs2k/tf4VQRg6aIJIScsmNapdIjgts4OrFEuoX89Wk3eaKBPTLMiIUtkouUaXFsmTIDMuWp++DJBkqeeQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=apyUOVuO; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-834d3363a10so17771739f.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727913423; x=1728518223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSyZMGPQXKBkz4kZ0qmjNo27H4oSupPDSi35nl9XIMI=;
        b=apyUOVuO2jm+A+MBhFeaxZICsWiSYmeCKa7H2LgKm8voyDtZiKgtTzCVyq4F0WYfZx
         V5ZwSqZYvFx8i6Fi4fNwduiyLdJrmROT2tNTiYediAKMim/PTXho/9jTEYCV/VmFpjjl
         /5xvO1S8H8GwWLP8uhNSmuyOmor2rf0cSj1Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727913423; x=1728518223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSyZMGPQXKBkz4kZ0qmjNo27H4oSupPDSi35nl9XIMI=;
        b=pQ5lqqaUt8R89xFDYb0h95QEmJJc/aHgbjCLIb4q9QTpRqm9zskFMcTC/TO22mnW0Y
         2yxTfeoAlKVNJXdanZdeYJGYoz0nx05vYWYMG5WT1DROxrWwj+2Jmydhq3m4yJWj4pcJ
         TZ/MmsuX5v6VCXInwobGUibHKEouIdu6TuVG+E4WOozVnwQ8u5w3yzu6Inn6EVZ+eCMl
         fun1o6Mrc7R3r50TI5XVEXPrHybF1d4R6yzmg7nGgcO9opnyeTBchQOSUAr4m2q66OUY
         3nVkh0gld5wUksYmPbPVOhyCK/+g2P32PIhzQwDjzp4pVzxS8/fongYD+sBTjaFR26kt
         858g==
X-Forwarded-Encrypted: i=1; AJvYcCX4PLLUplHfyuCWDhp8O3qKx+zI7s7MAy8SsOK8/tjgQ7x3Iw8pdfQDXuvgbULx0ilbdVbbD4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMjdA7v2XntuQX/TV/k8lDbeyvpEy8+q1AbopP6QOt7u1OQTr
	V09eXUwD0K1KY4oESbYEuFUdeXCzuiN9aiY0OsPjMfMidMTUc473ujbfJSiZ/sU=
X-Google-Smtp-Source: AGHT+IHh9kR0yfoxmhoMxEgAl2XLNnn0nCCHbNVux1JmoYXp/yKiayDABF92tCcXiqy+TMLK3eBsiQ==
X-Received: by 2002:a05:6602:6c01:b0:82a:3588:994b with SMTP id ca18e2360f4ac-834d84d0b75mr559838439f.15.1727913422764;
        Wed, 02 Oct 2024 16:57:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe38883sm1197839f.52.2024.10.02.16.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 16:57:02 -0700 (PDT)
Message-ID: <e500ad8b-07d6-413e-8fc6-2a9afd5593de@linuxfoundation.org>
Date: Wed, 2 Oct 2024 17:57:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/538] 6.6.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 06:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 538 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compile failed on my system.

libbpf.c: In function ‘bpf_object__create_map’:
libbpf.c:5215:50: error: ‘BPF_F_VTYPE_BTF_OBJ_FD’ undeclared (first use in this function)
  5215 |                         create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
       |                                                  ^~~~~~~~~~~~~~~~~~~~~~
libbpf.c:5215:50: note: each undeclared identifier is reported only once for each function it appears in

I think this is the commit. I am going to drop this and see
if it compiles.

> Martin KaFai Lau <martin.lau@kernel.org>
>      libbpf: Ensure undefined bpf_attr field stays 0
> 

thanks,
-- Shuah


