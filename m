Return-Path: <stable+bounces-196560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76EC7B566
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3353A48BA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8092F25E3;
	Fri, 21 Nov 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaHUM2nJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F092F12DC
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749831; cv=none; b=XMJnJCiBCOLuBpVo5H7ppVm1IinVfcTMUptkl25vDfxMxGoGyVJlP6BmV9Arc7PMtOP1W038K8H8Tnsl/24kid9HpD0GslfxGd2s1vyfwsGM92Q3ROsMgvPjlXJb7xw9mhK7mxtHy2MS86/1WTOsLDn27y/zTxSTk+3BuQ1RJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749831; c=relaxed/simple;
	bh=/3Fsv8xJYGR6NyMnCYC0WBdDkXp89MOQ0KycMIpmru0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuKO9J1++8qVP3ZyFgbeKsshy+1UN4UDSUzrzo7GKB0ZJ9CBJIYP6akfhU3QKljUOJJ4AcEmTR6uWQfy0azHYu+4gT8NdV/eKqwMNDzKqplEBJEZLD91vNppIobdMBxFgOGI4o+74yP/9UEPsmtST9mB8WKOa8a+8IcccHkgYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaHUM2nJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2957850c63bso16403725ad.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763749829; x=1764354629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05vOK3XNL1B/SMLezaEPANrmPpyZuP6hBZyVD0fJcn8=;
        b=TaHUM2nJUjbO6xpPC4hK5CwC6B8SonVMsvAinjFHoneyXDN5Htv/tQWunEAb/m+Jnx
         aUeNZD3YPm7xDzAjSM8bhKGKqEcSi/qFp7t4w9vUQ5piEia5cABcgYfzkfWJBigsKL3p
         NKK8dXNeqVpdIoaHzTCZzJxY/pQyv/iCtLaw1torVtICN/4uU7zrq08ms9M55jqd4k+t
         3bSokyXUlp/9uNSxHzmSclfIsaAi2Et/u9wsBb05b5/aP27ZButU5HKJTY+cHbkM1ELT
         buCbX7IG4xr3nwnnEMWjTnZfU42sFu8v7olMxK8qFee2HjphtEZlJGho8hfJ8QgsQ/PS
         biyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749829; x=1764354629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05vOK3XNL1B/SMLezaEPANrmPpyZuP6hBZyVD0fJcn8=;
        b=hhmzh/VpO7HvGOXIL02/NFu6J0T4tnbf/hdN/N4SPUr3aHMVBhTnIqMZjH+x39qkG0
         87qiEXL6fUUq6d1nG4Splodvlq/egWZ76Xd5Gr54QHiQPZ3kLm5IClqUD7DyjNB1MzxW
         4oFK6Zb7/D0sFsfNszF1F6aK6zaC7cvbeXr/AaDNR+LBQNsAaP+KS1Bourc90PrkQjgC
         IisPOh/dxW45V+s+Wc3IW4DIFO9UjcVX6WRRpBZ5m+IKQnt6R7iQJPbs67eKHjbXfi/h
         zeGoeegEgF7ecoBmJ+283lDe3LZm3mDEllYZvRwKTDrye14HL96uFpIiw4bknfQrskP3
         qS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqKWu18gMA3BDWdAmVsJnAl5IEGDOsJvGu+xejN/yEhtjP6BE69aILM5MARAH4m0YU2OspS+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPv3WaF8FvPPSlu9sZx/v5FUPATSA4fbqYAmkTU52w8VwfuYM
	sR7jKjE91Rub/AuxtqisE0d4JjJvc9EcOe63bFHlRImwpoIlzTZqPOQ34K4UFQ==
X-Gm-Gg: ASbGnctcn0K2vgQw7gAKcnOFFisJh5UurYQzcIYlNHf6f48hR6mfY49ctpWfsj0JD0Y
	LTn3t0Rziksm7rD0RDfFuRnryustQXqxt6CDWUrMRjloTqbKMEjvbHl0wAKGgPk2K+MSTLwtQVs
	oLgY1OYDXFB+5wJl4rh0eXWMs+3yDft13IXV10Mu+roIzg8vIVQAEm0kpexLgca7oHoy64RmnDU
	SstqVZ4F0IPdgH1jPQdwVKvwr10szYxQzEFyMz/vb7LPRhf9CoBDgdobDEX8+KQH1uAaBccMyKu
	JUU9OFvU1zCugPRwpewj3J3fKNQBFwAmNY4J7e6BRbwF4HJFcAy+z2g0d7fyMvdzuVvyzfsXkxy
	rsmEkJDv8LxKC76jr1H5LmyC1MJ/ZLJU7+9nkoMeYUqgwoQbfXqiVoOzE16rdTnPUwnja0pbvmU
	wfR6zHaUG7DmZtTaDSxknNrHDi1KEgvX7Y7NnR7JL7mVCVF7aq
X-Google-Smtp-Source: AGHT+IGTeIP/rqUuipvHHkDhbk0Up5bcjTyiB7vyj0WiNxinfe2KpLJ5dSrjZjejShsIPeV3u+Npcw==
X-Received: by 2002:a17:902:ef4f:b0:295:82d0:9baa with SMTP id d9443c01a7336-29b6bfa8cd3mr45930085ad.17.1763749828890;
        Fri, 21 Nov 2025 10:30:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13e720sm61910715ad.42.2025.11.21.10.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:30:26 -0800 (PST)
Message-ID: <528cacca-7972-4319-b145-bb3ca8bc7756@gmail.com>
Date: Fri, 21 Nov 2025 10:30:23 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251121160640.254872094@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

