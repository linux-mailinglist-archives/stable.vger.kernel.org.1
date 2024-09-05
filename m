Return-Path: <stable+bounces-73646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AAF96E15D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E5F1F24FED
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B305381B;
	Thu,  5 Sep 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixQNZZAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A825184E;
	Thu,  5 Sep 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558731; cv=none; b=RpjkXRtBkQqelYCWsgljHW3/deIWnD8gjgcFChplJs7+fHEqG/pZ1i7vxBoNz3tLbAfI39/E/wUb4Gxk53NIwknX94bmXLGN6W0PG5uDr2fO3pbTGAS/hSZmSLz+ZFm/LAlMj2hxr6P9RNOnVlC+xRg/+Gr4pj7QEwRSfGAgn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558731; c=relaxed/simple;
	bh=zyBfW0Tco4IThEnlAHhtYiZVmZaFd2ymNn4UAK6qYYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIOBbGr+FXJy3MSdylCxDkyFqDQtxZIrkR7SNbWbmCTUic8mj7atM3p0SCmXQNkSBPg6l0pJz/Mg02HyEwnNiI/G/UePbuURlvOBz8wjJoWrnNrLBYheVBjMney0EuYpjarlT7WtA5R01jbs4OZ28urZzAhymPsi9y9wuQ7s2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixQNZZAZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-205659dc63aso11635005ad.1;
        Thu, 05 Sep 2024 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725558730; x=1726163530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=POEvdg5MNJNP2xrdrnmN+ih9E3dB/pXUEq+0r2f4xEs=;
        b=ixQNZZAZ2e7QmDDUE1p7iyzpAnzguhh22soQBOKIDhnVcHg+P8DxZQUdWTBno10sVe
         z3FdXkeIkSW6yxSkxx9EzGaGmlTdxLjnRZE/b41yhTGEQpDPSq/SgDzyHhTs6Pp1giJg
         9WhtXdKZ7tduoRc1D9u8tjmj8u9IADFS5I2SGeU3D28bOFsc+GEp4iPkYK0p7WLcxfA0
         aGnSngw29oYdi3JlusMSOOlrSL/22CM59i8ryTvQiHDD1qa8/IgC09A9Z8oBCH8fiI1/
         d348DZhoL82zLMQ4Eim8hfCR/N8mihTs68WufFaHFJy8Xbw4TRzKjCiGMfMWrlzv0oxx
         2wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725558730; x=1726163530;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POEvdg5MNJNP2xrdrnmN+ih9E3dB/pXUEq+0r2f4xEs=;
        b=p8Y95zCkZXnS87sIvEiK4j6Qf2Zmgu7nWEnjQR4G2hc+qZRpsytV66kv8ACFN0Trve
         YIsWo0RdMS94VFNF/GVBs2dYwC7jWaHqjfCx3DcQN5YKVJWlDXcfU/v5qsCqwE/b4MWX
         4+4gB8DySbeIcbmUC2jbYm1AEwj3Js6GCLVZMPafOp6xYfuH+m6VEf8hjWiVWLQqPYzQ
         Rl5BxQmHMP5SHVMPI68t8nEaCM70oXr8V5E3Zi/PnWWuar6SUBKtJ+3bkwhs8M5/ZPof
         9R3r9dAZTMAL+Q9fCAw2/29LzcUH31WmuS2ZbrJuXpPOOvA6SLnrT3mlg2WOfxU8u3aF
         BIZA==
X-Forwarded-Encrypted: i=1; AJvYcCWahEJ4TW06NcLBme/fhtmT1lpU4jweJevU8I3ZEW+0u/z9DnaaUe7WwNer5vxEBcFphQDUtOUJd7gESrA=@vger.kernel.org, AJvYcCXfdlz1xjSSm255IK2Ksy7NkRZ+02v/RQqRvZ4+D8WTIL0VmQhLWyPOu945sY/jTSMAifNynUQE@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfEXJNG+ZcBZ/WsfphhJuSK02yvJC8mzJoDG1/IVhwPHz8K3V
	fkb1oj1d37YbeR7MZ4jqxCI90xBf7KoTnrtuGodE83wFwV8hauJF
X-Google-Smtp-Source: AGHT+IFh7evhUz/1N/ZF/XZcMHAy53GFewpSKpQhs9rzY9X3KyQGDCfxgodVg6adKgiVrH++7gcvhw==
X-Received: by 2002:a17:902:d2c2:b0:205:3975:5ea0 with SMTP id d9443c01a7336-20547642f99mr182433915ad.45.1725558729524;
        Thu, 05 Sep 2024 10:52:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae968f78sm31107475ad.119.2024.09.05.10.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 10:52:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <092aa55c-0538-41e5-8ed0-d0a96b06f32e@roeck-us.net>
Date: Thu, 5 Sep 2024 10:52:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/134] 5.4.283-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org, Helge Deller <deller@gmx.de>
References: <20240901160809.752718937@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/24 09:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.283 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
> 
[ ... ]

> Helge Deller <deller@gmx.de>
>      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367
> 

irq_enter_rcu() does not exist in v5.4.y and v4.19.y, resulting in the following
build errors in v4.19.y and v5.4.y.

Building parisc:allnoconfig ... failed
--------------
Error log:
arch/parisc/kernel/irq.c: In function 'do_cpu_irq_mask':
arch/parisc/kernel/irq.c:523:9: error: implicit declaration of function 'irq_enter_rcu'; did you mean 'irq_enter'? [-Werror=implicit-function-declaration]
   523 |         irq_enter_rcu();
       |         ^~~~~~~~~~~~~
       |         irq_enter
arch/parisc/kernel/irq.c:558:9: error: implicit declaration of function 'irq_exit_rcu'; did you mean 'irq_exit'? [-Werror=implicit-function-declaration]
   558 |         irq_exit_rcu();
       |         ^~~~~~~~~~~~
       |         irq_exit

Guenter


