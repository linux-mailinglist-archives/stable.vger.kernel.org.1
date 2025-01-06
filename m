Return-Path: <stable+bounces-107762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E51A0315D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2D61886B7B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AC8C1E;
	Mon,  6 Jan 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUorAg0v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D701DD0FE;
	Mon,  6 Jan 2025 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195170; cv=none; b=d+sLsnYu+L+v9srFW0GC613Wf8E4ma2+Ah6RLdFnysCk+lctTiau57cVfsC3dafDeV1+pJUomepwwrLNumw1KvO+VVr19j87b2VUTZRD3wE5++XP0lKLyoRmCfJw+iiHnvPr1/EAU16cIhbzUjyYTRKeCLxkuL2oq41dw5Cznpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195170; c=relaxed/simple;
	bh=Dmkw7h+pwZR7PNRImWJv7IGq90ezHGUewtcDGaWcLiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vdtxw7qblVB7DzlME+y9D460ofI8gudBRUn5OMkFfKslpgqM0T7NKmfGgTDFvZFReq8UDorggT0Glgq3Glc8g3SwfvPO9e1YkSq1VIxALixcFHHgpolwO9uPdRZYr+eEi1O2Fyos5FWrzGO/MH4HVn4W/PgIICfbx/VIy9XdXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUorAg0v; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so17182387a91.3;
        Mon, 06 Jan 2025 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736195168; x=1736799968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GrNl0YQyCQOVQbp1qVmX65QgwqOhk6aD8Sj9lELyy+4=;
        b=PUorAg0vRu3Rgw/4s50cEpPtDZ1zcO0lobx65W/Grdi5WyCnat6xDFuNu0uedJQldq
         z2N3EMzmfruQ3n2F7uXVTjjHTIZWE92gL+sn1yeVNNyH6A+aSyYFk9cV5P4tnFzWYTc6
         19oAs8Bn57Lq+MAtUf5h5jycV0EVu+19OHtTpMmr9pBf1bQ/i3ji+mvpRdTsvVziAChX
         EPFG+CE+r/gZcmfv9SfoCPvC49QelWkLQLO/+ov76y605d8+99hF0rzHRwM8EkkOb5wU
         um1YXMbYfb/ttiqxuRUkYlDFkZ78CFEMu3papbT5dH1bgnAZqYeCsECqGC2weoJx4sHj
         4VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195168; x=1736799968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrNl0YQyCQOVQbp1qVmX65QgwqOhk6aD8Sj9lELyy+4=;
        b=n4uMYVZkqPt/5JMIrOTZzBwwPaSlrJ3vMzYp+MAqTZiAWbrV0Nz/vfD/2KOJrGx+zg
         1bzPm1VJ8wtF+9zt/kLPSEgrIE0U4hk1z4RGJKR6+s1jraQBOunzScZniUoWEbhebCBA
         2h5QBF+NceiPTO5VwaOMojCH0GttZVSMgGONPEzeWwHXQSNXjKQ9Ls/EHJzc6lJlb6Gc
         f3DynecIPiyg96hdnKbADJVGFbMxwitsmV/f2MbnwEaws69Lm5spheonG41gavkqbU3t
         pntf9M3+CGqLF0Itx4Kq5pS6lo43VyL99ed8kJGaRsWtRYv+0SZAIjt68bUNJGywluvI
         ViRw==
X-Forwarded-Encrypted: i=1; AJvYcCW3laDtX51pLQDAMX6e+FDSd8VF3wQX7I/a4IVvsekbmuV3dMnAZgOzn7CP/OnmVFZc1YGvEI2Q@vger.kernel.org, AJvYcCW9sFMcDDChd447CKk8iJCON8vDYo86oxxTiXcpgv+kkP8oN+LjTh4de2n9Pga/oOgNIxjElKSxcH7erBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNB6p98ko69nTrE7oclZl/lOzl1jmWf78eq1GYJ8Sr4/WmgvH
	ByIzkzF64q1Gl2IulcrT3UjL4sbcU9kfaaHiGeCBQQKt2PeCJr/C
X-Gm-Gg: ASbGncuF0nu/qb46ePB01HFRrEUlR97xBducHJ22ILem6L6+Mg/7uqvEvqamoE8q7A8
	S5vQK880ySnzcWasltLCMxl3hwtr1JNLJ2etaQJ/yeyStKWrsLvnbfuBGj+lG/KH/qBclzs8LOO
	OqM82+F003drmCfDY8HnCSy1wLkk+DFsjB+zt+K24qltOf7rUYbjTzWBQDDZFsQ72KyZhmW85/b
	PAhcDnqtv2rtrJEsX77LU41TMn7PAyc3RiLLZbEXMTrsKyW9M1XHvvCCzlJKrlX+k5ccFvtrQXr
	9pHw0hy+
X-Google-Smtp-Source: AGHT+IERgVCR9lanqnApTNc6ho9a3G65/9nbvdrhBX4OSNPtos9CVWLl9qPXcJJuOS4O2ZOqRWtZpA==
X-Received: by 2002:a17:90b:2e10:b0:2ee:fd53:2b03 with SMTP id 98e67ed59e1d1-2f452ec6ec7mr81836991a91.25.1736195168413;
        Mon, 06 Jan 2025 12:26:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f53e1d31a0sm16269a91.1.2025.01.06.12.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 12:26:07 -0800 (PST)
Message-ID: <95047ec5-9f40-4b49-b211-42387db6bf28@gmail.com>
Date: Mon, 6 Jan 2025 12:26:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151141.738050441@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.9-rc1.gz
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

