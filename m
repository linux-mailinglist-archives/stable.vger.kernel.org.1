Return-Path: <stable+bounces-142834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20253AAF876
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB51C02B4E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3420C005;
	Thu,  8 May 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRsxXq6Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003313635C;
	Thu,  8 May 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702355; cv=none; b=coK4CoX1IewEvSQAcUPAxKzrXLFBF69jBjNqWMetwM6FLbDa3MXYWFfg+lBmwSfmKBPfPDu7SFYUwR4I+GQftRosnSumtlKilfTABXszkQUM4PyI1RVxRmaRHOUpCnIKir7/EAIIFA0rsuH4wUkjNBbXYhEZ61pcvSJsPxY6ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702355; c=relaxed/simple;
	bh=krlkiLPiuBZ2Ba9eZaNrZTnwFwaBnPtOs0WXx+wTRrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrzB0XfrR1r7eqGXT3uLUWDYNUmLUnd4NdJ6iIup6drhqNw5LS5C3KyC743jQbEJIZDNgr21qz73dZH742lQtyDpWgQ9/iCy9WBG+LVh3b7MWuPNaf7tGRqGfMYWbNLVoQxvsE7zAf+vXikQyt+rSMAnDG1WQbOMKwWEea0zLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRsxXq6Z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso874527b3a.2;
        Thu, 08 May 2025 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746702353; x=1747307153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oIrGaMv6OkRkilaf3GujYEmOM2f/wmwn6/n6QDL6LZI=;
        b=WRsxXq6ZvmZITjgkHYtCc+8kscWUgT9JyVou9JGWw70md/TZdp5P/24/qOjHemyE0n
         jA0+8B89RJs+u+NQvUYRAiqCSfMdee9b7IR41GawYTravsKMPbruoaGCJfbgg4VJCsWp
         9byK9KDOBFAZ5BIM6OrPBxsvIQgnN6tIjYLdlhh/e87p2zigO+0ZFTjUQE0oX5mi0lFR
         nlRF2tjqTsQ16qNkRjE4eA2pnTk+nJuCt3BBfncsJKMclK8OX89Sy2HQvNPMJooWe34f
         UayeTcQUqka643wb3dWZo4kc4cvtgkNMY8TVQnBg6ZcE10r31s8L+c3YkkkzTUAVTI68
         dK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746702353; x=1747307153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIrGaMv6OkRkilaf3GujYEmOM2f/wmwn6/n6QDL6LZI=;
        b=n4L90IdrjsRS+HakXKsIvpJ2I1co9qFTtDEGuzr16b4Q68qB8sSXC+DmggoibRxGjC
         /rPdIxOHMnf8mMGO4B3WpgvyJ3RnUj5vArTBMb6PeuwYsKMyqhpm8LJDFJ7y8vNjJ49l
         2YmlvNXktUdwoQTCBEv9wkriGEWnIAHPf5iLxfB9FSnhN0gNnc5un2Lrhasmw0BDZ+Ud
         h5UEg18RAapPqwx0hf2ll5suz1XeF3xG1cUgbpKmVArFwPqQXf+1r6apOHhqZNBEIQhl
         yKbv5Mh1WhabPVoGB8he//oWPdbpnXbD/UvidVQGxS3HhaDJdwiu8NNJT+bDPRBeP2mQ
         y8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Zx4wJKIbVo4xXH7rIxlOF7du+GX8jgQr5rIT6J67oSewZtSP4mUD3fRo8Fx8SmswQPlThVZVegxTh4Y=@vger.kernel.org, AJvYcCWPhF8CtRQQs9xe9pJSTYYfzipSPbWLor29fgkIboyoS3msyvWv/UNZVIxZVP/MNP4sfpMe8hB3@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJ2aIOG6EyXbzlqFvJxl/IhPhAKrrq1PJ82JAex662jRRqfb1
	hBKklKLtWkv/hby0GKAwz8IIYTWclL52EJg3r5fwo8zwp1HuDjIR
X-Gm-Gg: ASbGncvhS7yniitvcKy6bYyVzZasSwmIXyuiTUhg0RpGyoCFK8doCLIk1hX6UssMimg
	i5rqn113gcBapUDMFHfzKWwNVgsR4vqCfGICLkUxZ/dgz5CpOmmF3jKAYCjP8wnB/wPO241GZ1S
	uepStiJtqJxLW5a2CW2l7KiJ+/s2Mh8LhS/cXzdBJuYOwp5dDNn/ecw9BK9I4KjEfIAaEORKkKY
	c86zTu+Z2reo6l6gPpBmLl6rRgW/78ixm0JMKSccc6N8MAaPt50QiIz/sIep4LDWJ+88wRcACPh
	Io6NWycm1gSa8rWteUyDH25ao09a2QKv4MQvQOzQEv5seOsR+hupLq+2wlBDWeBainQA7vOGbJU
	yKHApKlfNCc65Ti+yCJuQ+X+FCqYIXpFIWA==
X-Google-Smtp-Source: AGHT+IF4pXfOdQWoWOnJYL8SseW3WCx7Qjp7xhL74Pl8m+1AgvycoBCloJ7roQxhaJOxpzAnG01Uyw==
X-Received: by 2002:a17:90a:e7d1:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-30aac29bfd7mr9927709a91.30.1746702352756;
        Thu, 08 May 2025 04:05:52 -0700 (PDT)
Received: from [192.168.1.123] (92-184-98-225.mobile.fr.orangecustomers.net. [92.184.98.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d531d1sm1929960a91.22.2025.05.08.04.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 04:05:51 -0700 (PDT)
Message-ID: <8135bf88-29e3-4ee3-a680-fa05857f8910@gmail.com>
Date: Thu, 8 May 2025 13:05:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/55] 5.15.182-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183759.048732653@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250507183759.048732653@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 8:39 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.182 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.182-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


