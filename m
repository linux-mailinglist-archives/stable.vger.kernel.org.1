Return-Path: <stable+bounces-67529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E81950B7F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C928712E
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D841A2C06;
	Tue, 13 Aug 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj6qz1Wr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F00225D9;
	Tue, 13 Aug 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570404; cv=none; b=Pb2jI1TWzpYykUzXKSr92rDqGo/jpb44suEkbNBKYdOyzD+/WuEvNNZcoUlAn19EDzjzrwd8m/IqO1jBtLBzmCFn3Zwqvr0vRLgtzohPzVmOSAVHtWte4G/BHAIQNjKwyU3Avf+PFbv1IfRSZ+jWKWRT5qcmZ9xAXeeskThhOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570404; c=relaxed/simple;
	bh=NippkUP8S8P6tmv9MWO/YV21PyZxIiRkf0vTLiatWHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3fnRUEePV0h9sSAHaqmjSlbpQ75h+8Ut20m7robjGRR02dpJVeNyEp8yxBrd0Cd2t6I6wIZ3E5EsMAItlyPNfIovPWeDILYCzFRUYW6lFYMEb1PDVDT14r7H/3Mz/Mrfjj8ot8h11kbh+jvKWX3XvCbUR30erpXtD/p9Tlahwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj6qz1Wr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so3843433a12.3;
        Tue, 13 Aug 2024 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570402; x=1724175202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HHxSyDfeWbCkXYqvZXREN7pKpypD1FMvFzppC390k0=;
        b=bj6qz1WrXW86YIcbNKAqUeLOpT44cfFgiwDvn1OPAyLMxHSmMruBiUPhVWEQ9abkj6
         64QnC8Xzqo0O9w6MliKmoiCOdAH+apu0EJHRrYw8skH/yraoFZahmFm/Iye4+ic9ug/F
         noMKbNlyil8EdX7wU92Tkunn6fIDVBxl0kflDMAWBr+3N27QHIe4m/s4uN6hmgAUiApt
         QGW2EyTHq8J56MKcmIVyGnE4pmmRao+aKiUyweD1Rb0OOzT+FqX0Qd2KtcOE4y29J3FJ
         ycSod6Fh9PnfDAEALramw/lhzhrPdttvHQ9D5+n+LEEr7DbAiDaY0UnhTfPm+2Ys81od
         avQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570402; x=1724175202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HHxSyDfeWbCkXYqvZXREN7pKpypD1FMvFzppC390k0=;
        b=Bx/Ok3ws0CboQMmjIyN/JedHEszqhSk7TOwI8UMerqxqdRUC91x9owFqfDNHHE6Mue
         N6oWeT+c4mbRk6nkW6KbRDv6MeQQBIoo6oGqUFRuS8iKVKBnDLHXAipA6ahaHkTv/zt1
         yLnT+NFFaw9lwQsk4ngxtzOLmmcgzDISavaiDwL/FZu1xoPIUGiVi2pyE7XM3W/yeRQW
         IzjUJqiHTmLqMhsez3OHEdF/YWjubHUaRefQMj5n8Mn2u+Ym82MqkNBoM1v0Z7wRE1yo
         0xyp3Kq6bPLQejjDja5bvOtzjeaJX7EcCsPjYENU9eAZN2WwvOJA72X0qGAvaqj2FPpw
         zRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVJFPT16unXJS19AkJ9wSQOPJOOdXZXVRRzhTUr1jTZ/ZF1Oi60xRi1PFR5eVFWQVudYA5VZ5KmXFOk3or22N4aG5w8vtZZ6AqyF2G/oXGlLThgNYmTCNJT97HsY3zMHMqmvcl
X-Gm-Message-State: AOJu0YyuVbCiiT+/VqZ3XZ3FXM61ra0LWcyKPu1rzqwYZ+ChTdvuKew7
	QWlAmrPjD8DCselPWNTMy1OGmrL5DYdJ4dY8I0ppQcZ16c8K//ur
X-Google-Smtp-Source: AGHT+IGa1SaY3ln0jbsWCZAx6W6HgJvu5yyS++HH3R4q3AxSmm4MUhbWEhhkRTsOCJ/F6m27oShQaA==
X-Received: by 2002:a05:6a21:3a81:b0:1c8:b10d:eadb with SMTP id adf61e73a8af0-1c8eae81196mr594808637.17.1723570402320;
        Tue, 13 Aug 2024 10:33:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a43948sm5986814b3a.122.2024.08.13.10.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:33:21 -0700 (PDT)
Message-ID: <e2f49750-5b64-4adc-9989-e9155fe2a729@gmail.com>
Date: Tue, 13 Aug 2024 10:33:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160146.517184156@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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


