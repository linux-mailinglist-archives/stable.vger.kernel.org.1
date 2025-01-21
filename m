Return-Path: <stable+bounces-110043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C29A18578
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36283AA1E9
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D6E57D;
	Tue, 21 Jan 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMx81IqI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B8186294;
	Tue, 21 Jan 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486658; cv=none; b=pJsoy8WuIevjB+zpvz3B1UbCVacuJIDEYwWjs7y5+MaV+Pk4VOad/gCiUqjL68CsH+b5qNT2yFREHCu0iXpakNyAezWmwBoOY0UTTq5v+YG3YvsFbfBfcWfL1PJFrMyRyJ9LjU+NF1vjArjles/5tOU2puMMGgSRe54ePoNKevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486658; c=relaxed/simple;
	bh=KzjJOKqD6Z+N/+NcTSTo3EQgTIbfpaHF7KpnKlddH68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVqOWN9UuNmv7Hc+F1FEXD3ua0T9eqM1eMMwKR0BVkTIoRC9f3Wf/rRtwsGunCUG3lrIf/tRm2jREd+rCVPZC9TlB/O+zcFnm6//dj7vgAlQLOJB/87wcAevmUMBWvZc/xHtNKUocPmUnxd/32RchwC7g0rwu0y6voR2Y+EqOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMx81IqI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so140473595ad.3;
        Tue, 21 Jan 2025 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737486656; x=1738091456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W1pNuIjqzZ840SRosQJ4eln3MiNEBVKPiikiM0W+82E=;
        b=HMx81IqIoVQPLxjG9Vd3gxdWIU3Tp/Vn9p9Hr8Cc9ohn5MMEwjzxSiPC4tneldQmJ1
         IiGhMV7+2SXgyMOMAMYh75ZIEZ6ThavrbkQdlAv4fTLdE3+lk1YQCFTLWbOICEXpwXYV
         A5VG/njzM6JfovSs23kRGweLHnXaPLIRXowQTqIcjoSnhTDuEgDQbzjuME9NEsyi6yTi
         nwXCDPUesAo/U4QAZeVW5+8YhIy7tMfGo/YEmRsNen0DZpGVgrB8gAl6bUWi/7lPxY1M
         zz28kq7MriY2ibXEt9+5Oa5M+ZjWo+htvPOwvYiG87qHQBb0oB2rSDBpYUyvKS4L/u8c
         TM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486656; x=1738091456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1pNuIjqzZ840SRosQJ4eln3MiNEBVKPiikiM0W+82E=;
        b=diCBd13MKfUO8/guwWBqw5YL8AV3g8spt6yp6g/YC9Q2jFWKbj63G7Kmjb6WBqDa61
         AHBMERL6+mIq3an4yVQAs2FGnj47psXDsM3b13aWOU2EwJlMfrqYs4KqZWMYsndsHbWn
         +Bsam4qOSA98zaxej+M5FASXW8grrz6I8cycmyZkw29CX//jjYakQKTa+w1UerqCjqCV
         dkbF2k/m0GGAn6lDYaRJIo/v8yWXXkM0qX/IzIsHtJzlBc/0B8Y4JbPt6hE3OidQ46WN
         EIEZAZ8vOcPfsc7DLzsP1dHkVMLWyEL5CCqWqBpOGlgXPeE2L3+mSkIACMu+J5r7G2El
         zcpg==
X-Forwarded-Encrypted: i=1; AJvYcCUoGQh+X3frFvDpNxiheVjutzO+sn5d8d5AF1XoXCmTHtIIA1LLGD1wQlYGpVJhj67anPxGoxLxgPSISh0=@vger.kernel.org, AJvYcCV7tihsw43Vx1IRrSMixSH1RkvKlL3tZJMheq//QLqmo1zmVrqXiNqehYnQt/0aRb1SaERyxdcm@vger.kernel.org
X-Gm-Message-State: AOJu0YxozdR4NL2eT/hgg71/Fzddw2yeDxMbFTT0HmbcmhwhKjYDY6h0
	Oz+7aNjQWhJFDLlnGtsK46560X5SgzOsdXZnKkx59sHNlaBQCytA
X-Gm-Gg: ASbGncsiHsnIUwHfdZvBtHP/vt1Qog+wXdCWXQmrZzYQrah0W9VhXbqWIJ5bVh7RDhA
	aeCUNfRhOeFLhyoycbujxJHVVDW1iywRQB+GIPGmO7ta13gikAXMmy+OCAfXWI56KTz3ddJsLzF
	ZmQ5cjYWz0aA1f3RZI0ZUGRuYiHirzx8L31eTkxZXSThTz5znqsUmai+HiFoJiyBX4rWS2ErM2e
	IKhk2HwPeneZjoYyKpN+UCyXW1YkWRveRWh8T8uK68QqNJ3dwpbk6nC8T88HXh5gjTqvRP7RPaT
	ZEa+XqQPZh9yNM2vMwR8Dg==
X-Google-Smtp-Source: AGHT+IGl2mLddNxf4fSK7pUAMOrNxLri2edA7Xg7UvDmuU1p1Xi0yyK3QEn8Y3UxUnuW9nnfzgByNQ==
X-Received: by 2002:a05:6a20:6a0a:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1eb2147ea3amr25676718637.12.1737486655734;
        Tue, 21 Jan 2025 11:10:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcaa3a964sm7897244a12.3.2025.01.21.11.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 11:10:55 -0800 (PST)
Message-ID: <a0bac38f-e7b6-4532-b2f0-9435e82b3253@gmail.com>
Date: Tue, 21 Jan 2025 11:10:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174532.991109301@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 09:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

