Return-Path: <stable+bounces-126962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A9BA75093
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3611895081
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D01E1A3D;
	Fri, 28 Mar 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdo2Kwdx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2E1E0B66;
	Fri, 28 Mar 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188144; cv=none; b=FKQ25XijmDHcC4De2NGL2s8EMEXhXoyjBDqgeBu3rwV4c0cBlwZvbeUglLqIPkSIkFibaXQ72upkBMKjg2DsMmZ8YxWU/SYGaDqAPmraegf4l2mYDoIcG/q38KVUZcbv4VnHpo1WN+A1koNLig6SN1b2TNBwi6HNReP9f1qRISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188144; c=relaxed/simple;
	bh=xK40CKXqoutN+Ul2oX1Csofy6qi0LZ+rD5/qYppxCe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPK294kzmMkwOD4/V8f2Atnl7WJ/Rg9pzLE3g94AZ9xB2T/dxEY0m93yfsdrqZ2Upk9qbwlDcprZequ23VhQ4y3gJ5+G4LQKGY1KThvgimeJArTEHO4slTwK7uwEkWqR2s7iTOwWMpFcK/iSngOio2HVJ+igT+Ju6htr7A6wVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdo2Kwdx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-727388e8f6cso1594910a34.0;
        Fri, 28 Mar 2025 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743188142; x=1743792942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYN9OZs/WadRSCbRfAworAJi/YfdgYnh3ZtveZTpJi4=;
        b=bdo2KwdxNkTBYLPnKEZU4uFziU12jRfKN9l44f7+BU+lvRqpzzihJd55Q0R2PjhC+h
         dxHnTK7SZiws0QTaOgFF6LnXdCY7i24A6/VOexczHAqLF1wEkaIbH/9C+RjobnL6xS7z
         QJCa414TXM6UbeZ1StPSDNeVGzY7vdKq0Wo6T1E//1NAqjHSYCMdA0S3D1Ji6nEoi0Ql
         JbUY9PrHO1JyS0GkIPcpBXfZu3euIA/AvUfThC4T6yI0nOnP5zysRsVgf810d5PM4H10
         4r1sY2jlr5XYEcu7iBxeYcB5swoCfoIWHjCAsRDXh1nIX6i3KU+iE03m9z2DK14CoyYp
         ONZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743188142; x=1743792942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYN9OZs/WadRSCbRfAworAJi/YfdgYnh3ZtveZTpJi4=;
        b=tJ8HrVjknWsMFfubYAkWXzQx5+ijjQY6OyZjnQxKDz5aD1qB85cPv2oUixfboncGC4
         oyHtQJU0FG3vpqb1+z5fMkgTtaf6o04ifOqMLDqzqkljRhtnYuNHiTacZwL+kI1r/nQy
         +8E6Q7vFUtp/xhtUt/v//C006GAVDVlkNoxW9d/WP6hsbb6690bTHjC3T18RgZ+YemHU
         qcGP4dcec3o0mtfK8bSlfVnvQT1TgFPlRVMgjcr75+IyNg0fRYpzfwHxQoyzDVYVdabv
         sLRNoEdq3+Tj30MOl/Kv4FKXzVgfy34IeitSagI4IUDEGO1OYDSlNk0VWNDhO61mSrHX
         vpKg==
X-Forwarded-Encrypted: i=1; AJvYcCU/SP72MTk+3QgZeMGuowJz2x8cR/3W6ga1vrpAagbxq9Em0mZP4mZobs5f7NUK5eATeEiZUAWkLYPBmLk=@vger.kernel.org, AJvYcCX09OXG4Say0l8v8dFRPWx+8CZMHTO7Mhw7VlV9nJj26iIlAtXrHApiIH5wsy6APHNLtU4Z9krG@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+8hxpZAPfMwtnjfMgTnIPiqRjcVSYb8rwBBumuIJox9baG7T
	QacQdUOTw6DpNUastIxVjR1eNN3GF1q0e9QPzVBL/0L4ijVtH4So
X-Gm-Gg: ASbGncsZh2rKZMOjHjn0YNmLgpwdsvrTW1W4gvWVWSIGkUnQIXpA6zj6gZUNHviONL1
	6s1RqoqsCSrEAM6XSCYHJTN+qg1IKH/29OBU2eC9hpXnAUQrzpMFYl50hzionm2IAVfUnLWRcSy
	MdWI70moi9J7FM0pqZ8B62zsabuo8x6+MPdumn0SSWx7RllXXUhN/QIiwQOSYezsfu7dIV/VopL
	/ehc42r5A/p+IrJhaR/UJ62otuAVzVCuxbNPHRL3FBJozpthbp193/t4noFTSyX+a4fg5d7mg/v
	eHPy/8yyl9bqXRIwPe8vps4lqDsoo6afrVYNhVFG1A4BGkMzaIKkgq2tP0cpAWcWPLt4h3O5
X-Google-Smtp-Source: AGHT+IFOwYy+F90YrKnwGg9/FiWrItI1J6HIr59HKtgHNE/idYZiWqYCONNFPbwbxvM1t1mNCuvDuA==
X-Received: by 2002:a05:6830:4195:b0:72b:7e3c:7284 with SMTP id 46e09a7af769-72c6381740cmr334173a34.18.1743188141825;
        Fri, 28 Mar 2025 11:55:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c580cc609sm459862a34.29.2025.03.28.11.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 11:55:41 -0700 (PDT)
Message-ID: <6001a417-6439-4e4d-8abb-2c90309f35e0@gmail.com>
Date: Fri, 28 Mar 2025 11:55:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/75] 6.6.85-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250328145011.672606157@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250328145011.672606157@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/25 07:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Mar 2025 14:49:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

