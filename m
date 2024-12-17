Return-Path: <stable+bounces-105076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36B9F5A08
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAE170168
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96171F9F5E;
	Tue, 17 Dec 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="at7AzM/A"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AC1E3DF7
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476433; cv=none; b=Sg3RQPaFRF/jBynH2pxEAWWTEKkdCPrNvURQie0RZMKZ2dC5RutSbtCh8iAvAFAXu+CzXmnn8j+k8z9avtlOdGsc/+FLyTKQNKDnNjMCikn1l5KJyuzMzhZLR8GiOmcxB6SmGRpupVU36IWtpILZ+HIjy0Qk34XGpFlFLhWZU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476433; c=relaxed/simple;
	bh=heZCgR36okwrEPenz1vox0Ph/7lggzAvy9tEGMZmPdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYcySkSjdf3Pa/K5XrTXGMu+rZWAvwDSMHZisNajo2cpIw1aKX4ZGlUkBTZzwOfQLTRDUZjw0/WxDexOC5svvZIG9KuxH9uv1qxhC/b0br8RvUV6+UDI+dEhMg1RJPy2WDoJWtSbBPgkL5VXIQsWOV4YdCL6rPjd1+E+ThUOhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=at7AzM/A; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so19491925ab.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476430; x=1735081230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytheTzvx0tqGH28SZa+nd7zFHHJvqM/FuQZdlG8skUY=;
        b=at7AzM/AwxUG5bwkRCuj2WQ+UoPjrHYz3vNjCGKKI7VwZLabi/0swF1bOVYkkes+m+
         CaGYdxw/Hr8YeiLRdHyWbpPPo246CUJpvnNhfGsd5jAfLMDVz61ktqWYvfnzO0EOEFbU
         BU+580/jrAu8+No+lZsleuGSMtODczW3ROE0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476430; x=1735081230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytheTzvx0tqGH28SZa+nd7zFHHJvqM/FuQZdlG8skUY=;
        b=AMAGrz+wy7wZ5O2+EIfRP0T9uDYqukfJrrsxjB1uFN+ZUxEbbTWmRhXDhhP/Jv9LKd
         MWXYBeM10CWxALBvTwecN0gKMP/bOFcG8Sfsc+LPW9frgyKXE16KS3MVbd5Z7XP1obYf
         p2jSVDOvOeWehkUF41IBjI8iCc7Q92URyXpS6b5OeRXGLGe4HcCJ00NOip/XHZapK6vt
         qe5Vzd/3BExsvS3+Mh8UlsxSfScB0MY49fEBTy8EZAbAIsizwEcMnxiRVuLK+/E+rWeS
         wiJjTBKRd3aeX0BhVn4c1ien14yNarQ86fys/xs7CLWWbtRylzLem/Jl7kh5U5gSx+sa
         zpnA==
X-Forwarded-Encrypted: i=1; AJvYcCWs44dfXxp7i4M8MdR6WkaNO1On1gGXJoucB1ywJvAyG8Fv+t54NNZ/FUSkFudUbDBPcmfWQbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/n5/Esm9NKJmLZZmdYSyI3cAzEi+v8NF9/Z4Rv1VosLN9lf1
	BB/qEzZzCPU1Wru0JIbI9dgq7VAG5vt5smvHBd+aM8zHL0QJBaoqB0EXf+IN81M=
X-Gm-Gg: ASbGncsnFRL2OA51WOoTIhbJ2TJVZbjQVLi8afz/k84q1bXE4ZA5XQT88Ngr0pjnfgW
	Lqtrle10QHCSML4rZBMHK9TdYr3oJDVpngCQoQ2yGC4Rm+ZIKCaLEL4en+3R4otWuttsGfhgrQW
	xe+KjCum1w5+mtJSAhe/YFFVvfVdPat9AmlQS27zUIfAk5hkWY5fkAJCI8u5Cwc84FYirUUC1wV
	aVkUxknq03aq1zoG9z6ShFpQGt7zrLA3Ck/pk/mTpqyheg8JAAlVyHCHeJjIJzf9GEv
X-Google-Smtp-Source: AGHT+IHj1urYnLVFd1H9Pq3MAXhO6pXENBDFiKLXPXYYGMdBg7DO4d/bKBJ0mtkdDouBQ9AMPQaYbw==
X-Received: by 2002:a05:6e02:148f:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3bdc4f18812mr5930715ab.24.1734476429636;
        Tue, 17 Dec 2024 15:00:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5dd620e20sm1862035173.0.2024.12.17.15.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:00:29 -0800 (PST)
Message-ID: <842c3d3d-fa2b-4e30-a042-0cbc45562da2@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:00:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/109] 6.6.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.67 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.67-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

