Return-Path: <stable+bounces-144482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3591AB7F66
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3299A166867
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2028283FC3;
	Thu, 15 May 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcTr6x+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434E283FC8;
	Thu, 15 May 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295739; cv=none; b=DWT65nu2bIZwZvcCBo1HXPbvhJayUk4AYYN3lZvGBwKneSBdOCFhpb00fLlQzxDmWWElHFkaxfvVQNWnlTTteY0rFc018qMxXWsfd4FkVJXvS2LN0tjTFRkL1ZmnLnvORafdwfbpXjq0EpEQu9Q++Wh+pbM2ig0Y9jFAEjYsZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295739; c=relaxed/simple;
	bh=9NpqHQAAUq2k+ftmLn5puhGuaRy6O84crNT/k9jw4nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZr1mFJtTWnmOBqS+GF+ti5CS8RVzn8plkYB3uK2hR0amJ0Ncle60wzvcjnvsWQeh5+UpNWo2MEHUJdh1xPKOYY7uWGGbqVOeJT0XwgBiX1KIhodBjv7uiv/uP2709nXa6GjGXKKK1QmWzQOlmA/imJoawwyKxgR/WKb3I783ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcTr6x+m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so825318b3a.2;
        Thu, 15 May 2025 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747295737; x=1747900537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K3Jn3/DM88WWkJVvmk7sL8Y7DUkSufUkCtIgvuhMPVw=;
        b=QcTr6x+mR2fcxrmCe1w5HFsjZEVWBFef/5RIGZb64LIR2KOegIR2mYI1q0y1l9u3c8
         80JndyJ1iraU+ghnBnezVQCKIm+uBp1mHQQ+Y0usEuNaV/3oCLVT52QYb+hHN7RZQnbO
         6NoCMK9qRUs4kWFxWSejA7IsioZ0bl2A15PvJjKHp5inB6QQ5VVCsuSWkIUr+AaQeCix
         jyjMOaSh1Cp+z3D/lduKu1iOZIKC6Ps+67KVA+h7FfIro3lk6Ea7F96fQd9K/LcByrm9
         /FRo8cKo+0HilvxQC+ogoLeA7jrcSuLtb+reuHJ6zCP9EUYcy9nM931l7AsFx3i2Et77
         2wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295737; x=1747900537;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Jn3/DM88WWkJVvmk7sL8Y7DUkSufUkCtIgvuhMPVw=;
        b=kh6i0jFs6Svenb0gqjuZZIat58JcTsfLpmL3t0Il7U93J4UnIM1PVrfy3FXm0dJiY3
         FXuvAo09iCr67ohl8Zo1JF2/DGjT65eLSC54E5tb56njyHJOoK1+jYeUorO3/AH5epr6
         UVRiJzdKXKdSnjIlmF5xVAPV2EpKb7fMzi0f5zsskcsINLSlICOftOj589ESfCCjX0dS
         xm2FR1/mMZV6Fbm5gR7qSithsfmpeskIi+QXgjKgJ21SMwUJoO95lhn3Yd2uDo7Urt16
         6kK+uBbvAal4eyJkZTOVgqJdh9i6818UhytGCEU1SoLNKO4OYI0wSB8Pssx7BkoBCOtc
         yICg==
X-Forwarded-Encrypted: i=1; AJvYcCUCrnD2cLEJMG1/Ji9AOLbc1P9aOWyp0WkSJlfvNGFM40FFllzAPWAplaxkI4UgOhk1ZVPkZlPs@vger.kernel.org, AJvYcCXFfif/xJZLYdjuxzFHm5+55/T/XlAku3WZrv7UkmJYJBTirMazcWR7nJoPSqbtzzJTg4EqIZ89Zdi5yLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU924r9sge2vpMr1QMiWFIi2uNDzOvE96kmc5BZFaUyrIOmis8
	9x0kvHNd38D+UPIOddpaIfr3W48cxIfEkFQFz7aXkURtLSaExxkX
X-Gm-Gg: ASbGncuQZer83jbkt8Nlm6zNZntAVeBT4T9nZzhkvChG9eT1X1cRUW4fmaOxrbDxMK+
	jCNQSlZtLnEMFpRjfalNHV9tNbIvfskBmrMhl43YQNThf4sgKx3qC/duS2EL5yS8QM30nqTkeyt
	+AKnRlKZaJR89gZaY80HSKl4c76t4Y+Q2u0eKQbl4IOGCOUTz/cueD3L+hJ7DsYzkhNxPejuWqo
	a4AZv8Xq1csc+tFMFNGhso+el4zWmqzz0q46MRolkccEYvLbRMyKKOgXkpAVMRQVaz5fI8/AJpp
	o8HTM4K1g5H3rNgPDZECIlTq52NaK8Up7PF46qI6Mk2nYzT2oHAQd8Lao8Xv+6VHDrlWvnu98DE
	JblBNUrQ6EKyc7V7qWUnhPNoUEA+omvQse20Ctg==
X-Google-Smtp-Source: AGHT+IHnHlfydB4fPE1z0O4AxRK7cFjPqerf6TRjI4Dqj9F5qWJIPALf93Kj3F/VKpUIMgDfhZKLvg==
X-Received: by 2002:a05:6a20:3ca8:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-215ff1bd72emr9734011637.37.1747295737124;
        Thu, 15 May 2025 00:55:37 -0700 (PDT)
Received: from [192.168.48.133] (mobile-166-176-123-50.mycingular.net. [166.176.123.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26e0fcbda3sm240899a12.16.2025.05.15.00.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 00:55:36 -0700 (PDT)
Message-ID: <ecf34b62-142b-4ace-af3f-c531d5d56e8e@gmail.com>
Date: Thu, 15 May 2025 09:55:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/96] 6.1.139-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250514125614.705014741@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250514125614.705014741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/2025 3:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.139-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernel, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


