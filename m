Return-Path: <stable+bounces-94475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA99D4471
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 00:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D6E1F21B82
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5391C7610;
	Wed, 20 Nov 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwKPqsNw"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6261ABEA2
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144934; cv=none; b=boM7hi8CaMQveznG7Db64lBLwJXvRIZh7PAEvWd1ZSzzeZS32G13F1BC84WCasvMXdSI6bQVrn83NHXVUjmRPUJNWNg9Y02Jx111MAapDGFcUT/bNi4KJwviNx8tSk/d8kxOOWSKz83C5eKHxtyt/Iz2No4BnxujJaZAsaUEo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144934; c=relaxed/simple;
	bh=jgDIqGZI7Qz9TWm+MGExUPJL+GPCEewDXf9PNDtwKvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEXR6QdQauCDFXQABTctdC3RS3QhMSW04ivSlZCeXobDcAQckOtQ24P916gADoDtC4+1ecPWR/KCnoMgXx+2jmHnhsx28FpFBnTGCKa/HrxzHT+HB6mmh3CThilZ5s2/uHfMZB0NmiaKbv36UamQgXNg9MAVttU23GYP8KW5DVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwKPqsNw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a777fd574bso857155ab.1
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144931; x=1732749731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNrmDAVT/R4KOHT7JjL9sZNJ7b8BJs3agtROKa254/I=;
        b=VwKPqsNwgkxQWm4q+dIbdoGb9LdNE1Q23U5qq7BNvdutXXx74gU9Tfx9Mv8ZNw3axg
         U0W2j6Kj53MgsIA9JKRxNKfjj3EovPgrdJcKRqz/TguQUULVfZSoSki0r81giAplW/Da
         8XZeJoba9vAh1LFSU+NQDOEddcwGZVEIoZLDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144931; x=1732749731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNrmDAVT/R4KOHT7JjL9sZNJ7b8BJs3agtROKa254/I=;
        b=lHeSMzcgL+fQ/lqcSYHNwqKmRF2pfu5/oBN1EUoY2EIi4Mr7Ksia5/ZgutBgK9ziHN
         6IcWpTk4JoCBkRwuCbV+SLBoHqju0xzT8twoUXoYKUKOhBampZk7h1MPIicMgEcGnLxv
         E2ejpr0XEA4vlD3ZFD/s238V+IwKS2DWDuVEaur4ArDNpjcufMVCeaG1PhrGgNawXYcd
         /aaySTFWSd2sTDU4UVYJ9BX5iZPCLlDQpUDV9rh/jsLvVinQSh/fKgIuJ7UjPujbTq8d
         rlPn1VoAXcADi/J+oc//QAjNoqGgwncfCHsi7eh/O9Zkh7+j/RDKZMeiwXS6874Srx33
         j3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjzUbyJ8ozPWDd58A6lBi+URWdX6HAxSPj33cx6EeTa+lwxzk7V2QBn29Duh5vgTn9FOxTRS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9m7Oc1mjkg0iiss3fT8gGECI/dBcAca59yB6Ze1CWsSTUrAt7
	l5keLBKKpqM7a27CFbupklRaWUH83qR0ZvaqaTk0dvlURwD9yY6tIVH3B9BbPgE=
X-Gm-Gg: ASbGncuUX8wLhizhj42YyS2rU5jey9bl4+qEia0kuroSUivc8wkyRCje72rAVTBHuq2
	onnnNwJs2Ee2MPGoiXhJDxj+xYH2H/VTrgq5O11b0TGY65EbXoV2mlEMCrn2wo8BGE1c9dAZdUh
	ApCPGpKW+m+6n1u4Kb1XOmgap1XjxDj1pUC2F6Ss1VT4VepsIOTbcGE0XSXr5klgs2z6kpm56aP
	3cM19VGIeO0UhsmyiXxmNWCVGtxBKT1tbLqVo6fgFiYj2IjSltWTu6V63y5eA==
X-Google-Smtp-Source: AGHT+IFQ6ZOS1DQSEJHQLfTo8fAp/CwP9Ri+uhc9AlpvsuSdF0Ze58MSF5XAOkYeTL8fNjZ5harxJg==
X-Received: by 2002:a05:6e02:1d89:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a78659d25cmr50689465ab.24.1732144929929;
        Wed, 20 Nov 2024 15:22:09 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eb77asm3347026173.5.2024.11.20.15.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:22:09 -0800 (PST)
Message-ID: <6179b0fd-0427-4179-b8c1-7f488fe6b7b5@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:22:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
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


