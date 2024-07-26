Return-Path: <stable+bounces-61902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BF93D755
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D3AB233BB
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204917CA10;
	Fri, 26 Jul 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izz53G1o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581E17CA00;
	Fri, 26 Jul 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013965; cv=none; b=dcxgymk+8SvbzCG1QXZwVnb1GqpxXdrv7vC4sItK5vrVczq7tefmCA4+tkEMkkyTtBoTS/nxMxX1X+jXFaRMJ7WP7CuziJWg0M3uKn15OxyebIfKbXXG12asIyQm9CXpedNzrhQ7BHD+rcbiJzHFMZ2mfQ8Zo4rT71oPvIV4Gmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013965; c=relaxed/simple;
	bh=Paa9ZDYvS0ekF8AgxpGFY48QgAj1OkW4CidPPwf91os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiaj22yYfPVs+V6nlOAyYGiEEtd/xusyTvyAg8Y2ewx83qsSgONBBlG3z4gU5Cy0R/sGY/I60qR23u+mCgLzDj2zBfojX4h+xwI7SxcEvjaOLG5B5jNm3UTuZi2hIshqgImG+cW9HOkkrObZ8Hw52pTei2nEmNuf+YLzctm7+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izz53G1o; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fe11dedb3so4430401cf.1;
        Fri, 26 Jul 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722013963; x=1722618763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phmZkQSEuAqXCaxKHicEmYsGacKY8DubgP7bbe6kSv0=;
        b=izz53G1odTiVkCmpMxMqip2NZUtBmOTLDhpozHOBcim7vqMg4m1b7JVqcJfcWbAwL9
         6DXlWNDjQLjVvGj07/WoJKUsuY7hHor3oqLwIpj/u1xUM9I2Z59uEdyhlyePDDwdYGo6
         6wsceXJ2k3GJsOfb0jL2SY8vG2lEiy5FLzMH68FmxrcUrP9A3f3vddsIgWLi+mPTSrCg
         E2ciCLezBWaRkCI7vj9nEogDZUJF/5WRVdantybsEDmKO8tKEXfk9DQgXhyyLHiKmgQW
         YfUMpeqqsBUaexcP6jO7UU3LxOhfPhr2NQgN2ZIblVZT9YEDjVQNRUsx7W6SM9Mxx1MT
         UT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722013963; x=1722618763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phmZkQSEuAqXCaxKHicEmYsGacKY8DubgP7bbe6kSv0=;
        b=ngGy54rSiRGb+20omu4t1Fvot1xHxZ6bqfY8Et/NOXTHZRcFkgBBr0FEwqc7pw9MUy
         tHZMDaYGOetQMdoTqjwIR2mmmvnW+xJQ++7zOP5NoNgyOYiOYiClKeEB24fzT4S5A0Np
         6YYodmr0/6zp318be+sWT6nOkymNMX+CCc167Ao6ArOfeD8jIjwN+0n9KqWDrYJzc8x2
         vdlz13wMEA4eswVnNB7VKiCVOefRN1XxnMj/6HlDH6z6cCRm6v6fRWacpjUrtUResmUI
         Dzc2JTjzobqlCS/ZTYnWBNA6sAYRQGvtfItOTw+rzxuXiyHgM0sCIPsFdzM5MIyLvw56
         p6ag==
X-Forwarded-Encrypted: i=1; AJvYcCWGPonY8D5gDE+aVY44mZzz8bM3oCITPKB//qz3cvIcMSM6YkIBpqs2482KP2yZhB5MaxB8AfeHxf4z69LnM0uCQQ8rPDVJEO5R1kZbxlOL7marN6BI+VlDtQkz0+OECN3meDCd
X-Gm-Message-State: AOJu0Yytx7mqBT1uXa3F6fO/JY2T63RkmRF+zd40dhWtjPQamWsOcXDq
	nfjZwrubaDm4GaXnFZOmfQdFHIR1SGSISakXeNS9PwJ4/eHF+HgR
X-Google-Smtp-Source: AGHT+IHZHGBhL8vd4ol7h2fs10xteHuuJ/Onna0wlk01Z8AAdma1n6e9rbgdZcTZUCltHx0iOmVT2A==
X-Received: by 2002:a05:622a:345:b0:44f:ef22:8962 with SMTP id d75a77b69052e-45004f2ab0bmr5921771cf.49.1722013962832;
        Fri, 26 Jul 2024 10:12:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44fe8147958sm15087101cf.32.2024.07.26.10.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:12:41 -0700 (PDT)
Message-ID: <8ca4c2d5-0774-455e-8ffd-69fe115b99c7@gmail.com>
Date: Fri, 26 Jul 2024 10:12:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/44] 5.4.281-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240726070548.312552217@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240726070548.312552217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 00:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.281 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 28 Jul 2024 07:05:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc2.gz
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


