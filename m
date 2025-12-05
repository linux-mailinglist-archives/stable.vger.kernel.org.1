Return-Path: <stable+bounces-200181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E4CA8A77
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 18:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C97B0300DA4E
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2233B6EC;
	Fri,  5 Dec 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5H3hRMU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7282E1EFC
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956285; cv=none; b=YBLPzT71M7kFbOHpADvGcwn1wIUwi8nvPmwJdZey7buDPd0E7OUsujQWh4KYCk+EtgiPvJVm4llM/RwV+3HGJ0JxIiozdM/qv79zxBnI4wFSF+jjTZjELuyNVZ9iCbcgYF2tcDVZp/YONE4JC5v2o30iX02gIAjkLKiS0MMcg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956285; c=relaxed/simple;
	bh=7N61ZWdUgGewQCkngjSTQM2NGBkmWGYlzXrmuAp+FRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EllNX1c5mYZvSz7jqfrAKjb1xlsRXx7oe1yH/twB1wbmwdKMz1OZzdeZgSOkNSjJOVuvvhxPOWe20IP5U5stH8qsfiRBfq6Kr3wfU6vqvtRGqHMSbF/WwGhA4PoIxnT7iClngG7Ooru2VvChM6Vjah6LGvUiLalxCLgH/KVdJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5H3hRMU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297d4a56f97so30612585ad.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764956280; x=1765561080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qRLfp3gti/bgMDKIs3NH6sgb69LJ4uhb6OjyGC2EJ8=;
        b=a5H3hRMUhTuu08wJq8vVSznRNzhJ4rdVvVl83pSH3ZZXzZyWJZs9RrE43oLATYa5Xs
         2RXUE8z1FaAkMNrXkwBfgO0wsPi5HRSJacHXuWf8TWRWkgLzJYKCsLw0oLr2Ikas+cI7
         WhSAgqazzWOkdCliG4nXVTYWM3EstiGY72e3kh0/SVp9t9+Cqr0iCnXJfycz2jBSgMYx
         8PUf7k1xzfhh5ofbtNLhntuF2ZQd+HrOZcsqWQmATA41UJtlMIm8DddC2SULokJqr8SQ
         vJAXDZNSn9aZmzP4uapyWZQ8S3+Uax0LEyfslaVJPkcNVfzS53I/cILaz7AUKIoCFCAP
         YYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764956280; x=1765561080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qRLfp3gti/bgMDKIs3NH6sgb69LJ4uhb6OjyGC2EJ8=;
        b=IT6r6MB8ZSYBFHGxobI9tThF8Uds5nr7xkq3Mgb5ELcwt64L6hhTyJps9YV3LPdrlD
         KMNCvmj9c0GZ1rBINmNFeCzXsEXDHvPvRscKyrwnX8SdwkyJeFjmtco/kDi4SjedbGpU
         f/jbVOW0fOwvVvV/AcH/JqD4VBCjzABMbzzfydZ3/mZY+ld+zQn3MWRVUEecTtoT3UA+
         fXvdKwDMFuTQ2cC7ZWDdgsVD7rOnBG7HaygIiA9ExCQqMNYg7yQp3IEWylNnZIFIR1/2
         kkntLnbJf3R9leel8blsGWdJ738c/gM0HbBgBIDEI2ccyyyuJQWEUVNMeNJYDCU+7WEa
         zeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiFI6JkqcNrPcfHq/QhKc0EFQv/HXa6UFtw/6bd5ZZ0gFYIXad9RhF90YD4+mqBkmBmLMYz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4SwiPaupg/+6NtslYdYCNfEy1RzGtsliRxFU9MKSo8v4+VFK
	1Bu17b5SG79Y2bqcaP1WwP12qHIGP6YH/U70Dx8ejusaVRBjSJwBlD8S
X-Gm-Gg: ASbGncvV90r4kua7HcvBI3PzbKVAI+2kbYjAqOLYXWQp5AUFKByooFNxnjjtES7fogP
	ceHTRVoqaLmOjzdaiEuqiSFGf8LfJwtfGyyuN9aHeN57LDDRQru1uWre4XAXw2f3qzpWxVBsTSA
	DgQYfRKcBRJbksD9K2BNOty7VBlQ9pu2fb9gXF1GW85Sd/e2NNEXysiSYr/QvHX5p3u2NLgOJjC
	Lz3ou+iBblY2O44PpcgxlhKIqTDLXwoL9WjO3vU4NaNb4UWYe7MdsES5NLhM0W+mDMUbtN7VfPi
	hq/udiINQPkGXQYsjm0RNINbA9yYm5PnorpiQo+zUCYtVgzlksqcQvfz/UIHVmTpXiGMkDuokTB
	7TZT+zxgjlP7hTT3w4lv9JoysvvX0tjYgLBrS+EhMZxlbZbqNL2QzK+pqWByv9mYckDsZIAwCAm
	E7R9/BN2suI8nd1aQF5yjj04rtiHsKccH58MWojg==
X-Google-Smtp-Source: AGHT+IFO6xi4psrGQDuhNf8aWIFpB2Da8ZDubG47osi0nuAvuKENfYPttjmkJhDp68hVbPuojZcXag==
X-Received: by 2002:a17:903:186:b0:297:c638:d7c9 with SMTP id d9443c01a7336-29d683434b4mr121468205ad.13.1764956280493;
        Fri, 05 Dec 2025 09:38:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfa2dsm55286825ad.32.2025.12.05.09.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:37:59 -0800 (PST)
Message-ID: <cf81a11b-c051-491c-9b8b-a286c884229f@gmail.com>
Date: Fri, 5 Dec 2025 09:37:58 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/387] 5.15.197-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251204163821.402208337@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251204163821.402208337@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.197 release.
> There are 387 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Dec 2025 16:37:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.197-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

