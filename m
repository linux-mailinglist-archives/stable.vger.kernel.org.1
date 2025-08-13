Return-Path: <stable+bounces-169419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356EBB24D10
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC5F189034B
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE12F83BF;
	Wed, 13 Aug 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFofw7na"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C72E5B22
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097968; cv=none; b=izdjZH90LAgNQ+G3ljRpeNNy8A8kJpog8103LU0xttNBIYSNrjoSvXvy+NA6pkRU5Zj/a2Qgumg+I87tlZmXeW2j5mCrb06c0wid+/Cp6kxwYEaCb1cCZAuwOn0xBbV2FsPzkvpSnPCwL/r6LAh6XGly83ioDVCQQKJp6D0AaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097968; c=relaxed/simple;
	bh=zVsSFbrvhm9BJ3DbBCbm+xy2MVqqV7KykKxHCqqt4KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmlBciqknet0+mDTHsQpix1mnAfdU+ORGUe5ju06bTPjmi20e6M8o5/KMTDi3Rt1MxGsGELsVhSXz7aQ71C1VnI7OStIuarqkxgUz+fsvuYqMmbXm9McJ4Me7UDVBDxU/OuVLsFehtkgmHqvhPJytYTAiiKKik9W2Wx5TQdMYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFofw7na; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e56e033976so1213735ab.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097962; x=1755702762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n42jFcBE2gpeQ/vI096ladjtP3+BqKDXgfUhoLDuD1Q=;
        b=IFofw7naSaDt7ClkuDxCq5Dg9crClItBMVTyW75rPVSYP295pK3/QTe+osvspfsuPv
         xEHCCag2PQ4NriDQSVwFhcAXQUN7hLVyTQTGgUZBNAzjJzSiyf2KccSfD1rLprrLo3yS
         XjJJotuK6cUDvtUKoZf0wcfaweMPnm3F7A+WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097962; x=1755702762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n42jFcBE2gpeQ/vI096ladjtP3+BqKDXgfUhoLDuD1Q=;
        b=OSUBm1kPKsY5RTxOPhB1YrAz9Ar3O8Kwh3d1CLpUinjw6WnTyaN6IqSZylQTO/Wuv+
         V89o3IugROA0o769OfuegeknCYivqi7z+7ZVlRqa9RjvxH/rbvKh4FsrcqeO0rnUJitC
         giCofdQS5nCjSY9KbkrgGOOF+bCri8XCXpjs/9FPdDXiN2+qLelGjth1uMOkmRx2j1Mx
         SqmcMgFusKs6x6kSjJFIzV+HojFe6YqfHUiUPz7H/RlQS/NORA1hxm9E0cTyKnr4UyNV
         W5e2NYGjT15gNBeqrjwCPsLC8Emq3v6QQBDWr1vuR+ZUpyHh30fxE5xkWGdPDx9UZdMG
         kdjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyhsfKmrGat+DjW4qnbgtqAfHaiaiiQSn5jAPJbrReHbWdr+Oe8pi1nAXT6KdDAaeyDfioRLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlErK5IvxIfYhLVLA97SJB8k1pOZ0RU7nt39KvB6prh1lalgY
	HqW5zfXCUm76ioVz+erbFMNqp1QVw53G4VcqWx2FaCmmDwUhzxUO7b2/+o7xrEguDo0=
X-Gm-Gg: ASbGncuPgna9A4MGeXP3jkNmPfkfQMQ2+La8FdlnLZ+WuzaR3rp93PzmdMK2mVDHN1Q
	YfcLgf4M8lenilyKKWoUIf8ZHSyElpwhhSg2YcMheoEHQBhSwqEuL2wSc1dflxnWvxIiKXXXW76
	1VeFxs2dKQE4wWFgcg6+3JuZfxyB7WQTFwrErw0khHeHI0EyqP73v+VDf7bQ1Ji+oExCot6fP2Q
	nhMNbLlFYwg/C1674XHH+DJhCjYSo5AWqq7AFiz1dqAdiXyuvywvUCz/rsqU1vUCk9QfkE5Mva6
	W3OEhF3hh9qsSNCBR4lQP75bo94HS6drUwVp6KAiWRaj/qGJxsICb3BxRc+BE/fra1vXrNsXLf7
	dAP37Kx1jpgq7gMZKtdDQAs4hyydD18MARg==
X-Google-Smtp-Source: AGHT+IG7OVrd+2DrUYOqB1Ip+rADtsN4EW9RyHicJM+g0CKieqgcluHwZyyU3hrd1BkUduuItJ8C3A==
X-Received: by 2002:a05:6e02:19cd:b0:3e3:b3d0:26cf with SMTP id e9e14a558f8ab-3e5685aa5bcmr45056125ab.10.1755097962142;
        Wed, 13 Aug 2025 08:12:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cfb72sm3840508173.33.2025.08.13.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:12:41 -0700 (PDT)
Message-ID: <9a55a42d-353b-47c5-bf9c-1b55bf67ec04@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:12:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.102-rc1.gz
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

