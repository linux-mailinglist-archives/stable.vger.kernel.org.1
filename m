Return-Path: <stable+bounces-132004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E463A832D9
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826C18A091B
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF092204F79;
	Wed,  9 Apr 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmNICRx+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2720297F;
	Wed,  9 Apr 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232208; cv=none; b=Td/ogHXofyo/cxkBrCAGY7Y677vc+FZJcR6WQiBj2acoIPpprsrcqAT7P6TRvz9SdYrR4oj0xB61dGCc9OFdkOdZORbCXw+fZRuBxWa9S5n+w5AYsGjXPJFAs29JKXNGtk2g5tVufflGvTjN6pbAUVymhSuYSGWjTTueoXnWd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232208; c=relaxed/simple;
	bh=Ka9I1gJSp0X0T+u/nhdNP1Ql3Cj7Gtryu0r8A3geZog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekeYaj1vzeMuFBa5nSwc0ncWbnYYozgLf54PtpCakODiRkjenXGNxRF2/+PB8iZxCGGVNOrHeFXZuvfWF7cb68dxJUlAMlv0j+kia6NbpVPZsgU8rSsKlPYq7AOlPmY0cGTWz97LeCQc6oRQOGG6cG/5iug/ExGTeDLt6qApPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmNICRx+; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b8e2606a58so28558fac.0;
        Wed, 09 Apr 2025 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744232206; x=1744837006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=St0u1FQ/HiS/87vKMqrXQMxMgUlG5KFQVCs/QGECYpQ=;
        b=VmNICRx+3V78ztrqglUta3S5bw1Y3UzPLRoGRy2AtHxZxXl5Y4jkHihN27Fey+NrZb
         bM2L8VvIXOuIdOcn+gUn88Ic1XDOFpy5lIT6utif0sDL9V13NhFdU3+HmT8CvnO50kGP
         gdCAQUukQ4obgmuAQAaBhgUGvp9/IY4fIc1d2lRksxMZ3oPXrndJd9X4NxI6eSDJYGnF
         uAZ+1147EydnwBuYqnwzw/zWQKdRchP8R0Bn/beLNAWYEZ8Yhiesq7BnNipn0ykBmotk
         TEafYdc/fiIIksiXr+MDkkwSk02Rrr99vnW/P7jsr0vJWS+gU2w98QgPxv7Yv4X/A0ae
         qZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744232206; x=1744837006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St0u1FQ/HiS/87vKMqrXQMxMgUlG5KFQVCs/QGECYpQ=;
        b=Ia2XeEiL5uawXxKS8wwz9vdcGJd4oxlO6oHAShOq4BXiQGfFHiSRrri6bsJgCQgXFh
         wvCQEHCL3faZDxoT4RIqIeqzoZdwrpoHm20xP6Gww+lC/jrSvq0TRjaPOA4QzR10xAAs
         sLGORhtain5+29ew8fI53reGloNz2KeDNoshfw1p4S9tHLnYv4fqCE48CyUpLFhgzTnb
         HUMn5oe7manx1yraz/QJHazHrpROyihK8cV1rBE9nB5GBqro9DmHN2Cd5uy/mCuyLK+w
         cQlezY5I1CNiQCQq98KbGGHp1WuzgvhKFC0JQjzTkr/2NyNpUUAYjxTFVUbwWtCowDQP
         R6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/7Ab7xQl1nN+66xIw26XfUwRgnJbC+hhtdnPU8sTNHEZjlw6LloxitkxrQvg8MI1iE6t3qmiW@vger.kernel.org, AJvYcCXOyJD953fNi9oYqyylNUyGJT6nIwJmGncx0WCuEROhDKwiW/Be2eA2dL0hane3BMgQMBWHoZGcnCFPvUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfuSK6g8OZ1xLkeKr4FMUc6YJMw/XNeDbXiZcxvdTBTnGU135
	ZYD89gJocii2oooDqCurW5ezTPTa7AuJYQHWLlkXR94iDBhb+qon
X-Gm-Gg: ASbGnctmibcDNPKBtapA4tkcKuUUQTQsungJGzlb+Watk7eLFXyWkVVsMXI6X33Ed9P
	FgVTGeBrTgmP1h/EMbh0yRKLfbqBp9yCRzCpdf3ihm16uUPNuqYxgPOtTeWYdy7b/T2DIjqY0AJ
	ofFpZVR0kC0MY8lLsPIc/DZ1z5kQs1nIXZTa4HJYkNpeDBKTAs0kRtP+14B/p8MiQ4BwnDNuYVy
	oD42My+Fu0osuKuteUSr5kOPAE1CGQ+LOWP2TzzP7y/XIpLarWUqowJvkaB8GIFy3H4CedetLcV
	tWDoIinUFkZ+lVIEwmGjczNvVXO+npU5hpb1Zi4mIsxkFTBJDXIjQZAOzu7gJLPnbuwQ
X-Google-Smtp-Source: AGHT+IHBEJxCYfyQDjJQItYWVDnh7HpluZP7fGhZMr8B63ZTI04kZBjK4HFOrDNUzYo17QWWUq5FBw==
X-Received: by 2002:a05:6871:71cc:b0:2b7:f8d9:d5f7 with SMTP id 586e51a60fabf-2d0b36d04ccmr115185fac.19.1744232206163;
        Wed, 09 Apr 2025 13:56:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd262asm380445fac.35.2025.04.09.13.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 13:56:45 -0700 (PDT)
Message-ID: <f170d500-8aad-4816-8bb9-b4433ab905fb@gmail.com>
Date: Wed, 9 Apr 2025 13:56:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/426] 6.12.23-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115859.721906906@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250409115859.721906906@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc3.gz
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

