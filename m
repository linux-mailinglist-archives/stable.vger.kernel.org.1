Return-Path: <stable+bounces-183377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C6BB9063
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 953B24E4E95
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA9281371;
	Sat,  4 Oct 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OXU9/8IJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562927FB05
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759597032; cv=none; b=CASez4UcUtBpmqEYpPF7EBOvzImBf203XzW+UP49HBcmP3Ap8WPkvwjcQaUUMpLqxd0dRhn6T0NGXaAHSVZaNLWfiaN4FzPnfwMDyi2zw8AeA4JUyL9EISr09SvEZALPLHQ1GDj+mOTX2/HqqqTUkTDN4XqMdS5xJz33UOyhtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759597032; c=relaxed/simple;
	bh=+UohY9HqNpMBf+gQ74FwUWrvvqUMkiginVNAaAKBJFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDPAvVUkqyktIFe5/Bqzpq4b8FjNvmZnYJvyLxuJjPz8lBNW6KnXV4Qm9nzQHdL0rtN0yPVWIWu6VZiaPyP370xSPBM64lzIdRkmJB6YeA/rgnFHVzH8P/wPoBAP4GP8IFLiPJVoMoQq0HzJ9Os7cgKG++UyzhXJ7LZx/InwcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OXU9/8IJ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso309893239f.3
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759597030; x=1760201830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1mMWuCz0t3r8/HFzzxA4DdadxyuLy3zuMlmevG8qBs=;
        b=OXU9/8IJYBw7XEtLbQTYR8QZ2eJXHvlUVlvK0JMjtArDfls214+PCp+AwK49zqXdO/
         cYxpPF/MuLYUCEeSz8KSowW3ay8+ho0W3s9zp3SdB5DGsXgU1CQWSRSJg0nyIlHFEaIU
         hlU8kUNO8FDF1OUTfrFxOwacdS19LCwaeE12s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759597030; x=1760201830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1mMWuCz0t3r8/HFzzxA4DdadxyuLy3zuMlmevG8qBs=;
        b=jbVPAzXba+h0NqJ3OGqBjn/Wv+B0s1uFcfcpEGDROzRyJ+l1raboJXPNzxxLeUeqKY
         gvn6m/+IedCTyqlsB1EIqsRJiNQvR6HvoZaxkQ9Ojk/6Wu0l+d2pBBnqWDxoby9aF3JP
         avRh2Je+hcO4GGYAYK3JBZQaUk5cr2Wnfa2YK3Q1h61SWL22epuY/jcz9SXfe+yUQgSR
         nilZunRSmIKiNfjWJQX2RUB0bKf3BIjSf+qCNXVGRDf5cSvYz9Y71G9NNgl2ROCq71RQ
         RvE2vuQGWdw+/lCJACpcuW0+QXiAUHKYdwJCrnSVxSsdsEEyxbj7dp/0rP4WBDer5BVc
         /1PA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/7PUTECdVFKsWCbz4cEd4kuB6IAZ3cGysV9FcD22aBo1T624HNSGTzP78tvn9/8gsuBxUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxsfhFxbKA/fYq7kjCPiY+vZt57oxpW45Y8I5c5ABZXr63x6P
	XsmuJiJgrEPpLTaWngv+uQQr8SIpgzVCnS9poLwV/ZRap6XujKFjmjih9LN7XyaIxkY=
X-Gm-Gg: ASbGncugS5gc6Dggbm3s4Xkm9tJrm9L1o0r6jJmCM36VKZoegNFrhyKl4vuWqzXIMbt
	te+XBuaMyf/ygHpf7ZOMl9X6dun++cGPpsRvUBk0HD7iT2nqhuk1N7WDx2Gqu/48cRX0KA7iWhL
	QTz3uLaMzc7E1pxeCiSjS4cbVEGsI2S04TemyGxh3pqGtuV3O96zfXwbuRsHxvgpnNtA89Kq1Cj
	K2MA7CyP7S2/NiIuOFhunvWRl4bmzGY3FHgVzG0D/Gg+KbBG6K2gnpHhwcsTKEaiCggVnLJoDp5
	mUatoeLiB46yRqzr1f1DHpZmihHx7n8/MnQm5VhX3fATTOd7FwaB7GaPqMAFkEZO0GZ5zV25QPd
	tIF9YzDkT5TD0J36kOwJQIB32w2J3s2eBZ+eOAahetWsBYbkawiIfANc8LoE=
X-Google-Smtp-Source: AGHT+IHef8taA+Z8P8AtiePPCV7SM1tDyeVyNmWwQlrFm7/YcjguSwVAX+OofP7dxS87Htom2Ta7NA==
X-Received: by 2002:a05:6602:6215:b0:887:26b5:a581 with SMTP id ca18e2360f4ac-93b96a5d491mr841505339f.12.1759597029719;
        Sat, 04 Oct 2025 09:57:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea7f82asm2964305173.33.2025.10.04.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:57:09 -0700 (PDT)
Message-ID: <052bd9ce-fb5a-49e7-a670-a75613ad0488@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:57:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160338.463688162@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

