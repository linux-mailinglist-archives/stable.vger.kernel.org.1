Return-Path: <stable+bounces-17356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4A8416A6
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 00:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4EA1F23FFD
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621E524B4;
	Mon, 29 Jan 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6iN2Icg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078CA53E08
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570105; cv=none; b=n2+zigtZPPBbyEdlMjbsU0oPWj8A5NqkWTm6cjMlDIhYbpADpNoseub6v4835osHv5VDKsducC4ewMw5kyjbsi16nY3gq+YZocUJpJwZFpohQG4/4kZWDWWnoUYP6QheQBBGoKH4gZnkzd6fLyGbx7pKeIlhBRGjoUXeVQDLguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570105; c=relaxed/simple;
	bh=ehbO0HFf0uL/p+JVVry66GgwWQcsluKxO5QnGZu2pHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVAF1sjNnX9JYGgYVFbml6kkPLTLI//23hJzDatE/MFCFq7a0k8RDEUOhcvi4jB0VoHUEz6qS4CtLHyroQOIyBKsSLrc8CTbH0Gy3ClL9VVbFl83mubEEMBaiDUQTi8D24BUhoBrObeazO02RYEi0VawXF0L2PuNdUkcb33ysr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6iN2Icg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso45590339f.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 15:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706570102; x=1707174902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlEg0VBx55ozwcl3uKk0QdR1gxYWE04fuZIKqnVt1W8=;
        b=Y6iN2Icg7qSarB6L6MO2ZO3xqqEI1vHsK0M26IJAlFeCKwid72h7RKrHpN4DSUTyr/
         zXXpLGjuP4kQU0mFL7+Y/RCEGW42EBDvwe1h/NEgNDydRu4+X+2iAP/Wiiz0PoOE29ed
         2ep6GmmMJBg3UV1I3NMvsK7Q0cGrAoqNr7GZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570102; x=1707174902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlEg0VBx55ozwcl3uKk0QdR1gxYWE04fuZIKqnVt1W8=;
        b=SXqiZEnXueK6iIhhN3qqtX1ooHyYNu/OtS1l8EKl1u3VwfD0f8X+4g40QGL8Er6CAB
         BU1zRTHixs2v55TfLzWsVxgAx6CHpgvUIpH5BKprQcwpYDIONNhwKN7aIWowt80vwyvh
         0MGxX/dzY/tRIL5BQR7UmRO3LMmS21FqnKsUKr94eE9xZpE/TAagZjqyL8oy267vOYd2
         BhCh5/W+SjM9w/U43Llu8MUb75RODVNhA9CIlJT/U3rf5kbM6ROHrItcQA7Y/z6Casuf
         UB7rNXhvaTLWVvCCOo4uJbsRsDS6mooo6C3yGtPUGL1wn7YXyOHzbCyyPuSd1JGXgayO
         i6/g==
X-Gm-Message-State: AOJu0YyNeawyZeo0BBYqXfsTts7q4j9GcdREM7m8+sSIB0ZLYDmRRYRT
	HqHCJMEPSMr64iCGSbM/kJnk8hQ5CkhnWiv4oHraKs4HLd3rqdrvoJ+/CbkfwpQ=
X-Google-Smtp-Source: AGHT+IHTwdmWs+k8W9kmfFqN0grLMB9mP0tEqiQOdwQiuLcTv+h5u+9+wvYtVGHtchOhzbsPR56BhQ==
X-Received: by 2002:a5e:870b:0:b0:7bf:b18e:fccc with SMTP id y11-20020a5e870b000000b007bfb18efcccmr8110539ioj.1.1706570102071;
        Mon, 29 Jan 2024 15:15:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g19-20020a02c553000000b0046edf6bffedsm1988701jaj.85.2024.01.29.15.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:15:01 -0800 (PST)
Message-ID: <88a1bc55-710f-4d64-b51b-90787a4090f5@linuxfoundation.org>
Date: Mon, 29 Jan 2024 16:15:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 10:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
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


