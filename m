Return-Path: <stable+bounces-189027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCEBFDABC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406443ADEDB
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D32D8360;
	Wed, 22 Oct 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3dbX3zn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC82D0C8B
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155040; cv=none; b=THHklc7XtuMAxnfQU9ajAjiHnDTewAJ2qOOcPdw7nx3IIZyU8368Bm/q1bJFRb+QwGvilki2Iptd4SmFwjYTziFSl1FuD3x/zxYKWh8dK5v1rEFXXTQ7iFj93GYXG+ng0USdvkmXTTw8T45QbeZjWyGpeQM9GfE5KgZiVWal8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155040; c=relaxed/simple;
	bh=7/2fJy4pxhnnXtc6OkwmeAXK6plptjeyhyTaalub3jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIC/GcDJWuz+GrVsPJx00VGACgnv6n6pVJwW+PogyWem25GIDopbtyL82sEhELlsloQt/b2y+N0o7Qhy218YtvlqVhnpxa+Qk/1MnfIivJf7E1iAKIvGD39Eu8Ce2AV/bNaGpc5LlHsU8XrKP+enIwfL3v64ncBXQihecYxWzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3dbX3zn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso5127038a12.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155038; x=1761759838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ddn45kgA5iBGs/Q0XZd+ROEGvzH3g9eY5nKIgWA7IA=;
        b=J3dbX3znb2PEZGoJFjQ+k0K4NRVykeQpcn7r30aorGtsb2PFE7JpF7u6rSK6yE/BiQ
         /VQu2oCn1GSTe0D8+wJatQNkWrY5b+pMklENbjQuO9OPfxzZqSsphkSlyr99ghenuhRD
         BAgvOyCtebwspsIUdvrNROf2N5PxLs13Ap9sGhV6SnmV6lYNkKCNk22gOxXoz7D/y5Cd
         C4+RHzEg8qZCCIc95OQxJGk/4+zybwzdrTbakzmx7VrIPVjiJAAidNqCLEAq5C4UaPUZ
         5vV0qhv51Z19sAnQApE9TCervfXQs+2LTu9/japsVB/XIhj9WneMcr4b7tXpJ1P/HB6e
         8Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155038; x=1761759838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ddn45kgA5iBGs/Q0XZd+ROEGvzH3g9eY5nKIgWA7IA=;
        b=KCTPwDfMzBbWXBAyRhTMl3XjhYaSgWZfeqK6/R0c+pq/689ilPPOTMqI2OZ2Kpk4bn
         dfpsX8JOXR+3K+THsZ/D1uSDyjEFET/y1np2PwV9pOc0EamxyH+tZ8dtXX0EuC/IHGGD
         d5wyMDVU9GxsnH6iCGV7SlXgz590+Epy7F3D5rfh6dfiFcy9flWOWWk+gYagNOORNFPZ
         Uyn4sgEchtjfTMjaJqrB7G0eFHpvnSITzmo/kPTHzXOOJ7Tg5Jvi4ZwNGFTW+w0zV7Pw
         LRcMIXMqUnjazqPAjh84GhdUAe0nM9jvPzQi2+IhBGbF9lS06KWWcc6DrorhPvbUAB9h
         /OKw==
X-Forwarded-Encrypted: i=1; AJvYcCW046ZiWeLdRNj6SaoFionkKlaFfRCLK2aVNbvdNfzum/2BfAGN3bbkt0J+4PCTcDV4y/JCE2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2c4vxQgF+Kgvn+yJVNUIduey0zh5Z48aVdGiAlzDtelyTi4Ic
	/iekwsRLsKcwjm8OUSjMKa5z5qcFkCB8r6VSvaGxPllqwfED9KDghtAS
X-Gm-Gg: ASbGnctsjcHgLLOCrrjKXThCr+T1ptm8ZZpcltpYOd086P/jZUqvsiqz3Y/igYe3rhh
	kotbLJLAis7tjVkI4a+yQ9HZQ6cyj0PtVUVhM2UU0G4Z9n9aYQjg2ldirmZAJAncVwxbpH58CK8
	NQTguvSECXdCFG4pdedwhIt/YE1QjfF6Iwb/3C+cg1SF0xzA+vfqIqrMwhzj3J1xl2Fr20HuA+3
	vrgRmNH+YTJRA+rxagQWgx32FDnWh02SC4r89k8CAVWX9124GWD3fT2bU2f+lh+aOz1CStusLit
	WskqaMa9wRSADcFjiPyuOmvqqxGr14ZSnXu4vcKTsq40dqvcTyS2MdK4FEGca0dd3LJq6eV8Bpg
	2HiB3Rq0yXQu0PYMkWm66ABOVXIzRtBToVskZ5CEe1kmC8uaoJcRB9d2qI6rU8aShvMhlGTKjOS
	44AetPcIm7Up349mIFM5ijdgwJ3XKpwc+FOn/uMA==
X-Google-Smtp-Source: AGHT+IFlcnSpDwzLFOUCCw5dfznfe42XnNXFCg/H83y/QkODNwwNkewmIPIBd13BJCZtlOmCR8rDog==
X-Received: by 2002:a17:903:18b:b0:269:96db:939 with SMTP id d9443c01a7336-290cba419d4mr292170355ad.58.1761155037894;
        Wed, 22 Oct 2025 10:43:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm145076535ad.18.2025.10.22.10.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:43:57 -0700 (PDT)
Message-ID: <90205139-d34c-4ddb-8059-e4796f040d14@gmail.com>
Date: Wed, 22 Oct 2025 10:43:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 22:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

