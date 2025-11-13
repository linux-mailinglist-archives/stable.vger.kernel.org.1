Return-Path: <stable+bounces-194653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E426C55805
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 04:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8EEC34BA76
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE381B0439;
	Thu, 13 Nov 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cas305hE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABA224D6
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002954; cv=none; b=ZnPANNND3x0iKwDlaPDx8Ju6Q0wO+qw3GP2MJ9dTk4zZ93gh+QYFtzWMDfrawveOzK6PxrvIzxVsGzL6Ewc3dxpEDli2pyIqyjKYFFCVlTmYiV48MVCqSJRBRnQ2QwQZUiDCVPLpEsepZV9clEbMT1DF3PuZ2/f3Lx4SKFhds5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002954; c=relaxed/simple;
	bh=//fsSqVwcMMj8kj2hnXE62bVqKB4thvdzGySq8e0d8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eaq3EOxuu+pwa6XekEAQjI/iACbBJTfU2lPqs/MB6sHOdEvwY5n5kCq0f90mx8FjQsWVoJ/IgUiOo5DGzcWBc5dzlT+xiBCw2sCbE61YwQa85TuSGJj4G8ulgYYuxWauy+SRrTdQoTjJpSrkX356HbNOLC0ebwWImYybkcmyhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cas305hE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so348101b3a.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763002952; x=1763607752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QQv8xx1Duq6ZgFVf8NjZsfCCJSLzn/A1nSzNFREUl64=;
        b=Cas305hENX3A9FBrNwq5x8E9KbkpWVRcAEt1DNYlkLVVZJIdxsjbs4wsD3SEAQmlI+
         mCTp/gbUi4+EJx7o1nWem6helSIvTzr3z4ISACOdQJuWFmZgLK6G89j0aX1oY7ctVCAS
         91NSsFbtov2OG7QJKfCVk178Zt0NTYDCF3RfhyUGwzfsk9qOfCpWsEI2OsF4vJxPfEn6
         a+I30xke13yX+sJ5fsrhtT8UFBdO6D6QEkmj6IFxCbJwWyzumlcTX7B3D/y4RIfkLLNH
         hPUMCTYiEMK2HMhF44ikXGQWiVwAGskSpjrCiEUkvykkMqJOFlcItL5cZSBkhgouqkP7
         qNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002952; x=1763607752;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQv8xx1Duq6ZgFVf8NjZsfCCJSLzn/A1nSzNFREUl64=;
        b=VuRvpdc7Ig6a1+OlDUpr5XUYpp6bK1IKjSOAKL8q5f8RSKFLCdFQ1CXbE6XHyYL5Ex
         RCNycFOKxb/dTtTN2wKX6x4+pQlFbI2wPkvipsls5R+yaxPgZeV144YEa9yudmxxu35G
         QEnUPpVij3LKolYU6cNFJDsdB65n/ioOagSFoHdatQLq4R6rprnuU2oJ0g9BWIRejfm4
         3my0Cscvus16YGXSl9E2jbodcrIuN/KnkllX3geTXWsGgyzGOcB01WRO2z8u6nyycUcW
         F8Daq0xTd31zWdoZ9SJFOr06hILxNf2fYIVat0jNGm7L+Hlebgm2SW1E4JlG4zWm8V9c
         Db4A==
X-Forwarded-Encrypted: i=1; AJvYcCXdFrYZE1/RKACX5G/ncldXVLzsl9MLxBciSxM+Um2Eoh3/YtM7s9C+KdeGI+ZnuU6g5pb1xB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2ZvLOOwv+/E6aP29IEw8JLkiS6rcyYMuDWpK8znDlAJ5Uky2
	vosaeZ1VTsjBffRWP8Pt8OhfWDzVyNCDlZxsug3sAK6JkfHlEVUnDV9s
X-Gm-Gg: ASbGncvDt4x6LQFXn7pz4aHyVrrWeJf6Gwy2M5Z/606kmWRz3GPFkHcKq7be23M6juK
	z2ieLB+roW+ocJaI9FkMNGqKHzkAmsh3lfTe6Nsh7l4Cj9xs/uaog+HJkeupP5YdKZvY1h9bm8T
	hexdt+68MjA3SGdok1zwQugEBD0tQMXLwCt7fYWzxR+XZusbKrPYwBTWJYUM6KAxNu0R2LqR/3m
	4HHpN3BvBa+eNS/tGBmt87UgXLABC/Ghx1FllphRwy2TBccnZJmsAkESQxpP4Yy3L82/oOYfTgs
	f6sHn/SgAs7rcBUQPc4ME+tHZOS4PhrxCDD6Hu38BPcIHnVFBlX/2L4zDZWEoU36h8W5yMbqeHW
	eWvE+fn5m4xwIXixTzTiRHOxi85E9K0TH/2FsDWILlXs0+aynwIWbmKO+f5w3zOKdWB5Od4t/v7
	LLv73sZM0rff7NxC6Yrl/kL/UfVQE9UrXsACAwLB3AbJMVeDV8
X-Google-Smtp-Source: AGHT+IHFGM7yAAmuzYKKX9AWtV35TPZpE/Q6IPvSk5IPW4CF2y/lsD+bEHp9IHeJDSfFlJ9JMJQf9g==
X-Received: by 2002:a05:6a20:1611:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-3590968969amr7186139637.13.1763002952560;
        Wed, 12 Nov 2025 19:02:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731a72sm486226b3a.50.2025.11.12.19.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 19:02:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <834b1518-67c0-4d8b-b607-f960a178ff2c@roeck-us.net>
Date: Wed, 12 Nov 2025 19:02:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
...
> Steven Rostedt <rostedt@goodmis.org>
>      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
> 
This patch triggers a crash in one of our stress tests.

The problem is also seen in 6.18-rc5, so it is not LTS specific.

Guenter


