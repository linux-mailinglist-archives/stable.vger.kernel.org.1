Return-Path: <stable+bounces-104138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88849F125B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9B51881AF0
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F81DFE3A;
	Fri, 13 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dHA6TyjE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00615573A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107975; cv=none; b=EgHdSFiRO9ohr+9WMajQWXBo9Fxrz9f8cFwteRlvIPHt9Xj/OaOkAqahDrRc2hMjBK2p72ZOKcUyUHMgFGZpTlh+FoBxo9MtLesdMV2TnXFfbPpY65crasFsKIRwkHCTFrLcTANIRldr3iKxnwA9qESekeswyyernFN1zJokASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107975; c=relaxed/simple;
	bh=PK80MB2a82ILZwjtwJVBex8AuectZtBoackRA09LVys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efXHkzUUPR/aMZw+BOLzx80jZ2Mt/+KHLMkyYInJIp3Y5yWbkexgGEkOx25N4irjHDNqqiBPoEKeotH62nImOHkdJWs6wzjhnhRB9VeWn1LbYg2GEkr3iivy+qIet32q7mN6BsKg5qj9HzvvUYmsOvgRR2bBpdacTJjVr6h93Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dHA6TyjE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so74510139f.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734107972; x=1734712772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXrSQne7C8l3nSEcpBw0LjVsuhj/QlI2zejhfnriMQM=;
        b=dHA6TyjE6MBLRzX3Vf8SJdWTPh4zT//3bmmcdpbE+HGo7jzp5VZa/7EKB9e7zx7bSc
         YBODV8ryF/0M+0pEDx2M07fzg96pq4MH39jcbZYHkjVbJXHgXL2JMWgh2BFjVRKkBKpv
         oBRVYw6TCEOhdfogZpzYuQf5KEGbE4tJT4F6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107972; x=1734712772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXrSQne7C8l3nSEcpBw0LjVsuhj/QlI2zejhfnriMQM=;
        b=tH77ZfZDJNOBOoSKHesxDhZp5AZcVsIOWE+1HF6279K7Mr5c6fbhYj99xsigIgHDCI
         t0x9nl8dsoQZAl12HWa2vaXFT9xbGUZnZAnHHk9ZO6qEgJ1yduK08BgFUW4yy4ijEJ6d
         +E56wgK4K1+dasDorO0VGZ1T2XHBDSiku7ktODTOKV1PVI21f9aCOZ9w19d1XoYjbBGW
         rVwAMiB81nCK1WXmWexMWO4qM+lo2uudxMfRrA9+lYaMcKN8DIWxCUdCRfPkLNAbb85Y
         X+kI4jjzkYxdyCsSb4vLXz13PmK5Q2wz2HZDzy5PQODmRqoPeGgPWmEybTpikeQAsKC+
         Jrzw==
X-Forwarded-Encrypted: i=1; AJvYcCW4uVgxUz/cFqgwYuofrQcj9sGa47o2cOM0JmxDn8bbbrULONvSRM2ycQUy4hIeRxfUY4dFKSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/cWdkL1aTZ01pTc/CUIJndjUf16nll3WxJ0z8DUY3l6kHyT1
	M4DX8GH2MKKF3564MtKQdtIaD2jvhXIPLDecP/Fu0Z303FbwZlEGuLxUdYnnUEo=
X-Gm-Gg: ASbGncs0ExTSStAAHkOizwlw7g4eW+MDeuag3+J8juLfeeRXj8dCamiZdIE05eXphgf
	ANgi1f3JzweoXeBRjWRvGigDxOqKhhJcKLEE1bsfjc2YGF8jdtE4uO4510GyQb2VuFyWXQKeuGp
	n4CA1p6Fp29XBjax8tbyWa7kFWwOfyVFHu17DghiLvu9A9UT0pQD1951ILZnjoBE3lFMNHeR5zA
	fnGola3RNdoqswYruxrkFQ+/A26d3sXAYQiZ88xae6JoMyICFzHWTgxOQC2d6Ctb9Ht
X-Google-Smtp-Source: AGHT+IGa+E1ul3LhwNTm5aeaCTcqWfKGT88TI9k6GZ1imc1TnoEYMDqfzRAhbIePITnmYUeDk5M0Zw==
X-Received: by 2002:a05:6e02:1a8e:b0:3ab:a274:d73 with SMTP id e9e14a558f8ab-3aff53970f9mr32030275ab.7.1734107972634;
        Fri, 13 Dec 2024 08:39:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808d8fa7csm49208315ab.8.2024.12.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:39:31 -0800 (PST)
Message-ID: <26e5acac-0732-4394-9efc-da91630a0a42@linuxfoundation.org>
Date: Fri, 13 Dec 2024 09:39:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 466 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
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

