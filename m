Return-Path: <stable+bounces-161343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A601AFD6BC
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232934A7967
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8392E5415;
	Tue,  8 Jul 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu9WIAKg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318C21CC74;
	Tue,  8 Jul 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001013; cv=none; b=mZLXVKOibtgyaxZ6u4EUloT3NsHeHKuwU5aHmtTNG3TdYspC89G4s/SLygIBNVAsO8dSbuuCpQseKHgwOCbsX4j8Nje8aX6O4TrnBPvvkPacZ9qr8WbYHAu2Y8WkDfUiDGEPyqdxt6FGgx/Q3j16ux5Ewa/y1hat1QTFXuJ1pMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001013; c=relaxed/simple;
	bh=+RR63u8LOhfwsUaOFs86tls6qDuvK04AjP+ESZntZSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNIvgHw3vO6VE+l70N6zk8W4GTFOPivVlpek37qg/2G/WuWZMXambYap1BKU6qHi5YBhKO8JKCWZZ9zkgxM3EZRSe0cYSD8tjPpaeS2gKeNihdvKHKftSQSm8Lu7Cc7t2IEjZW3twjdQHr4vmcEWxGERL9r1MLW0n/8JmCaKihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu9WIAKg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23649faf69fso42493375ad.0;
        Tue, 08 Jul 2025 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752001011; x=1752605811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BlikTIRDCOdj/5pvDnwYZdM0zouTWd/o3USm77KPQ2s=;
        b=lu9WIAKg6PLPxm2NJXRFT45mkLa+SFSHIE3+bGJfVWBbapQCUFiw9qLXUZgPE4zLnj
         Oq2WdUDxaR0A1mfjOpMIARub2Q0dYjUJommeiCQ/u746oXJuAbw7qoqJ02HdTaF+L327
         fbiVqO42aPqGQgpmQ65ktWzOt3jC6QifNNIed+dajinGa4R8N9dtkKMUoZ73fuMl0MyB
         UdeH5JkbNuMks+dwbdxK5Oqw6+Y0hw+/VQ2UjOIfE2AqrTRgnarDfoqlA8YpB18a8vGT
         InH3ZfU5tY5F6VjK/shTYyMnjWMdXPBR5wq9udfF00D8An9G+swW+K+PMBYWFqqzodgJ
         VbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001011; x=1752605811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlikTIRDCOdj/5pvDnwYZdM0zouTWd/o3USm77KPQ2s=;
        b=cSAqRQvOF8Y2cd9YBmH+A29PgS0+kh7TEPA4rVjtwSRpnbuPh/wHxsiZVHWVq5OQRO
         pJo4ePIbrmKfXCDdT/VnyLghMe64R1nntWo5So1bz493XsfqsVsKGMGl0SFSpFTWYaEt
         vExukYxeBffSkBXAKZNtqV3XuMn+EhCXO3PiiMITljKjt/ts9wwZPhPBT8K/3Bq5JXRZ
         8hzP/6HuqxGVA8FJezeebHEca7We0iz/05QDF4GvRIySAgPMAOjqRR25yD7RKOfDbOQo
         q/NVcP86hJuSegx8nC21GsHJsFmaGK5Ldt6n2UQqXybZ2pnzebX5tyI1MpClqy1SFkvV
         ieSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTv7PjUFLHzfno7EMIr0JC69BQc8aw+6ali2woV0R8VQmx+jcR6JW3P3vdlQwi2HZnOEWfKGlN@vger.kernel.org, AJvYcCWe0hpCeJfpjyK5Q7mlJzXpO15YuyEss6raprPAkXBRefmwNU/0MeDKRe81g4VuAh5zVirz8iNiyOMur7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0E0F4zuoXuLAxXKQZ+v2p4XNFtkOMIjjGY1I8x8xou/7FR4oa
	rY0kRUxNPj/UD769rXh7lBySyAm/vw6CeXJkapSHDMscU1ar45KSO78H
X-Gm-Gg: ASbGncssZjhjUhHHd6mu0ZfNg1i4pNjcjngyhukf+vOMJ2gGb1+l12pUFHIeqvgmIxK
	qniaIYGkZMw4UGko7mPtJdEKwyLN1LWlsrnC2ysSNJTSzQ1PCxJRqzrfHwrKkPyBNAp2z2TwtLB
	V1odl8Q7aWP++ZUxD3iw60CKKOPhSm3N+Mumq/Qgv5TMc1G+TOhz8LEVI5Ss9F5gXiXbe/QJqJu
	CzRGvcM031Ajatwv2A6v3v84n5CSVRLzTKjJkFXx2hX5TeMjYe4j5AzNoIBZ5s0qvO5V0xPdNFC
	WUSfmZWNG7gRaGu8Jl7qnRnq4MkA82B0zjn1jOj2l5KpsbZ5koRxklaeGDp5UGccjKXP7eXqijX
	UfHr43Q==
X-Google-Smtp-Source: AGHT+IHsB9hv20/vZjLR45OOhCSsAWmW1PQ6XMP6kbr9FsmnbiDqMwH4+kTNHJxFjD54qg03o0MKuA==
X-Received: by 2002:a17:903:3c4c:b0:236:9d66:ff24 with SMTP id d9443c01a7336-23c874661aamr242035135ad.8.1752001011131;
        Tue, 08 Jul 2025 11:56:51 -0700 (PDT)
Received: from [10.230.3.249] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84592ef4sm124991965ad.191.2025.07.08.11.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:56:50 -0700 (PDT)
Message-ID: <ffa5990d-6ff7-400c-a6f6-43edfc957381@gmail.com>
Date: Tue, 8 Jul 2025 11:56:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/149] 5.15.187-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708183250.808640526@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250708183250.808640526@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 11:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 18:32:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


