Return-Path: <stable+bounces-151862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432DAD0E3D
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54D87A54E0
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168341B4248;
	Sat,  7 Jun 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0iVhEwt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D8E55B;
	Sat,  7 Jun 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311392; cv=none; b=Y6OQEraXTmp0zi6wO0C9rDboaT1GvWvHjF2fonudV33wB/0cE9H9pBM7QwUqKySTZ/gUIjQooFr/jRa9G6ZeGiyxTHc4HMi7wK32madoLV4C3UlyLMFatdmGhHsz1KLtIqPdaZ8Um5xhozjMDm8kIIOKW7DpFJkLyafflfA4J00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311392; c=relaxed/simple;
	bh=/BAYsyNfYpaVs6kmEGWuiXyXtOyeM7TVepBEsnBRSFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/1ofz9zZrz04fY3Tmy2gCuJxgNUomPUEGub6Xo6aA0gyWmaMVKqlDnUYm0bzTOZGv97bBXZA2n1AJz8WZtLoJ5jSZnx/0hci/tgfCk2tuohKkFjd+xfV49lTz4wpe9oHu4XglNFSevyVeY3RoiCCN8L6hpjpKwY76hJ70XTI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0iVhEwt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e1d4cba0so24421435ad.2;
        Sat, 07 Jun 2025 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749311391; x=1749916191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=USms30rF3GOiqBHIV22MOlGUoxYwttSRPtn3OPNJ7hI=;
        b=e0iVhEwtGc0x6CGuvrVGDqhlgveFfSq3SlFx/1OxxmOx4vGU2JvMuEITnYyykTwDj+
         X66FnDkuhxab9HFksvFFNVSzBi8Zj/evBw0t8Y01K6Q7iRGKyQ4AJQW4Kk+7l2WUZRJ8
         0r6iiBG8oFt6/beTiH0oB13KHoOkzJeM1SIaR//xXHbVvX51MZ/EqWEqlCOa103F3i75
         RywwKy42iNQ2uflhgjjDwlASjSRkknArFQg8xf7xsvDqcl/UBsd4A/sovv+5XTPQ2zPx
         36Bj/okx1gtMchxIdEzAZGwCWVBQ2jy4cMsoijgBO/ozuDfq/4hMU1dmiHl/1l4joHDf
         vxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749311391; x=1749916191;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USms30rF3GOiqBHIV22MOlGUoxYwttSRPtn3OPNJ7hI=;
        b=TwWb9YtqzWR2yCDxF31IinQtX4LMEODgFvO3CSa9GTMQ2V2v20iqnWYGgkSlElxprc
         oSVeI75DfBoDFLPBeSnfXYhA2EYXgVBbjO0daqTeQBkiwRGQSu0PEkoNjaKeXB/9ULT7
         iP7xwG5SbEuwDH4WE5EgD1H0QRdjUxbfXJsqLdAcXZFgNopZoZf6OlvCg4IlDZvR1t3u
         g5lmWYnaG1p0AExzPvBj8Aeed213XHGmsssjTUPf2P+ryP/BaMm6J4vl5+qshFT5g2iR
         lOgC9DDfuZLO17dFdebFpbtwlsymg8zaMWPzAOVw81z07Tq4565c9RSd5EqrBg/Ffm/k
         qNCg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Vcb6fWO2t3MNqfbDw1/iSUwMzU76j+phuXizYKl2iRv+6riypzQyBKUJ9c29NdjVFqwpq7OKYLWDEF0=@vger.kernel.org, AJvYcCXEguUMsGn1Ane0niNsuLmYoPhcWEKBEMw1Zmyk4DWC2WzGXO1Lb5xGp5ipSa8YtsIAdg+cv/BF@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDh159gM1i79hGr8RNNON4CldY63FLJcbceKgwncyBreVgpWj
	qlIJceyA4HWb9YioiYFBjyPM9IWwk7ir19vE3F0yT0i6Fhn10C/cC/D1
X-Gm-Gg: ASbGncvZIk+f8XRmbDLPh6e6z/0++EGK3jFxKmbIlU6T2vtmmqJqgb2qdRmuzRO3CZZ
	mj3mVvKfFrZ6FlTJt6p2FRYCLfJDT8EAFRsygxNJHStPeAj0wUcCyB4bjqaI+wN7ZlRcBWDEHN3
	Y4C4s5zYCDazW9OFqrp5BBD/mqJrQ5kC/o1Bm+nCr/Yi3LIneXEIKH6O/Yi9i9TbzKkcBiaLxM1
	4WYjHAmr30e0Re4ly5taqjAOVUBzwHQYMxzbZ9KI386J+/+19DNUwa2B+mSXp3W5yispQ7Def4d
	zs+wsVp7aNyIhmAhx80/ynwVHo2nqySoxPX8xn10D98MtPme6coBRzYKtPnQ5EEpNvjsgWoKwmc
	Q4hLZQbFUrSwCiTQ6zfwHA00R7m2g
X-Google-Smtp-Source: AGHT+IFgsRgJWLg6bLMWGKIaLx00ZFwsRcXx8E7LX0oVeDWIgI37fMddiuU2iF8kOF9Dzp10RomvnA==
X-Received: by 2002:a17:902:ea04:b0:234:f4da:7eeb with SMTP id d9443c01a7336-23601cf42a7mr97218495ad.7.1749311390623;
        Sat, 07 Jun 2025 08:49:50 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d7bsm28469115ad.2.2025.06.07.08.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 08:49:49 -0700 (PDT)
Message-ID: <88e961ef-7ebb-4f94-8eeb-2344c0b8601d@gmail.com>
Date: Sat, 7 Jun 2025 08:49:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.910797456@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2025 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


