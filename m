Return-Path: <stable+bounces-209970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5681D29115
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3634E3029C79
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043B32C949;
	Thu, 15 Jan 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvcsmKKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A42E090B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516927; cv=none; b=dHQz2fgld7+GZ+b5ynK2olYpETGvT1s1wcD571mflyP/RYZpZN/Vc9Ynb/s//NI4CHZEOCXqm85yYAm7znUbhu+lqTcRteFcJionrgMBAwdaOcRHwsSbvuJoU7/brSsyx6p/J39qFCVdeFa5mDKUMF3D5o+37mbPH1pkRrbVMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516927; c=relaxed/simple;
	bh=bMOaTfGugxS6QIi36AKbrK7Y8LT2HQHJHPSWYoRjJJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn46JwaWHibl1joSmDYBUHXi8n1Srh/ye4BQP78elZBYbvCYjRNi1nh3UNR0fBa8dNqVb2cuePOD0/ElK7X/DfouVobPRcAPTVvkCx2g+r4UoHKKN/CxsKt66NJuya6qwzB907bqoMlxlmuiRgE28s+JfEw0tkktMWPfpJhaOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvcsmKKt; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6610b241d19so734694eaf.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768516925; x=1769121725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw+GRLa7oPofsUXGY1SgAYmLZ2UQOdGxmoW3/V+A5Dw=;
        b=UvcsmKKt0RksurKztCK7wf0GvUU/DnqwRFYjtOG1OSIIKYc+OfOyUi9grG7jGBJ7hm
         c0CGg2MHI5U+8p5z4RYDthhBSV23uz4gCpeBipGLb2a9blK3M2t6JuWNJml+WWeE8nII
         XFeA1ZO5Oibji/Vd4j/4Cjd+H9Z9amFCXZ1Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516925; x=1769121725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw+GRLa7oPofsUXGY1SgAYmLZ2UQOdGxmoW3/V+A5Dw=;
        b=g5RkzFjmCpAFm06x2yA9HuIiu1K9qipzdtIO0PnvNnqPxnzGoZfIm8jKrUutwgBdLz
         ZXhgl/cwuWzQjBDfQiS/VvFYticodHE9PDzP6kwIL5OSCCo1nnER5LyadLHU68Wve5zO
         PnaUEPZykrB9p7WePh98nyNpVfCRVch9Qs17mlJzmt7AJc6+d7ssx3YWegDVRYeo0wR3
         OtWaNrLdGG9RNfiCYM36uLCXRPX9A62yrI5yuGRgjzONrE5NBZeotYmHLahE82HYhPh9
         vdUyu7kViJSa8KLWo82wtUONx4kuxGlW7WnU1pChnsceR4hT1Md5rOyZyXUq9BN2dX7G
         y+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXWG828P4DMKE5CwJG4ilwBF+yZCtFIR8GIDydtWxyzOGD7jzoH4EiuRBhntceLqVam7o1wOnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJ7NRXw9nqVbDxiQ2SkC4Zcr9CyHs53/K4vYVuStCFw+7VYjN
	n6DcfEYFix3zKA7DXzBsiTohDshiO1WRig9VZjRzLQRcIFdNjbppUR7ylJFw6kqWlS8=
X-Gm-Gg: AY/fxX5o5d/thA5NJAP1HBCnJi5/MzKuhYBlLO1yo1l7/dks5g0Rh/7d+ldNhQwaKp5
	27oCjUYplWC8+IT0U8IHO2mTa0TqMpg1VsTN7QDOIkoZlRnaWmPAg+fh8C6v00ysqtmvCMC8oeu
	dzDDKuTQPxhn4Djt7jxtutHjBbi0O87BNWeNzN+TSnptsJqS11dGRDCK3u1efU5h/TrhUSdjVmh
	4NffmrGQZGowwe9zAVuIs9xE5Blgcwhsj+B6onG8PTS+zTE0RojsWQhvLw/x9XBt/elUVhvL7Bz
	3zx/81O/iWcw57Fsjv+F/vaS+Q74of4NHm8/L4pi3ZNa+mK7o2L4GMFpihV2CzWnV86N//Iphng
	9piMBd5RBRs0OuI8ul+946DFJ1tZCPf97lBfIrfbpL3pbjVsH5N3JI/2XkxRJ2nZGDpYhWaReu8
	eJLIRhd47tmx9tS5Mfw/7WLDA=
X-Received: by 2002:a05:6820:174a:b0:65d:1697:e6ce with SMTP id 006d021491bc7-6611795a653mr585783eaf.23.1768516925352;
        Thu, 15 Jan 2026 14:42:05 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661187cffbfsm407799eaf.17.2026.01.15.14.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:42:04 -0800 (PST)
Message-ID: <ced90aee-f047-4304-9a7e-bed0ba1db0c6@linuxfoundation.org>
Date: Thu, 15 Jan 2026 15:42:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260115164151.948839306@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

