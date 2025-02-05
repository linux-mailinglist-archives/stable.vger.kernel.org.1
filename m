Return-Path: <stable+bounces-113956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402FA29834
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83813A2A16
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3A1FC0ED;
	Wed,  5 Feb 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBL1H6IS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F151519AD;
	Wed,  5 Feb 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778363; cv=none; b=riSEYHZnwlcN50avAhPdfkELWSh6iZnBFDtONgAmC9aClcXt5K5oBTR4dPQ7Lu4fTk6qtNvKydZwBWaltLbIJvON5eZyBzceGdQ3KSxS6eEPMrwQxLEAbzomFTB+hU2g4h6TtnrTmzabxefgKB+vek1Oydu90MbBdiCxoKQbbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778363; c=relaxed/simple;
	bh=b9T71eCrWsGZTSKWu5AEhCrmZi7QmAti48/sGHej60M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrFMfmTwOTjjhw3Mbf74EOp/5yHUMpknfiCfFPJM4PJB1WPWjO9AbuH89YO7mnJgROV/6dBjrCXawWNIdxe5RTUH1szYFlAqEM3LKj5ckMsVB7jInUmPUXirR1cN1LWFjT9ZJUBXEarzjG7YKimtoY9DwYHGcRep1JplmMNEEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBL1H6IS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb972dd8e5so29351b6e.2;
        Wed, 05 Feb 2025 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738778361; x=1739383161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6YaHC7zHfgfmlu28QNPcdEdK07lajsTvPZTWhUl88QY=;
        b=WBL1H6ISqbc3FEg/XlnGWJTUXEqKvvoF4UDXMPrBHrvCEfzUhMxLV+DuE1r2HLCckU
         ZPL6K6sXVxAnlLXTEHDYHqL1WZJtNL0m17VQFe5nRv6uwtB9r/DylgIAcZ6O2m+gOx0c
         ooTwBqZciDFln5SuJhWEEyVR5Riqh+KocjXmKq2IRQ/Lg28uo1aM3Nz4XVbtONvw6fcq
         gQemNRXCNGd4xS3frO0+xRZAT7O/392+tdA4W3C0AuUnJCklv0kmV7guud+VahyLSoON
         zj2Pk1DvxQeplqrymp3M/irp9pW4EOgKu9Ypojv8TF6oQnYAbAdPx4ATj2W17gYtrHpD
         QUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778361; x=1739383161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YaHC7zHfgfmlu28QNPcdEdK07lajsTvPZTWhUl88QY=;
        b=fwTpuiYusWvgNJXlSLEhMLACnmJhjZqRyTtbVF4+2dnT6c0CY9ai+ZlAmwv5kWB5RG
         jdCkgkgzTldFKQH726bKvJFqqgPB4DZigjACIDFQNXvhrkF7LkLcyWLn0u0qf9uJ2vO1
         xlEjxVuk81+2PjAFTRKZK4nlkcvNtw6RjQ8gOIDiNoHRglkUjcZ3NyDyZ0bShnGyF8GM
         iZXN6jevgCkR+ptmHRPthjo08OZJhkxvxkAb3QgPJd4G7MN7fr/raaOt4y8xSjK6edYV
         lHJJ962O8pIa6Ge8HPgUD8d/jP1GKGZGiHKl4U/wsAUJPUWT4DbsWwJywxtNNHRkWDwz
         bN5g==
X-Forwarded-Encrypted: i=1; AJvYcCUeV5IXCNdGvdqPsS8QrsqqVehVO012sn7zK5ocPIeMY8EnegvUDggOkUjiT+ijLQUWjftjXJJg@vger.kernel.org, AJvYcCWP3e5VuztKQEsV77Zj/na3OV0jAAbtMK7iv201OLkXL2sqRmXGZ817jwcPEy39HdXPQd8b4sFZp9L0sDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZ1jYGHBXeLvAG8Hp9GxxITIUBwDHnOntMl2aKrADGpv5NJRY
	pMylBU6gsqJYcrv0lHh0bbQTttCaxA0zo9ml2PTO9vXYONP/QF6o
X-Gm-Gg: ASbGnctatmnH3alDfazMUeZuTTTyOxHO7hUCJgeTvU7XWpq0gSAZgyonIdmh29UIoLi
	mhdurYieyk+Wmg06yLtZf+Vt/5uE+xWCqOoWhZSJntbCTlugAJHhLep2fH8GY8T1RyIkAtt0Q6A
	Ez+tRxZTFA7Yc4H1wAt37NKaCEN7Z/lVyrCEo9sqlzpc8yvhQxlFuRii6Ka9qeBdW9QTOXTCdUf
	1wxw6YriOaWpuKdyXjbhziYZqbUMbwQO6lkz/4OsjD2rqqACBqbZbvkH43OkMTllu9eqjfGXuT0
	JN+JtJOUzzASfFRzFCrPyEEAJlM/lhCDnvFg6MbXdM4=
X-Google-Smtp-Source: AGHT+IGkpNxxBj+OWeR7r4PTJ2ETrUGVEuL26iYgX92UAJ3BeEe17n1SD9pAtFYBn93zzIXZchRg4A==
X-Received: by 2002:a05:6808:3203:b0:3e6:93f:4025 with SMTP id 5614622812f47-3f37c10ebc4mr2437502b6e.14.1738778361308;
        Wed, 05 Feb 2025 09:59:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618c8a47sm4024350a34.59.2025.02.05.09.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 09:59:20 -0800 (PST)
Message-ID: <b161c78b-8ac1-4617-bcec-0e365ee8755e@gmail.com>
Date: Wed, 5 Feb 2025 09:59:18 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134456.221272033@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 05:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 623 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Feb 2025 13:42:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

