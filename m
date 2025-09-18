Return-Path: <stable+bounces-180573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FAB8667B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E67F1CC4393
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FE28D82A;
	Thu, 18 Sep 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsN0JHng"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145328C00C
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219741; cv=none; b=ZbKt0iPyM/XY5c02EWvelQaY4MT+p7N88wgbWl4MrpzpV1qItOHK4jykKx41eqPIVrgeHNIXdNthdk3/y9h/VCH9WK97HjUcaOMI+TPuNG3/nSdAFx0lzcSoSZ79BV6DpfgN0DE6RT+03G9z5oyPnF275/DZZvjrnVX5o1q3Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219741; c=relaxed/simple;
	bh=rezYPpZz3X4W9ApFbHhJThBqYRrd9DvtahKpXyRXxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj6CfI4Xi7n9flsrL9jmf5CaBS8zqXlp9aUUmdDCdnv9iLy4dUNbGpqY91x6ef3j1V7aOglJQ7CnnTk53aIMMf/UqJse2FXrNEwdUt9LrR9OFp+5IlkrXKABkBMuTUwpvg1qdAkeY/Nr7+3KBB+tuOJ00SFSCp3EGvbIvHXIeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsN0JHng; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32e64d54508so1503460a91.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758219739; x=1758824539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHxteDGNosyzWKc+zOp/6XpISmYb+dhvuSpnMwep5kg=;
        b=JsN0JHngXk+AMun0DP5EDqEsIqu8uZnI1wuugSsaKGLo0X1Fuf83gUFX+df+KRQyWE
         B2qS9znS8HMwTGrQ8JKL1A3EoKuIr5HP/t8gvEHkRoIXnSm9UVyinM4zmsbDB7t/8d2J
         JmqZSeW/0qp4uCrgwZElVIabIM1uNhZXCavqhl3SEXYqE+ZINQwxuminqD/B7HZTJk5O
         QQqLMUBFnQsgGDdaO9Mb/cqL9phaASDNECFyEpNnA6+nI5Qu4VoiaeNA3yemts3XPyIr
         5pyZTL6mPRHzmAEs/5XvWb9avCH55HhVFivGRwVIrglCdCJciQaxTrFKyCZjvY5aRiNb
         7hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219739; x=1758824539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHxteDGNosyzWKc+zOp/6XpISmYb+dhvuSpnMwep5kg=;
        b=InNomKL52xEYz/aea7FVax4Z+FCRhsxXKfPp2GMl6HQXptNS45BNE+EV7m5aFLhcEn
         mDdWNiseS2Vl1ocMHVijUZGe5w16ccH+0RJz9pf6ASm08WBS1qtClXu9G+rPmbupeqlE
         dnryBwwFdmE29+yqtb1n2kKIktYpj819jABmfgrdFEEUNwQs9nKySnAIzaYGKnMddnDG
         gM52gV8C8Yj9KNgh/q+mxoCHBD6TCRgd/oVp5MxK3UYKanbP5Iv3GISNE63y8lX5GPlS
         2ex0/NrABjqP+f+Bk0lYGlvpr2VYLOsmkN6UrikUkPLfRxqxSt27LD5ckf/XJwyfjlci
         860A==
X-Forwarded-Encrypted: i=1; AJvYcCW39KvzCGfl/9noVTTqzWKfYMso77mWTssSy2oaVtXB5yaLejRvDaLCmkqSjfdpDvlaTOCwyf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmF07F4rr+wlglaJ4Eg3K9VqCuVULL0QCzY1qevYKUtmwQ6Mx
	tjaG8qZD2OXmQp/hQZdTvvLYd1M3jJ8/cjSELfJmbvuTCU/ZNOA/gtuQ
X-Gm-Gg: ASbGncsv/9OQxKcEcX4NGoOi/qXKA727HzEofCE3qsd5R+lY5GK1hRI7bPHKgcCafB+
	TtGjNaqzRYwxfGfXQB/wmQxb2JBjs7FcuVLUz6DS4poqnKzvCbe5jO5JG1WJBjUu1j7+dLozFF5
	O3aDUtBCm9cnKTy8J27m4U549OcT2qzwLagsdY3GXoxVPqE655UoyxiHHeuJLtuvtSk/8jbih/1
	gRdeDjNupw/1uUQnyTzB0zfkzYEQ6BZDc7M2QsHBrfnQcrKXzdcGdbYDKKhTxZlBhqXPISrKUTB
	Vp4riZn/SC/PTBioLgPRgxeOd2G7AdN8b5a1ZHM9SszeC1QYD4Xfi5mbKum6IgkziXyjsukNpSG
	6/uW+lsVvZk2hXI7qIfIZ5mix+LS8VqL+lx5xKnBgtq+pANElyq5vtUS5q4Xg9Bs8UJdBYMwke7
	4M2XUwskM=
X-Google-Smtp-Source: AGHT+IE4MTForfXoRCJyi82LZstZN5nhOX6O3jVdL7jLH6I//PGX95RW3s/Me4+dx+KgwR9BKNHpXg==
X-Received: by 2002:a17:90b:288b:b0:330:88d7:961f with SMTP id 98e67ed59e1d1-33097ff703fmr443479a91.14.1758219739445;
        Thu, 18 Sep 2025 11:22:19 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff373ffcsm2928582a12.16.2025.09.18.11.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:22:18 -0700 (PDT)
Message-ID: <1560a94c-a5a4-4769-887a-23d954d7639a@gmail.com>
Date: Thu, 18 Sep 2025 11:22:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


