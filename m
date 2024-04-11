Return-Path: <stable+bounces-39235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859D8A225C
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135251F22C6A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C5481CD;
	Thu, 11 Apr 2024 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cguJLhq5"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150241207
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878701; cv=none; b=FlUgOsFEyxsQ5nMmbZcAStdAhgNn81LJWIpjI3KmgRLfHzYu/WAaNuYaAyKNrvvRsKI15THgzytU9cEEgQnBhZ0cf+KWjsMhIV14qkcfYt0WzAe0i/dm4Pa/gDPgvT3LB/ROxp9hsHcm8DX1kFu9pncxr1ZiId+03HjTqNt5F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878701; c=relaxed/simple;
	bh=A5/2+I2e6Nc70pGxM00MEjaSowLN0ZxEDmyNCPx0VN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAi8IGIiP4Rhcern/P2dHEA++/cYR9i3IlG1bush35HBLGh/ZAYUPW/qFpMI1Ir1Z+Ezv3hOuysn/IkRIKLkzhhNhjUcNCF0KBdvFxnCSEmgVmgXVTZzmwuISzqKhaO1NCAC+lsyw/PIZhiXTEEytec6JEssEN22qw+I0GWDKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cguJLhq5; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36b00f8fbedso564125ab.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712878699; x=1713483499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAzHKVIahMAAQYuXrEXLm3Ghx8zr2AF9oIEq5k/AJGk=;
        b=cguJLhq5RaG+VN10HZP1sxXs2UuAp2RTIx8A8q92nIfMIk25Y46WtkQnmk7yUBCKtx
         t8TUHzbN/iTniRrZmd6MTL1Qi+YSEm+/J6Z5fbEpsrAFDeJZLUkqRBz4binGqP6feQtV
         RiPjXx8vp4bR+lEG7kC4CaCx2xgvuGdGejQa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878699; x=1713483499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAzHKVIahMAAQYuXrEXLm3Ghx8zr2AF9oIEq5k/AJGk=;
        b=vbtVdSy5DKE8QZVRF5SBzSaQ4xZUy9z3yNkL90dJUzCbsX0woRC6zix/zekuVMK9Hi
         XE53ONxTk5y+u82f5NdgyvOdHoe4kTev6FaQdSiXXGkmpALzkWA5P0+V5d0DUsJoc4YR
         VU0v8MlGO7tUP5iEPCL2n/x2Fu0fNpbcrBw4ZUZNyRx2Hc+tceBuVj4MiHtddkJRr8ym
         39AKr0s/1WMV3Mk/wQAy1AdJophqAsmmrv21RcqkGNc7aHq86CV8GgmErbtfpzzDchZd
         tmnqA512ex3SiW9hlcvP7MElOeor+UcdNMPDGd8jpgVN25EZXZIstYzNrWGSvK2MNEvZ
         bSbw==
X-Forwarded-Encrypted: i=1; AJvYcCVeYMnjvkJtKt2CteLzOhe/Qgm+HkjweOQn03aH9a6xR4ZDm0TOUtgIG9rrIizn1HR+MhSnOiXIJ7IClTxo6CAOZ5GJjkIk
X-Gm-Message-State: AOJu0Ywt25VtCSWiGQhnSy3gQczNs0siNOucwy5uZ4ml/II2Js14c2J4
	uOxgZWkd39kVCfSdA9GZH0fVCXIBeDJGIBn6swMN8VOMBJGcWmHXtN5ShK+HJbvqM3mj9CBte8w
	f1wY=
X-Google-Smtp-Source: AGHT+IGkHINz7dPYIPvNPoQg3hxjSUHSNt32HD/vaCd07WzPU0j6nBda9WqeCIZm5NUrqv1S6m3kRQ==
X-Received: by 2002:a05:6e02:c8f:b0:36a:f9aa:5757 with SMTP id b15-20020a056e020c8f00b0036af9aa5757mr1122549ile.2.1712878699144;
        Thu, 11 Apr 2024 16:38:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m17-20020a92d711000000b00369fb9df9fesm650283iln.8.2024.04.11.16.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:38:18 -0700 (PDT)
Message-ID: <f4255e0e-5b1a-4501-bc66-a47471f80c87@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:38:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


