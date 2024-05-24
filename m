Return-Path: <stable+bounces-46087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2498CE8A0
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF96E1C20D6A
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5112EBDF;
	Fri, 24 May 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2MoG3DA"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F712E1FF
	for <stable@vger.kernel.org>; Fri, 24 May 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568003; cv=none; b=bzqevJES36VhtOqvYUQz7IBoLEOpUXxSC1Mpyz3un5e6XvlrudNtwXUGvyTbbMcOsMz5/rO3nrh8HfoDpIupkmnfLjovwu6N6p0iqUG4dxTTemZu6fvT8IN4+b4H0oLSBOyVylclHyS+6JUSRwYZnoZaA+VH0lL913j9vDghp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568003; c=relaxed/simple;
	bh=uy3Bu+RWC2BwlJbf2rF1oLCzsBktn97cLQW+3/UQOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvhtktVN34qN+9uSjuFbOimuvvHMKpSDGwtAyq/VxkQri0UEoRy0LsUmx+LtpFgU1lfThPw/y2SQX0DdomiXFwaHdvrQuccQ/BE/k/PePXrXYP+npcnQH6FkkPVv9231QALdP7unWC7iLKWfIX3dtjDfMVFl7+Ef7mH69QG7KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2MoG3DA; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3711744c61cso2977405ab.1
        for <stable@vger.kernel.org>; Fri, 24 May 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716568000; x=1717172800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsPe10u6HqBDcmGD9Z1JKcdv2q+3cFzOGeNoz7xgfPM=;
        b=b2MoG3DA0N/dGtaNaWgvKcY0kSJpFnq0ZJbLBk6TdyVA0paB8HiXM1QhNAjuVlZS0z
         X9qT/kyY7O7QnU1bxKaVoFO0s5EoQsPCMyhfBOhV3447OMk3x/7VuhASdAUm0clEqXEI
         G/6FYhYaN0ueKBidd62g5t/kbZn3QEu/gKoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568000; x=1717172800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsPe10u6HqBDcmGD9Z1JKcdv2q+3cFzOGeNoz7xgfPM=;
        b=nRuN3sip9s8QC+l1ZStK/7BIWedC0KSrOkSCB/Pkx9aJimvlnS5aY6sE39f34Isnkx
         wDGKk81ZROnTF4tc4jwZf7ricU4CUZbp4cfQElzWhmZZKIc2WQb2Aq3VLFnj4Thj/uTi
         8yTCyOEa594tifNRnalH0d17V0o8LqrHoGDYWaBNZ4EpEzGuQ9BzwC5bGxCEA/8XOeHZ
         wfY9oEY20GI1dCdN9eSk0g+KmJZugwwB6F3+LeRM2tiEvBRC1GuXN5cAKlSuZmeQssuS
         bgcsB7I79azzT8co0mrFfVtCT8v7p7WP3StjN0YC1sAnH7VLshNizHPR0Dm1KkhUAe0/
         YshA==
X-Forwarded-Encrypted: i=1; AJvYcCXa9MP4oQKC8AoSHRHWLRYP8Nflu0O8DSAaif/vJuBVQ5qkVFBRthj0RxJ0EJsr+RjfJhmEcP0SSgwpnScHllDks9E8ItO2
X-Gm-Message-State: AOJu0YwSUTc3jmxLWInN1qm4q8Xu+QIhW70XTPNJ+daAd3HfqVdtzOWl
	L8hUh5nH5Fqpev2wcBvJHGCgIXu1mIYPRNFHGzXOxP2VtwTipc1I3b2uYi1v7YI=
X-Google-Smtp-Source: AGHT+IFZbhef8P56pBniXYHEspKkB2ti3g9EoFPYnn4FxykwHwL2OKJqu0yxdgGOlJl/tpiHmBHLdQ==
X-Received: by 2002:a5d:8783:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e8c65599d7mr325855239f.2.1716568000560;
        Fri, 24 May 2024 09:26:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ebbf1bfsm438640173.89.2024.05.24.09.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:26:40 -0700 (PDT)
Message-ID: <af4aefec-c893-4356-a50b-5f67a3913740@linuxfoundation.org>
Date: Fri, 24 May 2024 10:26:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/18] 4.19.315-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130325.727602650@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.315 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.315-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

