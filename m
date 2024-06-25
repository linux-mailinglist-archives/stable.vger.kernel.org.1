Return-Path: <stable+bounces-55809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C189E917359
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 23:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7079A1F22F2B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC3176AAF;
	Tue, 25 Jun 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KcjYRq4t"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88D3B7A8
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350685; cv=none; b=FnEnPKNnYY1DcrlajRWQ6ENe6OvOKf/Mcymmy2I3bJ8XJxfcn74/Dp0vBkFxVSSkOuGKMTlmjy88bXMFVmW+3KJecuuOwD+STr6wS+OydsFMYKHcSrSkG78bYlSDSGEPIaDkajAMS7DutsMznrfxT3/1k9qGYtJXjlQwM2nPDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350685; c=relaxed/simple;
	bh=nW0DR9XCcCb7XpSfcLzEN9SyQQOB3xwFqsqnicd5H2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb0jo8JGIiehaM0UIiqPPR2ZZ3haqKXmkrFpmt1RbqXehAe5WV3fmmDmJisArUqxa10D12Ddh0M4oIeC/9JBZINcPtgK34ZgboL+8cDSJApEY1W7fQ37r+8x6ZXvlWn+cSovcXF9CZC6Hwqq/OROsrak4C2hba6+L3QVpJRBYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KcjYRq4t; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-375deacb3e1so2495745ab.3
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719350682; x=1719955482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gq8Vr0aVYkgo0bSzjSaPaFgESu4jvyQ96EXjHbRRL9g=;
        b=KcjYRq4tKVY3SCkk7M7tK0CIqQDlJML09IyQkKcWK89H/cmIskUQvYTN8GUjtJ3fvR
         3/9lSJ7u5K+STN/vq0xXAuT9nntFAsqS7+DTEJrSbOylUpur/nJ+rw5A2Bpj+ga+hz83
         Fj3WPvxjGyoph9bt6V7+1X00oQUK9Ap3a7EIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350682; x=1719955482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq8Vr0aVYkgo0bSzjSaPaFgESu4jvyQ96EXjHbRRL9g=;
        b=qCAQplIVg8gU6jwI2TH4E/7gRyZRyT8qHqxL//hIxxB+YAS4g6uqtOxzA20rHsBDxw
         j3E8ERQBdMEtT2h4saqjXXaHQbG9krehiKBv7n0lnfbKJ9z0svgrFjMzv8e/FTaMwAfR
         V4dfDyi5KvjMQuvZAZTC52n2/ulWcb0deaBOSV6D4faxVMXpMuXL+g6Z9Z0EcGb3uSnL
         2UT/dokywVDQ/rZTkoqr0qZk+7TAbd45CAWebh3J/PbFhiTF66bFpw3/4o7fn+vqMpe2
         eN1En6qyTIZyPA6Zk8fXKM5OeaTYqaF+omqnsuK3j0ne1sNwjxOSCsEzpVAhOh1fNMqm
         prYg==
X-Forwarded-Encrypted: i=1; AJvYcCURaBDPm4LwmVGKSzEiL51vhrmgizP+2J/Bh1hzHF7WW5CBxAdL63Iysd/165wDEvxadaMOZpR/ztqItpdHyhl+I6zWH1qE
X-Gm-Message-State: AOJu0YxJ2NSO44jTgoQNZMmQn+zo5rCzf7VyAoBwCqpDWXspfAtfUZHw
	JGBJcd5Y4GoulgrR/Xfv061r2Ndp4H6Rgg4HgNiK3BMR5tgNJhUpNc7DBmSQtL7puvqEGEB0sgT
	9
X-Google-Smtp-Source: AGHT+IEXftu3PDBt6unrIK42kaT9PZZmR9EuAq5kHQmhySuQkvNlwOHsh10mIITw3dzkWfWG2eiacQ==
X-Received: by 2002:a05:6602:3305:b0:7f3:a20e:c38f with SMTP id ca18e2360f4ac-7f3a20eca45mr930160039f.0.1719350681125;
        Tue, 25 Jun 2024 14:24:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff51ecsm234726439f.31.2024.06.25.14.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:24:40 -0700 (PDT)
Message-ID: <251c5d41-a8b5-48ed-adf3-864477059070@linuxfoundation.org>
Date: Tue, 25 Jun 2024 15:24:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

