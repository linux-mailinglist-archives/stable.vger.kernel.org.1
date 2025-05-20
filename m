Return-Path: <stable+bounces-145717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D5ABE5D2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B6C1891641
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD4253B40;
	Tue, 20 May 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9A58QQJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0733171D2
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775552; cv=none; b=NmeueDseazKhI0wm+OD78zDuxHZzg2BY4NAdQ/1QlE4SMmiynj2oEhEo4TjqhEsyFvldTCXXuwG8X9PBx7rOJjYQOOsKF1ndk8U0l+HRuIeRcXIc9DxImPWmb9d4xKF/5Fz5AQVTsv7lBjbovk0VgYJXtgkMwRiNNM9DEyz/3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775552; c=relaxed/simple;
	bh=JxHtbcJN/O4Vpsg3y6yxolxHrOTOCH+dF8W4h1Bq0C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P982chwFY0b2KI3jhDSb8unB3QL36MHUkkEjw3jWwIFAFu/vo6C4JGk2/LDZFEWkv9HXm8JzIUVsu8kx5OOAWFhEH1jR2PbmIYFpZnr81dMCOPYfzZI+xLHms0av+kCIS0Oe9UdqzWePYzXZsY+9c3nLBfyyNEtkVGHj1Px54tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9A58QQJ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-861b1f04b99so189741439f.0
        for <stable@vger.kernel.org>; Tue, 20 May 2025 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747775550; x=1748380350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMrFfTENF4F3SCjFNJP/23CVdgvfjcCcQGdu8rVvJBA=;
        b=R9A58QQJgGJUeQMKdzodAysPhRA7TVHXYfJjdaOSbZn5nqOY9kxD+tItCCBQr1SeAi
         sF4b2NMS1dXYzunHn6zA0YlpU5otKL5wjMBS44CCzKOseyKp4SwfhX4Tq7LCMTahsN7g
         UvEU5f9HmSV4ULTeSQCPXJngfwYw6CiY3Dp9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775550; x=1748380350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMrFfTENF4F3SCjFNJP/23CVdgvfjcCcQGdu8rVvJBA=;
        b=MimF2iIZFdBZ8asvm05yDgDFaw+SQONE1E7P3SO0ix4cai32dW1oMmBT7ryprNXOvD
         7XLgzrn2xIIDTdACVXSHfw78Ce1XuS86fmvhDGQBx5IS8xfQNkuTLVwexdLD1Y4Cu6f6
         kHxYsN8Oo6i+FIz1nDuH5Ap4rfdzRATkoo/nUr/EdpwhduPGzSA0xUAOWkB02i53Lr9D
         K7RwZJ38u6QFj3LXFGVQQxwLBwF1RVUiK4M1VI6VR9xgffqHvfXElCbtl3mVNWd9FGCI
         3LZTqiRTFuQqhm+dSs4aPT2l/FAf8DB9j4o0vlzMI1F2TbcQn8us62apLBsjyC/p5/ro
         pZBw==
X-Forwarded-Encrypted: i=1; AJvYcCXAT6fCynxnc0MbpxvKNk2NUlUKoQyafuQxXiyB0gCINKjbACfN6kxwqpirXM3jj2ftSywS0TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlMuTbMCpgXFOq1VXtR4bbaOtFnhfFZRcxYHuAD8iRmsXML9x
	dPcKptojVKf4/687XV5ky3QSFJais0+2S9zflt1XpDqDpI1T+kYLi1XpWufnDKF+hP4=
X-Gm-Gg: ASbGncsA4eu2S+6np8ImPGx34246DbV4NnUSO1lz5Xns9SOvsB3ZdNs10MBTG6z+QgR
	BmECBzagVWLbiOIWqZyNw71MMdArXZc2D+BIhqN8txVCeB/d3pzzpeMlmk9O1DU0jYAzilOZiBr
	TOcr2GJ3/J/tCd6D9v2BIgTGuyLj+jnE2w+OEfd1IG8+LjtY85Vvq45yk5PS2Ti4hMoCy40QXxj
	uNnZsTVytGtBF8bKlUVJr7vwX3Rf9lz+5im8mUIgH8d8/5fHt1Gvf0wUyc6FlnLRPWd4SgIK/gz
	iZuYT4eNH+4ql3ahtQ9fjjEB8N/z/LbaWR/Y/qsen0rheYu7oVQjvIvGzqiF8g==
X-Google-Smtp-Source: AGHT+IH1LDM15vwRPpbt5rCMjiAO4KoSLMc0NMXg9FmElbvwrQgJ4BrS4fhsC8wXOY8J96B+wGJ9fA==
X-Received: by 2002:a05:6602:3791:b0:861:d71f:33e3 with SMTP id ca18e2360f4ac-86a23199f69mr2609760039f.5.1747775549724;
        Tue, 20 May 2025 14:12:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a46dsm2397257173.16.2025.05.20.14.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 14:12:29 -0700 (PDT)
Message-ID: <b316a79c-1146-4bb7-baf2-6f0727f87a0d@linuxfoundation.org>
Date: Tue, 20 May 2025 15:12:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520125810.535475500@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

