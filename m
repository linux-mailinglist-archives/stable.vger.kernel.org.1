Return-Path: <stable+bounces-86396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DC99FB48
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 00:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCB1F226F5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997041D0F42;
	Tue, 15 Oct 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGiKNp2o"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3721E3DB
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030895; cv=none; b=WIHlJv4hXvC+gPgZ9Xjva0Jeavu7GWPnNExGoe+GAD3mPuKLjkn9opccBa9p2RRsuHKdGkQPFWJxeFMf5lIJkXZEll75teb0aTSJkaSTJafPT/vRPLpCRuJSXMkcMk6ZifOuMPKwt689LKBPQxf2Jg3b33OIbydgSDwg/8XhY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030895; c=relaxed/simple;
	bh=ltQMRIsXUfjEPweA4ruMh+CIceGsnMVBfbTkfwieJUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqinAskraDMgsemqpXzD+OPrNEqbBjB8AjI6AoFwHX9Qh8fj227aJktFlmX0eHB3j2Q2J7PGirVXgXm/5BfgclmBQGP3mN17cq7QFU4wss5fDLO0QJrHh/dXqkV6M+2wKInoW3DSZCLPzoeYvQY8dEQI7e7dtJF/DLi33QpEUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HGiKNp2o; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a9be2c0bfso5671939f.2
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729030892; x=1729635692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNv6EpUkF46yC8CnPi4D029NeIjdWSFiLY/SEWTCkiU=;
        b=HGiKNp2o+rby+Hm8z3jD15uctQQodadtMMSQlSflqWhEq0u1w/bs/t2cgAD3CHYlMZ
         T1HCo6Jj0oRwQnZDWrGtrpkpJbmBtSUmgMAj/TzMgt4EWpjmFlobJ6Ku+XDfWksobvD7
         jxMJmG175NNFYXhVhhG6bkBEnI0c12dyGLdt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030892; x=1729635692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNv6EpUkF46yC8CnPi4D029NeIjdWSFiLY/SEWTCkiU=;
        b=vhzkb6P3qn462tTX0adgiycFNY7rHiFdFFV3V/Bp46kvQwWX1nmMnsopqGzAKTiO8M
         dXJbXjxJKTMSk1dixsvzcf8B6FUHpgumwRZiH4nzzeEztybPplccMqLmjYFeWdRVOGqB
         gqQt2+/21E65gPG6JI4RBMB873wu1XylEZOu5lv7DcMGdQNsUDu2hx0lF0zSVqArfCk/
         OJTvy8lnrn+oBchBj/BwIqykLokNPr9FWOg4RRdxcyM0O5ItZbquHrmGK1kPXQu7sTL4
         dr3K8ILOAvb4zMEY02dUJJh/UGu35YCmRqnvxd1KLDdSoRnig5aGjpuxYQYeJxwkhNwb
         OEkw==
X-Forwarded-Encrypted: i=1; AJvYcCXEdLPBE06Ddm+qqkZylFO0fet4yVhyLu0DL0i9KsYdmTcCB2KyubuS5s8z6o89Yns/sA3V7fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKv5vN4zh/3Rz8IGU30eP8nNotAjVaKecNJjOZgunaFAHxYaki
	iuJOyva2r8zvz+m+2UD/XkQerbYGoohMKCkiSY8WWMd9f8BGOBK4Z9Imca8Mn90=
X-Google-Smtp-Source: AGHT+IEaclnUl4KoFETjKApAJu24dk+GljHsnn/vZz/hzAdpQuBIfKEIAYOFjZjg6nfn/buMaj3f4Q==
X-Received: by 2002:a05:6e02:194d:b0:3a2:4cc4:cfd with SMTP id e9e14a558f8ab-3a3b5faab6amr157980805ab.14.1729030891827;
        Tue, 15 Oct 2024 15:21:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a612sm521449173.162.2024.10.15.15.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:21:31 -0700 (PDT)
Message-ID: <cb1a9ce8-c84d-41d4-8fc1-ef7d181af1e2@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:21:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 05:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

