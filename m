Return-Path: <stable+bounces-191540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8AC169A7
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0F1D4EAC1F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A134E750;
	Tue, 28 Oct 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BAxn48q9"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D6255E43
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679531; cv=none; b=eFA8Qmv5/f/UJiWwvktu7Esjv9xaZ+VKOOnyfKMrM1o83e9eXuONh0H4AZSy6Jn6bxLvUovmKNtTIYFGXxQFdmZFJIYEpNMd79YKO4YtCaSwDTdxtoBs+Oo8K3+sEuM9y5OzPMdlkeE7APpIkR8nGTGVMeNyJJrlJEN+fvCLkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679531; c=relaxed/simple;
	bh=6XhqGS0XEGnv3jX/pGKq/NJFCGQN3DL8eZKSvZTExYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ/TuAze+xkPCuY+P6kpCvzooI5prHgEweApKgutNucc0k//w04VnUpxQrDR/fl3Hj4jDgddDqX7KwecaJX014IVfV9/tMTVgsIOT1hq5J/E1Jm8QQDPa5AKzChJ5VbQs5c7RIE/Sws4l+kh4e0uNBZHIdjicKizAdkUCj+Gdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BAxn48q9; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-945a5a42f1eso142719139f.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679528; x=1762284328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ntm+pSoGGrTLjw9jSc8czmANZelUc7CVhn/2fFWs9c0=;
        b=BAxn48q9qmIhuzrd1+0qaRlEtIifjez2mnZEjNX5U/pfQSmslrM3AxtA8CX1Cbeau8
         oMRZsJuKPqDPIyN2GJNdC4YSOAKusT3BbgdfUEKbgvAbCrVg2GXs5mdKyCvvVx5Py5ux
         Oz6QOBu14s/weGpcSPjxXzSNlVmzcRWoxCYvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679528; x=1762284328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntm+pSoGGrTLjw9jSc8czmANZelUc7CVhn/2fFWs9c0=;
        b=TKwUzk9P8A9X6PqVzBiq7ljMousD2VcBxuoc1l/RWNf82BSdHMi5NN378sWfVrPZd7
         9R/35wjzgadw50IU+xIwuU6sZZmGaD0m6odTcu2hzoazbZmMJu0Ez6hUSVNCMifXLWsy
         fVHuF3kZAB7CMOwdUk+i9BnPNywwqJNDZ0pUG/MGJ3A9T41b5YYq0+ZCjXZeSLw6tym+
         pLVkqhnkZw9/6o/xBWwtOH+G1NvIPoIHgTW8fLgCSEEU21Tn7VLciOllm0C+j5dAltQQ
         pXPxRG+4oHXlc2eD5Mdp3Mf6B9Bm8JZyBspC4U7g9wR4E5OdpV8li29/yDSa8sve8Cok
         uVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4xI8R8DZKhurrIunUm+AXWKpcD5LAIZXkNqIQFRtsGxPh9UsS/AaY1vz+pQTUUk+qrC1PhB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01y/6rKNMOeP0jrCA8THKaWh4EP53down+3dIjHvdsBilgSoF
	Ds35RfUOXwU7UzNYaq/lzBDMsG0/vOAlA9oTvQH07f8iGrBybKpKXCE/cLbBHSXgx4s=
X-Gm-Gg: ASbGncuDvH98S4Q46tgJOdJj/60dWDN3ZkHjmJv6mDIJXOSxOXr98C4EufYo2SRIc9Q
	jfwkStXGlYm+nQEHTJ89K5Up9dZ/Ab+dYTcK4Bq0cO1ZgqO8datDsrUUmBUtxt+mOxEuLJDPd7c
	QKlzhT0JHhlupXnsZEZ2wd4BInMo2LAAKqD69/XlrMo+CynteE9wAqNa093jAv/Ui3xIG/8m+hM
	hRpCdomqHS8ZkOXQUn9rwFOL4N4CYqzcR5LBCHCsSSvF0rlnUMJkqPY5wNKqkct7xgWNNTqr2ek
	HKnCHzMKnVgk0i8syrjI2NmmoyJSyda7dAHr5JiPM+te+4NtnDfRP4ggTwNYtq4rF5icMhc/jtw
	zWzhozlmsnOzPZrDkUI1UQRQpSg1ixjFk+BggaBQdIq5AL/U3tCZRms0sA9Tx66aLTqIThyxw+k
	ziXkq158WrTrND
X-Google-Smtp-Source: AGHT+IFiT3LediOigZFqB9hgXiOho/4NEBYFsscX1ZMleYKnQWVc995iuHoH3hsCSfQ7cCIC5sZbbw==
X-Received: by 2002:a05:6602:1613:b0:91a:695a:cb61 with SMTP id ca18e2360f4ac-945c97f0662mr94211039f.13.1761679528464;
        Tue, 28 Oct 2025 12:25:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359e32d9bsm381597739f.2.2025.10.28.12.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:25:28 -0700 (PDT)
Message-ID: <1db89160-7f4c-43fd-b12b-1aa624d9d09d@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:25:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.115-rc1.gz
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

