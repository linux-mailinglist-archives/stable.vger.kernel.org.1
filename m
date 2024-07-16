Return-Path: <stable+bounces-60277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B554E932F5C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C23B21B41
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44719DF8D;
	Tue, 16 Jul 2024 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6NBUOin"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254D54BD4;
	Tue, 16 Jul 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152192; cv=none; b=PgDybpD2ZyH+3cwsGDqErsua2vDbxzGfBC4ZTBK4vKLCCvxmyQ6x93nNh7OniW4fyvckU0YErdy2Zz49mvPJ0WA6rB/mPprO9D9nMbkAxJqFMeibi5xOgnvprhQCEPmaRWVV3nzCOAHIxJCrA1tIUSVXhGie6GkXB4D/kuSBHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152192; c=relaxed/simple;
	bh=2YgWT/VTHM8vCLSpVHJrwCbPuHut7t6GyCnV+GRWJbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKfTgFPvsuQADpqVc636eqgHaCOBVmyF1emVPYLt2BFK5RCVOboM3qmdzQpwy8+oiOUYt0mqVEXhSX4VmORg7VgSmN3DfbZegG18xoRc/v5Ltpm5FQ/2pI4fLC3zBsgVriXUUJYWoiiy5OQuPjuAG/yZcm3LHy+VnYjg5MvASfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6NBUOin; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-78512d44a17so4210244a12.3;
        Tue, 16 Jul 2024 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721152190; x=1721756990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw21HKKLStYNAT8K9Zm5OQcaI1CIyT02HeyhGHNjbwc=;
        b=c6NBUOinySJ9WVPsep0NKQRcp5S+SC0tFeNRxzqF3Wee9yI7QIvZq+bHqZ3XBe4fHy
         WOKJYa2Nr+nkL7RuGo1jAKfz7sDOPSOqHGrgSK6UKLsP6ehEj25sEoYHcXAuCdPR2OP+
         QQHC2I9CT205QH0Lup5BX0aEFrzAmDAgAp6aewLwPdgsQ/CbLo5Qg8IzFz7ytW8JqtFb
         o0VH6DXysIw/F4bMBxl6m59py8G3oOXa8MNwKRBoubxZoyUxPgHooBCpC8S/bnTjcLky
         +Yaaykw0jxHYB9FfnAWbbqD8K2Oyajuz3pj+8XqKNT/Tg6bzZnO4q842J4wYmrbFT8YT
         V4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152190; x=1721756990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw21HKKLStYNAT8K9Zm5OQcaI1CIyT02HeyhGHNjbwc=;
        b=P1Ypk6znwPifUAXwBzAm6zpAw13APUxWC9xbbG7y2E8mMuk5omQVuutYBhzn/W5d2B
         X54bSbg+f+iba3gtIkepx+M5t7asmDSQwCLc9m0aZJnyTiEnvAz1i9P41bX0lz7K4DHk
         k/gCjWOZCsIrnM8cKet8Vd117JSPXuUDPzQ5BBM+kdUHnZ2LmDEzCYz6lU4uRGTuOoMt
         MiN+K8YxD6v339rNAbHWENzZWZPu2+SJstOWCfprLex5DwgXdN3xQR50k7ZGg+xtnj4q
         USZXtZvUYr3Lki4vF0aQZahNN/EgKwmNrH3ePlVV4eyTMgQAJm4zNLtPVm28v9HbD62l
         S/fg==
X-Forwarded-Encrypted: i=1; AJvYcCWaxCPH/T0R+ayT8u9tKYHD8SBznag019eS4AB/0p1dXjfySY/Xg/JqIBPNVDK+bWFy+W0hhXAH+IlOmIi5ggHQ6w0LZh1TQdI0dNIL3RD8BKnckZXG/spJP737I4+b9EX4sSk7
X-Gm-Message-State: AOJu0Yy36VsFatTR3KQUoFniQl1N9FCZ/k3fdY8Y3KY7AU0Va7u8sfN1
	qgI5kgk6XMLZCXH9o/kLiVlNb/qAK0p4jpQ2f1fV8DqALXqPLql6JbVVaA==
X-Google-Smtp-Source: AGHT+IHEUJk0xLd08fCWUkUT6q7L5dyqKFpNyi0iCdDU+61xVknKryfkyO5HXzgACjh2WUmNoM02+A==
X-Received: by 2002:a05:6a20:c781:b0:1c3:a446:160 with SMTP id adf61e73a8af0-1c3f12d1da4mr2342066637.56.1721152190245;
        Tue, 16 Jul 2024 10:49:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc274dasm62983165ad.166.2024.07.16.10.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 10:49:49 -0700 (PDT)
Message-ID: <64f66282-451c-454f-a437-d8baad186868@gmail.com>
Date: Tue, 16 Jul 2024 10:49:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/78] 5.4.280-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240716152740.626160410@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 08:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.280 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.280-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


