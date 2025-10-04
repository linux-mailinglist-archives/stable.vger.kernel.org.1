Return-Path: <stable+bounces-183375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E2BB9054
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC83B346104
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82B280CC9;
	Sat,  4 Oct 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0WabFMu"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2F275AF2
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596908; cv=none; b=RLSq1BJlMhCAd9h/g7PgabecE/hCAPkkthASKqvptk10cD+GXhNHNgzXBM62oOvnhz4K8QBPgnKLmvDKVBrQs3sVW2zrw9vbttzWFw2Oee3y76H6pxvNeFPKPXjkpgio7r1Q3MPwz8LuYwvo9Nh9fyi8stvPHuwjj1AWXsj4HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596908; c=relaxed/simple;
	bh=tsjBUA8ELBDzVXfzKmYIZr3bArGX2DI1so1CZI61+Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhDi4QOo/rCbookmDKFUFvugGsYYZCEuVfOk/D2MDBJWhVNl8zF6WPDJTUpDp1YeKRCTVeD+mLwyrKlKf3L/CKS2gCDdMoq8cG9orj4iAJb9Dl5egFzaP7aIuYeaG2XhjCRsIX+UtMSrwPIYkpj5uEA3zU27MHwYGmEK8Ax4ZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0WabFMu; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f5f2d237dso16464825ab.1
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759596906; x=1760201706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgjgiZYlZMYzFou6GDp7zcb8froC/z/pnBhyitJ+ZRI=;
        b=d0WabFMuO/UXNfsKaaVkGaAp2PkCMNee7B3gs1NJhRhoFCYNNQ7Rw2IqXd/7B833Zd
         3IeOTkG1rsSEJvBCO0vb6kTbirBhn2Ul7ps8W6LOYSldZ3DjFAjDFa4TwheGtMIY6ko7
         DJAm/5NX1uDmu4lGwsRbjEd/vs8DHHuo8+Bi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759596906; x=1760201706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgjgiZYlZMYzFou6GDp7zcb8froC/z/pnBhyitJ+ZRI=;
        b=aj5pMiZdsCig+31FCvj768fMoG30f1WGBqW/j3H/HgS1cxZiJft9rT3ZAC2a9mPPhD
         3rVsprvaJQgEbO77dZMNsYmIrDLnZzmkpRLfRQPH9Pi8JE+wEVZvgFhBpcAVXss7DT2g
         bDoN2hLlb8JXV4uGPENwDNl6tTUuIg/g0LFGUM/rqawz92nCOL3bX8SxhBCoMw7r9ID7
         CrTtcOXh7zpvWZFTHFi2fGaTX+kNNX+R/RZXEQOewtlrGsdPf4/V62VvVicbJfIlhTQs
         ehxD1pX4sbb+72MvjztgBHfpSS6qncYMQLf/Rykm2GXgt3LWVvM5FRjS2bxmstdqIN1G
         Z4+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8+0k35lmdwLL1wJtdU9aOa4r7RGEJUZnUrv9KS73OlzYVWiq5B4z+VMroi2r8lGzLJG/nT6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUTuoEwDlqtsOwk0npdanqgLcsv1cbLiO9ERuO+4olMwZ8cSr
	JOf6LW37nDHbeAOkmxtYsvtoep63V/OHwz2i/TlMgG7u/n47UgEIrh6FwRtZm9KtXl4=
X-Gm-Gg: ASbGncu2TgzyQyfVjAQ5fuqbPqoz0xUADGCqTLWn89+87kWNzO1TkT4HUkEb5OHuVuZ
	WV6A5CzLuRi+w7mz/12RjlpO+S0Bb1E4nsCDq0dLnqbjQdlvybHPnlKZC6y2Q8Fm6l00qK+qliW
	/y4gwnZk3fItUhd1eN1O0ZoYNxIJGxyp70GJU9razfcTC2mHWA3hxNLm65q+C7mDUvgS7LbD5tm
	UqXKjYSx6lFRG5wjIi3q6MkbKTCPgOQb1sIBCJYu4YmlnTmkcWdnJLcTFtmOpa4nThaAPHE+moF
	pM5HZmsxKOxLU3FyCTvLLNqIqCdy2+NI7XIzbIk0vC39q0sspq6AZDfVyDysY9hffwhOHV0VBj+
	yPgAGC7tUpejwHjusKDinmmobdsCyClmL56JrEeMpWZbVneZYWcwV/OBZtRDxbNFgWWvH+84NDP
	JHdYbo
X-Google-Smtp-Source: AGHT+IE6YD3b9wlJCqIM0+EJtLwGyyXpMTh1kGQiDpelqE7028RMdOYvJh94CXHwN6hfIiH86d1R1w==
X-Received: by 2002:a05:6e02:3788:b0:42e:7444:b019 with SMTP id e9e14a558f8ab-42e7adfe854mr95756255ab.32.1759596898253;
        Sat, 04 Oct 2025 09:54:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc83c5sm3108334173.45.2025.10.04.09.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:54:57 -0700 (PDT)
Message-ID: <7455752d-da89-44d0-9016-59c6a9b7b53b@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:54:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160352.713189598@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

