Return-Path: <stable+bounces-64806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60938943769
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD21B21A43
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF016087B;
	Wed, 31 Jul 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHvTh1Ip"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F645027;
	Wed, 31 Jul 2024 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459129; cv=none; b=C09WqtqDdb+R9hiEre8PmpTIqIPA0rBbHh061Od/L/UtqqA4JICtB3B95DSzx1XrRukW1dWy3GTCB6wCYqZIcLiY/20MiDl5AoTzNHdoDm1HfEF/GwM1QTsyL6hd8qSMntnav+bpyKkJrNYdftfxrQXeNrQrA5hL69P54XrDTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459129; c=relaxed/simple;
	bh=A3gD26s2NXmBTV7HKjEy2yFxyKX1FyIBM/cldbA5FmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIQaTZtn/2Sx5s1kS9vpfL2tsZA+eLapoZAqea8sZRy58ziYzQrCrhs5EV6s/05Qd9yNOsIc3yRW/RrnQCyqlpoXZ9L4GGJBA2FEi+eyVFw6La6qH+wtamRCI56Q6CQN69dre/cpwGFxhNCSP6LTuznWMMbnGGsfQrqRpY5nG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHvTh1Ip; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so4679492a12.0;
        Wed, 31 Jul 2024 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459127; x=1723063927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6QQny8V99NEEFnUaCvV6kdfdKgC29wv2xf+A0AoKFo=;
        b=ZHvTh1IpvYpgZJSmCkgNIIFgFRqECoAXR+NzzFK25Xs2kRy4M7Bp6BLFR2fe36QSdn
         /gfAlPCKOAHpM9gah7LNTuy7SEhWTujgQpqL888LIIT6GCsLTq/8rYKfG8BX1myxV5Su
         XkTeEB4VvOPLw3AbD246a9h7jEJsDpLtP1eS/TsrNtxFcmUw6T/k2Rc5hdYGepmBklQd
         IpZEbdmc3rj4ASThMeW3Hgs0XNgeRYwT307yAArPD/AEZd8qLsMGUuckYN790iqepSCE
         aC1ETbefOR1QTIYe7y0ufyqS5C9ubWdpTSuYXaiL/fDo4kFJQlcQjM8YH6P4+Ow1vnkM
         BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459127; x=1723063927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6QQny8V99NEEFnUaCvV6kdfdKgC29wv2xf+A0AoKFo=;
        b=siTChWnecfpqDZcrS0Eyza3lv1WtPdmYwvgDYzmQeOXdj3JR+xfo1926nL1l4gQJGL
         gCEXkC2VKP6L/SOUy1bC5rxoAP2TskVfVNPDwhfG2jgRnP7d3XliZGkfU/jZDwfyKkMg
         nS062QoQJimYMTN6dcqUKKOa4o/B+weAdy3ou0TdLN/ZA+os/CDnfdyR6fZbleRd+DVE
         cYRhctuJ22HzUwZhpHkpCAePVWcw2DSdg7I/LbAXrVl0ubc3Y3ks4qozaED1LMB92AG2
         VEiiNjPq35c2zvM8IawK6dQ3vN8buFByP7dVvrqfUkurcdN4vzLbRrJXS2e5XbMQsmV8
         eyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3R6z9UdfObclnvPnWH9WeYOySAAHW9qeTjVNh8ZFghq24dZm00bWlFBKotJkYT3eYGARGw17xW33yaLrEZ4DDeE1xUwVZz57mWL6cJ/BlQ9pTYyBeeNpDydYt4h/GvGxd+laa
X-Gm-Message-State: AOJu0YzYoPy6Bjhsgpt7uHi/GggfARfuSgUhmXPF2mTafL/mG2Cx8pVy
	L9DshbQW8mBYgQJdo/I/IyaF4FbNnB1lYyAaac7ETmz5JV2IeCZQ
X-Google-Smtp-Source: AGHT+IF/AdlMshgvwClMC4XzkNwAlcVLrF+f40BgcsD7rL87BunoA/t/Zf5eqnC1uXAmRDYXBgqaOA==
X-Received: by 2002:a05:6a20:72ab:b0:1be:c6f8:c530 with SMTP id adf61e73a8af0-1c68cf2cefemr933547637.26.1722459127285;
        Wed, 31 Jul 2024 13:52:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70ead8a3a91sm10373946b3a.195.2024.07.31.13.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:52:06 -0700 (PDT)
Message-ID: <e2cc38ce-62fd-43d0-87f8-74002c90ef41@gmail.com>
Date: Wed, 31 Jul 2024 13:52:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240731100057.990016666@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 03:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:59:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc3.gz
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


