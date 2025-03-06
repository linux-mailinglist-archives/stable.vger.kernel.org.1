Return-Path: <stable+bounces-121291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE47A55429
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260CE3B62B1
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7F271814;
	Thu,  6 Mar 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3iXhkSQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EE270EA0;
	Thu,  6 Mar 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284276; cv=none; b=b3zhswt0Hhvc1l08k9REP8APnIVMEUi1WS1M7I1r4uRE7Yq0NXdlIqFJ0ZLnRJ3h9001Tiu/ID8ABEN8uZmyAKUWX2FcZD1i89EGAP2NdAOVK0VFTHFVp+lz1aiSv4iraTFQFYkuSdUh8yH0d4ysGcQgAwUBkON2sMX2045PHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284276; c=relaxed/simple;
	bh=ZBMP2bJ1Hb/boW6eVsTEN52GV5YqIAox9RyMWEK6NMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rHlTEBuVaLNHs8m0ct8S2ilzcIeA8Ip7qfzf10F2ehBlCav00iN16Vrdv+5Rauv+whLsTYcA1CYvvtSAYjNS/wmiDbBwykaY00rYBbC4mmdTnve6ZyGMq2draymMl7N64w6xmn5J9Pp/xHGnEag4jWdw1v5DORqkkwbPLlCEKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3iXhkSQ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c186270230so260645fac.0;
        Thu, 06 Mar 2025 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741284274; x=1741889074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rCLTrWZbqg8TymbUHv4E5FIaJnj6NcfTeBAZhUCsnkk=;
        b=M3iXhkSQyzS4Xu/PxeTHuOQ/yboJlA3Js3TRlf/QCBw5N0kkq5T32YLZLUmcmxC0UW
         V9Z1HOvOb4rRjx7NKYR8GxDpYTkFtX1d99Mmh2AiIvOFqxjptnz+8mYoVwE6CEsf5Jy7
         GITcvr1m+dnINbfkOC36SeaTi9rluJ91U5xEASlG+V8Ot70dh1/R1Vi4PD3pAcHz3G6J
         SioI6BIRCycpVb6/FxWFl/Gdid5JOETdRpsTTJBkwikpSpMSYhktiIc7aj3+ksIfPM2l
         BedafSXCWRbpyLsnSi7ZRLp9zQMCc5u81K907mQTtYiW6FTm6Xe4sMCeNK63wuiXF6lI
         wY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284274; x=1741889074;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCLTrWZbqg8TymbUHv4E5FIaJnj6NcfTeBAZhUCsnkk=;
        b=FgqazAsk+X0852OQ3xfylCcQQayMo/sR7YhhjRd9UZYzuNmoCGDluzKiBL9FXLRx1i
         AKydtNhB/H46n71h8LMpmp0cIXfJ3fmlWxnj+bJL+pq1AqV9i9KLdyei2pvDgLsmOQa5
         iIenHAHnNkuTqyZPJMzf8RUOuctcQlnDibQG66S2BYy5quOm8yHAatu+ddnScCkJG01y
         tF9Kxgzk4r9wSQuVBfvKoCcI6kWN/X+IVAILM+rrTpusO8KacREvdJCxBb4Iazodc4x8
         fyPY0YTV14Wdb9HVYA7IhQrzU57Q+ZHe4AoA7Fk0ls7V4biwi2eWd2tHQQVRT/NuIax9
         6+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU/nKwpinbzNLW8lXp5E3XpnmoJOETNOqaMh5jR8TI6EpN5BI8VVMEVlgAy4B8MzBKWrmEBR3Ku5nnNQPk=@vger.kernel.org, AJvYcCX5ctcNdVxRhAg0a+XpmQtLiNoVX6DcAbNkhuXKO/SuUWdDfuWfiRxucpFoWnnun6AH1h1yS1mI@vger.kernel.org
X-Gm-Message-State: AOJu0YwCygFWFl2qm2HGbnShhx+mkx+PcrSlRgApkjePvkfscRf6cfAB
	15TCzOEH+n8sSos7VKG64Mfq6a3eriYIOcR6Xh2Q3a3KduhxZHEY
X-Gm-Gg: ASbGncsB+HVYHtIA8w680cUgIQU1TBzDJgMH3i2y3RcqAJgoWxbMQmkHq2UQqxu0QH6
	0MW1C7OPC74pMuKzx8QxeiUI94TrWS90NE67Zr0VvGrWu56gDEM7u46WuXpp85AHAr97rBORbQT
	FiSUx9nFASeOyuT/GSKeSvJD9Ayg1dFuso8iewbKTQXS+hABQ9kgEaD6uASDjezCZNoqdEU2oya
	XxH+XAt0EaqRozHbFU4HGVbcJ+KmB2lB4nrgwAT/sgC3ihnvyVm66c39gVke7RffbPmfr8fjC5P
	5rp0UGnSSBtLGmw//oWWolkLgPzGUd5JpTshW0opA8MFaU1zxH4sEiUAlwYg9bKjj4rI/Aen
X-Google-Smtp-Source: AGHT+IFn/4SRrNfmhgiQP91ION0n0sqnjvDsCkPEk07pVdOQK1vpodfR2dENFvXII7UHkxR3kqxoNQ==
X-Received: by 2002:a05:6870:c111:b0:2b7:d3f1:dc72 with SMTP id 586e51a60fabf-2c26133ddbfmr126648fac.29.1741284273900;
        Thu, 06 Mar 2025 10:04:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dbc3457sm337298a34.60.2025.03.06.10.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:04:33 -0800 (PST)
Message-ID: <aa8ec6cf-e8ca-4f5e-9982-a432fabe2ebf@gmail.com>
Date: Thu, 6 Mar 2025 10:04:26 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151412.957725234@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2025 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc2.gz
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



