Return-Path: <stable+bounces-75889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BE975947
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B932286140
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757851B142F;
	Wed, 11 Sep 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNf3EJ23"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE01AC8B7
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075536; cv=none; b=s4v+9Q+7OgGRmDXmHcOHiYp6TGUvCbh8aSzbXkAhZiv3yA2WjgrRgNz/Y87l/vlKtjEGWKjj3Mj9+Wt87BeTmiVn0XMzyIEHyUFlXjhCfDKFlql7BVmzngsRTE3sJl+5Xz+aowdX1eHVP6p7IGZrRMUJNT1QCyheJJUXW5insQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075536; c=relaxed/simple;
	bh=1DE5fZyEHazBhk4YSxji28x2nF2X7K9v2+xK+H0heYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIxKOCEdaVkNtuVzIPPzZkv6njpjWN4IF9xH/xDoWAXCGD8R5DXL1uWCi96rCQFHUWUnR7jib/YdR1FC/HKChlLp2c4B/umjN/FzDUK9vaOANYlV4qGLbofosSS1UzYNRiP7GOYVmC88U2ay0fpMRJRJIfitpBfPKA+FJiFzzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNf3EJ23; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd93a6617so1058839f.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075534; x=1726680334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtdVX8O4R5RlEn6XgHHpJbfm7Z1QBa4ZYeeQfbViS0w=;
        b=TNf3EJ23qhHSzUNJ8VGt3l4snw9y+UGwUK4EBPrLIJ+9I+ggm3plVgYmeglIsRN2/o
         9j+tNyFmV+isLxnqql1EPZq1cITD3DY7B9vnbIW4SSrqZngIEp/0fAZb+fBxSIDiSDw6
         J6Th4VQ2yZNcBm+5IUvwg8lsRHBpmiwZLeUQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075534; x=1726680334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtdVX8O4R5RlEn6XgHHpJbfm7Z1QBa4ZYeeQfbViS0w=;
        b=RMOpWRt2yLnVIoQA8fB//gNAxDZfMtCyEGKVvpFRWFQ9BEKt9xGKGmjEZmDxYyyU71
         a2P6K0unarg/niIi3FJlM5KU2RooyeCRYQ3fUXXIQOi7y1ufrpyg1eckVVvDff1ZGA2e
         J4HsdH8uN58+Uzzt9gDWI0nUafwRZ9XVd+Dt/3ulBgKioy3oS0c562NCyBYhYlROkgms
         ryOKG38JyHTY924Wa4D38cyP7XFIJnkrmI3RjaPNenbhreZz3uVcgvS6HDH1IzeIacNM
         DPWGbmZ2+rO6QlYeZclnkLCCX/isW+LSH62xRfRJ4nzix7Zg/JxdOLHAXwGruDtCOTbg
         16OA==
X-Forwarded-Encrypted: i=1; AJvYcCUF8C+XvvjE1ODxOMWA/a7gnCVzVVPYKTiNzGfNNtLyxirQ2io0L9elZuv1cJOb5VEUOXV0dFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0MsZsZrq0jtBuZNCLvqbppTPQYQQGThVkKxmYNVj/8nqPiXq
	bVEHjG78WOu5uhzW6f55EtNEgI41kR50y/J8cSMKF7+qVvLEOtRNFFk3IhyjMkU=
X-Google-Smtp-Source: AGHT+IEzkYDwTXtn8Y+11mQQfMaw9Yt24MtITkri4cToPizDt4VvR3VXvFo4NwxfHzWwKFn8OVgcXA==
X-Received: by 2002:a05:6602:6087:b0:82b:c70f:5061 with SMTP id ca18e2360f4ac-82d1f8de413mr37458539f.7.1726075533508;
        Wed, 11 Sep 2024 10:25:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f954537sm91790173.171.2024.09.11.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:25:32 -0700 (PDT)
Message-ID: <9bbb8370-758a-46bf-a01d-7e4d4f3c3a68@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:25:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130535.165892968@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

All good without the iio/adc/ad7606 commit

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


