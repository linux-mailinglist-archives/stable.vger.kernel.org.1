Return-Path: <stable+bounces-145697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4CCABE2C2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518EA4C2E07
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAA27FD65;
	Tue, 20 May 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws6OH5UL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A127FD7A;
	Tue, 20 May 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766234; cv=none; b=qIMHfl77dMBgM6X+WtTpQG4MpHBqHXYJ5MhLhYoTJPspUvRxeDhnow8rx9CYvkdkXuVLYmvq/L9oT2oNpZXnGD+W5ZwiSSts52Tyn2+g21bVM9kX2+Fu75SYuWHtwEPP7hNtRlkrv5YotA6RrZYteDgTdTdIoGJtAhtKYi2ymgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766234; c=relaxed/simple;
	bh=JICM+9CpN5Uqo5Bozrviogbjrl0NxiJgwJj3pDdrHIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euEVCzSNncKyFbHnKozbc0v3PZEOOusCt1sgF1PtMsf+3HEZjVmdynpa0RVbALCe79+l4likr3VzqEDGh8lr0nAtQd0f0LXFRIQMkZJMg4PStf259NVPktRhs/f1zVivn6WY4yB/6wqcBl+571kdMHCNDmVU9YE0nf9l0en3SNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws6OH5UL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231e011edfaso49123015ad.0;
        Tue, 20 May 2025 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747766232; x=1748371032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dXwsJAQByoOrBBaZLY+E7MZdLUJE91UXwKqaAsM/qoY=;
        b=Ws6OH5ULoUJRS5BvbiCTbBmli2Qv37BXmaDLifkmisHxVmNvIl7jivJ03dU40BoCkA
         oIVeEoU6AhI42oOaLMA5S6xmw7e04gebfWIU8AFvaEj1VbCCnxR71FEE/E570b1TsC67
         2jiDQ03m+E28FOCIUNR/LErZm0tZwZE0cxJfQRMRplHrxu5hMZUdAUHjkwLtyHvbP9B3
         OcnHBfxeotirnctDp7J1rn1ncGc9dygfgh31pYalvYuHnJgUg1ETLSvfvzPT57+4yrhp
         QtNA4hzD4Z48fMKtTrfflH+B+aM+VhorIe22X+y4LE6QjYR5TpqT15ydvahPmebuGD65
         raQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747766232; x=1748371032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXwsJAQByoOrBBaZLY+E7MZdLUJE91UXwKqaAsM/qoY=;
        b=n/opXnw3apyEC10ub3t6XduopxK1OE/IAz86/wausapRLJn13iVYrLL3TBmJjPsVCK
         XGQWb65idicwkzGBzzJYeSAj8AM/kS/A5RvgWslCp3CoeAu2qj5LPlwQofpf2tN1HGKS
         Lo4C3j66iq4Hk3A+sPydiCNlgQY5+oX6ZliHIw5benaQ96Py9towJnzvxn377CzOQ9lV
         xFsJ4qFU955/yPoztYZZXW+33yAIcQaMkm6NbzeRE5J1oLfkakW5Zku89T0UTy5WkNNI
         Ea6+8ANFxkb1Lddcm0o8wUyuY44oQnkRxa05QvxTQaKz2x7L2EjVlDefq935kq1N7GNv
         vw/g==
X-Forwarded-Encrypted: i=1; AJvYcCV5U2MW4MBEJWjURJzYhJVpgpAc26J1gQ8l0Wc4yuIYm66k1gLuvux02ShrjRUEbnGgCCyb3BFULTOflFY=@vger.kernel.org, AJvYcCXIDE4n2SjdiuYI2YrHoYXGkJQrOEFUyggegl/FL53BQUIwJIlLsIKGpaynCkvsNO0j34l5oMo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rLQdXxbfECThzqZacon9dKOUEMWh7+10gMDUwwEo1moTyKQX
	lZp894KoI2t6M9FMZtQKF4FOY2tRqQa+2bWdHzMsGWu+v7OghXbLWZL3
X-Gm-Gg: ASbGnctbTSVnwO8ubMbf0RbJ7ixCIxkiM8B9/uPq+0EWZy7nAIExWHyHhfxGQo1SXZk
	nLsxjs0qzo3mB/wtrjWE80xpLNV2TZ1u4iXkksakVbK8Dybd5EWG9uhz1JzMdp+sDJzp49hUyEc
	IB6k6HRKkbaTWx58oOt/P7H1Dc3tOt5sQdL53ZuNlOA+eXxPdXmevX640vtrktZp7UzWXclbVMp
	69KLd5XLEnrBeeb0JyO9fFVoBb2PvQgobQ5YYs88mTrQVmP7onjbXmNd3tRonb6HgG8kWkHd3LK
	wip2aBnXgNRmHGRTxRJkzcQG81BftV6+TdEga0jAMCyqX5kySMRwvTXrJ3MYVaq0Vqk4o4Fpr9k
	LCYs=
X-Google-Smtp-Source: AGHT+IHJwFKbXVkEArUkxOuEvJRbwPQDqevlrFfXVoHuv3My4z4Pnv8EEjI6190Q5SCZg++y7mtAZQ==
X-Received: by 2002:a17:903:b8f:b0:224:c76:5e57 with SMTP id d9443c01a7336-231d459bee3mr241144295ad.39.1747766232192;
        Tue, 20 May 2025 11:37:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4b1020dsm80019585ad.104.2025.05.20.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:37:11 -0700 (PDT)
Message-ID: <d087b0b9-1d87-4049-affb-7220d9b96f3d@gmail.com>
Date: Tue, 20 May 2025 11:37:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/117] 6.6.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125803.981048184@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.92 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.92-rc1.gz
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

