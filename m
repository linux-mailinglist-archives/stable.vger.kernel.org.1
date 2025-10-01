Return-Path: <stable+bounces-182971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC30BB13B4
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3811C7D7B
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D7283FEB;
	Wed,  1 Oct 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShjPxmBT"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48342056
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335460; cv=none; b=D+1hFKtyljpxLD9XvZoOZT5+Gl3I0aU8iC2+StjpmsR8zymQbL6Sa4+RTmXsQMKMvl1VK2qEDQbzgWqpbhdHze+lSm+ZukdJAe0JslOtn0U3p6D5QHoB/1gytBkTiN9OINcJ2c/Mse9estLkzEZopgyG9KUHm2gq6SIlzR+9jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335460; c=relaxed/simple;
	bh=42WEIdqkfFBAo1Dv2IyGMKfPr9BeV+nb3loEHQqymqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyTR3YF6YPE2aC3jBPI1FQ7U89LnPGv5AGSXGF7SHVoArXsnc3H23vXWI2tTG1+BfvDaRVr5MyFnRUa11ivgC8NR2UMFM2djoF9hs3F7Ge+Jju85dF+5vFy8TC5ZZuwFT/bXEHGTBHaI1XG2wcr5zyWYx29dq0BAqzgt07tCP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShjPxmBT; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42d8b15548eso110085ab.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335457; x=1759940257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te+5NbOWKHS/5qX08a4TSadV7+LggdZYvrui5XC1Ixg=;
        b=ShjPxmBTojb+yE6Ftg2K7Jn4bsobqVuN/uCu+P93cDM7qAe+5CLzEd3KvzOVi9X+5k
         28cIzR0iB9A3BkLDRwnwuRj/phUlgsBi6p8mDjWr6vg2IKd+ZJq/8bws/O3ySCAjfPmn
         y2GaFR2pkGD/0ngwIIy/1QGRir0jaFrQ0QQHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335457; x=1759940257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te+5NbOWKHS/5qX08a4TSadV7+LggdZYvrui5XC1Ixg=;
        b=TjsBO1Yfuas/m2DlljOp0133nvA8Lm89ju6QCdqJP6MbNlYbXRmBbGz2URVr/9mFLf
         ioQihP2WHBFVwMq4vCA5KKTHeVbpuQv7VBn0rsz3aLuOK3cT5mHsivcd9qmAJ14BvU7X
         3CKJOSmTqr09sF9flFNAbz15C+gHgTLMFcwuVGU2N+o3Q2YMiUWlVwEGprLb/5wAMXYu
         qYhX7LBNrNqGPyPgBuAHtqzeduvgHYXGHxrK/njZJNIQldgxVNnKtI/tZ6dn4JVRaWJY
         pSSAR/VQyk3plLsnbbyQIneoMncmxgXt+xjLUoHvoPydy8/5r7dqgfmPbqivZz0IkDTA
         ZpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFE/uh749aQm7rQRXzSSkpeD/Yauqxp0IMWvOz7xPprs3r+jcoQGJYX7+ugDw+KYpPiD8WzTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdfuu3n7er31EispXPEjKv+zaO7LVgzNrBnhyHozeuCvMwovQ8
	vuH5VMrYXF35Y8cUK7J9zo59jMrGgqFpTXDz53r9YjWkruAbdCv5dAFRLP86JdVEZdk=
X-Gm-Gg: ASbGncspFcG/1RSHx8QoB7v/myHaEWXRNZQAxSZwfVk6o+VhPAQPdQZDEhE3qZwEaEN
	2F5RSqgXZw2KrARVjlyjmgf/Udj7qt4XPtARvVtsId4o5a9BoU5kRyW/mjFCqEEZ5a1u332Og4z
	Sv/eMWSz2bPLr4LaKG2OqOjivzqwoQDNqfnTzhhDUKkKpyQY9mwoIze7lsA0pL6fIQVQzy9L7+3
	Ftg29J73rnupLgQ/Rf6a7Z2UxK5vMhAvtr1FAu86xNuXDp7Dbn28/QGfawf3ubqk5iFcI72wVZa
	PPbXS2pbnA73dpKIJcjWJwtllZsFfiq2mbapjPTsubuIdvW0KU8RB72guMrZncLVxJR1C2SAffj
	+0MhCVNEnm3Z8HBQWw3O6Bk2GErnaGesKYK6jYxIhLvASTN862YD/KwAxny0=
X-Google-Smtp-Source: AGHT+IH0excAHZ+jMnE2ocUE86didFlaIgYk6DkZJGEMwQnc3kqU0Y4RCbD9igEPUrB7EaQwDn6QJQ==
X-Received: by 2002:a05:6e02:1c24:b0:429:792a:a8b1 with SMTP id e9e14a558f8ab-42d8161793bmr59555515ab.15.1759335456959;
        Wed, 01 Oct 2025 09:17:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-578cd957c45sm1392409173.34.2025.10.01.09.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:17:36 -0700 (PDT)
Message-ID: <92cf1715-4295-4ef0-b6fd-0774f4fcbf11@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:17:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

