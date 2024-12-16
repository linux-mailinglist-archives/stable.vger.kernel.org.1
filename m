Return-Path: <stable+bounces-104381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3299F36D5
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B17A1521
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835DC20ADEC;
	Mon, 16 Dec 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSXOeHz1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BD20B1F5;
	Mon, 16 Dec 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368051; cv=none; b=JTaA93JhVQ02iVizIs0+7LiGrO5ve6WWn+1RNBanELNSvjm7XyAQloqKmAErC7/shXis3tkPiQuceC0l5UUDPBAIi2buk3ylAnPQneZExy43z2hl7SY9y/bBMnMSsEQZI7OfHI+gfNom7Gnl0jPFQvMTzr0FC90zF3ilr4fJhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368051; c=relaxed/simple;
	bh=nIV1DmxfVi+Mib3HJgbL9EDF6NiZRMmiIF6Y4RvTdSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM1wuPr8knss3uqnzT/Q3PawfR6HlHNN+9qq4YQsuy16nCFC//g2BGu2Milxuc7HwJitmPr1l+UmHNYbTDdw8BUl7atx3fznr8fZ9itYC6OCL+/zMb/88IMZgFQNXC8nh3Cm2776Rwze0VTCKkbIw+hT1vOtW9gFkVKAUsBz8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSXOeHz1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21675fd60feso45778575ad.2;
        Mon, 16 Dec 2024 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734368049; x=1734972849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8zOzjaJlDBPXxh57eb5jO2HE5yiIs3Wf3GEyJoiLUk=;
        b=hSXOeHz1CTZ+cPF43wJM5U8m7Nd+2pKmvFMYuflJEYR9msYWComNPiV8DWs9hCUF7J
         iwyJEPVQDrElOJz5W0iJljFvyR2r/qMEupryBjnPN9SPlMbZXsMUcdtk1D9fvmguqICb
         9XAoFVDS/hc1qJgFRmWbrGJS6Gr20VnE4aXBk36A6HVT7rv6O2+3z50O7ZTCtDOQ6IiV
         zeprN78oGAaYeNjy7bRcqMgThR7fhipoEPXjpmINE6sGI70dKgP9sbz4jJeF8R6kj8Cj
         DmuDtIYPmMPCmlOq2kwKl5D8lwOySqP/dhnlU1UymV2YaI808qF5euhyreRDCpYw1OND
         r/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368049; x=1734972849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8zOzjaJlDBPXxh57eb5jO2HE5yiIs3Wf3GEyJoiLUk=;
        b=iHlP2HO2EizZyYWePH1mmcnJCthDnSGJKA+igneLJ3daLQ/ZVxni1kFu1KVCb3yMT2
         21X5VocRjbMPMn+Gc3j1HesQ0oCqVhm2Y+IreskAKO3PZKsuJMOCQHd3DqtFGviEGdAj
         43os9XYvRNtinsgfRXcTeAI7dw9kt5gIXtE4QVgSlYBISxEx8QmJTuW0MCoNdXbs/Ccr
         555iHpjnmuN4vhBydY65/lmIcvNufly5UL2jFDAhtBo/X5NzcTcKgEvuCKDfBNi1Zxyq
         or06tjPxKJkZ8xH+le1WGqZ22fA8Ou2xm7Bol+3ofr/etUuDBS86ItjJ1xaF/in1pm5p
         Orog==
X-Forwarded-Encrypted: i=1; AJvYcCUmZoapCR8LVs3kvq2Wmmis1aOVU77Q6/q8Qati/Fr7Lyw2SKqKjFVqgv671qj9AFgnc4oumPSFpRihdIY=@vger.kernel.org, AJvYcCW9IIN+Zzf3eBil1xjJlgj+RuwE5AWCqWFbcWkvw2+IcyBeLDac5gwZyDhBZD+7ESa1rf/Gns0A@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxZcbVLvwtkwAeaJYzp7gf+NI8FfrJCt7e2E5sh3/jIBFyxRL
	ymTiFXlsw+4N1jKRw4fMS0r8P5mRR5g7QqRkZWQQFkKq+9n2Ij/z
X-Gm-Gg: ASbGnctedMU2ampl82UcPYyP2vfTRC/eKuuQ/JHBfyXrn8IVXt8oys+37v4ZxM0BMuF
	w4Xadv2xDizYEoT4Ky31tpvZiURIupU79kQWYkB4xjJdHNlOHLnJ73jQAzBsoIqiY0nxvfKWwba
	truOCNI0xp4t7Ky3/qJAhL21S8ROKfq0oN5ENBLLXPLFm46WveE5qMPoqHR+WD2Q8pjmjAdZz6E
	/QVHEsb8RsgVZRJRG2Dge+Doll6fvVZAzd9SZeO7lto/hoBk0z9xU6WNxia1mQDo9YpV67c9aEg
	+GuJ3FSiZBxnaHxDlxQ=
X-Google-Smtp-Source: AGHT+IE247/C7LlD0CbgkuKpBdcsqeF0GznYQjHYwP/PTRfVkmDZb65uvE2bRPtlsx9G3yCjV3q6Dg==
X-Received: by 2002:a17:902:ea08:b0:216:4169:f9d7 with SMTP id d9443c01a7336-21892997505mr201786135ad.2.1734368049121;
        Mon, 16 Dec 2024 08:54:09 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcaefesm45292665ad.58.2024.12.16.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:54:08 -0800 (PST)
Message-ID: <fadf81d6-6115-4829-90e1-858e48ed9b43@gmail.com>
Date: Mon, 16 Dec 2024 08:54:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241213145925.077514874@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2024 7:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc2.gz
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


