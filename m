Return-Path: <stable+bounces-61218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5993A981
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 00:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775C31C226F3
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62D14900E;
	Tue, 23 Jul 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1w0Cg3Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62252149003;
	Tue, 23 Jul 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775270; cv=none; b=snfdZr8QUPJP8ib5VD4HlnMuOxM6yHI5rpMQxbjPAir67VPLaBFa4ubjFLsu/a/I+dvBQHcjnrueNOZzEExJtXjRB1rLrpcm4I1+SWRGvuUoo8ExkF2D0Jy9L0yVEL+6CqfWPpugrr1/ofF5b7UNmw1Ha/Mzjv/uzTc/D2dUYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775270; c=relaxed/simple;
	bh=1AjLTDbuhyesuT1YeSuYmfbEfq7w+4c503zcZIhhfTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qscnz2R+urGyMITRwglhdM4hYzJY7OunRkxPV36VdtCecf2hSb6MjHQ+FE2udOho0u1/3ga9i/1ghlmfPGZsl2enorqSWpaO5KeBygwVycg4a9XPBsFZMW/mf+vU7LeHpbF90XFa/Ejb2RuhLiTxjiZ++pSK/05+RBGFBrYov/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1w0Cg3Y; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b79c27dd01so34065886d6.3;
        Tue, 23 Jul 2024 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721775268; x=1722380068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWMntoosXb0dgJn0gpXmbDSjr5NrrVKbXCip5YcXW2c=;
        b=K1w0Cg3Y8tKaVBIopHZEkg/eVW7l+ahFKweQRhLR/MxkOO5F82QGFUvI4B2e28ca3O
         VMbAreWaFuwtLAxXHr+8S+2ZVXYA5P4O+KRjAMS7ktyBbpV2qxEMddkGIlwZcYke7FHV
         txHAoh2JNGhC1GHj542meAN4TEkn0hgzmeCOmfkMHL/YKjAkiVj9+aQSPeNnvYpZAuk6
         eW2jWw7dHxlvtZbswrF5LqJFmEmOkWYhJPWKK0/lqcjALeyXlsmMyA4n9Xoc69O/07jN
         t/i1Zep/IVTmMncYGHX9TNngA2CssUTbiy90qatyYS0L7JSe9XIOObMY6Riiq1E09oDu
         SbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721775268; x=1722380068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWMntoosXb0dgJn0gpXmbDSjr5NrrVKbXCip5YcXW2c=;
        b=weE+sAKs7693MitGtP6s+vEPsOAe5V0aLvaggA/obH3eVKtflnXaKvX+T9WO8eL597
         L9cU7gxG23tvDLyKvluCjOLS3GH5/LYrLRvwQAKjbHGzmWdlm9HSU/Jd9oowyfpVFKq7
         oAroWpFNTvk++Gh7F4qFCUUwraeCOThjom4M1Unh7+bWKaBDUsGYl+IEZmc0mHWyPyqP
         2dFgQSpKTqH05c0b9kec/L2DiQUd/r3fn/kqXEZp0Qg8ZsJY9Q2QvtS2os3YACVuIJlt
         YkCNb3r59KHzK5C0BF40O7z4KPn9fbq7BtAGECuLbjhSdwKCWLy4+oTpliGSTjRIebi/
         aQNg==
X-Forwarded-Encrypted: i=1; AJvYcCUsnPZV7AT6HpolNBwTsEQDhgEx2ipakVzKiHk+wmEWpd+Q9PUqohptyMGoMgSwOOkkQrxSJ380N90Yr2s+JBuiUGYnguol9H309nzajuhJORDp6uY30mMCe5trhbIIyXC9fHT/
X-Gm-Message-State: AOJu0YwBKaammAkHuOWYkSERGDHUCAX7PD4YBHW9fdp58jtk6a0Q0BkQ
	4LF69QQxIrTp0dz5m/iEf09JUcFIpq2ks2QCi9/wmqeKdHsKplXZ
X-Google-Smtp-Source: AGHT+IFiIruTHHXZAK76VBbvCdeRelJiq4cHOVQDT+BXtQr4+VOSTzm+Xj/KJddY40pYXnK5MCIOFQ==
X-Received: by 2002:a05:6214:76b:b0:6b9:611f:eb32 with SMTP id 6a1803df08f44-6b98ed48304mr11465216d6.34.1721775268192;
        Tue, 23 Jul 2024 15:54:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b96e8bf456sm30388576d6.56.2024.07.23.15.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 15:54:27 -0700 (PDT)
Message-ID: <cd7b0b38-af8e-42f2-be5c-c57fd8e3937e@gmail.com>
Date: Tue, 23 Jul 2024 15:54:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723122838.406690588@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 12:28:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.1-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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


