Return-Path: <stable+bounces-206072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68FCFB81E
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DAE3038056
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C11ADFE4;
	Wed,  7 Jan 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6/z6ayv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A41F583D
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746759; cv=none; b=qEhAVfNu2C+13raRHwQ3G2XOkIbtw/HIllDb1JYSFHckIx7jhvr7TrKTOK1e9E1sFWFM0t7UWPbbbiXybsiM89lK3fp8zQUaYZNTbvIk5jXXNdtBt9/GKnNatQg01fO0ddBcGCa9gB8MBivJQeNEmVARxUUOCn/th4aZzSCPadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746759; c=relaxed/simple;
	bh=OFJYdoQzcXwLttrVoAzXKR+W7kolRRGDljGsgq/C/Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhRxQa4G5fnOwbPFUPfQGOolcOPlJo88Yl2WgZS7pc/gcgsgECK3VifCN4AJvD7cNPxiiSC9b75ZRf8vrhRTpZGiqpuX0X12sW9xqHL6hxZLBku++RyYeC1GO/2immDJd4yPPAyDKuUDqCELVtD68G70A6WtaN2GzKjIBBckLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6/z6ayv; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121bf277922so1190890c88.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767746757; x=1768351557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP297vg8zfSDiTJ6Zr9Nj0Ru1xEj3sVMbfXESAoNKCM=;
        b=i6/z6ayvDHcmuG11FVSh6lm8u+v9jp+jLv+ZwHBFrD10EBudXrc8sFpjm7nYXJqRR0
         h/2gtRsi5iE6SsvacTKK989xH3anb2sEOM9ihuzYsDSFIV9C6TSYanNE9OyJcXf8fCkh
         FKlb3aT/V3tEl0tb1RZrUxMIW7ekMNHwgQhYhqhbPrUiJa5V1sTk6agN0b7U4gJl2l2n
         fZAefQoGRWyrOIgSnwjmb8hS2EVSIEr+OSV+msYHbFcMOcqMN/zsOjwcY55YYKeOJ0Wk
         9nUQpdVQUwnLou0qCgzBLIH2YmoiTcObICYSfgvCKrep5ZGHZkrdmUG2UpJMlAprP0fC
         7A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767746757; x=1768351557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EP297vg8zfSDiTJ6Zr9Nj0Ru1xEj3sVMbfXESAoNKCM=;
        b=Nbls88Mx6xHxqQJB2ct3TRyDERVotTMJw3f6EODS07dPb/+uQt6hjUkcH6pL9yBhwY
         zJi4GMJmjbPaQhegzWTVWYWvUG2atJ3vjAvbFWOei0JaiFiwpKL1TeuFB2PvXi5rEDrZ
         yW5XQmPCq046PQGnc0AW4UTKklq43XpO6CZUjY4jnGaCmGOFYxqYjoee56m1b1276it4
         fhgE3bWku+g8EjrEXcxn2Wzrptw9nBs3HVMxenLur+bHZWASPtX+PJcR11staYV2B+LC
         CVOWN3ZpNAGcNO12W33NKB2lcZLfBV1TnjBloJB36MDYVGteFJFKN7l8t21mwVglyyyw
         kLFw==
X-Forwarded-Encrypted: i=1; AJvYcCVvVmRRGNpHr4VOREwQIpLMbK/i4BGaKItUH1eB1c+4HOnIaYckLvpsPC6nLnFTK4anCRmNIZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsRRO9cLupWCyNUtcrmVPGkXSasHnJJR/Y6jnWH6RCnaKLPWf
	W86DawvR+ZJABN8VZNH5EZY8TGkGtQ6QYBcqWBFY7fZOp6GRG1WDDEuu
X-Gm-Gg: AY/fxX55zkb2K9ekUC0xAo5vGo+1EYH5xqKITNzEqgKwxSUGDCd0cu853dUCpDyG6cn
	+6qKHDI0AobTfHWKsnl8Cxsc+VYBO8ubxBrs6ZmOdB5/kQGX7R0anQd4j6HKWJUGsDbMoCm4gom
	yiozUqOjISIV0YMhvTzgXK+7gNZQbUE+GtNSJR/Qtonq/4n6uZ1zjCB8CIII7oJCNOQbrAKRRhH
	AtRBB0W+ykIzsj1ByR+d/E1NqM37Ziy09Z2Jn66chKk48zU9NtjKNg+OS0EJ1GRK/AnSRgdRpMe
	HWMxEp5voI8jAdJ/y1F1Rmszcozy4/PYlBx3Sl0b4pdLdBbavxVWODvI3obMRNIqLE+I6K0I4Ez
	u84d/0QIkILKaYvxbpHgfmXt3Iu03BDnwfcrhNO1gIQ1GwOUPkpt7RCgTWIHrps1WHwAbNiu1DM
	KDqO13cz08fCS/T5oQxW6NXE3oawht1vSjRYfdEQ==
X-Google-Smtp-Source: AGHT+IFhgfq4svu8rEScbRNxmFWK+7vRCDcNtFHbpZcvY4SlIUakl2hZEI0cSyW0E0eQG/NGrc4izQ==
X-Received: by 2002:a05:7023:b8a:b0:119:e569:f622 with SMTP id a92af1059eb24-121f8b7a8bfmr483302c88.27.1767746756928;
        Tue, 06 Jan 2026 16:45:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm6694400c88.9.2026.01.06.16.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 16:45:56 -0800 (PST)
Message-ID: <781c6589-d7be-4798-9bc1-396d1f51e87e@gmail.com>
Date: Tue, 6 Jan 2026 16:45:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260106170547.832845344@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 09:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

