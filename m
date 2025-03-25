Return-Path: <stable+bounces-126595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DFA70887
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE14A3BDCE0
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B6263F28;
	Tue, 25 Mar 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfHsGLyo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81725EFAC;
	Tue, 25 Mar 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925044; cv=none; b=pxL7HYFu9ZVj4r6Poqz7k1ojVIGlJbv3sHqOHBYkX8JRHygbKOKZcIbI6NlAhGSTwcFBTFtlyR7U7mGs7qNTjn4FS17EK6YVM58xMOB4R3dvMk293V2OEDnmCt8Pcyra2PVy1YS6+zh31Gp0M6hkMNXEORKVRYgdD4+tLXnVayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925044; c=relaxed/simple;
	bh=aWo66zMNZsltX267eS7ieYkDsrrujgp9Ss5dR7uh+3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze96s0ILRyxT6XbbK+1a5XwFfXFi3JisEnDhuwcx4yYkHrBpcKRUlLxDw8BytASuP2f8J5EeOPEtyZikDJQeL05zI6hCnkVl7sjMenPf4ZCPoMx+gcDkuJygXFmlcdlI/NkPt8rTFKZVCsDqYH9mVsU9No1BDTnAJnkdnAUuzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfHsGLyo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227d6b530d8so47036945ad.3;
        Tue, 25 Mar 2025 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925041; x=1743529841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/9O5z5wpMAD/d6DKPdNpelq9DnCqpNf5QfA4sBqy9fo=;
        b=OfHsGLyoqzccp2WGNU2jJEYIMR68/e6J/P+Jtj0G8JTAIJT6UNSGIFlhcdwi7H+iP0
         P+MA1k4SyX9iLi9DIHT91TnLaUkW9joPyLObNrVt3moV4mVatCKgUWAgYLZU1Kl/D/DH
         tGhGAsWTZVC2NOJ59d3GEhaqy+5XMKBzDSSZne09FjwadfvnEJYj0V60Zy7KRTJjLZ9Y
         Ngh2zE40lHrzv5XRajHMFyauJkMnT2PN/FYqiu9/ktkQsyoDOxyTI8xmrEG1CFY3Sz83
         jmQuirXfERcZ6fvSY+Yr3vIsnJD0vlXZUvZbe+RVdLtBft/gQyezhIaU3RJgAg3PoQky
         81DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925041; x=1743529841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9O5z5wpMAD/d6DKPdNpelq9DnCqpNf5QfA4sBqy9fo=;
        b=IZT+kTqO/tUQoXMvgkei0m8smMfwPKI2dgLkkCV1ddaH7dW3aZbgOUk9iTi9gyRIiU
         AUt4ut2g3AK2v5Hs/Z1ZN5qQUWtXPTCY5LURXt0U4U4E2qiO6VcZ4ci2zrtETL8yenDT
         9cfyFmhRMwV+cYLfPblzFNK5tfNF8x8dSwzpPf0ghyfqUyUaQ3T1od8RXsvT8wucbt2C
         6+Pag3pYwxkuluNMFRFjomDJBegWrltvsf2wyyLcNYPLWReBQJPipUcpRI9riQAojNTR
         e+twoKsh5CCeEmtGm+ZrCQ2T7iUl+dyNfBT7eV4tfpERf6kSN6pHD8gbHbSW0eRU9BMG
         9c3w==
X-Forwarded-Encrypted: i=1; AJvYcCWOaN2yBhRNk+N7FttafffZUEkcwvMumOSWypQFRxE7TIo2t+GtpxoXsQDXxcHyZQ4qWfG1m9nCXM2q1J8=@vger.kernel.org, AJvYcCX2mSfw2lgiuZpzFJC+TSqSjVSTRMN8wOCypAsVi+iCNyaYSDE1Ef2aLBtO9iF3YeCGFs0rhP7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/loSctuS00NAee44ABHPGroQfyLizVITx2i2GSqxv7acyR6T
	T0DrsmkVTNJlXLV3zOxd8q0m69eNXWILCE5M47cEG3FCvPuzp5+6
X-Gm-Gg: ASbGncvunL/M4vJtN4u5fohEyIEcsVAhhwZQEtcxlNFSHWSXV1T8M55/p1I6fLjuKtG
	i6IGf5PGvdklLmVMDlSRXgP0tbuUWoLdZts4XEqwnypTs0NIljWB6H2Z1CegOntY1YdGBG8g0g2
	Nk7HTRq1tUDYn9C81enTjS6isqZ2DvMJKTBORTJg69eNfMr1b0GaK0DmvqGNJy/OvgSNC8wFqdt
	HLrAG126d/V+ZQZo5JDKBSyQjK13R/UF33+wLmb75RntrdigaK2lq37Lcsi3cHxC2Y6wQbrEJcb
	ZoYzSrEFQ2Lze20RwJnS7D49HIsPER5FAmmEW9Rm5EOtGowZoF8LqbP7deXomKmbWpPnE15F
X-Google-Smtp-Source: AGHT+IFNy/AoA3IgJdV0KhVTbA9UE/acBjBDx4/c1rrBsATih8TDS0W2KoovloZQLPALvZ0WeLCU1A==
X-Received: by 2002:a17:902:d4ca:b0:223:4537:65b1 with SMTP id d9443c01a7336-22780e10a22mr267093925ad.36.1742925041400;
        Tue, 25 Mar 2025 10:50:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45857sm92940905ad.57.2025.03.25.10.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:50:40 -0700 (PDT)
Message-ID: <6f1865d9-fa0b-46bf-93e4-ef8d86820d4c@gmail.com>
Date: Tue, 25 Mar 2025 10:50:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250325122149.058346343@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 05:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

