Return-Path: <stable+bounces-202737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4ECC5391
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 22:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF285305B904
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4FA33D6DF;
	Tue, 16 Dec 2025 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWFDJoFd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10F31AF1E
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920900; cv=none; b=IX7VCZA9I2Muamoo15vcrjdUxM6sKqtTqNKfZFJQlwqxD00q1TXIRhxTNmFe9xNrxhQzYNMT4x6nVjL7x5Kg0Wz7eIarnmWwMkpO5NZFfjvwppGxnK33WTMCjbAhct/W4VABVFXyWa5JkjahuBmyMCpogSiHz+3oz9zP7noPulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920900; c=relaxed/simple;
	bh=q7E9hkX0pCOvDlEdHDkmL32xzrZFQmSe0NB8Q2GY8i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhWvwPUhYz4YfPHLZYXo07U9NKkZwFZSCN5e5DAdIVH3WzMb7Go722X3sKP2WARXNgA/YiyrDW9bslayEbbZK7LcplJii0eu22O9s7/d/Pz2+c1TtHxftrLyKK6pJeO6+jq3JA9WkFsX81wqHtnki4SXRv7p+pPUKBCZcWMOS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWFDJoFd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a26ce6619so38262966d6.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920881; x=1766525681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1iIRZq+upiNqQgm+paIoFiCtt257xmNJ+NMW/SquYE=;
        b=RWFDJoFdPCl/ClnsXlFPMxBhNmogWVOWFDPUtUr7FpKf4Bu7wS5WwYxWA4wpk41ekF
         uzyJ/vIC5H6MDIK0pSeECXlHx9ROs2EbkFgGyRsJ5UdvMtoN06J+sF279DciSXRvpv3d
         v5ZGwAsQAEb96wc0o0ySrn8XIOKgUkj4MH0Bk6FCmL8KpEKtWxPLh3+EsmyA8IOK9Uf+
         /oOqPAPPb1oHAq+wLWGDTByV4jooQZXiNzoLlhJg8zZn2Q+975ZBE/uY1WSIBm/pfVA1
         jIjdMBxVkCbcGGcgJjnS+IKAuVWf0txKogodJ4YWYgEtziwn0F7TU5JbKhq65shm6klv
         n4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920881; x=1766525681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1iIRZq+upiNqQgm+paIoFiCtt257xmNJ+NMW/SquYE=;
        b=GF3krHZ2i4tf/+9TPMjl2f6mcS8Xo+CV8e29yJigFFd+mouqXn+aCi4zBSVQWcaEnI
         eHo/Tt7dBvy6FsO+Y7g8yf/wRHi61GZ5hY5yo8SaiYUMC2h/l7+J8jOj1269uOEuuFPC
         TYjROs79WUqqNWzcZmP3t9Yl8Y17ROKXNvaEG8P8I7rWYpu70sISY25A+XWXBBFRyft5
         XfZlXxK0fDYPIk3EA0pBFhtvPoqzlYmCrV59WLG/jVeMdPMAkMT1f/t9tUFM8hONp1Hx
         uXFaEJKqWpeJzCoZ11imjOSxrL+b2dZ/cnn8ysDKbMGym/LpR/wwDB9oPFBoW9TdPHZB
         js2w==
X-Forwarded-Encrypted: i=1; AJvYcCVC8kBQUT/S+LOhFLEz2tOwlAE4zk8OhY6j0+3g3OF2MWTrKqrGa7RxUvbwQW9ToBgIUQiLbV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHz2laK4o52IG/zH7oZdpp8NilZKpX0FAPF3XpwnmYMk2YtRnZ
	C2vpr36oKOHZiBgtL9cEHB7v92xyW0xt2nOUYMIuPLraXyGwVIzaIwz9
X-Gm-Gg: AY/fxX4uX6qOMAS+XPFn9SFucho30cQorVagC/69sVbkXURZNZqGDD7EhLnG+jwTxGe
	CJfK8iIcL+ZTFlTbJq/gcHuVDlAeYfCb/fYtIE36ZMWuQtsRNdSyx0peb65ntkvYuZDVcHaFq7i
	1+/mefsUtJ9jt1k02tnjoCyWsj5QNr0xxNYMrS1iION3OhEGzzP2XX2Y9qh5Ka2kIP0pWqkUrbm
	ltx2rEkkBz6jtyXxMotZ6BI3wIlWGaMzjQlWC2FnbEGuxgzzoBW8rIi4vZIiKf38DC9Jv8v31oU
	H+xJ0JXMxZQkRnJCoOWqYVrKuq48rZ97CfwXpp4Dfe8Ub3MZ+ELxlTlv/k2ecn44T+4HFkpOnun
	bF39TKg4J3SpmMNGnSIUhE6KQS4MLw+VEo/p6Ue96IMRDUG+rR/yNSWbsN7MFtT5SpG7Mx0yqWo
	tap9JJCeH+0jWMBwTOmyeSsN6IC0L3oV1+Id40/g==
X-Google-Smtp-Source: AGHT+IEnVctkK/5qXb4LERvLEpNDkc1Az/Qnh/Iupgq+brP0HMKZ8ypeugbYEC1cjCmcZG9Puwm+2w==
X-Received: by 2002:a05:6214:1311:b0:7e9:2697:dc63 with SMTP id 6a1803df08f44-8887e15ab17mr251027136d6.48.1765920881257;
        Tue, 16 Dec 2025 13:34:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b597f7sm84031066d6.14.2025.12.16.13.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:34:40 -0800 (PST)
Message-ID: <87182669-6ae3-491d-8d65-40d8baf02683@gmail.com>
Date: Tue, 16 Dec 2025 13:34:37 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251216111320.896758933@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 03:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.63 release.
> There are 354 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.63-rc1.gz
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

