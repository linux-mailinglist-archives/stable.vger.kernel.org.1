Return-Path: <stable+bounces-106579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D39FEAC0
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396B8162473
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495319CC29;
	Mon, 30 Dec 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PwioZY5m"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494F19ABA3
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592352; cv=none; b=eGZXyGNyqcNiZTpil/EmPP9l5LP8pq5TjJ+pfaQdSSRunRA/vy6+uXgfIlb4bRAfccGugUY6gU4H4S61amNp1beh8SQcPi73wl+0AqgtYQ1tpY9I1f/vjhkL4ZQh1VY+R7/EK3SErnZaL9LTAJTAmgNML81Tg4X4BMYxMa9fbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592352; c=relaxed/simple;
	bh=vTU3H1/sRvYpuMMMR5hkt5v7VOn5C6mSPvE9kITO+UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8/Ce+K1f4mEncYzA06V34P1EZRRjO6SY6vsg+fsp1B8nq1HFpA1M4ve4Ahi3iPj7HlvpFhmtv6g+Zt4uwIX0sVocnQufhxVErYf48061k8mt4EDYFd30BWbpaPt3Ltse1QVdaEaeYudwMpQoU7hCj00Ivisrb+9Ij40py/kIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PwioZY5m; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso847154639f.3
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735592349; x=1736197149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cv4G7/sErhZgQKmo9NijRfxp/8v8RJcLxptnmXL6YU=;
        b=PwioZY5mNyPnk5S7LBkS1Sk0b59w+T+aN3tj/9a5KhPKTG2Hl/x+PNE/FWOYc6bK4p
         oQiWp2+LIRaneJN2JN/Vj1NmZHYjar4TJNNZcOeSMpQY60WS1W/YaHx7+ueASkr8mLQ5
         Xxjxx5kG5zu4DaS3q51BJuz0ZOljOSvi9NQkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735592349; x=1736197149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cv4G7/sErhZgQKmo9NijRfxp/8v8RJcLxptnmXL6YU=;
        b=fCTf/0K2nihVsffM/B1hOK9as1RVJvK1dpaftCYDMQJI8nuHumS7WHwl1dOcm7X+vL
         Igpn7NRCAUGVUZRifmLAOp/YTlmbiptvF7R4gwbV7KT27aOvshpuyRwoMzhy06J9f8FX
         EUVLJ2upfSX6+9JCz3K2LazXRR5duhuCcJCEb2EkvljfdQXpwFgFPW2AOHA5W2AKtIu2
         Uy2KNpIxDiaEc/vx5sxE0DqvW7sJZOt1qxNkeeFGCQnsK6RY5jH8b5AXcMbt8He34Kfu
         ct4Y4V345JrHZssqAPW+pzhjBYiRtwG5Wl85FiFfHoUhTtoKXEy5/RMlVpkgqiPmbuKr
         TPCw==
X-Forwarded-Encrypted: i=1; AJvYcCV9rlF4iQEFm8ORdHZ/npCUIZGIbXOSsRiRAYptfdCk+YBL84Tnx+3T9zDSSkd8ji5cB7DqPmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMEolmpAbOtuoTLb95U7mSxTrWa77cvuxobrT/v0tStp7dTzs
	Q6BQE6zEHmgjwEhwIe8qapTAFnl3WOfB2oyi7g2B764hC4zkpy7oa7xYroQ4OFY=
X-Gm-Gg: ASbGncsUCoPCqS2fU88u73pwBKm4SMdd2RdIVX/JJMF5y+PvhHopEYro06DOYB04eUv
	KfJNKFzreijJ+17Jaf2Tfl1LaFK9jM504u9Fu37Efdtf20DOB8+LF6wpscCB5Yu5SWDb6iXLZl/
	gO8VrwD0CJp91Pkqihxpi8jQwt/R6HRwy6VvEehbVKHlqw1tCO7HgSr4QXlPonwnsEBV19YWmNl
	OQLAKRYID9m9gs1dhBX3FFAcmSKgZC/x5J1G1NQXnP624NcJHpuIitUmCAV41vJOp0i
X-Google-Smtp-Source: AGHT+IF5GZAtgN5jx4NEFMEu0Fn83y1Nte/Rnijh0Xu8azUFjmwoUtb2T6ZQA02TzfPc5c8c2kh+MA==
X-Received: by 2002:a05:6602:3e98:b0:843:ec18:82e2 with SMTP id ca18e2360f4ac-84a087436edmr1473730939f.8.1735592349248;
        Mon, 30 Dec 2024 12:59:09 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8aaecbsm557047139f.39.2024.12.30.12.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 12:59:08 -0800 (PST)
Message-ID: <79806eff-15d8-4a9c-a274-621a92e8a382@linuxfoundation.org>
Date: Mon, 30 Dec 2024 13:59:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/60] 6.1.123-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/24 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.123 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

