Return-Path: <stable+bounces-163395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE58B0AAB0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 21:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229AF4E6DF0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083518E20;
	Fri, 18 Jul 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkD65MH2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA351547F2;
	Fri, 18 Jul 2025 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866914; cv=none; b=fIsx0aHoRuqm4YCojhFczPil7v++nNKVn6JGUC76RShQ4/iMS26QoTnm3J4LXhxV4B18pFepF5Hl6LDMH2PcE+y0hz/zc4rSbEcg57frn/H3tfBKmB9A4I28OktThq6v1Fcz0Ly+IHt1UYP3yxu79othaxaSC3V4FW1xyncgmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866914; c=relaxed/simple;
	bh=O1D+TB4i5fQHwMunOAC9P1z7yVAZnSMu2q/3jxcGGXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXH6HVro//BoPV2eih0JPYbV5zK9Wl1TGQ4QafS3tpNU+v4xwNCG5W7o07el+/jum6rD1HIo3VJRZvcFbVm2df+TuXHi8oC3J9FSNu92Q07njUI675pCr/8F5BmUYG5ssK0oMHIaDiEp8DEq3kM/IWKXKwcuHWUrqeVkskSx544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkD65MH2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b27c1481bso1638842b3a.2;
        Fri, 18 Jul 2025 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752866913; x=1753471713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cH5sJvHS1uO/3t5jCi2uFruDY/oe5mJBgjnDbAXMUPk=;
        b=QkD65MH27Asv+EtVopFJL5obTdzwQ1xs7gHW3TqN2nQwtsgQBXNx9ONcVRDJB2KmdN
         HbA7FQp8++DgHe9IrPnfIlioXJSGJmJt8NAOibytZgPfHoIguIS2wgUE0XS9KSuZTC0e
         eP7TiLWBkU0WEc7XhNbP5uCOBEDXojTRPs0MCUBhw2wKJibXaH1zLon6vxkcDkC0vOH5
         PPfgSvKn//tgsP6UewRYeF+9A9L3uurWNC1LJg3AwqkNTTWRVxWTdsHrKaVqkvdLjSHe
         xJzPFj2ge6eDtWeg7OuhZz8u1ls0pIckmwrqEyqpo/y1VOMOxIJ/DG6W40TBrGbX64Re
         a4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752866913; x=1753471713;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH5sJvHS1uO/3t5jCi2uFruDY/oe5mJBgjnDbAXMUPk=;
        b=VHMsqegoEJuKW5e+5KYKqtmySBZLR+meXSA/v6V8SQQ5i87WMV6Cdye+hEYHhwBQHJ
         HybmkevY4sAz9NlTd993Dktpm65u8//x8Ufo+a8FsZ33mUqXQR22FDj3nfnGxuNLv6NW
         OoIX7C6QgPeLibfsn7P1mYmE35F5GNhIXwPRBHR5x8cqydmGL0YrMENXdN0/NvK8EABp
         7LMKiEEaMYIkOXck0RA+MCNtciwFoCBEBRAIWWK7nVAas2+v8691mGpyYNadgeuAlmsN
         n619iz6hRRb4AUq3L7uuWmv2zoWwXp93CN7y6+jeG8cYxpDU03T1B2tuFYYoT9Wc6BEA
         JqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcV2KINlI729hw8LwbkAuDpA8C2dDOhEd3BnykCtiOgFhGn9HiHvu6XKbqHis5PTZITQQPTL9c8QkdcJ8=@vger.kernel.org, AJvYcCXgd3rXTyXia5nbyqFy8QL4gO3UzBQyXE+tlzLy5skurNIhTZqIfj5evqNVPBD3aEY2c7ubnaNt@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUxs5b4yYac2tERWZvwzGZvyEjhmuiJPUoSAe3toHwoC0u2zJ
	pkhNw57G4vjId3ty8jLkFb1hMAQG5aw3Lq/3BJoRyDbQ7jx2+84oVtBo
X-Gm-Gg: ASbGncssZXvAV+A7bMkCCTKnyLd/XXGo2RXY6o73wzKkFoOkVa8VnhLK2Ipl/05DR5E
	dCbPHa5d6Yk+krzX+2NM9OUYPpynCvxyhmuZH1zKDo2x/N9MQd8BcCDj1s/zdFe33IAHfbBPeKd
	mZ63xqpwNFztaGdqdO60VfaKY/EqYc3n1mOOkuZldJmP2tJfXaaQ6VkyE7WtwpXEXT0mpYBZeb4
	wsvKyDD6XzekfMNlFnYPMn8UOvrO2yw8GRHd7yKvGi10E4lA0/iTjNx96CET4v1esqi6LUqnUSD
	W4tNtPPOsDsP8TFF55Y3bEfL7HJKMEWUFo1q3rf7hn+PQxljH2HT1dhes9/CpvsFXkxE5doHldi
	m/noxsHQy+qUK/ZcR20YzIGLFW4QPwLfZCmPy+aLg/MqgBR0MSYJxLF3PLWjeBHj+126jWEA=
X-Google-Smtp-Source: AGHT+IG8qlq82B+AIq7C46cKEStshxtPfPkP/Y1y3IbPD1wLbAoNipxskgMD5DK61EEDCtMSolSuew==
X-Received: by 2002:a05:6a00:ac0b:b0:757:51d:9dd9 with SMTP id d2e1a72fcca58-757051daa11mr14362912b3a.17.1752866912527;
        Fri, 18 Jul 2025 12:28:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d55eesm1658401b3a.55.2025.07.18.12.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:28:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9db843ac-85f8-4dd8-8121-59376a8a97d5@roeck-us.net>
Date: Fri, 18 Jul 2025 12:28:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/78] 5.15.189-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250715163547.992191430@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715163547.992191430@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:29 +0000.
> Anything received after that time might be too late.
> 

nios2 builds have been broken for several releases now.


In file included from include/linux/pgtable.h:6,
                  from include/linux/mm.h:33,
                  from include/linux/pid_namespace.h:7,
                  from include/linux/ptrace.h:10,
                  from arch/nios2/kernel/asm-offsets.c:9:
arch/nios2/include/asm/pgtable.h: In function 'ptep_set_access_flags':
arch/nios2/include/asm/pgtable.h:286:17: error: implicit declaration of function 'set_ptes'; did you mean 'set_pte'?

This affects v5.15.y and older. I'll stop testing this architecture for
the affected branches.

Guenter


