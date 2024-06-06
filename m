Return-Path: <stable+bounces-49935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC08FF70E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 23:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1236282A1B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB971B3A;
	Thu,  6 Jun 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUw9Np7z"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51E61FE3
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710796; cv=none; b=gQLwkbzP3YhX5kFsqI0UzwXAyDCCKPJYdgA03Ae8GyOjfjBDRUUAlHjVWckSiA8i9nSbbsqaPdSkt2MNu3u1271RHbRi933PanRZEA0ws4B99ocCLCbvd2bvstaXVY1zv/lEfqAJXsNLIsNqUtey8e6N/KLWl/2irSqWMWJ+/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710796; c=relaxed/simple;
	bh=8woO+mZR1xTpJNj8Nrq4e42rr8a1sNp+Kie6Ej/VHqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5YH/Tv9fiVFWbcp7hDRNZF1y5ImYWAFupoo/09lM07IQWiVfyoa6U82etQxLZ7qKgl2eVulkts3qgM4nrkZHfWA4p1gdNIKoPGFiMWlQTOUEb0JVZ6OtfnRgB7JuJRujJTK6jJ6AsUh5xClcmzxf0/cYLVrP3MRs2tRfkNxpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUw9Np7z; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-37489a3651eso951115ab.1
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717710794; x=1718315594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3dOqHDmHQxZBL9d5fs4BncxmYPiNSY28Je+YxNNlSQ=;
        b=hUw9Np7zQ8Iws4pyXohUVf/jm6pUi7iRM83ZEjo9j7rlJOh1S2ZKvRBqEqwBiHazDS
         VHYKM56sEukEyrl6ORsHN1xtC18TGIdRSaf/4aTqwaVEWE//IBnb9Fc9ZcsFYlTR4WpV
         5R7ogLm4cfj5QS016Mckkp3HaLwsJ1P/vij24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710794; x=1718315594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3dOqHDmHQxZBL9d5fs4BncxmYPiNSY28Je+YxNNlSQ=;
        b=eh3A1au7k9qkNPtiidC2BNQJs6P6rGex7tMFMKdIo+clYT39npdjzluGIgQhJL8NBc
         ianMFirG3EX+sjsdZV5UlqvZGGj6HbeLt5yOeLBSfiGS99Ut7X6VlCTHEf3kHQZVr/at
         ZvwFQY66DZhyhELaZV7amrIhls1XvZyw+PxyWq+YXJDavuZ7KUYT73Yuqbcb8XKk4f02
         djSQsrJrx7HJnxxz0M3YjxyQ1tuT8l+VfzKN/+/+Ajw64xi9BWdRuxJQOXxma29ZGNg6
         l+UTXOajwjKtyOQGI6EKo3xWOgYjS4MlZCtjKf0/OC2cL/sqTgTXtnBXXuPusHgA/s/m
         6Rlg==
X-Forwarded-Encrypted: i=1; AJvYcCVzA4oePX2Cpt7Pe4mrN2h9JnovSo39w71pot/Y7NTcX2FWLoHiXwYR2fo3A6B3/5cL8lesA/V5ZuuM2fOwdreO3yOtMnFm
X-Gm-Message-State: AOJu0Yx1PYkGnj0JjHgbTmeEFan+VbwVKLfwlpE9mwto1PqJ3JdOf1cl
	qMHduSfAmb6qc1F/Zi7Ort/ySdfj8ZDgRNUTfhXuz+MbdxDnMIUhKJkYr6m4Nbc=
X-Google-Smtp-Source: AGHT+IFj2HoC+T28HWLjKYBudaMNCDAlgyHTQ5/YpVyf+pPLuqyyDLSSG/KG7Trpz82Jw9W+uV6JMw==
X-Received: by 2002:a6b:720e:0:b0:7e1:b4c8:774d with SMTP id ca18e2360f4ac-7eb5712cfafmr100909739f.0.1717710793990;
        Thu, 06 Jun 2024 14:53:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a2212f33sm528175173.18.2024.06.06.14.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:53:13 -0700 (PDT)
Message-ID: <b0c7ef44-9617-4fb0-9ea4-e30493d3a609@linuxfoundation.org>
Date: Thu, 6 Jun 2024 15:53:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 07:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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



