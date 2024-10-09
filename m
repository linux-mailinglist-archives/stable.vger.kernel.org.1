Return-Path: <stable+bounces-83159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51C99615C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F1A1F21E90
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B817C9AC;
	Wed,  9 Oct 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qSEB6JYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7C17C7CA
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460053; cv=none; b=onBgWlnh2iWYUTX7emS4+wg/20hqrvPbzRkG6FBjxUcwtj0YtElDvWKHGpmMyy0sCocvbVc3G/osCl3fLXkPir+QqGOeInGt62lCX03sIt6SHSUl+X3Mu2ZR5aTbfcmTGfvzYc2i7z479cYma5HroFmP0jplFjpM29jyGUQ9lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460053; c=relaxed/simple;
	bh=M3yxsY+9PPnN46n9uKc3CclIdd+jGD1Dvn1W9uL3vZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6htpXi02y+dRXlKgFqYvssULbRkAdyoG+fkdIiSL91nvyMQq3L4tMgj3i2POEwTCctZYccY/1B44FNmNtTiA+6sXSn9O3fpZ55sv9l6qqfyk4CSY2TVukQGEAJ3Q5flffhfd2NgWVhi+NjV/fsN8TH6VdST1SDNBeeQw4Z37Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qSEB6JYw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A918A3F4C0
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728460047;
	bh=64u7S06vuCARV2d1jETcvXWsb00VtP72rN9+doc72U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=qSEB6JYwnrPjEMFEmj5Y3lNTuk1ytJW6MYg8GeDc/FDwXRhO+h53JO1ERdjmBK+Oe
	 1HWRNegpBTH+0HrR0u1ohNghqd/SvbpGgKXoxIgnUHsm2qq/gFTCqYlH5+xuK8s5qN
	 cOaP8UF7N6dIe6F5962gDQVSUWrUQtkOBKoF7f9jd/+SNYnWagFcC4qoJn/cK9h2Xa
	 Kod9bqTHZys8KyFl/BaGqD6nNQvXaHv4A2FmvDcxZSrRlePLg9Hg/sYkuut8tRoKMM
	 8J923aKZb80aJ6MkXH5vR2NWbGSN2endcFNxRyCFUD4YNV41jgU92cGIJSl2KO73yd
	 Mfr7lmlJ4zjoQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d3256c0a2so806129f8f.3
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 00:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460047; x=1729064847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64u7S06vuCARV2d1jETcvXWsb00VtP72rN9+doc72U8=;
        b=wn8pjq+3dgJSm0tat1Kpb3D64B+pWp6Es2JJKeRbW1dXLT8KSoCq/UICTCYQN4TDks
         bbkrbRt3cRVBAKjOuHf5WSCTsSTCtB4G1hiQNpqywNGQA/S2LIR8ZONtq2T0WA6Lkt0D
         1a1mbY469QwUXu4vBcZVVvKA4hegFV/gYWc8JhjUyQzcR7gmXJY329qJtMeN9H+oQXnW
         XPM/7wcDpE7eMuABp1ORnyHFt0Dm64KmEKqEtOmmXBdOS+VoEzf/zZIer0tIH/rP6CCe
         o9hBy3Y3Cx7hO6Kt7ObTDhPI3IjHx+UgmtdMetVIAXAWcPm5y90QbbJWcAzELtrksBRg
         6qZw==
X-Forwarded-Encrypted: i=1; AJvYcCXRtEywTvUhLNsADlj7TskcCiIW/1hL7ZyGQQi9Z6VQ3zzcbDICkWzhg+guo31wF3ThHFMekTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92m6mWDMX7pz9U19T4ljYHEwkgGBuVuK0GukkuMiDLvuL+0QO
	CTes3Ii7pkOiCjnJodtyqnzN9juWb6rF+aGJkWFhhVA2aM0BLBNJVbbWqMfCyWVWk0NJOnSNrTL
	zi6nPJIMP0GvBcwoBSVrQvR7n2/sixLpGOvIavZ7kjRQs+mODg600Ormze8GJyw2Gbp5wKQ==
