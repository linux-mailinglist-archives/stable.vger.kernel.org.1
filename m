Return-Path: <stable+bounces-124114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE06A5D3C7
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 02:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B71796A2
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 01:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B808770E2;
	Wed, 12 Mar 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aSsXgzvX"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430879476
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741282; cv=none; b=F3ZNYu5zzd3viNqDbJMqdkJa76oyPRPY71nmKoxBYzVo39+eNlM3Wo6J4whKY+cgo0P8ObiAGJbtqWFmnvWm1qv1/9mqrZL9ttpJ1zIyi5Zg1DyI/kgNr1t7JP0roo9SenHUhAz/Wn+LUDq6iGy7Pwea44n+vl+tHKSz2N2qoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741282; c=relaxed/simple;
	bh=pqTs6PSez0/L6cWDvEZMc3ndJbwA7vVw//pZkJYuDZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvZW9YrKoS3fUmYoJGv7u0z1tdMJY+sTyQ7CJpKRgYS/GWOfSofKJzUPU370X4J39VQMVPe4PP05XXNfxkKDvqr26k3EhsICbzBRhc+tnmL1zfeRJpghB0WxKik6heX0NFW+e2St366EAAYf4yOH+6PeiXbqjttGZfbZexO4bAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aSsXgzvX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d439f01698so1501945ab.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741741278; x=1742346078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkhqhD/I8qtsdXa25766C/WcZA5mOA1TQObYPvGOQ1U=;
        b=aSsXgzvXL0ao9yvhi6fc7zaEcaxiRT/gBCCSvJPFqExOXK/THL0q/hj/s6ENGHJOW4
         A1vDMOyAcIqDXizr/iIo9/uW3Xom+Cr6rT4xOcVPtd/spqnOL3qB+t4uQ/tyo/T5vLZo
         pNDRt2OhHrkHY5rbB4VRCdm+8wzXaC94DQhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741278; x=1742346078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkhqhD/I8qtsdXa25766C/WcZA5mOA1TQObYPvGOQ1U=;
        b=X7aTAVKVrNS9h2il+1XLWQltyz2a7QwBSgTXW8XZSDWSClSBDttZVJPf6VljXwhTug
         QJ2FGyu1psCOLHDgqwsDMQUMBd1J9fhsgJHfXKwYAaoCTkwKmS7AAUKL2+6yYe9ENbfm
         Lowkev7GkQppEqeEVb5AVr+roFFUI4seNQQhzAaS8Qdpcv7hDcUnAFjHbJieLMerGv53
         3JvSKrc1gqAePtRi+2zhH2iFRViFgd+BKGOQuq4TV5IJunxxJKN+Cj1J+Xid9dAReHcg
         of9gQZGJUfhpyDZJw6s9w+kYHqvPtBpYnE6mBiYLS994qh0We6t7x/153WzLYBzx91II
         nvoA==
X-Forwarded-Encrypted: i=1; AJvYcCXEqEG/6HSoFq0SFB21ZlnlLdhPiDMCaS0dEY0LSibk56kRauJb5n8BCBOe5k4SuBIngs4I+xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aWBSp3clT/xZRVVZAjOQLDubGf7xwnKu62dVsZWmB8tjJKYK
	B6lzZ2I4+1ysC7f59QrpMb8PQaUR++GOGdu0k3R+kKdEnhJ9kle3lI9DBwAZPyY=
X-Gm-Gg: ASbGncv9xaadned40QSKcXyppp351M24Oge8vS3Z9dNUtLxmNG6/0OLi4OdDl5VuLB2
	Oxcfc+bSg9dxCyNX6zh5s0xaWe6cwtoZ8/37QdTUwF4L2hzSU1oX+aVtSP+mqtoGaR1qK2mnGe4
	6dGqQmib5A02aiEUSWpAK6Uoq6SxJH4kLSzN1NXDBMVeX4t7I2yIoIPesDlszMbHqHhsLA8rQq7
	HHY6M5Q9ZGCRqRdZUgbjLnUMgTLwpXb5DJCogsWZbV0f1RUfVyLU+6mddBzWdjtGVxKzUXzoF9D
	DX+keOCW2tEWKMrN1Vf2bSM0SszzK+P+FcXC/t/ONhLUpix4GB1hN5uaeDcObF7COw==
X-Google-Smtp-Source: AGHT+IFwl/yS9RjSTW02QbwqxgrQUdpwIRAbglibdgwGcM7oscbPj55DnQ4Alu/un3yCdOV/hEuAjg==
X-Received: by 2002:a05:6e02:3683:b0:3d1:84ad:165e with SMTP id e9e14a558f8ab-3d4691c7983mr57874765ab.7.1741741278248;
        Tue, 11 Mar 2025 18:01:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df4c5fsm3045120173.1.2025.03.11.18.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 18:01:17 -0700 (PDT)
Message-ID: <bd63889b-7b7a-40f2-9236-3dc974221723@linuxfoundation.org>
Date: Tue, 11 Mar 2025 19:01:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/328] 5.4.291-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 08:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.291 release.
> There are 328 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.291-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

