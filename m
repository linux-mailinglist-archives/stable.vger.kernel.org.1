Return-Path: <stable+bounces-60477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A593429E
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944391C2160A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED41B970;
	Wed, 17 Jul 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1eTsgo3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F318641;
	Wed, 17 Jul 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245028; cv=none; b=Rs+dogV9doz4xqJ2TQPQzZarCFIj5q2qjV9/628gO4GBbfbtkDkseNsgh1lGUi3yH5i3bB4htMwUzxnSM/wfE/vAWzoO/79NuXAuofRme6c136rE0FuN0BX5Orf8SWVG1yRo2WS9LIiWXewvkYt/7xl22ornE2ca4dkPA1nvdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245028; c=relaxed/simple;
	bh=e3rWkXRyMTSDQrTdC6NBk1oiJsPf0uUS1yTXMzMot5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2QyPKX8N0basMsC5kAnzWa1A0SqO3Gw+/p81DLyg2LVGPjpWGkVMUOKtDglgs6oXe5fPt5VrUCaAXU7aCh5XClWUtCYufD9d9iXYQjc5aBM7+r52BeX8nVZXty2FvQS5Do8j2HWH/Inc2w5fpsFqz6WkQCfSLTZuZvg2ZkwNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1eTsgo3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso79392276.0;
        Wed, 17 Jul 2024 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245026; x=1721849826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKPozxotJ17He89SsoGOC73F0/fehg7fO9LqzjUI5RM=;
        b=S1eTsgo3EFzvgVE14pORpcgjoYnzrvhkaNFLrKS/1s2m97PKyOmSFO9pxN9gGD2Dcr
         k0zz0hVo6bbqi5g7Xu8Dxev8i45RTnH2WvOoYxju41siHmHz0tvyXf5YN3g/p+GEfuar
         AkpoP+9mMMu2Ei5GuKKreJb08sSnwWwBQe+xxP+X0UeftYiNXeDZY19X/DjifGU305Xw
         7ECzfEXlXnPLEUUevMfAdh8Ov+tD8E/j0tqQbC83u3e7l2B2J015OPM7RVAlG2BGJEFk
         B+8Oma3jnWZbFQN1jnfpCaaFUi1+pEcoaFB/udiVn7ga9RMJ4mftMEGlQwAYmr9bT7/W
         K8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245026; x=1721849826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKPozxotJ17He89SsoGOC73F0/fehg7fO9LqzjUI5RM=;
        b=e0vbVr+lOGx7j3LbdqOYxP3Ni0+THkY8zvpeh6MALUTETNAz8YVjcfa18rOk0UgHHC
         CVt3Jy1aDgIbgqeBOFslNXZIwB73M+tyy7faJ+9IFff1zY806m+YrkQEAIM5Ke6Awpzx
         UnHyEQqQMSHiT5UQsyxvcGwVhiSIBYg5hLA9gawuGR58uVx4dtKAENI/hKnVY4gZWsdK
         TkK/iFvyfeTS2CjPk9xwsjQWbYSL34Edvlo5rk5845p6aQRWQWaNEnyv/Lj4ieu8b3dn
         6YcXGayXaed2zS3RVbwKG4bjRo8+Zd73XV7FcoWvYe3oj3cfFKSsEkhx7hdX9dBDg4xU
         j95Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1P0gIm/MZtwz0ye5J3zrVK4W8q2ZyQwGrOqyVGuSe/vZU+LJ0yLIV6Te0kkMxtp9mybXYfZ+CQ+nJ5yz05GnDzKhZEAhMAdaeYo1oowBb4JlslstoBYL0iHQ8zg/D9CxFKsB
X-Gm-Message-State: AOJu0YzxIypxAV+X+fgmnfui1Bsuq4IPcYcW5VX/hhA106h2/RuoApCl
	NkNrJ4NtqW2cCzH2XmzV5Q0ZXCgcv7BlEi4+bIlfO18x86gziTiU
X-Google-Smtp-Source: AGHT+IHsdjhHg5mdI8hGqCe9yn7NB+DeyAiOT/bpMt8aIlkMs48uDK4BvQCahfyTZgtpL3mBN2U+Qw==
X-Received: by 2002:a05:6902:2189:b0:dff:338e:4f6 with SMTP id 3f1490d57ef6-e05ed6b9380mr3548069276.5.1721245025627;
        Wed, 17 Jul 2024 12:37:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b79c519008sm1644776d6.64.2024.07.17.12.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:37:04 -0700 (PDT)
Message-ID: <fd6f3fd1-afc3-4aa4-bb3b-c14335703dbd@gmail.com>
Date: Wed, 17 Jul 2024 12:36:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/79] 5.4.280-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063752.619384275@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063752.619384275@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.280 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.280-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