X-Received: by 2002:a5d:5e11:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-37d3bada7a8mr652278f8f.45.1728460047167;
        Wed, 09 Oct 2024 00:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjy0iSj86RuRw+Xk9XUJOj0zHUIng80b/tKMspPKiIgG0uuvHQFCiq0VNFpthVXphITx593A==
X-Received: by 2002:a5d:5e11:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-37d3bada7a8mr652267f8f.45.1728460046709;
        Wed, 09 Oct 2024 00:47:26 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:2015:a58c:a3d4:2675:9367? ([2a02:3035:6e0:2015:a58c:a3d4:2675:9367])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm11658085e9.22.2024.10.09.00.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:47:26 -0700 (PDT)
Message-ID: <a3308767-eb30-446b-8c70-32b36a3075e4@canonical.com>
Date: Wed, 9 Oct 2024 09:47:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
 <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
 <811ea10e-3bf1-45a5-a407-c09ec5756b48@canonical.com>
 <2d907c14-5b43-446e-9640-efb0fa0ba385@ghiti.fr>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <2d907c14-5b43-446e-9640-efb0fa0ba385@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.24 09:34, Alexandre Ghiti wrote:
> Hi Heinrich,
> 
> On 01/10/2024 17:24, Heinrich Schuchardt wrote:
>> On 01.10.24 15:51, Alexandre Ghiti wrote:
>>> Hi Heinrich,
>>>
>>> On 29/09/2024 16:02, Heinrich Schuchardt wrote:
>>>> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
>>>> EFI binary does not rely on pages that are both executable and
>>>> writable.
>>>>
>>>> The flag is used by some distro versions of GRUB to decide if the EFI
>>>> binary may be executed.
>>>>
>>>> As the Linux kernel neither has RWX sections nor needs RWX pages for
>>>> relocation we should set the flag.
>>>>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>   arch/riscv/kernel/efi-header.S | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi- 
>>>> header.S
>>>> index 515b2dfbca75..c5f17c2710b5 100644
>>>> --- a/arch/riscv/kernel/efi-header.S
>>>> +++ b/arch/riscv/kernel/efi-header.S
>>>> @@ -64,7 +64,7 @@ extra_header_fields:
>>>>       .long    efi_header_end - _start            // SizeOfHeaders
>>>>       .long    0                    // CheckSum
>>>>       .short    IMAGE_SUBSYSTEM_EFI_APPLICATION        // Subsystem
>>>> -    .short    0                    // DllCharacteristics
>>>> +    .short    IMAGE_DLL_CHARACTERISTICS_NX_COMPAT    // 
>>>> DllCharacteristics
>>>>       .quad    0                    // SizeOfStackReserve
>>>>       .quad    0                    // SizeOfStackCommit
>>>>       .quad    0                    // SizeOfHeapReserve
>>>
>>>
>>> I don't understand if this fixes something or not: what could go 
>>> wrong if we don't do this?
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>
>>
>> Hello Alexandre,
>>
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/ 
>> uefi-ca-memory-mitigation-requirements
>> describes Microsoft's effort to improve security by avoiding memory 
>> pages that are both executable and writable.
>>
>> IMAGE_DLL_CHARACTERISTICS_NX_COMPAT is an assertion by the EFI binary 
>> that it does not use RWX pages. It may use the 
>> EFI_MEMORY_ATTRIBUTE_PROTOCOL to set whether a page is writable or 
>> executable (but not both).
>>
>> When using secure boot, compliant firmware will not allow loading a 
>> binary if the flag is not set.
> 
> 
> Great, so that's a necessary fix, it will get merged in the next rc or so:
> 
> Fixes: cb7d2dd5612a ("RISC-V: Add PE/COFF header for EFI stub")

Thanks for reviewing.

At the time of commit cb7d2dd5612a (2020-10-02) the requirement did not 
exist. I guess a Fixes: tag is not applicable under these circumstances.

Best regards

Heinrich

