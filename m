Return-Path: <stable+bounces-150619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B36ACBA7E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4B81893AF0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121B17B421;
	Mon,  2 Jun 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iedJFlKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB11E9915;
	Mon,  2 Jun 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886782; cv=none; b=tBdlWafrNUEa2wiFmpaKKSht956+Ra96kGKSoLEWnybYOMiTE7d9/Gi+kNBU7G3hxuPlS9w7Pbp2aNotzucPTctReRTlNNmTxyTwQQB05yeTAIVQ8QR1l9E9hZnZyFKMQrPjY23tLH1dau1OjUuTS3pTD7o8wSw7vnALBIhJC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886782; c=relaxed/simple;
	bh=zgpZGKOZdXxsMSuvO5nvnv4FHUC+dFI/Zjn9jY8B5BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYH41g9Kvf9cVu1dC2TJq0qYFs793R9yBWRPK8h5SdWaiv3OFGXg7N2ZbdPU2trc3I55KQPyNMo7fUU5NSLAMQZqs8t52pQyyuMFsh879SJXqqvIrC+KG4JoN5lx7rYM0c3y4uWWvpP5z/J3XMiuyGr7OehrC03KBzvxDGPFJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iedJFlKt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ae05d224so8739895ad.1;
        Mon, 02 Jun 2025 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748886780; x=1749491580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WIwBAUV0I4Oht8vsEGOfWHlq+X4qgFsuEv+bbm/1a3I=;
        b=iedJFlKtu8kLbx4p+OSDwXk2Xr6H3GMOva39ZgrywVaLtFI+/xdgu1wq1fDgRUjeLb
         8OjAoZu/ScnvcBd/JOUqIyVcoC2tunOybqqoK2qt8xF6Q67prC9+XLNdCK9chaCvZTD3
         DBcc1MxhAt3McDzjphFx4vHQp3x0Hi52U4Z60KVVYPxq/7E+9LyYArXHh8EeC0cj1Sep
         FlgBrDg2abLDM3mhh4jutt8MBsOdaMHTMLFNNLmnbCehx/qxjdwF5wwILZzJ34MB93Li
         8GygZ/L6/3+/KhQPOAimRVfeTJFTrrL370UZVqeRsg9/O/HyjH8z4yC3aGxY4zpUNTtk
         GEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748886780; x=1749491580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIwBAUV0I4Oht8vsEGOfWHlq+X4qgFsuEv+bbm/1a3I=;
        b=ASrNHxGMRtOG1sb61YiYvrBNzmqoI3deoMFtWxTf9DMg40VW2GBXjSVJaGmsXBB1A2
         LXrTkDkRfCvE342t6P8w9I+EtFgw0KbEOKZ0IbVYuA1z5//ftWvtdVMsysnG4fd4f8dq
         xYSxlj+gqfPuJurDVLWROPCQlouxgalKfqSvxX52YjWprYszni7SE3PnJssw637hmI2O
         DWFlS1lYnseeL4/c0WHprZz7lW6VDD38c2CpwkMkYf8LyKjpmV3j9AKei6QC7hOoPwfJ
         27taRDGIswXaATyECojJwKktinTcL+Cag9pygjr05YV82G8ysrtIlh0Cgy4cJYsrvev/
         nezQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDdnZ8TTwU2zBbYoEW1psCm2GY4AOAq13PFm1aWYtXTgkgfkez6IbLb9VrFUmY1UXr26QZSkCb5NY7TPc=@vger.kernel.org, AJvYcCWqY8qPqGZW8pZc2a1OMbZj/WdhYkLe0Op1WYNjGUYAXYCvt+LRxyalFYMkjAItQvJTXDpo0qlB@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuKHEJOlyVMXvimcEE1CknEFulYpsubJhMHvDq0yJbkBIh6s9
	JoZofC5u35BCG/WFkiyF1mdzDo+ENA/gxCsAXUh5nUM+B+76v4+xYxBI
X-Gm-Gg: ASbGncs4noAt5EDl+GRwktu++gveIjkbDjk4lsYh7WacxW9UCSsbDtl1XujQqU1BhDi
	aMqFLq7WRxUi/5dxPTp6uYkR0FZK6A3Ac7trgVTIy7+p/E5A1ZiImrZqCS0yS+//neXWn4xI3rL
	cSHGJmewR0YjngZon9vU9z67tR2BsR1k1LI3izEwRdNSTYVam2nFvNPSZ6uHcsqL2vqwqeFTmWU
	Gr8KbGchHhCFA+uYJnsqUlHd9mMiiK3UWnBW+VA23A4cltXmy6C6wlFAnx5HJEG0mdwdpYQhTrq
	fmPh7YRvZQIF9dc5NOFv8+S0ysyrOenfEIxnSuCGf/sLeJrD0H0idZLL32ielLgwCsPRDwDxwNt
	zGak=
X-Google-Smtp-Source: AGHT+IHv0ZNjSuhICIogND6fWVzHvuiVxCskIuc5LhMzI9k14YMGD89MfZi5rw2XsFCWkuHTJ0zqSw==
X-Received: by 2002:a17:902:e88b:b0:216:271d:e06c with SMTP id d9443c01a7336-235c786f175mr4120425ad.4.1748886780431;
        Mon, 02 Jun 2025 10:53:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd96f9sm73762545ad.98.2025.06.02.10.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:52:59 -0700 (PDT)
Message-ID: <595224e4-49aa-4a22-ba66-bf5ca9890d60@gmail.com>
Date: Mon, 2 Jun 2025 10:52:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/73] 6.14.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134241.673490006@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.10 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

