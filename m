Return-Path: <stable+bounces-17355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F384167E
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 00:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34531B2154B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB86524AA;
	Mon, 29 Jan 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDLr5zs0"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FB51C3B
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569563; cv=none; b=PIB2VWepU0mBZMghTYPfEVzJdHO/ThP/SRzvIyIWRancC8A7crGlk6K3dU8rxxOBBU8TPb/XP7a1dBI1J8UQF2Nr7+CDgOyEbLmqBfGEX7hsXRURfZAZboucTVtMh9qzXJYIIeqtbi9zrQ61pzB+yT+MTjEtKYCyd5jOSupFQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569563; c=relaxed/simple;
	bh=T1i+0Z7ACB0e1waX+DNelGsHpBxFRWm1UAJdYGSjW3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHTylWkdQKgOLfLNUOjRVAsdv67kE+kF9HEC8JdO/+KuuD193/INS6X6KJyD2a1oQ4umaJqpZ71EiNGInlIvAzqaEwITXxvLUIPq+oy3zn6DNxesw9aMe3KjffGiBRlNTrxxHweSdF/NwKOJ39fmMOkq1rudyIBOvKxJFplgByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDLr5zs0; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso45444339f.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706569559; x=1707174359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtZNDuZTycih5i2sdrujtgrVVk9yC+uswOIOzkl33jM=;
        b=aDLr5zs0/rTnaP4tr0X0Fvc2D7IABQDbLWl+oYH1uUWKApamAFTJn6u5E5BWvlQckw
         KVVbA5R2/tdMpLjdzJx2d39lCHZSpC3VoJNSLJFVbpNyGfBFHuc/XUn5nnBjDR8JBj5J
         8Mpa4veB4v0eKU2IOhFlKGh+oOA5WcD4kBij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569559; x=1707174359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtZNDuZTycih5i2sdrujtgrVVk9yC+uswOIOzkl33jM=;
        b=TNNd3WvKMCwyxE5Erxn1rwtQOzndJ7Ne79KjaImw/aY1u3NTL4urR321UJC6P92CIp
         BQ/G3i0QTyRDFRdeGK66iwVGaGCLcY9Wes6uVjUwqrHWeAVG4af9KUAmTiJJzRQN7AGO
         YXtlF/p3TKRI+aaGLAQ4mkh98xLB0ADe+ttH5OKOcg2d/YwO2Pns0z3h1Fi8iq9Ik4rJ
         ykj+V9paMaFNTMZIsMVoRTN3gqrVeOx+tm36n6rLrcatBVmzp38pL55cPnVR91RITHpE
         tX998jqA2ai8FlGIO7ZObdFIdRIVmiU4qt7AMtHvDY8a9g8cGPU7civlqGIHLBJrQcOf
         hvJQ==
X-Gm-Message-State: AOJu0YzvNFqKMYE8aoqYYv0RYUC6idSh6RvjpjtaJ6xP0zDczfYGgK6Y
	qXIDueBDwnRlzAPdygIUahxwkcaW9kwQ/+jfjtJR3jtYn1nADx9gFz0haoOAMKg=
X-Google-Smtp-Source: AGHT+IE6XcnK4WKeliuDrDTChW1y9AdUOP8cK1betdjliW8+3UzXaLc7J+q720eiwMh/frzYuEP3zg==
X-Received: by 2002:a05:6e02:1c8c:b0:363:812d:d6a0 with SMTP id w12-20020a056e021c8c00b00363812dd6a0mr4567440ill.0.1706569559541;
        Mon, 29 Jan 2024 15:05:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e12-20020a056e0204ac00b0036382acbf8fsm822713ils.24.2024.01.29.15.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:05:58 -0800 (PST)
Message-ID: <b74d661a-a857-4c7a-99a2-e5902f174052@linuxfoundation.org>
Date: Mon, 29 Jan 2024 16:05:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 10:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

