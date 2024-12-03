Return-Path: <stable+bounces-98183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A49E2F1F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D31631D4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720F1E1C34;
	Tue,  3 Dec 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHYEi+Qd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF921DE2B2;
	Tue,  3 Dec 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265208; cv=none; b=NT+5E0uEWIG00pUeTo0YiwhK6hzu0LtwDnz5z1/0k4OrJjjGmxuOVTkJsSJ9uc4GPGlPdb0RAQFe+fu4hiiXXE/oRT2tijCZBwY2qupGyThA2TpgWOeI+dxLBbv+FoHscCTs4VyTxGOOCLJ5l3LMt5kRCRn9PjT7H1C0U0ViZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265208; c=relaxed/simple;
	bh=++BKE19X/423fa3Pz7UpJw7IzqNGkxSx5++yeCYTJ3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYEb69uOi3A/g64eN9DHH1s8LEgUOXsNkBMZ4Qd4jPC9hX21weQuiillJmP+NzuPGz6sDXvHZ6k6etdW32VHSXeAyVuSQYFZiPISve++n3d/niEdocaW+vwhFFCAaK37B6jBm9cudD+a+h6gBUuDm4hlzJlqg8LXwbs/yv2AKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHYEi+Qd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2155157c58cso30079525ad.0;
        Tue, 03 Dec 2024 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265206; x=1733870006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7wcwjgY8U3EHSDN0Cy2cHC8zHubCiLdno9hU9kCj5tY=;
        b=eHYEi+QdH89LLwWhDuRm81gDATLWdrv9OJz99NTXopTvMNIwtM8f2ceRyjuC9XjV77
         iKoJ3QWfloi27hZxB+oELhfLnlQGmNXKnUPvWpHc5z9zADnrbcRh9dGKOmHC0VOVfXv1
         Xmt3MuJFRmlTZtcrRg6atNDIMdYcYcaXBCaBIAX2ldTNIJrWjXIqauKHsXczsLCQ5G7Q
         oUU7E7yuS1gmxeJkieSlAiue9gaPhucC4tuL8GhOTACsZ61hCJs5WSRRgc6jTWhQAVj5
         ab9g4+YWFoFzGyOte3T4D7dBg7hvQYoECWoNAuVagQrXk8AXsCgFvpZsQ2eUAXG53sy3
         WG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265206; x=1733870006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wcwjgY8U3EHSDN0Cy2cHC8zHubCiLdno9hU9kCj5tY=;
        b=Vn4C6FoviogDa0RTWF5IbuSktJ0oxOPug9sMG1AELMJPhbqdH/q8ul2izOPPT1snzf
         Gt4PEyW8RmpcmR3cQCbWL2OLiqzibGFXExSwAnZiNP30v5C14x9m5Yzp9q2tlkynhf0k
         T/nw1UkjjhK6D6/fl/+wODyGSarkVBErB1mq8htKbuhvQozubinwOlYbd009UGvoL7j0
         KMd7HqZm4rYyJgs1jTScsZeG0YXOZwFlp0gegWvjcyqqbz6Lj/3lyBUOfYcp/fgQs/7J
         o9/XB3Nj+HtXLxHhoH0Dvn/sEcb6uDCqY1GYBkrCy3h+88Cf41t6+OQiU65x8E3oZ42h
         bV5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWavlPsjhdtzWmvcaCWlK3gsHgGmyansKBhdJgx7AYavXOU9wxFtSWJh7mmDCNxWGUqeQdxAcY@vger.kernel.org, AJvYcCVovWkgX4Ana6SjxL4wVF7BCfEE/7v+0NJFsLAu54IAkL53EBfJ2KDJtw4mlVRYt7tZ9LjO1TkcDs7XTDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kCrZ7zdnvoV5Ne3ViTingYtJK2kpjMw3OpyFA2wR0nlGequO
	bSi9s4RlXUlmSrDiDdnhOzDTuUC0PAKsyMrbqfyvk3wS89YV/ZIQ
X-Gm-Gg: ASbGncv8ISiDlUyiYY5f26UYeRo4ldzRuu29dL0rGevD7UUi2YG/Nx8OlKqSF+c2eQf
	4o7rftYclsqnc5Ng9fhsEBMQ1Fp6D7GhvHZCUSZadgyofnqzBdkSu61NNzqOHjpDQBR/yFUQddp
	u4qEDI4UJQCvlVsJrhUw7dHSJCXB7o/L/SCfLWLK/xRpYR/9sM4dhD6j/1bF69N6L8mtxz8kWKZ
	XTD7mosqNsWkzmO8+snYWK/OfpbiiyinhvlMssleKqXtpxOjH47P58PazFa5l03gR/G2DfdPIxm
	3w==
X-Google-Smtp-Source: AGHT+IEs0oGfVC5VfImEvCM4VUes6hm2WW7bSm0483Uh7U05zK1sRzsMiJSaMiBUQFNMd1oNN/wjwQ==
X-Received: by 2002:a17:902:f64d:b0:215:8270:77e2 with SMTP id d9443c01a7336-215bc423d23mr67233725ad.0.1733265206045;
        Tue, 03 Dec 2024 14:33:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2158f38c849sm43184695ad.104.2024.12.03.14.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:33:24 -0800 (PST)
Message-ID: <713b5871-c7a3-44fa-a5ac-5cf558be81c9@gmail.com>
Date: Tue, 3 Dec 2024 14:33:22 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241203143955.605130076@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 06:32, Greg Kroah-Hartman wrote:
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
> 
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build for ARM 32-bit, ARM 64-bit and BMIPS with:

util/stat-display.c: In function 'uniquify_event_name':
util/stat-display.c:895:45: error: 'struct evsel' has no member named 
'alternate_hw_config'
   895 |         if (counter->pmu->is_core && 
counter->alternate_hw_config != PERF_COUNT_HW_MAX)
       |                                             ^~
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:106: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/stat-display.o] 
Error 1
make[5]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:158: 
util] Error 2
make[4]: *** [Makefile.perf:787: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-util-in.o] 
Error 2
make[3]: *** [Makefile.perf:290: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:300: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2

This is caused by 73666ad2a629ae8c2fbe3b7211ef9a56de4b5948 ("perf stat: 
Uniquify event name improvements")
-- 
Florian

