Return-Path: <stable+bounces-183374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41838BB9051
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8185189D18D
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112E281509;
	Sat,  4 Oct 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYeF9Rzg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9C275AF2
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596874; cv=none; b=XJX8D65sjfm3Q7mlMktSqskARv9AYDb4tj7ppZo7tpOsrNAs0j0Uc5GhPfNmgyVVgdYote03owkWfgpJ/fXh13BGmMC+eAXVb6lIYIffylUoNKf1ADCy0uTE7hQg+NUu94l1x0yKX23XCjzYRuvCKR+FGoZOPGTmR4Vs4hdakF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596874; c=relaxed/simple;
	bh=7jwL6Vl5B43Ocy7VPpUCA/ZQ+E8vvJVNntNOaNWS/xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqprNabaIfGrLRO+p463RI0l0Q9lyLoKGI3Dzqt8M+HZ+T2xa0x96UlrOYS1b21u0/ChrBjMWJM87d6XPfhj0ZjOZtaoYnnHGjnwJEA0Q/eBIXGquKqXPXThSyJ9i2WyiWris10U80OprSt0FEEJSJddwFKSBfw3LbzIXa/dHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYeF9Rzg; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-90926724bceso281473039f.1
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759596871; x=1760201671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBHBG9tA41TCvQg7ZgtdnkfIFkrXuT8caUQqZNNWJoE=;
        b=IYeF9RzgpWzk3DBwvFk3rhF3sOI1oJZcW0nVtEHUEdDC/fXuOEmg9foFmSC6wg7N2z
         a9sWC/7nij6VX9NrwitjWxtvlhDWHleX5e96G77Oyu0pwNyDbsjeOzbQFyMWQfqO0/u2
         lVLDEujEFdjWVmT7fcvl8P4da/SEkrqdM8+Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759596871; x=1760201671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBHBG9tA41TCvQg7ZgtdnkfIFkrXuT8caUQqZNNWJoE=;
        b=hQVTTx5g1Xzvq2fnCVCLBVmyuEWnaGnF7k2wlHCCFsFtivnlrSxmfYoeZAHWKSeWY7
         xlT1/C9q0xEV55GEuAgZWnkiVLI7nbZtfQcnKvO+8WOwwE/VT8xurFDMiZTpRzGVrTRk
         bZwhvWR7RtAvnCifi8/JpVn9f7BfwK4ZfcFnrgyMtOb3gLNWiRPrlI0wS+zTglbJlKC9
         cTDqFdPG4Gw9Ah54bC7V8elyPd0LADJrnVfZPiUBh4+w4spLDDk/GG/CYmMWaSMFk6nW
         xUGhVqDIZqvQO9rNzDHmw5seYf8Ne5o+lO3gXd1GsyGJiv8hcmz4hTyWdIb6jZnz2oMR
         2d6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPsp4T9RhGZ/nQgslfW2xuFm0q3ObLsYfg1goOebppGbzk3vqIo9cfDuTx+oftFyraE2VruKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBouAqGUqJNrRY+PwR+RhyMDUua8E8Xf83Z/xtHyEGihQzRwRQ
	i6LESYsFrJuYxes+O6ZHLB00ECrMCWgXcmoHRkkFAJVlb4hgoF3M00g9I5UNSTnIItE=
X-Gm-Gg: ASbGncu5gGvECwYl0AzUDKSL+jOm6eo8h8EMu2lvqnwg4JSJwt7cx+kpbL6ZOJYuXAq
	Ti+VXGd61V9tPqGFnfKRB0sK0zDNRWixRdvqBQSFJctBDOWy6WLx60teIYeg4LcgVAuTnzF9XfB
	riWBeJb4TF3BpxuPnzJ3Zn1S1o3LYascKmbRS83f+5d+gwKh9eAw7oyOT1G9u/uS+1iApG4IXFv
	tXdHMB3GbN4RGVdJvKaC9P7zCNfRnLFAT2FJ9tj2ZoS9PcK8m0/EAnxYr9mI6r+WnjP8x+PEGeh
	US/L46fj9zASJxgTj8iGB3XsV9V863SBqljey81bcYwM9uLE4V3H4ZVejZ8WKwH2r7L3oBPOxx/
	htKe6o9ZCE6dtN0bUIsgALayeDpa9JnHDpQw5o5TMFfy+PsUEw10XGs4VvXjaYmTcxJDJpg==
X-Google-Smtp-Source: AGHT+IFpIfH6lTTmG0N2imGQ5NqZw46VJZnySYfxkXs0eV2kmfblbxS3NNNdc8KyNLc1LeccYMthRw==
X-Received: by 2002:a05:6602:3fc8:b0:8d3:6ac1:4dd3 with SMTP id ca18e2360f4ac-93b969aa445mr985467539f.6.1759596871101;
        Sat, 04 Oct 2025 09:54:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81c735sm291244939f.3.2025.10.04.09.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:54:30 -0700 (PDT)
Message-ID: <edd6a626-a7fb-41a0-9b98-2100f85ec2ee@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:54:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160359.831046052@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

