Return-Path: <stable+bounces-158443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27137AE6DB2
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063371BC6582
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4312E610C;
	Tue, 24 Jun 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF9aAXSX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66842222D2;
	Tue, 24 Jun 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786677; cv=none; b=ixyMXooWJzsjN/ZL83NM/xgvhbU3mmt+k6F8u5fNWCaSgM65Bf0pNQu/xcQjsybCsAwdEzEbCqZK3aztrmjUCfNBAsr9tnLu3p76sOiJILRNFh1aRiKPn/uSdKCweROQ2+ZREBnyxrCupvLEhKPLuGh1ftJfIO+IW4FVApGO5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786677; c=relaxed/simple;
	bh=ukmnTODouOFjPUParCF5o0rMy+sxb6HlnqGiPe85+To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrwBLkZm5F6T22PbWKRbSgwJRVN3nBYd/em3Xjxq5Gwvt8lz0QMeQOWhDQz25Z/eRQ4/nSysSx1/gFXzyYpsQ4QZSh5sMYChPtiANlf5Z53CDFR9x6UQBHOu9VBh6YIkjyLexfD3wqH2ksDhpOL2KQ974vCslVQUjC8KxQaEqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF9aAXSX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso381705b3a.2;
        Tue, 24 Jun 2025 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750786675; x=1751391475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aek7AfukVB3w8z+c8ayab+lJztJVDxSWIM4wv2o679c=;
        b=NF9aAXSXsZoJrgwCNx9YB5ojMwGqsGfsrVFBKKW/FYbKGlyaDk72oR3fvHE3V3OTPY
         0yBJSM3uTrAP99YbIdK5Kepe36h0gsZfJoV+0xz4qIVf8vixFO7L4zyICge3wsbNEtir
         hzFNHqykeF/f8D2qAzfwqRU+qMnjXdzvhMdZxNpMpTh3CNIyceUX17AQpNfBcJkYU93x
         CrtPOf/XhFGB2okbJOrzW5rOWX9yx7stCWf1Eeh64w+essd9f0yHWbZZxjEWnKY1fbMs
         +BH8ldJAX1d6n3WT/FOT8KjSdJsJ9F9xOmi+I8U0PDEZw+LtksSBL1Ay0cz92bPtbYlC
         JMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750786675; x=1751391475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aek7AfukVB3w8z+c8ayab+lJztJVDxSWIM4wv2o679c=;
        b=pUosj0E5ag6+SMXk7if+I26iWZkEDH7MrwoInUd1tCkViuhGJEbDMDw3lj/qKGfA9N
         xexkVEpNI89i8TCb3cpslcRVGj0rOKzuGgcnPcoxmP004iOYoQGEg75cGzSEC1V6ijH7
         YqwxhSrfGShSEFwhS5lP1I0r8BJLSbCokl0tNXRsIg2GzJtBvI1NL8lz+jdXw/LO6aZi
         fxxtz4OGbTXfQoBXECi1ejhZg7QWKhYBzX1bd4GyUsWZQ6ZC+5FLbd4Oj9r9Jy7Ktp1L
         eG7bwqKjWCAuO57p9JdX3Ek6giR1cDEqXyFc88a3z/XiET8kV0AkEdNOjfvrivV1lLhO
         M8fg==
X-Forwarded-Encrypted: i=1; AJvYcCX7cQXFv1uJol17Tw3w4D1o1c5bp/npH94S/hrr0Cfv8G8vI9pjdC9IIJzcpsEAnkKDtSUWKVXn@vger.kernel.org, AJvYcCXokf0IzTbK9DoeG1Jp1TbgpA93ccb+V87HosP8rpXK9/8qeNsa7h0u6aF0JiQXLIDS0qW/Re+9K//02+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtuCDKYbUne4BR0PteK+QYdb5iRCgnja/4JnulZQuJnsXR/4F
	PdYkHkm9BgVASTAjrWRcHasHwH8wVY2o4F2khEi5nNstfLeyz/XS6Zj7UMQUwpLF
X-Gm-Gg: ASbGncv5U7N4gnEayN0fh8PhGQEDYD8yspfBOIzdMwxGbME5PWIdh8CzhMT/rTarfO/
	vTuAXzBTn8RjCi5LhKy+W15VMTNOiAUNGvDJvdPUFyPR/2eKtnRizNsI4939OXvhGw0H5If3Ei5
	Pipreb2x3rpN4Z2vJsxkhMRknzdnCjkSFzqvzZF139/oGsCtYoJv0o21e4uvAatfdLDE5VheBRJ
	e6Z7e3Nc3FS89Lj2qGfHarl3+a1TygqhHRlRuQEzPmkYL1ILkkkQIj6Li2MU/onYImwfUQfIypj
	VvLJoRylLOOvZZ2y2E9F5YVl8pg2FbuNHRuXA4jWXXUkBMifCUVKSsqnQ+iWcSHjJL6NN5mGTtY
	9pk3uILJzxVpuAA==
X-Google-Smtp-Source: AGHT+IHDle5XI/EZff4+1+7+lpJPC7D34r2C4A4aRi7/ONzVB8eo26lB95DtEE3BuCBhWNHQSOCXFA==
X-Received: by 2002:a17:903:1a0e:b0:236:9726:7264 with SMTP id d9443c01a7336-238245455demr1377075ad.5.1750786675103;
        Tue, 24 Jun 2025 10:37:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86d5efasm116834965ad.208.2025.06.24.10.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:37:54 -0700 (PDT)
Message-ID: <6a86e89f-3786-44f6-83e9-05ddfe7e6ebb@gmail.com>
Date: Tue, 24 Jun 2025 10:37:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121449.136416081@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

