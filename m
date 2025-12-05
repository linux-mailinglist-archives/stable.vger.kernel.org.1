Return-Path: <stable+bounces-200180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C83CA89FF
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECEC3093CF6
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215913557FC;
	Fri,  5 Dec 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAYHtlwf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2C244670
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955576; cv=none; b=VFsKvyik3RcLSWssn/QActCcObQyS5/uafwLPGNtQw8O/CLMxs45K8j7+wEFH2VSShhaCVbW2vk04WS8cyANoUy8XpeC0v2NwhBzT11SlKhCeFPHdZMomc/37m/ZP1Apd5nY4BjVGh2piXctzfv5wYQeQ29ujlPpY5BFw5rsQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955576; c=relaxed/simple;
	bh=g6iktb+IWC5y9d9lpV3js62z29b6taQIOUMvHdYUJ9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ89bBWtv/nJAQFvRqYJHEDVaCLHbSPztFn1xQ/D8feKCCcADWc+qHN4tIbSVjcCitJJei/0T2EzSPm5qmepmmwE+cyGZIqhzV3djpVjfNu/FP1QpJWRlXlpV8eygjhk6YDdFy5RvNRkbsbpyKiwAMZk1pqBpsKTy+eUV0q0FFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAYHtlwf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee2293e6a2so17398641cf.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 09:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955574; x=1765560374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LINLdZzEK053sMV9v22q8svB9xbGy0ZtcEzGRAfCE8Q=;
        b=KAYHtlwf64WMpcvRUZNCx4zp4fMFLD2Ird+9VAwbVHWux2oPtDkdVnX2e/eajFn9oc
         6NSRA1Q7EoG0R4uWBor0VjBurimOzReZsZAcGYKqYDgaameGuZpqL2TUrbtQObP87bxE
         BbYOgyBnczJ2LaFEE1dBH6T2R2XG23Xw99U8wCH2VYrzjnvV/VveP0q6J6eEyCoULdnG
         ff48d5jtXUiQAUCAF/xCLIlLiEBqhE/Zy8fpsXJgxAuYevRvldWrR4+soY0Zq9xrUr8h
         x8HQ1fqs9+0Hbf7gGoQ43lgeiX9pjZxoKb8Lw57PmWXY4GD4iFcYm+WhcWCHYTChgZAT
         jzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955574; x=1765560374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LINLdZzEK053sMV9v22q8svB9xbGy0ZtcEzGRAfCE8Q=;
        b=FkYmUHjtW5YA1gaLMevP87fVeAf6OkKBfHJzX0beZQjjLKRY3UtwhpN+lDawNtGDWK
         2aPhUrgmkhjh+5yza0YsRKqR/0eeD0hICADXa/g1nysyKIu7eI+tpX2p5xbZbl4Cd+CA
         Hq9xh+15aSOMqeHTDAcgpOGobQ5H/XcFhjz+H6Vstx9sB4vuM+kgAqcwQM8zAeMi3qW0
         Puy5wEbpk/TAhMsyAFkyzJNZmGZcy35lCmz6Ao5oZJOgJh/YBWvPvyD0EbdZeZZzpF8i
         DFXg30kBV/GVwgIPf4A7UkO8eV44YuvlyOeAWO2BxORfLfphDmsxalJbCoS84wpArUe9
         ZC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVD579CkYrXBNLBhbw1/6jGO0t3EuSIJBGnYYK3axx94Z7yDjSvsjKKNxTu/XmTN/S9wHDm0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8Ko1tXh7LpmE9CHf3vXl89u6ntWm1FCng1CqbbrAw/VJodT1
	WAfvyutqXnpqnKOG3X0L9kqG3GbDphxTWE43XtJBxfIkIstfO4udkgqyjQu0Bg==
X-Gm-Gg: ASbGncuHXGh1i3Vtdcz6N446hQjAtmbpRIWKqn3Unbi8JAYQMGEWUuQKQq2/598tnA6
	iJB8JwpALFVtN5Sh1USqXUs/LlsoPmVQW5A24e+qb2hiUcIOzhJWx82pteHgUtnMJDwk86NNu/d
	pVt4kjBGBOdQxqKvv3Hh0AUo3WyENa3XVDzRtw7icG5RcdV4PGE0Owqr6FEIeMuzLFL/7TchOUb
	x7YCZ5phBk4mBTvaaMt9xQnW9R3NC0Rl0C7QMXFfsIX8QZKnAGgSIAGzQjBEESu7tILOcIRBT1I
	ppBUcszIJSu7PaKhDodlOTs63huANir3HlaNEQtu+HbjF9PdX7U4IZt5HPHUYAnWCLjDAmEw3ka
	7sS56pme2Rx8pGCvLqmVXDGS2iIlD4KDDIJb8qZqOaO9m835h3w5ZUk3oPlJxnZuA5BWfr6dgCT
	sWlteSU7sawELzmxZxaRbuA538mTM+gzf3GxTp2A==
X-Google-Smtp-Source: AGHT+IHgkqlNiyAQxO/j6fihjxQBw62JYYCT+i9/xAjbcB6t1Y6B2OClS2hc/EE5bn1LhcbH93kzzQ==
X-Received: by 2002:ac8:5fd1:0:b0:4ee:2423:d544 with SMTP id d75a77b69052e-4f01753008cmr153536761cf.11.1764955574345;
        Fri, 05 Dec 2025 09:26:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d2b54csm29932351cf.26.2025.12.05.09.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:26:12 -0800 (PST)
Message-ID: <4be38ed6-74b9-416d-9223-7b3f37d5a74f@gmail.com>
Date: Fri, 5 Dec 2025 09:26:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/295] 5.10.247-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251204163803.668231017@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251204163803.668231017@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.247 release.
> There are 295 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Dec 2025 16:37:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.247-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

