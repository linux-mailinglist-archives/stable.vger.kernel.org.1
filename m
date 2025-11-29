Return-Path: <stable+bounces-197648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 783CEC945EF
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E54E1798
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC030F934;
	Sat, 29 Nov 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIC04vV/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653620B7ED
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438234; cv=none; b=nQ2iyGlcw+d0fmOx4wWneTyi8p1MGCECvH9aWpDUGEfp5tyS4Kg+SZiVfsB7EygGa4l0/9KM8oq6a+up5m5aBF+V4k5H5nknxRPj5inHedt/yhJuqJWBktEeEPowTY8FT4InNK5uQhXvp6eM2cJVVFgT22IaukcvIL+oLfhVtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438234; c=relaxed/simple;
	bh=hr/EnxzYarURpGb9g+Wt795YBjF7OBdlPOZnM7GdUlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR/XOAvf28Jjfzmpko9q2CaUZFlO3MK7L8Kv5cBHy2eHOenTza89Ma3ISTxm1Y2puxDb9ALNub9nM+Tp3av7Y8Zns5T7gbcyv47S0gALDM1IRN8oPaOj571ObHmNZb4pg53UN/zAa4dP9ACSyTrx8016qY+QQ4Z9sM2sfYoFMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIC04vV/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29586626fbeso36221495ad.0
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764438233; x=1765043033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjKc+y/SFNC4IxZSCNtfDR+P0M3U1zDfQwhqKcnpxBE=;
        b=UIC04vV/mJISYNEWTgIre/UmV+o9AYa3B40sJ1YGA3dhoujQnmcVCEwJ588Dm+6WDt
         5L7ySzAYUjacTMwncdbUn6d27JjKA0T4R0GjacmNXwe8Tfh7uC0djSd4lwoZkSJi6pCV
         wDsZqsDpVvNVBZCokZvqsj9dihqIASuPEsKKC72nSD3PggDqwz3jQw7kjZD54t2GcCHA
         H4vcK1GC+u+xx8Fj04cQhg7bnQrhpLlGROEji4dNlFNuhmXKaC+nmxCr4fQIioShJTit
         yJvRGFBTrYFr3toJ0ocmnY983Sq8nagaLS3C4oH5zmRBgq5sDTxPWlL2p2wmhVD29ypA
         fVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764438233; x=1765043033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjKc+y/SFNC4IxZSCNtfDR+P0M3U1zDfQwhqKcnpxBE=;
        b=sFp3GKJi7qUEsclhY8VE5JtcgvYKfCa5KF6/IytSJqRQ+6drWaCXmJfAR8sRNPJusj
         IN+3Lh8CSA0qA6Z1m78OnGX6Axi8rn1/vK20smzpsbYXgXolsqozII9+Kvqa/OD+4MBu
         udUgfc9K1ele9B8ms0oVkZYDt0gG77FX7brEZ8rbGpgbYlJms2QPRjPKvyd3jGwFtEdf
         keRPmmnOicKocxgR7K31UD674lnr6Z7WvUazwEFe245YPNuFLc7bS1otwt/0V5YP8kp1
         p6QPi1EwikATODBtHU095jUnBMoUtpLXvg0LXcCIIcFnNtUv7BvHLOS/lumgGHGA3/eF
         9vhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzRo7fN/jxH5dtsOpkNt/iNZAFsWSKLCe+CIVLe7BYAYZ6nSYmtWQ/lCShTzOzk7I7p9CnuG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPzPoYHGbfV7So67exOStKe0iojo8BiPg1fkQNYyj8cVGd4Ym
	TzyNBZ6/NdQaL53/7DnosNmAdBB1j3ItStpGdMrFn6Lb9d9r+IST9uQa
X-Gm-Gg: ASbGncsIL8pkLHKfESf1x3VNlMn0kzcfpBKOCro7rahuHKxALnppGrUbhQhVYLKOFfd
	FUlpzSjH0HO4DTmTnBkEw/Dh9851cMrK0+f4yKhUlDIpKEtUiJ57MYfKUqi/iDhEYg4v7Rea4Fw
	FRK+fxPNlEKxLP1OuWrdEFe7qTW7ROaeKAjCbNxqtFDWZE5ymsSDSDYUGIYssfVQMnrv0ZpPe2f
	79zyw6CuP+4Usz/xjMcjNahtPo2W2Cbuw+VDr/837haI78bU1s2iCbVYY8RmNQOaSksjuBzTfgq
	IVW+23OAIx10FPlRb2UhKfV8bB4BaTZQUGQE7SRaTYtUjhJOy3Pwfm8wDe+M1MG9j/7wM70Kokt
	TjwMOPn8LthZpkrTZPwESzjtSI62mm7vO+YMUySlmyHmusbmA3Fq1fbwGJ/eKU88XsK+HW8wjRp
	uEg7r9y5VJf2fBvQsH6n4tWDTKY4aTz1fhoukyPp1U2HIviQtM2xJM
X-Google-Smtp-Source: AGHT+IH93LL3+ITbLAjL09Z3q3AunM/juzsLkPDlXTrXTowB7qxVhPg3FS+bcxr2Xm6E0HA19rYfHw==
X-Received: by 2002:a05:7300:6b0a:b0:2a4:8aaf:d6b9 with SMTP id 5a478bee46e88-2a719112b90mr15450649eec.13.1764438232493;
        Sat, 29 Nov 2025 09:43:52 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm26746638eec.5.2025.11.29.09.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 09:43:51 -0800 (PST)
Message-ID: <9fc9bf59-8d96-4294-ae3d-5286588791fc@gmail.com>
Date: Sat, 29 Nov 2025 09:43:50 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/86] 6.6.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251127144027.800761504@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251127144027.800761504@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/2025 6:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.118 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Nov 2025 14:40:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


