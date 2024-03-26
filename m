Return-Path: <stable+bounces-32352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDA88CA94
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293671C656A2
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDB1CA8C;
	Tue, 26 Mar 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YmrncCLB"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111641C69C
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473608; cv=none; b=U2Cjm0kjqZJX2UafTwTE90sG61Bb8NODRua9Fi44vShNSgreVMAuLH1oa0Z9twM4OPxi4VK2pRrY1uwFuUmS/SC4DrbS5/dFNYUGak1qMREFSDKVJEqgQZwuZJ8/89npanw6wQ3SaWPAO+9XjwIqTVBBwIyJ6zJ6bCsr3jiF12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473608; c=relaxed/simple;
	bh=E5DQ34rF9IgTtL6HHwAIlPQLC6Jftcvulgt50sKhzMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGHDN0/Fc6YYKlty6Mr0041tQv4+zmXcmKXfKcR94QhRuqfmSw/uD3uEbUAN2u9/m+d7Skj+6onOddEi6ox3LFPJSmCt7eagJceSF0ZLfXdhQW3MYi7RwsBbUC+Y8KwZkBdsOKDF/0Q3wGhOrBQjTurhQ2TCgMu6w+D4LFPnntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YmrncCLB; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3686ab64840so7179645ab.0
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711473606; x=1712078406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/JfzjcSIf6AcXRpAIfnlPrKIYRo4lNR989orexK8J0=;
        b=YmrncCLB5eMLMXm9KITbP0Dp6yUiuppVz5iiwC/iyF1fCGtWFPjhtxosuTftw0S3tl
         sMrDu5txJC+lrCYbc1VPflA4tP/9CxGvZFf5Qyu/wMfIXvvhD2ZvxExm3c06ljDZ2/Kk
         LFEmvBdbMZymMmOxuRoXp+tqJFCGYPWAV/cqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473606; x=1712078406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/JfzjcSIf6AcXRpAIfnlPrKIYRo4lNR989orexK8J0=;
        b=aULMgjl/u4F6K0Usxf9xryqH/0qkZzAGSBEHigmNk05d0uJ+6/e0ONhKbf1XXEfdBq
         x4SkgRmcTjs+CfJUMwekZm5UfLkZIqx8gjjKJgu69j137WhEShC1CI65OVA1tYCPoaC4
         pniATuB2qSL9UhwSf1TEAAJROssYOg8QH1KwuqW1YaXRVZGH3rozEKXf6a63zHFZc54/
         7Va76kt4Jgl8LUCHx2CsUwHk6LNtSlf85cXWh4SJUoZoCvvuaOgzZTfSIlvd4GWcy64p
         Lj0AQDAcJVxkd5HnjZkFBU+KnpqoA/7mQiW2H9IXW/i45YodQczq+40PN4qAtLHcdWeX
         bSug==
X-Forwarded-Encrypted: i=1; AJvYcCXTrPtmA7rUOg7uL92cSR+oJKy4w7B9IN34L/dPww7soEQSfnaJyykgtoxiR82bq/l8lv/FSN3ZQ1TJBB0qMUQsIY9k692b
X-Gm-Message-State: AOJu0Yxx4xnuIK8aHv8kdI6Lxl1DEmkhhjLpLDoMJqCAvVaJdq9gzVfh
	8lzKApkMNSsXiA+3R56E/FOOCzKoeCSm0ardWEuT5tOD+TKrjjZbs/5HlN1GFv8=
X-Google-Smtp-Source: AGHT+IE15wMU2iSnf56HwEhVmMoLmXJyEZ50a71C9JL9A2kJbtymsHuiPJBRedggDClrCyFDEPfScw==
X-Received: by 2002:a6b:e618:0:b0:7cf:24de:c5f with SMTP id g24-20020a6be618000000b007cf24de0c5fmr10377772ioh.1.1711473606140;
        Tue, 26 Mar 2024 10:20:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t18-20020a05663801f200b00477dae75331sm2826852jaq.51.2024.03.26.10.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:20:05 -0700 (PDT)
Message-ID: <1ce59258-f76f-4796-bf72-e27bb078c5dc@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:20:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115928.1765766-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

