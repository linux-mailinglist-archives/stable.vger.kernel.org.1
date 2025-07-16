Return-Path: <stable+bounces-163157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092AB078A5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E873A8F9C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94872EE998;
	Wed, 16 Jul 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWKtPoKX"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31F2F50B2
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677494; cv=none; b=dBFYsiiKrhUfcesm0XuIWJm2OIDmmX3yCoG1mqgKH3wPEGI5NrTyFfqrBpq+uHS0fe5ZksrKBCvdCLMrXPUzjhaIel7+/eQB8l/M46H0w1D31cjqw+8RxHVhkxre6LU8mvEXngXGXch4UnkrbtGVF7oc6Ii5EnWqQxslMMfWzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677494; c=relaxed/simple;
	bh=ykpYMgCTCP5IA6crj9QAcn4gLod+08HVDpTkohc2frU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7x+eBF5IOXhbWXlsxVYCvI7XGPzZlSV3Grb3rfRDpP0f0fXBpSAJlZiS/Yhwvqf2zxA9nq6IGfKp3gbVCoDGGQhNjldRd4M8lCOqQ6SffTFPFqy6Ez0dZuBilCdjczRddwAhpcS8nISDme9sBjhmBYBEFtZ6tlP4MyQU0956Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWKtPoKX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so50665795ab.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677492; x=1753282292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ4fgAdCXaMF+X8p3B+OtFN3EJU615/xlwO/KEG8q1E=;
        b=YWKtPoKXZ3Vde6eL7MndhJktHiShRpDDOB1qChT9cFdjqKjCW8ve9tQvd8D87V/ykA
         dhryQLQ4JK/SLv2GdrwLlOJnfwMT5W7GHwMYkXUYaE7Y/IJLQHgbaIvQwLWY1O2sTcTp
         J3CwtCrLVOFswyTRUpqmEwPKXvvG98KW2vwPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677492; x=1753282292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ4fgAdCXaMF+X8p3B+OtFN3EJU615/xlwO/KEG8q1E=;
        b=dSFI9gjpW9Q1fRvuuF3rLJ/GLUsUNQ00/kJffFGMA58jhU9E+UAduIKvZlhgNxh+S+
         5WcAIAyWF5hAiEqu+RcFDC9glTxumwKDfE7OMDil0ERnJsT8F1FSpT2gUBh542i038T5
         HYXqwQDFBWETzZfjm7Y3ZclQjbJhJjHy39ojoHGtbRYTx9+/szKAAIymUh5yqQ6DM/q7
         f/V0cLNM5Hjkj5kzcPjnu6mvmO1lMkbG+sxZ8iwgIN51H5vtGdHrbs4STXbgsdvgGmDR
         idsB0BE9vherssIF10AAbRT4463niUJ+JFiRKv0o/kKl/JO9nWtse8OJSZZTswftn5sn
         apMg==
X-Forwarded-Encrypted: i=1; AJvYcCX5AzCzIuVBJexFysXY5XV8mrSUrdDrVFuCx2kIo5K7E27HLsRKmNMCww0gOxsVVx4AGDpNtTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8Sp+Btz4fAcw4JAveAdgG13SyV1wVhMiJEGO9oXtk1IhgSTb
	nzbArqk+xmJe0DjFFN4uy54VuTxBQCBaFv+0cZ4UvW2MuwTotzuHXlzxDM9XkceWIE0=
X-Gm-Gg: ASbGncvgjD5kPsOqtehaNuZvimqbq/C1aCKLNh0YoLD/aMacYbq+WUfDSjNSdmefJma
	+AjYHiO/NWVYH+s8nXCYDlWIxAwF3jJM24U+GU+kWuefGiCPTV1D9LDSqGl8Mi0PM7WvBYOmxLO
	gE0wuXwYCyVwjf8lLz7PaGRuadlxdE///9diF6NWlcin7WmxXd9MikIw65PahJZI4h8vICdiZfl
	X2EZ1qdCPD4nAa7a0Bwyvqi7WBT6cEAipojisWPtUruf2KSKVVnixwaweUvzmdTd/4afdVEpQN1
	Dps1oOKPZY4DzBBmhUnh60P7MEWrGiZJAprFy2RM4qMf8Ea4iFXoIjmFf7MSYZmc13JtzxHaYyO
	doSn48rEo9lApbupd+Q8dIYxQgLx9G60FtA==
X-Google-Smtp-Source: AGHT+IH2P5ahWBwNlpCIsyRgQhzxMyn4xcRyAWIOS7heh/HEDYEdDgo3ckJ9w7dS/5M/k73/Vil5rQ==
X-Received: by 2002:a92:cd03:0:b0:3dd:ce9b:aa17 with SMTP id e9e14a558f8ab-3e28251fdb3mr29219435ab.20.1752677491760;
        Wed, 16 Jul 2025 07:51:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620aad0sm44817485ab.34.2025.07.16.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:51:31 -0700 (PDT)
Message-ID: <a5582e62-274b-4c61-a9fe-9b7ad0b87970@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:51:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/163] 6.12.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.39-rc1.gz
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

