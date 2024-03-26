Return-Path: <stable+bounces-32348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58A88C9F5
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77228B22FCB
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582C13D505;
	Tue, 26 Mar 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JS3+Q+MA"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66E13D532
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472452; cv=none; b=j74oZPxSSwvHcNodGYhsAayvw4ujmVM0MrukwfImvAhQkIRjXyro3xqsxnAq4Ob9Jzsd2qQpQeR3lLnLwzq0T4TlLk+PBg7C2Kac4h8uUwTE6cWRBynxk2mxwVYjurPAaBr4+d3kNrqUlqM9YfXP76LzbekuxjnD095D5TT4vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472452; c=relaxed/simple;
	bh=t/4Sgc6HjXtKMpupkcNp91MoxK6/CCwIcId/AInDpSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QujvYBjCE3oKaAVWQZY1qf8i49TyPtV64grG/byTnwttSfQ+JmNvRZ4MpjPw7a+emuG5iogayhQACbHCJfeyPizCdBr0zrhRDsED+WyMyj4LpCwEJSwTw5ZJLDl/kA12CVAzsyLxJtAFG88siPTjr0QlpoYCM3GyrfHSZTIZGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JS3+Q+MA; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3688f1b7848so356895ab.0
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711472450; x=1712077250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TIiGcxhM7vXT+lbILqbIn8E6OfjV7ZMyP5RXQ5dfqI=;
        b=JS3+Q+MAmg5mtjSDDuk0vqIJ9MACrlIk2Jq4ChUkLEe+8kTljv4J2IJ4igkj5IdgO3
         YsNW5rZA5obULnIRkW9eNSFLQlYlSTgNg4uo1V+hIZvSPpTTeckO4Q7uwxtFv7WIFLq/
         DI39Z+a8MNeUX34qJ6kpw0+7mP2M+7UM5Fs30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472450; x=1712077250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TIiGcxhM7vXT+lbILqbIn8E6OfjV7ZMyP5RXQ5dfqI=;
        b=HZhF7/QXJF0dE3eo77UgRrMYmoXD6ksls8Tl7q5OH9638EnYZQTWYsD6A/kqFiRNwY
         sTUSVBgkWpNb5mrggfrLPg7Rf2Z5tkOpynqhw72ptNUW2T63k7Oa8kdqd6Wyz9o+0F+v
         gaP/GbokAoFFgNVTZrO48WDgSPvRg2QA9sYIO2bxv7EJGypuOSbjZ5MDUcn02sCDFlCW
         Z9ig+A2pjJOQ3+ciWeOnoLE8kahWxf11UIfh2A3Ito69/CLgDtdEAasSz93LzskWGynY
         r3n054ZYdrbHaQSh6VoUXNLecwzyQKN0fmeSHjxmcPR7zcuon+fOa6KHk218bEBWgj+U
         QZDA==
X-Forwarded-Encrypted: i=1; AJvYcCXHDJU7Lt0NsaJZEDOJAsNYrb8986/U+kYDRXBAhv9V8aVJQcxAgzp5cv35QXzo+IXgV7XEgfnGqOkJcOHU2sDU/MlvOyQs
X-Gm-Message-State: AOJu0YznDI30OcjKBk5A7ak0W+2hdrfCvILQzoo+STOT5Hm6BY0YH4t2
	UdOyPof6lotrjfeoLn1GkEmEzkTzCV0dKVVOhmuhEaqDhA7HkqDg3E0t8JOLCJ4=
X-Google-Smtp-Source: AGHT+IHArss9/xO1eae0+X8Z5IsmnbV4GfnfwZjKVACSkEZRNC/kmAb2BuPBSNKwzmtJ/61TitJyOA==
X-Received: by 2002:a05:6602:88:b0:7d0:2e1b:3135 with SMTP id h8-20020a056602008800b007d02e1b3135mr10571753iob.2.1711472449835;
        Tue, 26 Mar 2024 10:00:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dl7-20020a056638278700b004772a0d4b0bsm55667jab.8.2024.03.26.10.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:00:49 -0700 (PDT)
Message-ID: <94c58018-6cb1-4f56-8b78-8251b64e251e@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:00:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325120003.1767691-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 06:00, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

