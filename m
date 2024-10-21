Return-Path: <stable+bounces-87647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DBE9A9364
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3DE283FDE
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95A1FEFC1;
	Mon, 21 Oct 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnmyeHZ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9E1E130F
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549998; cv=none; b=GgVdJTHp91R+SGhE3XjTLNcGkUvu9ZzEvIu9hTIFy6uMDYaKEf0HX5NKMq1DTFlTx8XDYGWtmtDIVkoC4ZP3O8wVVzOZi2WaLjmxpIEqK+UmuzSlzgELuKdQMGBn3rzMniLWtZF8P6MqH67gP82NkweM9QJSb7LnCiIpWc6xsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549998; c=relaxed/simple;
	bh=lrwrnJ9sxyVS/b/WeRQ1zGC+n8IdJHwc/MYSyhOj034=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etSxBgOQh9HdgPbIL+ks5Pavl69fMCb47agCBd+7TaIweu2N+1rx8tHrRvwrtnlax0LXKBZzzSW+g/er03NIY7PVb0PQ87lzMBb+8RhjrR5NaAoIp7co1nsSz8Aa5ZLvYYXLP7/86Tb4XgUnKQUu/z75iR+V8BhvrC60mQr9Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnmyeHZ+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b63596e0so14682605ab.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729549995; x=1730154795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uml1sKj+kvUwOGLK6/8asmpMwnvEywtfjt6wk3MU/qE=;
        b=SnmyeHZ+wxvHx7MBg3X7MPHT18KOlp6/gB6Ennjtj1tIFq5rtr3sGM0KZ3fqbK8d8p
         L/qyyyjiCCEuPNqtJRtt9fWBF6WYvMXMlxKJrlL+9rJnv6YZnO4ZYgq5uM01qzakI0yJ
         LUeBGMyCv2uT6QRcJA4y+8IFTM2SIFdpT5EmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549995; x=1730154795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uml1sKj+kvUwOGLK6/8asmpMwnvEywtfjt6wk3MU/qE=;
        b=HqxwsOqeYaa04UtyvWxUXzMJvfGiYZ+gIj3hQbntNkR0RGRoJX8CcxjqbCmfO0hb2j
         +zMqDLiSs95XXsmQY01PEVgft7PE8leBGlCC7Xjin4Q6QEYuZmuTXAsLL+bejPbXl/Nj
         9OgKLG7l0OyubUf0fZj2RkuHsNHqQmRBBZZge9v7c96G+iSgc25KnnxtFgdht1OmATp4
         ESaBWGNs/TwVEy1xurtXkWUYKC+ITM4SSeJRO3MCsRBRsKvznMUYoGFIeUS/N5ycwjEO
         a5kmGhntS1UR9eKL+wRa7PlV9QN8uZKgEbOnQdvBB2A3TxbgdbvynVlyAV1VoSkBJ7Wx
         YxDw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Prtw4JBTms8TFKa3kPA40CVxOWTyGnwg5tkRcUlgvRb3e3gvIA+9YqyUcZM8zD8I+KGLe1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWFM7LtwWyFOIqauLh20PJ5z33wJVHqcHKnHKh40gOi18cQpz
	eBdMx00gMAAOyncE/7OVdu8WiHQA6BsJMQ2mai7ygF9UVsjdJ8SErTnkvz/TtT6N9Qd0G690Xo+
	Z
X-Google-Smtp-Source: AGHT+IEJprBi/nPg63JepMRPm5U+FNcv/3C07TNfOCy2tNezSx/w6E0jpGj3z7mxPWwwP8k1cseGRw==
X-Received: by 2002:a05:6e02:1e07:b0:3a0:ce5a:1817 with SMTP id e9e14a558f8ab-3a4cbe359demr8268155ab.0.1729549994578;
        Mon, 21 Oct 2024 15:33:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65c936sm1258671173.157.2024.10.21.15.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:33:14 -0700 (PDT)
Message-ID: <86e869fa-4435-4fe6-a669-4b7a6f1f78cb@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:33:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/124] 6.6.58-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.58 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.58-rc1.gz
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

