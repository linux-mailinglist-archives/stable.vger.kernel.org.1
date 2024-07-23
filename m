Return-Path: <stable+bounces-61215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC793A861
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 22:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA62B2272E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E3143C42;
	Tue, 23 Jul 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGsU+vTg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835013D898;
	Tue, 23 Jul 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768165; cv=none; b=fzT1R0Nz4nHXhVj1wUmHxb7gNGC/hpDtN6a0+aBKObyrs+4f4PeapfhIFjbz3Hm2wCx9JN5HcgFEJLfPT/JAmR1cDNjWhQ04XLbp1FYQdJymRfWO7Jezm6fdjfDqTOsjjL9Iyys6IvF/FDDi9zLlZ7OO9KEIugLtNPRS69AwqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768165; c=relaxed/simple;
	bh=CKE12PG2ujHkA7bFJm+/JoYiWMicVup224YXZcCr7xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBXJVytYtUQaWvSNAF5eK751eIF+bzwSjaQNV2Ry06s2YxTuA6jyl5ISDMJlHoH4Doxi32cJSulYKo78hkcbaTrD9pJPdYPiIwqTZm5fxffpnB2awRH8mcktzGjv3mXyv6v4jf7buQSNit/bDNAazyGk9ouA054jWEzKvIt6t1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGsU+vTg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d150e8153so185643b3a.0;
        Tue, 23 Jul 2024 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721768163; x=1722372963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NCzGXrh8n06olyrAiz8650mTJFyCIMqyVh9qyVnxko=;
        b=kGsU+vTgLMhlPZ1vAamLqdusElQ+SfRQO+tLGirheg+g7OUdhpXUWTYqYdEpkHOkPM
         PIW4821tVr3g1iLZn6U5Lxconh3oPgFXctMXIPzLOs28/rs1wuOnQl7dPtJcq21g0qIo
         DVMbZ4Dbn3WwHnJarRgMOIoT6iRneyARHSj6px34ydZQjJyJYt7yIy1/zqllwgh2nVGF
         t72wqIv5gEPNeUT4YymIEx3mt6YuwmOSUdc1sx27gEvx70F+wA0l/fPcJHZhIIXCPiF3
         r9hPUT9iR0SCfl5zury+O/5wclcX3NnqfV+7z85Pp6521jvID2Gsj4Xw6ThOkKVYbtT3
         8upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768163; x=1722372963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NCzGXrh8n06olyrAiz8650mTJFyCIMqyVh9qyVnxko=;
        b=b4kEyHbIu1VGaPhmghjQmW/fi0dwMJvFK9r1id9R6uli880P+SVuEUxQ58ouvyss0U
         2gVcjSiJb4PTg7p0b4bJ9mWbWrzHSWqh70xITL7aCzSe3ICzWMEgFas64AbaJhn4ssLI
         SmWUUBeM74aJR+WmlOI4rVQj4KVKZJ6jVBme2w59V/Ui6NApFtSwhZtlECIVYI9mQUBs
         4ckGBIOA0uxlTUI+DHXgA73Zm5IgVSiSnvGk+6w0EQ58z8MzQAM4S/9ZhThWGoqM0xTV
         eZcWRwifxtJCpyuGEBmN183qQ4JLhSvuV+BRrEB7rYpbmkmVlEFypIHMRL6KH+rNQgoE
         i4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVplKDnlQ3xFoNJKtQJVSvtL5/Je1ojX7K4wLRaRFi/4Xa3yfc9rUjMrb9ofEHLJ409U9b8VXbHGR6SGseWXScksFrKsP9dDAVwKbBCmnDQHrxDdnrMkiVHVCkV8eNqRcnOsekE
X-Gm-Message-State: AOJu0YzUlZSlkO5rLgsv5l2CM7QxBObSXPvRx1KfMRg3O79DDW/YU//q
	hbTnCHzBlpoWvyPPzPan2HLL9fH5s3kBR6LsofEuDE6iHB4Yb5IS
X-Google-Smtp-Source: AGHT+IHw052qz8tLBs9sqFgmZdY9aGOzii0HRaNMhW+3QI4mY25KD/LlPT6D5yZQEPRA1UZnF2hBnQ==
X-Received: by 2002:a05:6a00:814:b0:70d:2ab5:8677 with SMTP id d2e1a72fcca58-70e8089965bmr5792409b3a.10.1721768163053;
        Tue, 23 Jul 2024 13:56:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff4b5cbfsm7355555b3a.73.2024.07.23.13.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 13:56:02 -0700 (PDT)
Message-ID: <a9704dc9-f461-4e13-a06f-345b9b05ad3b@gmail.com>
Date: Tue, 23 Jul 2024 13:55:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180404.759900207@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.42-rc1.gz
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


