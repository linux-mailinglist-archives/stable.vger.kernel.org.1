Return-Path: <stable+bounces-144204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14DAB5B5C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0933AAB68
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082B1DA31D;
	Tue, 13 May 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZydaXYus"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2331645
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157505; cv=none; b=AlQ54rzBYOazd+LrHk9quiGC01eWFqJgBF7BKJOsHyew57I92m6O36ssmMVvtgdEouRDEjzkgQYJcnCtWOYozttqhYW9gZFgCXQAWUjS3AWN7AA1D5hnunstdJBEumEUIvzikT7xgNgFCP48Ymu6BcaTyyh4V3u0uEZT7Dwjuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157505; c=relaxed/simple;
	bh=SxZIwTrJ62NdlaBYSELFNzFfvVHXOji3aJBLXzgDJCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nk8nqz8DGWArE6Tredqkjf4dj1KUpvyB8t0q1LD/xGuc147UMFfhX+KBbJkXsUNNECONQVg6fud/NKvoEFOigrfXqCBTJ89Foczs27rS5tlJ49nUbb2njPhxJUSXniNyaBrJInh8jjGgVZQOK4ZdJMqunAxqUpUbgkchiao0k7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZydaXYus; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86135ac9542so4083939f.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747157503; x=1747762303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nG0XYUWg69EbLL/G8YlTfCVljzU0GFu4+p99ldKTo0Q=;
        b=ZydaXYusUo6CNd3608mYXrc/HReOEslmaAeWFK0lwqWfWb1vYuHakq5NR69bQTSyg0
         UnwWIj0THn5qxoaU271ModTQzAbNY6nPyCLAa2mCw3HKw5mhtGIwx2pOcW/oR5Ji4U2v
         IxOmAR2j0CB8SX2eXysLFXdRywqdlRT8TuiGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157503; x=1747762303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG0XYUWg69EbLL/G8YlTfCVljzU0GFu4+p99ldKTo0Q=;
        b=Uwl2V9ZResjHoo1oiUONaCLXRAwM253mcKDLPIZ/OYS31DGVBOyUZmfmijeD0cZIPA
         aSJWzpTG9t4AeHm8MS1g7+vcUCSRN9KkptvySxSgcCRN6FqdpycWUxmrpVxRo+lK1Htl
         FrQojjEC2MhnADX3x8ouqlQWznZ34/xBFl/aMMIBIEgESwBkbhA9NkEMy5yPWeNOnkbk
         /5lJhToNZhRoQ792YjW7iPXBcY2Xo5X54QiyTUOH/vRd+9FZ2p5N+Uw9DjRfMrnEpoCp
         6phcyseKqUWdeYHUlIoDSDzEow7cnROIGNRLUsVPCXv4ZS6jYxphljVDmJlNC+3K7zaQ
         Pgvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLbTp0dIfiVDjj1JPV+fKqRKg9P4l7fVUYTuez62ewLfBElCl+8bnZF2N98u2A4uQU2k8HGJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa37E+Bl7lsnH9Mt5b+bC5XzBGpzeSf1cqQD7zEHNfwMlwmX+H
	dt1gCX7IEPYRSx9xQJarwW7grZ1EHQijASaO4+VZ5LHpCWVrumdrgRu73A5q9n0=
X-Gm-Gg: ASbGncuri4WDBfyvZgXhSgcp3lS2mRfNQirnwT2qmy5/fIprpOCRHZskUux1mCQN/UU
	mTRNkU8ThoHG6P8YMyGAVTd6X3rCTnjCqNwLdpHG61ilCyuRVzh/7/GE7EP/gFdLKOW1tOehpiN
	fz7riSsryPhDOGsWlf82kChrXPVtZDTwUCmuZxfqBdrxKp5TZEsXD7MMqZGuEeCneMItb5gKEo8
	Uy0FyY5v+BZ1l4TxPGWDWT2ofcfylKEmCwntDnlH5LDqQutPLdACqtJV2X/DxSyz55Mis+g9FsL
	3HP5r5jGXDXZqny/K82vuXCZiSXjepE1sMbMPQXcJOb5mIXGk+T3LEgkFmzKMg==
X-Google-Smtp-Source: AGHT+IECJgvCVtWlq+g4QK490gTQzFPaDnyF62/GyTgHPBrHCrk7yeYlgj1ujylYOHqhp+zRxL5rvg==
X-Received: by 2002:a05:6602:3b86:b0:86a:441:25ca with SMTP id ca18e2360f4ac-86a04412a9bmr205433539f.6.1747157502707;
        Tue, 13 May 2025 10:31:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa22685251sm2212186173.138.2025.05.13.10.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:31:42 -0700 (PDT)
Message-ID: <ef7e1312-83b5-4635-bb8b-edbed0dc20b3@linuxfoundation.org>
Date: Tue, 13 May 2025 11:31:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.91-rc1.gz
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

