Return-Path: <stable+bounces-192241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277BC2D403
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A367F34B3C9
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7983191D1;
	Mon,  3 Nov 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXA+7JwA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2103189F43
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188646; cv=none; b=BcFDMNvNhYXSa6xgqiJ0pRB47MUgGX0arkC0hYL1OtkRTerzlCteZz6hXaN2xm37aNWX3PeA6XJ6iRBi9rC6fY187/82qcUUBbfnpMj8H2ro2FtZ2G7JIXqZMu2PQHN6IodiO1Wp2v7C1S+zQKXCWGQKPERtUZzDg4ZolgzD3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188646; c=relaxed/simple;
	bh=+csLiPvaXB7cw5DKMQWtltLuwsR3d4lws5+o61L603w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vy7IjjRYCevV5RztQ5osGgKnaMzqlbcwY9BOi5Wzk/863sBdPoDJxfFkFESRZo8NqZJqhlMppm3qKROyDvgTdKJW0w8Y+kPvQ/QjrzoYzts4rU9KX3HDRc0dHzPYNLx/PaTcC8pbRPxPASkYt7nke4uiX3DK40dlV7iHnJewjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXA+7JwA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eceef055fbso81688871cf.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188643; x=1762793443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5Im3Pln0a9an+fAWtgyl0jY5GCpUicHm8/nn+JeBo8=;
        b=OXA+7JwAhARt0py13xRki8ezHOuagy/kjFbmYEHFfcbKEboQhWLUA0oPrSFvsoR6d6
         Q6sw5gUCiCxJnACtCC6wkYw4ZniJfCdx26BpwezTxDjmvitBuzJhCIl/1DPP+e/viZ13
         ckiIWhdtndJ1EaMbZtITCRVuAuCEyAAvCQTQ4vloB0EhznSqhqw4AWFsTwiSQoOPF8cm
         56aeyu36CMjkaVI1z9w2n6puSPst6nOCRIceyuUaLUJZ9aMkVNpXV3FN/8CI6T+4v83E
         wkhN9fSJpEyUOPjpRSOqifBzVZ1Cdo1wiFXjDMbw7sj4Dzl2S480qvjVvBPMAfEwgRUG
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188643; x=1762793443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Im3Pln0a9an+fAWtgyl0jY5GCpUicHm8/nn+JeBo8=;
        b=s5ngYTSsTQ3DShWLSwgn26pMI4rR0vh98kwxABuejZlKDVZVvo178a6rrKQNQE6mr4
         7nSdktYOCvCKPpPCLMzIcR1DezEyJOEDaNKVfV0T3o4/+TUNdWhOkiebo2Mvh6A36HU5
         0aKE5EyNDglizU46JI77Uwkj87WAdfK2JPOi/tyz3+M0uAgYNd8tvU96l1LdDk9INlVO
         vo1T1t75y47UvBy0fZ9pKm5aAJCxkABGg6vhPzn3igvE8h1Z0a6YMbE7w+1tQKb2W2Sr
         sbLKrDAupkw5hG9cxQ3QG0E6BAMSXE7FsV/6PNT1TbaLkA3LWvSklzUK7GWtXxrAdpQT
         D3ng==
X-Forwarded-Encrypted: i=1; AJvYcCX4IgVvkH/oROlticAFlvtbm9HVOkRFJLQTEGScOlH8ahEedlg0MBi4ItruYL6pWZWAvcDdQW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4S+YDEH94kzX1unrJV5dzYYIMsOizAW1M5ADr/Ep0m9IXe60
	o7XtQHJxe8XyC+swSqsr2D1NUBq119B94ttz4P2VVxgl7J1ebogz2tPh
X-Gm-Gg: ASbGncuZvChmgxpFlvokyDJBqyfrLR4/z5YXMS6UmtcpceewqtH/HQWgi+A1Lj8RH75
	T8Z2v0E1s52bs8tK/RulcFuJRpW8qmSMVcNBHbq+zLid2e0dBhS0jRX/uKUqoGO6XV0wCJJy8hD
	S+6D/CBzwEQ8/ut5Y/Kg24i2dF3YCE0+Zf2U92Nde/FMzlWQzC3Mbt8QgjQ1RJfj0hVLMJYG+jO
	Q77//mnTcH6P0E3kdbS1/mtKQDEJuWd3Gk3FbUx9iXUElUpt4WCksNTi2tHaA7qHRFwoKrT6nl9
	i+q+ffz+Ob1gQny4yQpHXqXazNP+UsNt5oRKovQHNfPbsjUmfLPVzqgDUl8sbVLKV/Ax4sGgHaB
	JYrClmUWJGzQmRtxoixeg1u3jTfv/DUGtHE2PICPtpsgvYjfmvMaSXUMesq3986i/Lxo1cfJqOZ
	vtoh89XZDQtTVQ79YDlDGKulyfGT1LCn3pIXJpuw==
X-Google-Smtp-Source: AGHT+IEUK+QhETnkizEVhsn4OSDbW8TLlREputnus2DePYq7zcOHls1TEMf1YxRKvCho95j2x2XPsw==
X-Received: by 2002:a05:622a:4890:b0:4ec:eec7:483e with SMTP id d75a77b69052e-4ed31055828mr154509391cf.68.1762188643647;
        Mon, 03 Nov 2025 08:50:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbdf2b1sm1644631cf.17.2025.11.03.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:50:40 -0800 (PST)
Message-ID: <36d2ebd6-118c-4847-9233-ff848f6425c4@gmail.com>
Date: Mon, 3 Nov 2025 08:50:37 -0800
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
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.57-rc1.gz
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

