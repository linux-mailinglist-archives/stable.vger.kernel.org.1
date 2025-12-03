Return-Path: <stable+bounces-199899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496ABCA1311
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D81317BEE7
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE832F762;
	Wed,  3 Dec 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW/rXcXI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941C32ED3B
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784298; cv=none; b=BneIDqltQkMdVRui2UYz+hLKuyo/LceLXgxyir6xsnJiapRfvUPG5X3UfOmb2q8P/V//mCtalDAVeDbt3ZLIJtX4f1PFAw7CPaKG8d8/1SyLAGjpBjVIdZjLhmQ2V8qdz3/SseTyLindBs38Ee7+IyzdJVXXk5nvxt70mP1dLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784298; c=relaxed/simple;
	bh=m/HSIYITcLsa5oWRvzEUVbcH+VnZ2fyECYfRLYWel6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQVekGVNERos9ZXn/6xedDGHcYJIZC0l0lFjNYakyFsDlJUI0p4T7h0IwwbVGGE3eXkuC3v83rc5otVyGjLuOwiypPM4MqVuwwMfFabTcA+XWneiBLa2K/naLSiQtFE825Pe5fqlSEKcL6SAV9d0DDHrJKNlAn0iVp93Iyl+5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW/rXcXI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed9c19248bso399121cf.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764784293; x=1765389093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE9b7xWLRQ2Du7armuVSfl/uQrcZAwxDIzraZOeyv+I=;
        b=AW/rXcXIhiYEE1+0jRVIUJ0xnekveyr4hrUTaHHtoNv5sNmXJjX2X1kj0dsWlnyLF1
         mTYT00jdhdkwhFJXGeYJkV4pb6+EMXK7aKPA5H8ahPWFM4Pue3o81dgznQYZkDZwwFyJ
         G3Q4gKvpsfa4LGJ/irnGH/ZWav1JhX+5+n6XGO/tOoNeocEBSNPSqLEJUwHPOekTtdv/
         Z8ZPrvIQANEsoyyU4wKDjgn94YXpTviAkbJZiqED3O9n6MScXXqHf5kNc6uIYuE41J/b
         Q8haaokmegjSnJaNSwHZVIhQ6xBpTRz+W9KJhEEuvM+lFTcva5QmTualdSx10T5xeSe2
         b2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764784293; x=1765389093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE9b7xWLRQ2Du7armuVSfl/uQrcZAwxDIzraZOeyv+I=;
        b=vPtH/5ioPotShdOhuAHOZYTD46xEA6ihBwL2YzE/AuwCJI7wXltKfR9lt7yvBs9uO1
         snU5Dpyp3qoVbZG3+wHgNDV4nkctKTJQr06ebASB54gdVq1n/AxF2YHG0QhbNFmDKXGU
         FHGhpTKLrGjo+SQwioxvyoylQaoJaNvLmkSw8Wf2l0ZVJFFoBQwpWIulmn9gFMxjOiFR
         hwrxuQ6U1d8vZWgTuW3KCE6ncFwpoXGAGcnyG2N0eJXR5pJkQ0gwgzv2COhMBpH1xToK
         I2GI52r+aMVIP1i7MgahvADPh3Ca0NMtRlEL7rlYyFRy+AG4rsbgxAaPqMl/AgVA/eyG
         sO3w==
X-Forwarded-Encrypted: i=1; AJvYcCXdwG5ctBgyzoA2buJ1JLjMdCjySLqgzj6JK6ZCVdrxQCH+WEsqVtAOj2Lr5VwVAR3cWLLoSU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKvIxPyLTYoT7YJLRs/sLf7ClVNfI8t9GDC/yddyVyuOHZMLT
	qusJn65WYxnAiF8qa0TYFk/z/VnUv4KqV+XLztSWbH1l+8BGElUIWBQb
X-Gm-Gg: ASbGncs2/ELeOhogoXONu5QYJzsj+xDXASynb9QyuDZrDqOSs2y39wH0Pq5yYh6h4kU
	vQf25rFgNVN7ilEFG07VRDD81kY3teWa89Nii+vcZTjs6CfqXBLfTGz6Kvd81os739Ul22lp838
	yuirr6e6qIJzy4uoTQcc8VRMc2pWAQC9s1YjQh+5q9g1XkGMJbQTutP6egklk+UMnAKO9qZgeKw
	HwNN1gVsgZz2xzt1qkyzOT14fbNEqYeFnPdtlB/WDQ+9/O6mLj+DPPO9MdMUVWMSOD7O/IsWUni
	q3H/c02/yXogkfSu02Ta7zFBkqTHvBSWfJB1oRVWzhnDmLjcq/qoS4zAh2s//IO+9az/GJf/8we
	ARdkCWbbrj9AVeSrdWfhD2WliQ3+xuayDnfxPAZZYCNZKxNAbRW0zRWQBwJp17eMj9axKF7mSsa
	6EifRfdhZSyXAVoBxsf6A9PpcT4oc0nJHn5GwPxQ==
X-Google-Smtp-Source: AGHT+IEodQvzyGrpchEKcNgajKI5gYLkGco3SSXaT8+tavu+JXqnc5pwPkx7UsTe6eyZcxNixBiaPQ==
X-Received: by 2002:a05:622a:cb:b0:4ee:2721:9ec9 with SMTP id d75a77b69052e-4f0176b6076mr43450351cf.73.1764784292514;
        Wed, 03 Dec 2025 09:51:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2fd00c0sm118897111cf.13.2025.12.03.09.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 09:51:31 -0800 (PST)
Message-ID: <d9adb2a6-47cd-468a-bb6a-de11aff80659@gmail.com>
Date: Wed, 3 Dec 2025 09:51:28 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/392] 5.15.197-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152414.082328008@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.197 release.
> There are 392 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.197-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

MIPS fails to build with the same errors as 5.10 with:

arch/mips/mm/tlb-r4k.c: In function 'r4k_tlb_uniquify':
arch/mips/mm/tlb-r4k.c:591:17: error: passing argument 1 of 
'memblock_free' makes integer from pointer without a cast 
[-Werror=int-conversion]
    memblock_free(tlb_vpns, tlb_vpn_size);
                  ^~~~~~~~
In file included from arch/mips/mm/tlb-r4k.c:15:
./include/linux/memblock.h:107:31: note: expected 'phys_addr_t' {aka 
'unsigned int'} but argument is of type 'long unsigned int *'
  int memblock_free(phys_addr_t base, phys_addr_t size);
                    ~~~~~~~~~~~~^~~~
cc1: all warnings being treated as errors


-- 
Florian

