Return-Path: <stable+bounces-187755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81678BEC30B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29441AA5D7D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56219F12D;
	Sat, 18 Oct 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsxsN5NH"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255335975
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748342; cv=none; b=pkUquTlaLWk1Fc/odSXQ74n/HF66zn5eO/5eUvFeLISt05ABKPCV7ar8pcCgs3J+u4mvAPlE5fAEH/ZdN4mof6ahOl4yurA4frA04M7lvq6TKpAbERjAnsrPcY7WejzI7M0H8ekbdmcQfxxCaQtVT5oYcYCeuw6eUKReSYxtWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748342; c=relaxed/simple;
	bh=lLlH5s59nYXoff3V5w7MB5vjZvxauckcZwYn0IdVOIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud0df8aeNQFUQL61ytGMy2tv0VzHmC6ne5K1ppJ+7G+ksrtdDKZpvfd2GnEdI1DMvEomkk4szV8MUrp+B+NrzBB+Y2IlSF6BB56BX+JkyQTXym466RzVuytcx1OznxqZNjMxdi8+46wDENbBWzHWLgrkp8iMSqCBP8B3ptfMbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsxsN5NH; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430ce2c7581so2961295ab.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760748338; x=1761353138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtaDUW02iUUQ1t4dCWqp4SISu2Hc4QtPf6jVY1/LtYs=;
        b=QsxsN5NHVRF+GvUKHMP7lfa+3evHwCoLGcW3inwEgLT14sqaaXqfw3ycJ1jCa+N/tF
         qU6vSI2QsenZeBjNeIe/PLa8QhnxTiRPVOgsDT7WJuzhigmsq+OhhYRzYhmhOT84Z1MB
         2AiXLNVESaCKn7b6I+JLhrh7toGlqXYRVEAAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748338; x=1761353138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtaDUW02iUUQ1t4dCWqp4SISu2Hc4QtPf6jVY1/LtYs=;
        b=vYTOgpC9TNNsHAVrpLLGgSS3Mi6qkOynlISZHTIAP4sni759WdlSDISa+IYGkMnbI/
         ZwCtB2QcqikIGppjbHmAEmfhIIarlPSv8jl5bhDa+DfthranwxNDctSMt+SVrfggvMct
         6tpcC406vvETcFat67P9z4VVImQE9G9+sNXXXwIbjF50mVNaWxIsSugEFvnML+i4ndPr
         5CI2SiDT9sJ5fHlBp9u2DfkU0omwLWNtibjmkZ+U9MBxE2CprTdLcXfIU87SHqCZoY4x
         OQO7xHta23+YoUQEH2bvVhekElMqL31d49ym42wnwODUIkNk8maw8kzxALxvGhZnz21t
         NAIg==
X-Forwarded-Encrypted: i=1; AJvYcCUyIdObuEDug7vGBU+du0Zawo9Uf+hVp87SvggQ6tHyICBX+BpTsa2S/Rfk9GwLUd8juwxqkFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFbXfTQEvayMXUjgfWbtNnCNOIcxvHq9XBvWQLhQ6WXfQBWdy
	tnCI5DBn8M76smUGESQIeNcjYAyWhVxfEsyQpHITORKEOWmRa2Z/Cgu+rlfcDkLbZTk=
X-Gm-Gg: ASbGncuixAOoyt11p9mr5YMvKhs22dqYaKhjtcPd70yguSiMJQsPA4/8URi2qSOyZIW
	Zv+gOo3SeLxeKWzwSPMuhiJIi3gMWSolOhWPaGYVNSFRh0iAAWcR3lSeB4AfAeZCLjgbZJ4o4VN
	eVCw+93zI1St491wAViBYzZpqOREIQN0XYoODxvssl0hStygd9exWn+Nd6urLPC7UVyzAQtQSve
	fzyVj0en3L79HRv0kRm40/ZYiMLeORdYAZtBl/iyrdaTuSLT56NEFUDkVuxVVQNOIERQEhQj801
	L5iiXr1h+p/MdUDt+7r+7GFK6cjODQtpBxkAcr6i3uwIN16rjhTrfVeNMhRxZRhHrjor3JVw/hq
	qa5ZZhJM194Fh9X91nEF3anp3GPiCsuUUVidZTWokY0XYnAX247bqQuZTz0FJ42gzvHeKWPB+s1
	96+TGXJrElMYiRL35YPFwVPmn6BPQ9jNXN9w==
X-Google-Smtp-Source: AGHT+IEmcHTne11ARqkxlAT/n2gIYyAQRzz477vLz0vdj43VMGWBnukSxF91rbE6R3Bm6WP++4meow==
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-430c52b5afemr68440605ab.16.1760748338318;
        Fri, 17 Oct 2025 17:45:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97406d7sm409328173.34.2025.10.17.17.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:45:37 -0700 (PDT)
Message-ID: <90e26028-e9b9-4c22-9bfe-b039327b2912@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:45:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.195 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

