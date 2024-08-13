Return-Path: <stable+bounces-67525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E3950B4D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76040283F2D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9C19CCF2;
	Tue, 13 Aug 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmld16QL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49E2E630;
	Tue, 13 Aug 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569550; cv=none; b=gzAJAZMMrPofV38Hbh/MJMUeHem7U9nA+Efs9bj3VIZ4QVONPIAcLX7U8NUP1YqL+mNr56TayG9T9auwgDNkiuD5ZC0w/S9Lg7TAVurE6WZEN8dD9jr1gFnAqDOJXz2cDFsnpeOcFDEI54kl8SJ4LOY6aPBjs3Hb82XDEVd+Ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569550; c=relaxed/simple;
	bh=p3JlrF731p5W7KLZZTZaFqixZukbSiTDmCckaWM0a0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oubyuECyTQ9/jM9yzoGFUHPdzbtutjTEZSzE78MYqIfrHf524RrxxOIDArgmcFYqCH0J/vukZ83Brm4KO1vrdHs0S7eD6hTSMJjG+lEzSUJLUmFwEoUaN6nSAiZ54o8la/sPm4D5llGDHQVRBAKJVzCwMkDtE7epBQKYwvrR+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmld16QL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ff4568676eso55273815ad.0;
        Tue, 13 Aug 2024 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723569548; x=1724174348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCc0tsfkmrKQXJYCabsN0V3UKjnS/OuvyKaoLRsfqns=;
        b=hmld16QLNP7tWekiTuBeFxD9AP9gjghR/6tsfsNJ/03m5uJI37lofpUIO/nCn7zYC7
         z00TRnFl/MtVPvVEzOjXl9ZLpx6wx6ojiIS3AG90EyUUOlF3rFuXQ1UsNVZZL8JqKKyO
         JVSvLsWKAIw5q3aCq4cuP0YLwkm4gB3GexrHvPani1QzaHkN7rJJBWBE0WCghSqHhYCD
         hyC/PkfrkQ4QV5NWrz5+Jyzd9aYQvq2BSeBWvFBiA3ZSuL3BxbkOCmn3vvSVknKSxup0
         VFMxmwxAaf1/IR/QRAOfu5OODOcDIlbcFiLA4zRxcYjL67klQEvJAGUSGqiOMqXEoUhS
         BAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569548; x=1724174348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCc0tsfkmrKQXJYCabsN0V3UKjnS/OuvyKaoLRsfqns=;
        b=pSWyHAPEHRWd+js1usZbvP4tYm2N6oCRPTr3rRZeL9wdg0/hUBjeCpxRxbJFcVGdz0
         UcdWk0rxZ3LV99QS3DBh4svLPgglyb4ujZsFK+lGH59u7TJKvMBribSZ7zV6S8OP0TIV
         65AiLL649dty6OSMYKfbmtCB36IBG7cJ3M6LXQFvhQ80rF3iE6GAjakdbeS7zxloG/NP
         Yh1aU2TBM3lRsD+6TLkhyB65sCWUH2j5AVx3aOtrIGVxHG/MJasQ6BPVQvwc1xLMeeWr
         x3YsynPXuJ/nziT6xkF+YWU6aEP5YAfnizW0vsGT9u9Ui7DVwA4SKfTfqoOqr8OVDQKF
         l2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUz0vHultFtZ22yMRuqA7qZ3l88ew8I79gRL81H5rP1AAVI1W5sRlwUz9x+yXJEEuVJnYN7712i1SGYE3oHB69gEUrIQfe35ZaT7GOnm3iNxi7EVkLltm6hDcR6baP4JoDOI0HE
X-Gm-Message-State: AOJu0YzraoXQqq4lj6ZwrnQTiCPK+QgymiFhgrqDN5LvHidAiAIyhf6a
	+saPWuRUAxaPnVo9s/pTuEaDwUflzDCiHNDkfl7beUFJXVwQAI4YGN51mg==
X-Google-Smtp-Source: AGHT+IHZLZ8+gNQpMjLuMxej8awWkxCsctUKAY8TomcFBHEzy5e/OV5URSLHpHoz2Q5glGUstAQ+4g==
X-Received: by 2002:a17:903:18b:b0:1fd:a360:4469 with SMTP id d9443c01a7336-201d64880eemr2532825ad.42.1723569548059;
        Tue, 13 Aug 2024 10:19:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd1c86ddsm15990755ad.263.2024.08.13.10.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:19:07 -0700 (PDT)
Message-ID: <c0984797-7fc6-4176-a7b1-eacbcef2f6ea@gmail.com>
Date: Tue, 13 Aug 2024 10:19:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160132.135168257@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.46-rc1.gz
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


