Return-Path: <stable+bounces-45200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B938C6B20
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BF41C21F94
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921ED39FC5;
	Wed, 15 May 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1A8ljxX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261A39FE4;
	Wed, 15 May 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792318; cv=none; b=gk2e2JRPgi6iBj34gWOydl3dpCPyw9vOr5NQupaiFGojt2c9fGc6pByed3h40ozv/Kz0WcZYPVkZW+O+x3KQyhWZC1Iq09xmHs7v0MHwL2AZLoI+nc1ZNG0usrss7ZQ/kqL9W2KDoItjGHjCp1CqThNtVUPNCpVEAS/GZMF1SeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792318; c=relaxed/simple;
	bh=I2HA0q7hBT81SyHA7gzlxS6UcwHkri2jKlHX9ck6hy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNeLYUEi9h0HljbOZxPeGBbu7/O0mn90LZwNGiGf/Rj9lT3OCLyMSpDu3LLRpMWePvHnDA//4wQIBgcxJcVyLKBePCKYbOL79wo4iYTvBZvKd+06lKoUUDlyx59RwJQ9UlKSCB7bKB1JhXfPnh2YADHba6IPXgKYH8mnk5TDNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1A8ljxX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-620e30d8f37so5897627a12.2;
        Wed, 15 May 2024 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792316; x=1716397116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9zUil5kvkyqatGu+714JnNLw08wRNNFWgJAtvQ5Ic/U=;
        b=f1A8ljxXGSMEzyQOWOqbwkcxmlIOisS0lgHUPU/WMNPjkyI9iprREj5Q2CWzBRyY6S
         xRvzcqdILH1kaLu4ioowX1lTw8xIL649pEtlV8tuA5ONOBPF4dQYFe3lG9qJznkrg/AF
         ow64vS4aGrTfyzlp5FO2ASU3gZWFMBk9rCEH009kTR/zLXvXvB7LxaFCI7XofwNg1jiI
         aEJXWAk4uR1LI7ZlhRboM7t0YTDcZ1sDfk9LrlS8t0Hh1PLEk74YDG6GFkvVm+amE/X9
         O6RMIrDWwVlx7bBmaCe3i//Uo6WBs/Pk8tELvY4rNfjCwenuIlI7L+mS8Dw/vq0sXhRi
         YSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792316; x=1716397116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zUil5kvkyqatGu+714JnNLw08wRNNFWgJAtvQ5Ic/U=;
        b=xCR0QI78NZH2doeYI6EqkJ6hmzWZxR0r3WoPOpmjNUGaIsv0NYiyeP/KkXeY1Iw47n
         PH69RSxayRFNsX0dYpjHbZIWgOp/8YPCbFSNGGaLete7Bo3wB5cMbfHqHAXtNDVv4qvf
         wm7J1axVGe/hFFg9ahnyw87AzMMnQJjPsXWj4O94Yy1VV53lB8eLu/gPleZYxQ7hNcK+
         0+2A8+UelkH0kMEpqnnmGLr8REi3lvASQHwr5iWzYC5+sBINeVookoQXWepf3rlWyS0l
         yLc0YTEAHJT1Xr3xtAtAU7uCzCGSgUtq7x6QXqg3++tLXTHMWu0Q0ptY87L11xK8Gd56
         tOuw==
X-Forwarded-Encrypted: i=1; AJvYcCVBuZUPP6Wnt/iDzBhZIPgib1GjnvFhQriIJsBB+Rvu7T29pGYmegjKWoRsWl38FZaeHw8uzF9jC5einQnpx2jLsxfqXb4x0mVl8KmGniUs1GnMDe3t1GArr2pEa0CjPcnV/Hjn
X-Gm-Message-State: AOJu0YyEHuxNP6VZi+boblL9cQgVA1UXLw/om/J+gO63xTXxo6ymWV6N
	3D33WABHIRWI+HibLzbJvGHi+ILCiB2uFB7jFAaNmyHRZM/tfLQA
X-Google-Smtp-Source: AGHT+IHaRbfAXLdm43VBG58561Dsf+kijeL08E6BODgDQ1PogLi1ul+QfSdpgcRbheVUXWiwljT35A==
X-Received: by 2002:a05:6a21:788e:b0:1af:ccd9:4b1d with SMTP id adf61e73a8af0-1afde0cd6f6mr19389471637.22.1715792315967;
        Wed, 15 May 2024 09:58:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0934f3abcsm17060765ad.153.2024.05.15.09.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:58:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <823e7e2e-4536-428c-a029-8907ebf89635@roeck-us.net>
Date: Wed, 15 May 2024 09:58:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>
References: <20240515082456.986812732@linuxfoundation.org>
 <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
 <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 09:20, Linus Torvalds wrote:
> On Wed, 15 May 2024 at 09:17, Mark Brown <broonie@kernel.org> wrote:
>>
>>      A bisect claims that "net: bcmgenet:
>> synchronize EXT_RGMII_OOB_CTRL access" is the first commit that breaks,
>> I'm not seeing issues with other stables.
> 
> That's d85cf67a3396 ("net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL
> access") upstream. Is upstream ok?
> 

Upstream code was rearranged. d85cf67a3396 affects bcmgenet_mii_config().
3443d6c3616b affects bcmgenet_mac_config(). bcmgenet_mac_config()
is called from bcmgenet_phy_pause_set() under phydev->lock. I would guess
that trying to acquire the same lock in in bcmgenet_mac_config() results
in a deadlock.

Guenter


