Return-Path: <stable+bounces-104380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D029F363B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F89A165289
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290441531C2;
	Mon, 16 Dec 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRzLZTG0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204F14E2CD;
	Mon, 16 Dec 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367167; cv=none; b=syp0IcdRzITQBBTN8wexeLKhoCE3hJ1oJ17MyuJeu31RaHsvO3aRPAGPtAGF1KgkWoo/x1TdXwqFzcGU5YTdV1B6TXHQt5+wWCORkjuPMUN7H9nQgWTxhcQWltoYhcvee2afD7IVVl3EPWo+VUeLRlu7b+GmXKWZMLi6uB5HvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367167; c=relaxed/simple;
	bh=HB97ptxfQdcGt5WW0Z8teZNUu8TvPHIb+TnixivnxBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGK6Xc6aJwSxdPlyxvh5eCyrDcQwf34Ay13Bm+HPZS3PkQtivVqPeViEpS4pzuhAzW0gWsB8qU8CwMAU9B2xTpyZ2Yh6/hHGWiS+Z2E3nrZYJYCDIbOXwwcKAoLJjm1Q0u5o9ib+dGx4DpU9ybRgB95GLdSWaFRHo/tTpF4BNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRzLZTG0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f1525565so5104200b3a.1;
        Mon, 16 Dec 2024 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367165; x=1734971965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD7aXvIEwUa7UnG265vLiK6U26rw7FaP167t0jjQInk=;
        b=nRzLZTG0RzUPx0Zy1bEq3N+5thWe1CyfnWMw933MrhyxdOovDKt1cdgIpUgxuT4nP8
         YthS32RStSl3CJG2kOJdQJ1sqUk6UD7ELwq9UtUEmtUwKVDoqXYTpp1BUyubPjf4ZJ8k
         1FTgK7zZY9gkRp9Ykd1rK/e2UC7wM/b6KHEncqo2HdSpw/dRUNMIIJac/4QVLIpVeCqi
         PijwkMpn2XOmUyQIG1LJLwm3C/4P+rbXHbsQ0KuCDToADWBAmmtyh1B7+ew/g2ieJzCI
         RA4BIPd2pn+3zEs9F5Rudbxru2Ozt/FgP+deNbWBhCL0MQM36YEPgjQhgjYpxM/vCi87
         4VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367165; x=1734971965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7aXvIEwUa7UnG265vLiK6U26rw7FaP167t0jjQInk=;
        b=W10B3Qy2fUY4hdJFCTtJaDvMwdkBEBhSHx1r67twC0FI372cA/LE9GPcpKtA2NGBPm
         0HDBw//MN+f3lv1jTpEvFnTqDL1tQXpZ+/TI+cr088VCJ6IN4+Jn6EE6CGTkso96iFfk
         ryAymRnbQKa4nMlcKatPUeRy6y6iq5IzwRX747N91BH22Q0hwGpfjXYpbs20zmm+JP5R
         hc3Omo9XA0dwUf+qQF2G4hZSfbbPgoGjH1EZ+WfjxUDVCTN33Jl2CBf33nlwDdnVcF9j
         gRjEMf6/4j8z++v5BF2MjXEik+Oi9A3HZkB+FmWwSfhDLpvk0KC10PJY1flvLefgG27j
         WU4A==
X-Forwarded-Encrypted: i=1; AJvYcCUqFk/lP58T35NuhbOPV0jv/x7GnwKYtS+gHXtgofSAyrkfWlV5pU8iRPBF+mUi1cJT6yld1c8UfSTG9Cw=@vger.kernel.org, AJvYcCVgIeNFLGcFh5P8Hwbi8Uz+eL8xABQnLAD2GOuTnzVUMQajpLRCz3tsHPYj/95dQQVyWxmofGwd@vger.kernel.org
X-Gm-Message-State: AOJu0YybBXJQ6nFG2d/qAhMk6BdhQFGgf0HQ0rlk5rkwVUepzrlVGNX+
	aBmDVBfiyqHSNCp5ABwuofYqZ5QqFuI6WLwYSJl5fiYXZDDZGo/m
X-Gm-Gg: ASbGncuHVVyWufR+pZ0opyB+u2NqG5FTwnxkXHtGsTbH/rHo+wXCw+WpVaY/hDrNt6s
	ntfpI1RSO1rJz6QSPFpvEFqytO4FX1PcWaPLcCDCalSdcFRNH2IFK2/VaKHzbElY3wyFPZt5sNT
	ADDbchXP+tcTqJDMek7aKrOPxg1/6t4RYFfnHNmvk9BI6m75SKTDKIcMKQHhO3bHPShLFWFlPkD
	QGZnv3qVBI2SGngqCLXlkuYZs387k4K6cqLm/UUsrMlARZWYP/K/MZmMVuzpf+wo2ZdsCh+atsn
	gMxQgM6TI3F0gPjTD00=
X-Google-Smtp-Source: AGHT+IEOLsWLvI0TSnoLs1Bp5A+f94y/0ymkE8Qi7bPRD4MrLFTHVzKvXSSTvhiUUo/mIuLkVPDFvw==
X-Received: by 2002:a05:6a00:e06:b0:725:df1a:275 with SMTP id d2e1a72fcca58-7290c264d7amr20359969b3a.23.1734367164714;
        Mon, 16 Dec 2024 08:39:24 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918af0ca3sm4970415b3a.81.2024.12.16.08.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:39:24 -0800 (PST)
Message-ID: <626ad436-6386-46ec-bc9b-94b7845385de@gmail.com>
Date: Mon, 16 Dec 2024 08:39:22 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241213150009.122200534@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241213150009.122200534@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2024 7:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


