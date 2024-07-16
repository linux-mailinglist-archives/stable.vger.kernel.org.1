Return-Path: <stable+bounces-60354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBBC933241
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B274B23AE2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872A1A08C7;
	Tue, 16 Jul 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsBmp2bn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF91A08AC;
	Tue, 16 Jul 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158752; cv=none; b=AvmsoDsnwpejEUzPOHl7e+BC9K/5c3ww3vHKbpr9TSnFWi+PxKhPWXqHmxg50K9zbeSxegvgVo4rwadqc8ONP32RY+SFcWldHF1vfZkvj72zeMJu4hWfjbYT5ky03RtaqgqmDkGPLd1qCvJdkVGALXJS1Efcavvyued81RKlxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158752; c=relaxed/simple;
	bh=SFnYNtOX/L1s2rt8W6yry0w/IYE9fQO8IYOkwAWeNOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaXcyqC8IS4JD8KM7tU+sftky9+kyQtp9jaFMSOj8mkaExqPv0IWdTGNBZoKsnm6a0t/REJIID0NvDiJWfKxwStJ4gt/L49f9QM2JNTk9fAw/psnfS5/1zPfwaQvXtOKyittKDGeN72fc7nQofnrdsT7j8quIu7PpAtLJ5XHR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsBmp2bn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b760dc7e08so25420446d6.3;
        Tue, 16 Jul 2024 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721158750; x=1721763550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kH9hMqX+74zTwKMOrS9BkiKcobiTryPKW197Iu7EZMQ=;
        b=RsBmp2bnuoLkPf90qhZbIxO8FrTIQh/vX5JYXrUURbZXsuKRWuCk3ziziGgoQR1B/H
         JsPO3e/7ve47D91WUCVzFE1Gpl42ycsWyY8DMVAaOzEKtHAaXNJBTrAw9jowfyQk3Ijm
         LM9GL0L9tPy25ALUpjzJdboU3RnQN1cQWtdqfrRJrh/eSmzlkZTuHw40w0BlYPCMLn6g
         ci2qVcPo+/Iay3VrUEScbCCEBNoukEXIx1BTfxDRnBjn4AJsVQPH/IUByosEHKa6ggQd
         TK0X0XYVry4B1wYVyDOVgpO2qaVA5x8FP225oTMfwAHROR8jwTad7B5iZRvkq0vnjrgd
         Ygtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721158750; x=1721763550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH9hMqX+74zTwKMOrS9BkiKcobiTryPKW197Iu7EZMQ=;
        b=dVP5leGu+We4Yrs/tN3pRuijX7cB44k6au9jPCYXAlOSF6IgF1gPjlw0cWt3XgauzL
         6GqVoqnSWu2G5mvJU+MsZ0F+fZxiMqRAq8RYUHB2ZFnk65vr/JtkkPH3Pl51xuMQ4Ln0
         qjyYLS5w0sQ1kfRVbhSQwgMUt6JipGFM8peFww4R4+Pk6D8Z4leQLD4hOI9gWeYMZgMF
         2BGnXwGkvUFO0lYi0fm957hez+xr7wBZ6kyfGqO3z9M3cvibXCo24LOU0V1dWbDW1D9/
         lHonwhSObXGMiRMlrMNZsEgiwnY3XueJ7PdKL/DDTbiFVXHK+j+HKN++gZKS01esNdoz
         2MVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ouyr7WuPENSqDx7MPkm5LV4wkjyR5n+48zuBCtebyBQxPrsIW+yoPObhaVTk2FSw7AzPu2CZFrE2HG8Toc1+GOkc3mB5y54dY7bdOGTCKQC2gc5GG5oV12njuOqB9odbAUKQ
X-Gm-Message-State: AOJu0Yw1WH3Hz8k7MjboKDap8V+Y0Dfb5qEwdlmvJvD4m85BfARSRmig
	GdBqShZNxZ6kjGh6sS1nKOXH3wOg4s7AtMgO2s8QmcgbsDr/rIfw
X-Google-Smtp-Source: AGHT+IHQ95V4tAwmAsKIqQ9hZLbfGvJSJJoxcNc2i/Kb5qb5MSj61OWqrm+sKX+DSRZD3H0MJBOQ6A==
X-Received: by 2002:a05:6214:3011:b0:6b5:da13:bf42 with SMTP id 6a1803df08f44-6b77f62d83dmr39168296d6.58.1721158749565;
        Tue, 16 Jul 2024 12:39:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b76194f42dsm33958866d6.8.2024.07.16.12.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 12:39:08 -0700 (PDT)
Message-ID: <e93903e4-685e-4960-aa55-6cfe153992c4@gmail.com>
Date: Tue, 16 Jul 2024 12:39:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240716152755.980289992@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 08:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


