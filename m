Return-Path: <stable+bounces-60496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD093442E
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014331F22235
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962281822FF;
	Wed, 17 Jul 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE2Xemlc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC1B64C;
	Wed, 17 Jul 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252989; cv=none; b=ZWp7NmfhCUHkQFZ8WPGvXnhUixY6WyKzgMZ05sadRNoBOsxsvqBkJuiiQLTlQaDeaqgiOve++WVEuFYCotg/heGZRnnR/mQcCGJwT5xQ2MX0SWKZnKDioU+c94dzn2KsR7MW6IrXV99pWi8NHsvAjNckUk2tDsghKc72euDiQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252989; c=relaxed/simple;
	bh=QFOExT69EBDwLwEhYgwDDiGHy4Dcq0F7/rJKgS7aDxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPo6j6MyhCMScxvYG+QIFKUEav8uTkgVfwuF7qZ/ZFk8rpgEuPIU8z/aC93pYNGHzUHBRxju2z7Ra9iuOCreD6hoeAiinddz1oQF+LgXK8FCrWz3Fd6XFpVQ19kzlg+VmGoOEQdGdm+7WSblN7QZ822pupKs6SSr7TQHBHSO/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE2Xemlc; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d94293f12fso107710b6e.3;
        Wed, 17 Jul 2024 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721252987; x=1721857787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tY4vih4BGe4SNwmppAmDnFfqNDtCozDKcV6EqhYE6U=;
        b=IE2XemlcyJMb3jWJt3nFqQXghe5p3qFWng9al2FYM+MbvQLpCkpCIJfVcTdEh4xUKZ
         cq/BUjkAdLohDe9GyojmEyzNd4am17LQ4GLtYPpuiX6Sz6ZGucwBIcl/bB2CPXuCiCns
         LarPSHXkjbOtfv9t+69K28Q9OBEqVZfVvNqTvQLR/HEA+YiEc8agRLD8KkT9CM/NFTA9
         V6WNRb3LUNA13Qqmy8zwJxoLFDFvNLgP9QjnjMXrka58ke68XLG2jC1ozDpEJNMglsIr
         HCJxM26Aq2/v8XoK8/1nJ8iwzCSpOFjFuDemK9MeC2j3tKYPEsulCWUIFclDFyxxtks+
         GbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252987; x=1721857787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tY4vih4BGe4SNwmppAmDnFfqNDtCozDKcV6EqhYE6U=;
        b=S3iQQzg4vwll40x71C7/GfIIXLlwZ6YiJYJZUIRsm3J81RX/rf1osMNLVv8xZ/GQqi
         TU8qqiplSwl7ksiER+W5jW3p/FlIbWHDi4vWyiKaZdkf5Mu3RMsJMLm3rBpwzYSXudUW
         cC6PEteVoBXqIiw603TITxCJMg9/kvwG/gz/jCm/U2bDlMSAwRnPdWoi+uyqASuf3oGU
         dvvJnTmXkaxi+q+qUF/rXLj4o4wOmYvLAquf6hNfDr3sWZIAI0+f/pRT46PHNBO/vo7E
         D0BccvHeNvVyHHZL7xGEOyEno34ZIHnPCMgEHkvlMp69yA85qjeEo6I9l0T5TY06+f5s
         vZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHKkwuElDc4xQtmvMwPUPvIgvhn6oGRTl6rUPSEbqcYR0idIQGuwae5S54DGHmSjOkDgIUof8zYwfCAPhXmFth5+KOSy88DlC7sTEI8MYuuyk90Xh9e2ykT1OoxiiezQvXQvA
X-Gm-Message-State: AOJu0YzVcYsyogey27dfKuly3OlMeOZVeBZ+IPqQNokmyGdpPwEkF4G7
	KD6zGmPlieenpVOgm4QLu94AW4To37iN+V3qmcUewmQtrOzhZ5sL
X-Google-Smtp-Source: AGHT+IGv8uNuuHK2Xq3XPE0HAXD8ULsfvxWxAPtjXbd7W7I6ydBw77Ez83xGyEEqSPWWtgCLKZT+mg==
X-Received: by 2002:a05:6808:2225:b0:3da:409f:46d7 with SMTP id 5614622812f47-3dad7726525mr1117033b6e.30.1721252987130;
        Wed, 17 Jul 2024 14:49:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a160c88dbcsm444932585a.135.2024.07.17.14.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:49:46 -0700 (PDT)
Message-ID: <f80960fe-24c7-4848-87d7-11bc565c80ca@gmail.com>
Date: Wed, 17 Jul 2024 14:49:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063806.741977243@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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


