Return-Path: <stable+bounces-45987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0A8CDA35
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68253282C00
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E21142067;
	Thu, 23 May 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Z76W0b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62654AEE9;
	Thu, 23 May 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490216; cv=none; b=K037nrAhbQ26O5NWgcjqzX71IYFIpgLngXCDtF467alAN6KDa6+v7gi8vg5bjZpngcRR9xAXIIlVTt5lwjPhZoEB3e5beAesdnZNKRiB1jHBg9aKoMMr5IVjSqKRBpH3pI7JsPJM327nN+iZgYJaBs93IbNjlkFQU8K2d35nIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490216; c=relaxed/simple;
	bh=kyE+MwN/uIjHh3K6ejdqz58qWZ5WZfIAknWZx2NbxUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aw5oDjCVqGZYBBWT2U/BDImY3QU3lJvsa6ymaSgSRhxZbeQqES3vcuo7RwXVVGSnlTP1L/9/q3DgxblovJcmy9XbDCFn4+Oc/7Y/andmutEUBG6SZIxnOIzWBukdqM8PM22YPkngucKqzDKaG5nteQ83RE8m4ZSj2yk/cASSotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8Z76W0b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee5235f5c9so122955415ad.2;
        Thu, 23 May 2024 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716490214; x=1717095014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5jWOQ5e4KuXtG3+BV+nC19AzmmlYRZIw5wGYbugR1o=;
        b=L8Z76W0bkIvF0JdeaS+QqGRE3E6HOrRf+YTUMY2mB1EgHA8H3gU0LIMrgpQmbwYaX/
         dOBstVDGBT81Z1cuIuWcOSt6gQTloooRcnycY1wiBLeljRcI+P3zUT/W151gMfOPyBee
         p3YLiSBHBWu6IuWtSQdL797stP35tRlhXTRk+eup3A7ekThjoovAHPHuT2tpLLR7vMxa
         Z8ekDntQjUKttr22XCveALbbtsjDI0xVOpRP2TsW3RovN3PVYR31y59OeDpTEny6Df4A
         qicgs2l93YMvZ6vH/pnJpNqBrK7EpH8Coyf0Nsvj3v6dd7mHFTjW0kg1699S7afsDCqs
         FgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716490214; x=1717095014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5jWOQ5e4KuXtG3+BV+nC19AzmmlYRZIw5wGYbugR1o=;
        b=oXCCqHyuhi4YD3MlSjxJWgQMLywuCDxIA/BG9TIUY6/j/YyzBAA7f8Kmd+U50tHE47
         zIbOUro2K8VorCY+WOt5ppbjWoOIcAiBpOOL3PkV2kgIMiyIjlLink06WHzm93k+9Z6j
         bFCQTsM7i6HImFc2F9WDHNRzeBzJrjnBA6lH1ZAFQMX0QL11TqXw+vIiYLpR87H3ocf2
         Xsn6OMcSips67+Io3x+w9AR1+2U+cXfFj5M2252pr41dWBpiavJjA4ffTo868XZNc1T8
         zKAQ2C6a89/4e3HtC/unCG9aPQYEvswmdug2w2zj+bk9Q/IQuY0VTWueMbFj46pUrEAT
         jRWw==
X-Forwarded-Encrypted: i=1; AJvYcCVC3s0lObWE15Hjl4O00rkDVAjVokXA4GA0rNU5J+7GF7XnWCqqaUD2gRDUi2iiKi1iwsOFvK4iCjPYgOqha04s+rTZwSxdiYsbwicseTU6kRD4v38gAha65FpLCWD8agKoIaC0
X-Gm-Message-State: AOJu0YzutcEaVAtGjqhYrQE/jVGKQk+HnjanH5+E69yfjuOAX0Xo6EnW
	UaAEWueVMrdUQ3edFSTW9wapzJz+gd+eq3i6W6Eh5fRmnSqy41nl
X-Google-Smtp-Source: AGHT+IH8TfXPmp+k2+6BFrZp7D5q+d4zjU2H10O3j9gFv9PYr2beC6QHykVOAGJXFo/xesXdoPw53Q==
X-Received: by 2002:a17:902:f987:b0:1e6:7700:1698 with SMTP id d9443c01a7336-1f448c266e3mr1967485ad.35.1716490214038;
        Thu, 23 May 2024 11:50:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0bbde9d7sm266512825ad.106.2024.05.23.11.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:50:13 -0700 (PDT)
Message-ID: <19753311-98f5-40af-8e53-173e12e83503@gmail.com>
Date: Thu, 23 May 2024 11:50:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/23] 5.15.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130327.956341021@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.160 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


