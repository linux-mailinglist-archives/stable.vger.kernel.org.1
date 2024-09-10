Return-Path: <stable+bounces-75772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B713C974650
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 01:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FE51C255B3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769081AC43D;
	Tue, 10 Sep 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9C5SE9g"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA117E8EA
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010458; cv=none; b=B4kkccnr9LpEAQ1TIWdFRsOfI+q5BDCXwzsGtnQO5Emz6xOuFl/opIXh32Y6kSqQDwJUf44hrIONjyFtjZo+QLvkQcjPBdH8OwrhTW/t2kWPxev9rjHKvEw+m+Zsefot3xRvpqWsykqmMbaY++98TAk43aDWTK7snTjv8ptxZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010458; c=relaxed/simple;
	bh=U4EAbY9M58DyLBeT3V4uWlg+wEurSR1JCXjx/kPTLJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHBRGwBs9pnbTZ5XAYssgOXr3AZlTCb0Z4QWl5yguREb1VrwUGp1rf4Gg6YwIFAydVFC08AAm6KKNj97Pfe4WjxSiLJzJUqKMJeQc3Yjbcf6GcxpsziJzcfaK5Uh1nnbGCNxJuxJBLD2uJ7ANiT2PFHsKoMjVpUVqX9r/PR2ZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9C5SE9g; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aac438539so182370839f.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726010455; x=1726615255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP+F6KQXB41yOMLPUcFAdK1CUArMESt6YLkIllFzb3s=;
        b=I9C5SE9gsGlmT50I6mPMlObeq+7asPc0Yh2uwjB3lzDPoi2EBzX/aj3kqTzaBxxka+
         ftN/saHeT+Bo9y4bWKUxEEA3tfnI4W5paPFgOc/lkALV+nG+EclhMdrFQVz+R3abjRA9
         QoetKqSMEpuEY3n0EInGTlmtdOzyyEKo0Ugv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010455; x=1726615255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP+F6KQXB41yOMLPUcFAdK1CUArMESt6YLkIllFzb3s=;
        b=iptvxFj+G/IXW8cucel+QLJR52KlUiNSyqqfbbCBGqfrBdX7kbqBRyB52O22kdezfC
         FPKM/zqS29+RazCIBHD60zLMHQ3M4fHvPNdn76RZAOZR58BOijK8iyu1qJ5nyY9w5FBD
         ByMeTrsUhFTU9SgZxHwTEZOXPKrUlDYVU5MSHKEJNCTbRIQX8ytNbsHW6PEbiuBTZ86a
         DCSYGxb4YM8Qihqj9Fr880YAV/f4GYHL8ynLHjbyBcgsmGuPy/dOJwkAN2hh3ZrESOGR
         UbaqH/txXkSPvLfWtWGSLqT6/FpCQouVLvndYiefb4vjZ8WEEuvFdVRAwbGO6xblgVHH
         07+A==
X-Forwarded-Encrypted: i=1; AJvYcCUV0iI97CVHBS9SxSRx652iv2VY3LfoQ7TE+LthhU0nULmKU2hS6UiMh2kAYc4+r8cHS+lhGFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIpcfu78mHvSlZmfEoTP41EzK7g+32zwZdEBo5Yynqd33F5cd
	K0DupihAMH4LXVur/27YNoz+Yna7LIhMxGF/DDf3HxNDbdsrcz30wy8hlVeC9Gs=
X-Google-Smtp-Source: AGHT+IGc1C+Rskz8tPoGBdLeCU3gP07CCcQMmJVw6yyFBK3nzwjbHotz3iB3nLtNKvPCfRADwwHUfA==
X-Received: by 2002:a92:ca4c:0:b0:39b:2133:8ed4 with SMTP id e9e14a558f8ab-3a04f0aa8e8mr189561925ab.14.1726010455190;
        Tue, 10 Sep 2024 16:20:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe55d8sm22621145ab.45.2024.09.10.16.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:20:54 -0700 (PDT)
Message-ID: <48690583-7fe9-4edf-860f-7372983924b8@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:20:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/269] 6.6.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.51 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.51-rc1.gz
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

