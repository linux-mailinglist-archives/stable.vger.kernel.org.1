Return-Path: <stable+bounces-93662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DBE9D00DC
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2660B215E5
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7888FC0B;
	Sat, 16 Nov 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGCVNCVd"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DC194A52
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791056; cv=none; b=e/U1Z5pFBxeRDC/g2IzQIRjrQNwePTZA533/o6+r3fy5xVcc4krRzzZfsvMKgTpo4PbudBRLNfzmIBQ4G1stYkHwftj1Lz7dpbnrWv6E53JM2FTZq498FHNIyrB0Y67LpBJhRLKRc4vldpFzvV8hMhTpqKBZzHlD7G75zkXgSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791056; c=relaxed/simple;
	bh=kKJ3qTQEwhEQ5IX+PHwZJtS5Ex8dRqGOuTPBeS9WNCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbRamQhytl/PJTCSdcucNNcpHWAC0vnYuD+Jn9quGmuP48k3P508GfQkOhCVPbvD2r63m0vi5Tx91565vnO4LlY154oWXT2YHKBtPtUKyyl8TBQkTdbrcso8RiRccHMR7V2hmNPXcF7evjEyDVsTKVx2TKFv4cm/28TraIhpnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGCVNCVd; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a74d9aeb38so4998735ab.1
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791054; x=1732395854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U58JmcjKhSMtIBEtYZmZshd6JtYlfTEpWKxxkoGVqew=;
        b=PGCVNCVde1UIXdpEVsX9YkAkTngk8e1CJm9hk8UZxdIE5rDsoBMnCo3ZKIrpKbmh4C
         HzJoijbgQO89aJCyxP6/NMUhEYqAIMmeZQXk/4HA8K0KyWHorPfswTB2CyDsKxc9Lf/A
         Z6IiScedJIUiWKwC0PoKI/YZYCxb3PVoc7p+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791054; x=1732395854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U58JmcjKhSMtIBEtYZmZshd6JtYlfTEpWKxxkoGVqew=;
        b=H+ypsD5gjpOZEZnYcYlYcxOIG8czgoggtF1odMy6c1jZjz9RvCCzAVIxYjvOrBsjTa
         0ZcIkcDiTjxhWJGbOmtoFwRkK0eomKq3zqilPKy/fHF19rYkDyF+g6fxs5IPh2/OMsVS
         60RSmGMuwBKMCZFejSWUlEB7HuSoymlpB5OX3CFNZNi/nc4uvbp4Q3X/lpUj8pIjYq03
         HEMSwYxKp5UyaO+b74KwA1JMRsMvWaj5RfUhGF3PAIJqE5bAhsxEC7t26ImyYD55+H12
         5dsaOegTfHbNlvmUAEfjvv4btMeVn2s/CK6Ak5zoowmTIYQK370oyjXdw0DdBFwxqcu0
         ckPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6JqqSDwz7Pk9ng2aUtM+4XdiQjfQSigIizYBGnaF4wVWqk3bH4KrglMfH4xHrci9m9A58NFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7irI8RQvD4BCV+WdaVtmvQ19DStibE7FgBwbIU2EhEr8CSRu
	1bSdwFSuSt+RAPKmFDbE4E8HJMNJCHmEcaOxV8D0MVawljZleo3eCthK99FxiGw=
X-Google-Smtp-Source: AGHT+IHN59PuVmN6IviLKx+2Cem2ed/yJl1OmGwJP3wojhFylRkff5In1R2svHIJhjohf75HlacK5g==
X-Received: by 2002:a05:6602:2ccf:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83e6c3199a9mr743702639f.12.1731791054017;
        Sat, 16 Nov 2024 13:04:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756f5f28sm1175069173.159.2024.11.16.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:04:13 -0800 (PST)
Message-ID: <467eaf93-e41c-4c2f-81d3-03cb1934fc5a@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:04:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

