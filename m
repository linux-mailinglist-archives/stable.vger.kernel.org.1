Return-Path: <stable+bounces-75770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A9974635
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 01:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF951C250EC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9261AB538;
	Tue, 10 Sep 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LG4ThvWQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32F1A3BAF
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009392; cv=none; b=eI1G0UC8z2l1pSw1x0pobeOajDJC6QqKfdGoRwNnlxJGoDnqC/WvqaDDRFH/qcoeor64dOorRmHtJqKe+oySKAdw2quxK3ffbDQDARa/4O1mp0pugkPszpxKUD78griK1fiKtw0wKyjFUlQSVkeU3Hha6q14uUANb0s0s6JDcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009392; c=relaxed/simple;
	bh=01XXCU8JIt+/LolNj9F9a66tCdxaL1YDcBc+c1mPPQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdneB3IL6GNv5Tk3eYDwJ93FHR1qsN+B2+DeG3RUv2M61s9cCmyJ0ig7O9FxX+LFvCox6I5/6LLa2JGxEmEdh1V+/fNfEWhwVNXClXb/+DjUrbb/kxXup6NalqCA2FcHT+wG+TtyNbvOX0igR/gNfaQCo8262cLjxJibe1U+JKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LG4ThvWQ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so130308839f.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726009389; x=1726614189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Our0i5FAN8M9eyBuwGhZmOhmd7tZTzv8n7Ma5HUwtUY=;
        b=LG4ThvWQNQYY/X9wrtutguloE+S1nRz9okNIEg7MTk6b2Dp1F9Nf0PNP5Jhl8Ai3Z6
         6j4nKn1MYVUBgfqM2GJhmcvkWgoqp8J4uBBO0UsR2EDHaLQQ02oLHCFlZ1nNf7TWOQfU
         9UFkd57/PRFSOVBHdTcv7/BxMbFdJJSVAZgHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726009389; x=1726614189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Our0i5FAN8M9eyBuwGhZmOhmd7tZTzv8n7Ma5HUwtUY=;
        b=N6962EunRo/ueGAw7cnjIzv3dRNwbFkOpjoqnHO2vb4E75Iho/uyNvxYDoDShYQEMd
         3jOOFscIaIN1edZSf11wjP76cuCWfFXjLe31NWcstRRjr95cRQkmsvZTi2SDk2olULu7
         wABWdJrKl/ai92gZE2toW6VwDmDwV//XOCApLNpeOtv1gIwdcVL2rbfuyx458V3Flpmw
         Ei9sosCgx6qQnzQ4Jl3v4FKkh/qYrBS+OQqmF8T5kK/gJs4jgsHQRiKXxRj51sp/EW/b
         gy3zEIouz1z6fevK2B+w8rwKuP1YoeZ7WeFjXQy2Gp0Kf6/b9JpwvBuyczXiKj/0lid6
         pjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJkjSCSJwZVqkYEph4vD+AxPjeVkCJL2ICqgTbBsGsN2U/C0Iww9RXqtcpWncv1/ZYq4hsTpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFJ2RVTyYHj9Edo6EgCO35xu/njA54QFvKxKic43rjBIWgQQR
	TX7WlhNCAP6cD7Il+2PwJnTEW2vC634VYNXsj1EkNj02VJZVgAvUJpWbm19PeaY=
X-Google-Smtp-Source: AGHT+IHTzytd/BXjhulGOFJeDN5N2Y/iSixDSXEeNyCm+5M2O3H39PajIp3Y22RsVR4SC9HtjYRdKQ==
X-Received: by 2002:a05:6602:2dc8:b0:82c:ef21:91de with SMTP id ca18e2360f4ac-82cef219385mr890886539f.14.1726009389357;
        Tue, 10 Sep 2024 16:03:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa7385633sm228261539f.33.2024.09.10.16.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:03:07 -0700 (PDT)
Message-ID: <f2b4e304-2a9a-46ee-a56f-c7669bb891af@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:03:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/96] 4.19.322-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.322 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.322-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Build failed with on AMD Ryzen 7 4700G with Radeon Graphics

   CC [M]  drivers/gpu/drm/amd/amdgpu/ci_smc.o
net/bridge/br_fdb.c: In function ‘fdb_create’:
net/bridge/br_fdb.c:515:20: error: ‘struct net_bridge_fdb_entry’ has no member n
amed ‘is_sticky’
   515 |                 fdb->is_sticky = 0;
       |                    ^~
make[2]: *** [scripts/Makefile.build:303: net/bridge/br_fdb.o] Error 1
make[1]: *** [scripts/Makefile.build:544: net/bridge] Error 2
make: *** [Makefile:1086: net] Error 2

Possible problem commit:

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
     net: bridge: add support for sticky fdb entries

thanks,
-- Shuah

