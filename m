Return-Path: <stable+bounces-163193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52AB07D40
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3ACB5852DD
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1129B20E;
	Wed, 16 Jul 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOo1MXzb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212E29B20A;
	Wed, 16 Jul 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692267; cv=none; b=I4XfUssTtHfFDZBa1Gs6o+P9fsz3DJKrLQz/ExS+RdO5pJWg2VpBPybfbk808w60dAnb887BjCApYiR9OzNF0Lo5tVFNTirSe30miFLTeLvzCwdM9Pzp7nvtSANxNTMorx7fso6+QbOldbapy9H0JNW4Z5tkBRPFwXgA4Va8YSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692267; c=relaxed/simple;
	bh=2VQaiE2f4fpyS1+Nvhu3ATDxCZ8+tmewullTfLLoYms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYbKLRfHElPb+EbBNt0TNB/3PqTlxo6k+lTV22jQuyrcnC5b3Ursb8h8ngCWtikM5IpYWVwywi1nyk36qPx0KiKUnFrdPpPV9cvawbguSt9VCLO34HtA8PLSBLaT4PTJB18ZcKevBI24QXRpSUbs8YCpWn/RrxATlsD+IkpqKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOo1MXzb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so2025341cf.1;
        Wed, 16 Jul 2025 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752692264; x=1753297064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlc8B6S4byi7qqYIr9GjvMiwX+XsyRJI63r/10AmDZs=;
        b=kOo1MXzbkO3IyccA84IjrleAnjP3SV71myMvlCUcUm+h9kicnvikytfPxh7V/rFkno
         R8vzFg5IMKxRNk+8oJEKUdZQA3a4t5807AehofGHAQ76hCD5S44pw8ZCluweBVdT8O1H
         yB9E+Pkk3kcsb9wuWmd5+GUMPRCmdskdHRjzMLEtp57xPk7iHgiqR0rdgu/xAJbXRv9d
         BtoJsA85D9qYp2KYSL8UP21ASLAx3yjnpRAsU0Umdj0FdW/xiBemPpayG9Xd85fcp+KS
         /1YhTppBi6gl5dpDfDV8OeVTeDwnKyW7lvhRS7eIosV+FbZhufzWC4Quj8gv9SSDplxz
         fqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692264; x=1753297064;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlc8B6S4byi7qqYIr9GjvMiwX+XsyRJI63r/10AmDZs=;
        b=ChRTSyIsLZ0e9duimcRj9sULrJm2lKMmo/8ROI44Xs+dJaANgp3WpPu+dmlfQkdxzi
         zYKgxUgajZP9wk5vfGSNJTQJNeh3uKh3SJUNQFikxeAXgcehNnLJcekOgiyLIKbh2gSL
         6aPR90IJQm84oMXPvbTILiqC691FsSLlY9BGg24oy5VHZu40hOysRwK16efvzI4oFirR
         fGp5rNofVixd+OFvadeZOwQsQOxHYI4QQML9JxSqaK0TVdsxHuVhXmMjwnhJA/GRks8I
         zDX7kbj/yKhc0MpPnAU0qcfNwgX9QZ34mCqmTkSv2vLP8rhKp5IO8V7efK+7eJHrnzIM
         SiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1BPPhJW6kqNHyyXvoPUilAQdrjkPZsCa/dodX/MY/PDhKXysw4bgNGNHTGVLATPGCvW0chsp1@vger.kernel.org, AJvYcCWv+lHRg1A8mOCUlVN6y7DROr6t9FRxe7JgC41HkZhmlmi53Yno9UV99f6xEpz0qGNGgqWcd+L+gSABdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh+h6d/4XrgnZ78XZwxzB9ftbwqpbZDKiXsux4vyaKSU6oIL5
	fpmGDmQke/ESI09u0TfvFPviKQjMvfgZMtzqF1Tfun/wwJOsLEG8NJrC
X-Gm-Gg: ASbGncslLYADcsoXG4dnn/4XIHhbm6uY9AEhkVxU+GvBi+K92d/ADfwxQxaUO2iIz4/
	HbUHDGhLuDKrexsgj5exOkZtrzgpRX9OIcyiE3m85ZHDay2A6TLiQa9diaOYwBFWd0Bn9x1rLYa
	gFzhPiLPkNUVYk4gTNRQB/yJ/R/SSrFmPnr5P/MvPKc19hqolrSQLqqWwoqC9MGTXtUjOHkPWON
	KYEKvZH5CnrN/A+mNdIfJDpJXmXcdTIG8ZYFwwYXhtP5WqxWW7deWBdfEqZr0un/qrvzY4HgnNf
	cI2RL05PrOAd9hP7Cp5+Nfgb+2Uk9rwAiOzGOBTwimDwz6dKYvA5MgS+9qjZeVteJBc0tQDdDDH
	68O68TrZ4LJVcbVE1jDbCZuvsug70vkANx5OMQcdm587xPhQiJg==
X-Google-Smtp-Source: AGHT+IF9GOyyapNBfoqgOuqiv1XZB3qmpXDUP+K9ucgAkq5QF8plhpNilPsAFDYUgoSKKIQonp0F/w==
X-Received: by 2002:a05:620a:1aa2:b0:7d3:e868:a684 with SMTP id af79cd13be357-7e343635982mr449863385a.51.1752692264133;
        Wed, 16 Jul 2025 11:57:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e32b48255esm374138085a.97.2025.07.16.11.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 11:57:43 -0700 (PDT)
Message-ID: <dada6ceb-bc96-4d8d-9137-4ca1763baf16@gmail.com>
Date: Wed, 16 Jul 2025 11:57:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/165] 6.12.39-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163544.327647627@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715163544.327647627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.39-rc2.gz
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

