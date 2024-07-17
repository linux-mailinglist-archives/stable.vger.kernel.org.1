Return-Path: <stable+bounces-60494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7857F9343FE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE395B22763
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C351188CB8;
	Wed, 17 Jul 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWYaN+lR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9B364CD;
	Wed, 17 Jul 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252056; cv=none; b=QkiHx3cRhGEKnTuMGq8s7Uii4Rb/99R106+SnjA/kOzTePU2srKUnz9gLeIWMpbg07dLQylDjq2PK348NV77iAimsLn78TjutKrVt47WawtdZ/nhcWgWKL/Y8MHNpZ9J04CNqtQDgnvS0n1SkyIzbuh44VUXFFju26UnpwcMce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252056; c=relaxed/simple;
	bh=gl2Q+tMjWcZ/GoedLF9UhlaZefndxux+7yo0H7gHVzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBLTk/nFIyT6C/ikCD90NJqzLVJe0Ufyy9buo+r2QCI+2mY53vhoCmfxOUtEAk6Iqm/LpQi8szskfolr3/Qh1cpjihsXIOXXpTQsHtYaMJCSJng8GFeZCWBf0DOWVLyLJ+/uvZhqFX+XRZAFFex2oExgr3EC7xtt9YTEFftVqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWYaN+lR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b79c969329so1097196d6.0;
        Wed, 17 Jul 2024 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721252050; x=1721856850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsBGb2vdt0b/FjklMsKTbmLxEuWSJkAQN2gXGcQRYII=;
        b=QWYaN+lR855Yv7Gjpa4/G5wXv/ykwiBSkjh1YZvAVYLzSLvvwA2cM3KJsOjMTZuEgv
         rkHyD7JCQe3Z9HY2QmNMBfrHHOufJcblkWvid4JsgHoOF5Gzno6UEqr2H/AFl+EherZu
         A5fSXBmKsihnw/smEqQVWUM19RXc6sAc+ckN2qxAquDyV3ZoGzn9zkfvvXZ8FtN09bRf
         KfeueGTmHJrLPKGa67xo7PtQMS+fUQhLyaJvwu4W78KezQ/bk8nECK2JDR75BFv0qtDs
         nZl9VCaw0iCf78zN64ntF/l9tCztK58vcYsYglSBj2ZaFsVLj9iDextXuZqZ+Gg9FbZC
         G/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252050; x=1721856850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsBGb2vdt0b/FjklMsKTbmLxEuWSJkAQN2gXGcQRYII=;
        b=etsYzfCEO/flGOdH+jwEdaHgvBRIEbrxZfrj2BKS2ddzBmfjJ7ClbYe31UaUi50z0F
         l41fPAkBINrUEo1J2p8O5Kjc3i2w+pbr+pkLcPPZO1Q66oOCqbArFsc0yOXK/WaZL1Op
         7l08jRyoZLziw1YbyuGmPeKNGM5gFw6rP7tEkwzfgweUp2GfzwXkeRr2cfNwjjGrsty/
         Y4Sxa+QvM3pzZtqLvW2oWSNlWKEz9+1k+YF9fao1Bmcp/uvkC+kBOo2MTQRe8OOGeM2T
         7vPhglU99NwYPKxFMznaDZyPS3jesrG87GmN3/r4bLChNrynD6ZGjRkwTwLMrTLAaCsT
         jBCA==
X-Forwarded-Encrypted: i=1; AJvYcCX6YQkyuGYxOcRq5cxunjqW7Z+w9XFeyuHzgrAewk7HLlWCdfNazFFDpu5PiXXAmLIiMAxNiQ3YrJTzxpX44AWerJPgU3P2UppgaT+loFpkMKYMHQe8FVaZ/EIpRhU+1d3WcvLp
X-Gm-Message-State: AOJu0YzJPJcSWn4SO813ogJegCaOok9cDcet1kUeWCDPCSD3B6z4Nk0N
	IZnM0iZ7OPiFGwveXl5gsJDc70s3EHW9sKYon6BwY4n/ON056PJj
X-Google-Smtp-Source: AGHT+IGeBFbyrv2x408blAU2xaOFM1dKbO03qWpVIzeUtT3O2btNETS9AdxJX3RlUwGcB9sIx9IcDA==
X-Received: by 2002:ad4:5ece:0:b0:6b5:dcda:badf with SMTP id 6a1803df08f44-6b78e200381mr35274676d6.42.1721252049851;
        Wed, 17 Jul 2024 14:34:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b79c4d18f1sm2506186d6.19.2024.07.17.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:34:08 -0700 (PDT)
Message-ID: <08082dd5-8f91-4b8c-ac6d-9e8032bdc3a0@gmail.com>
Date: Wed, 17 Jul 2024 14:34:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063802.663310305@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc2.gz
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


