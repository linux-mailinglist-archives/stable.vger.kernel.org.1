Return-Path: <stable+bounces-161497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB2AFF453
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971803B6CA6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4231FFC74;
	Wed,  9 Jul 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J1yZ4Q1H"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942115661
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098542; cv=none; b=drzdXl9usrs6p2OO6bcVTjgD8SpTervfxXf7a5sDFDM21aoD2GMO9nXgfoRlGr/DBLEhR3Vk5hHsxocLGvEJkbrv25Qz4DGms8NNhKvEDw5OfR0/Wd55bYZlTLvk/MEiYNb4iq9dDknwDOeszjyP/Y1wWlFYkoVikuskCUpEnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098542; c=relaxed/simple;
	bh=g+VRb4yRTwwhPbCi5o2N4nNzKovgla+sV32t4ygzyJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbP/aUb352W0sGwSwAnhh2JiyiRjmzb2MhP9ANjDj5nntRnGfda0M4G3fN1UDiyX/BaqPRykDDP3NfaqqTfC7oL5wmqluVaiz0X0lUad5GCmQvvBZ0U+NGWywXjLYSOvg053xCCXjYwa1P68y4Qe60SBIXidWaTri70o5cilh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J1yZ4Q1H; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d1131551eso15571239f.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098540; x=1752703340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM92HEH5zfsbI+DNlrhf/9uf+uKIrQAwzHfs3x6qnuk=;
        b=J1yZ4Q1HGHdir2/RplwokvcqUoF8sY3AMCJQ/baGoQkYZWVIbUpTnbuCbhAZ41toeR
         RlzKSSHg4lBCEw/Fe3RMw1jbd4m5cstyJVGlmQ2oWsbRrOK16YVYd/cjLllm4DMxKSP9
         WMPMxTQFsAeWLlmv7GyrpDEprW+X451AOWZLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098540; x=1752703340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kM92HEH5zfsbI+DNlrhf/9uf+uKIrQAwzHfs3x6qnuk=;
        b=FhnoHW+z9RcHS+WkD6knvdnbRtIiZsLSiYE2PSIYu4CboDzdpZP/2MYeyKxyZbm/AV
         +cGlSgEeatxGJEjhPaClUFAsqmYcBiSXq9OYCLozG7lfPLHKlT4fYjvhBmQuoba8O4n8
         d/HyJFA2Y91nm7/XqPPG8b6AprcYtiaI10o7ZQ8AkqzDHsTVuXFyhKy+KZAYe9pq0dtn
         tEp3ElkM8Gs95sg9vxO6+cEssPd/nVHFOmckS8AwMpt5CopaOraMlD6P4FAgTXfEfbwL
         ZIHNen4V/sl41zdNpsgSP/Uy5PbTc38IlfpfO1BaCUDonKfswjOHDD3FGFqjEG61lyzE
         M4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWx3ipW/7QLe0EJr1x8ew3XAxOUIvh/ls/HxdieziVJYTbqJop2Znt6dqjftVP+c1YCEycS4rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBx2+DtyNdPNi16VIw9iJ3WnRo/r7Rh4t57EE9qqD5sjLnxKs
	wV3KijAjEArk3zvlEuTkpvf8ONz880s3/ILVE6dCDGXH9P8O7oZTlIwEONnjN2W0sXk=
X-Gm-Gg: ASbGncvS40w01o9PVD4prHkvM3+vyVraXAQhZO1vXYOzLLIj07/aNZUyZ7RdCB+PfMT
	bQuUkA6hF/prRsjxNd9PX5DUcH/v7i3/i8ytCj51qdzP7hvB4ahFF+cVj8Kix9xP/I7Jzk+XDb6
	UHZXaNgwopXXh+TxQAkyHEYzrj9l9ru3GHCn5KNK0TJG5RRpE2MNes6GEzvxhyT1jm0jcy6c0fy
	+Sv3KMjOE+hsdKc/2cwFy2Wmn0epVJwt4IbpBknTIfAagcSis7So7I/WrBg6b1hqG2IjE/R/Xhd
	PO1RU6+cXDiiJmPiUiOohPN08VKBxuyyc3m/QRUVzZWK51sC8QRidSlPKDWsMCXGQDLuz5VNKg=
	=
X-Google-Smtp-Source: AGHT+IF4t0+0q5H3KEgFPgq8481bxlPOMTECM1/CqaWW3At5iyB3YCAM6l6cXFj7NdHfrSCvWvJWfw==
X-Received: by 2002:a5e:a607:0:b0:861:6f49:626 with SMTP id ca18e2360f4ac-879662c069fmr167682139f.6.1752098539767;
        Wed, 09 Jul 2025 15:02:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b0ec50sm35376173.119.2025.07.09.15.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:02:19 -0700 (PDT)
Message-ID: <3bd4df4b-24dc-4700-a7f5-4c32c486bb94@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:02:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/132] 6.6.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.97 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.97-rc1.gz
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

