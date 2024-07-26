Return-Path: <stable+bounces-61921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D793D845
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5C1F2506C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0738FAD;
	Fri, 26 Jul 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYdbuW5p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BF38DD3;
	Fri, 26 Jul 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018184; cv=none; b=ap3kFmRmvaiMH11lhBK/YN5MRisuq2cwZ4BxNvstUb5iI3vQvxJdVz8m1PopccuzvS+W5+4oHgtxeZE2TVWSiDQIsrYkViRbjnqOkuCmo6cVlasvvIMF1eMFSEptQ3COn0zZnytlyGvVANJ/CUK05AOnAWKBWYQw7QciS5ii6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018184; c=relaxed/simple;
	bh=NXuxfbSFshWj7VpqMIkSso+XTvOsVSg0ytFMHzYj/FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQpvwmStlJFmFa7uWAo02ctbKtCC1ywF3XgZ51X9wbRauADR5sllULqqSF1xw6OPdBVqQe9gd0V/f89ZWkF2nk/Sl2tN4qdjF3CWRZCnsoBo+fWUUIEwwWbpbR77KFwiJc2XE5UG5aGF1skO/REyiXDFISw14orXOg4bOMT+6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYdbuW5p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1dadd5e9so1206825b3a.2;
        Fri, 26 Jul 2024 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722018182; x=1722622982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dhDfK5ysELU67lH9lFcdq/u0XuELw/N2jDHhfUf6Pg=;
        b=PYdbuW5phofQW4ja5FKU39OaAyjI5yo0E/a0p9M7KZbbU2XlYi7IQ7aqBoCWlIhmwg
         1Oi3q6miCtiousCYnotm+bF4dC3qbfMouwUAVGoPRx6UqPjH+/Hrm8ExWU7zsliGi3B8
         giPBvXJMIL0crPWL+9EpGCCBBoMFM6y0lTUyzo/STCec6cx/rZas9h4ksFKCAvlc77OS
         w59rACH7YTF1z9VTW90zYGKB63L78oQQR5cksBZZO2jdEZWdmDPzBEupbIy4srrkHtdl
         TLq876Z/cz6K5wyBRFGKtWAD2KDAicCRl+hProxo5WmuCdsaauXhHNRR10I0jbpnXDtA
         zSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018182; x=1722622982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dhDfK5ysELU67lH9lFcdq/u0XuELw/N2jDHhfUf6Pg=;
        b=A2zJH5FoTKl26DAAs/FYJR2aRJqYjr10qkywFUlD+BFwHRcM9yuHvq6vl+BfgMOpzP
         xwi1V94+cvQdQn+CSWpIirWYPKLTcU9D3UypHWX1zQYYUHdfpZa3ztrS+dvPlmWJt3Pg
         1v2EnxvihpNM4E70wQPfwhu23V0MNhaPVb1aY9z0WtVwNepJ6k5EIZs2B8L92fuEv0NY
         /FCaw1RJ1x3+SWyMtcyBm4uXr21rEJ8We7cGzB+u/bTx5aOGwRCzcHg/OeN7qfjYIZYy
         P4dtaiCbu8VjQghhp0e5HIvjfDCScVsBBvmHvhGVjMnOkUOO4AYgagFYSYbDFoODoqXI
         2FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGtylbHYNR8CFvIGZeIivjv97g3noo8zpEvgwg8HysYzvcrxzjqP+dCGye+ueC/u0yCyR1YuNprhaXh8G0I4Srm6N9OWpzmN0RgprywXYe+fYrAV8lbvLvBeKTMFx8ISTtE4QK
X-Gm-Message-State: AOJu0YzCoN6S+55mYvEszAKtv99WcNLYAoWsRZ7EG1XRaJ6DF8hxCglJ
	PQcGJwBW5MiHoVy7BmuFjdlvHM/LbXVOMqDkN2JORshZdf9Udh+6z+XJ4Q==
X-Google-Smtp-Source: AGHT+IEYtAR8TW+qCjezfdBy6NG/LzVqGZNjjejyUBsQ38BPbUibbm+HIoQxBu19fqyo1Nyo3uSnUA==
X-Received: by 2002:a05:6a20:2455:b0:1c2:8d16:c681 with SMTP id adf61e73a8af0-1c4a13a47d7mr377367637.34.1722018182266;
        Fri, 26 Jul 2024 11:23:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cdb7600054sm5813739a91.47.2024.07.26.11.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:23:00 -0700 (PDT)
Message-ID: <b5c7d24f-ad3e-4acf-8171-8c1d44bc1025@gmail.com>
Date: Fri, 26 Jul 2024 11:22:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142728.029052310@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.102-rc1.gz
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


