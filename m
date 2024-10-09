Return-Path: <stable+bounces-83161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0F996178
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B078281AF7
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD7187322;
	Wed,  9 Oct 2024 07:53:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616B185940;
	Wed,  9 Oct 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460382; cv=none; b=XTbCLuMzv9336a1U2TbJ7m3MtqHm3M1+ZTHy1nrzXpkWFtydjpfNimZiz5RvQJHtqDSwVUkiR3a8OqREu9KnQuNpAvujuV149TWqnUDBarmHFABYPLAMNGNnorIshF677l79ge6dWCkXwyCJ02K8IWV3pKytTkPTtxFR0HFsrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460382; c=relaxed/simple;
	bh=+pLjG6qVfCrJjYwRdzb2oD8RD5WYMl+eOpx7RaGqGs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS68tWFlYiVrkATr6nAWq5e6wUZ69HQWiG4Kl1oVCx02pi3LYMfpzrHuXZKTERn2V47V9ipeMb0jy2MJbLwgg4V7fyeQZA54yIXuc+zEbFNvkfcC5qqpacWA6SnnLwpy/CrPr1eTdh/ZThOa04zuYOnymXRpFOMCzKpOjvUSv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D808D1BF208;
	Wed,  9 Oct 2024 07:52:56 +0000 (UTC)
Message-ID: <c5cd71d1-8779-45d9-965d-8459d060857b@ghiti.fr>
Date: Wed, 9 Oct 2024 09:52:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
 <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
 <811ea10e-3bf1-45a5-a407-c09ec5756b48@canonical.com>
 <2d907c14-5b43-446e-9640-efb0fa0ba385@ghiti.fr>
 <a3308767-eb30-446b-8c70-32b36a3075e4@canonical.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <a3308767-eb30-446b-8c70-32b36a3075e4@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 09/10/2024 09:47, Heinrich Schuchardt wrote:
> On 09.10.24 09:34, Alexandre Ghiti wrote:
>> Hi Heinrich,
>>
>> On 01/10/2024 17:24, Heinrich Schuchardt wrote:
>>> On 01.10.24 15:51, Alexandre Ghiti wrote:
>>>> Hi Heinrich,
>>>>
>>>> On 29/09/2024 16:02, Heinrich Schuchardt wrote:
>>>>> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
>>>>> EFI binary does not rely on pages that are both executable and
>>>>> writable.
>>>>>
>>>>> The flag is used by some distro versions of GRUB to decide if the EFI
>>>>> binary may be executed.
>>>>>
>>>>> As the Linux kernel neither has RWX sections nor needs RWX pages for
>>>>> relocation we should set the flag.
>>>>>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Heinrich Schuchardt 
>>>>> <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>>   arch/riscv/kernel/efi-header.S | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/efi-header.S 
>>>>> b/arch/riscv/kernel/efi- header.S
>>>>> index 515b2dfbca75..c5f17c2710b5 100644
>>>>> --- a/arch/riscv/kernel/efi-header.S
>>>>> +++ b/arch/riscv/kernel/efi-header.S
>>>>> @@ -64,7 +64,7 @@ extra_header_fields:
>>>>>       .long    efi_header_end - _start            // SizeOfHeaders
>>>>>       .long    0                    // CheckSum
>>>>>       .short    IMAGE_SUBSYSTEM_EFI_APPLICATION        // Subsystem
>>>>> -    .short    0                    // DllCharacteristics
>>>>> +    .short    IMAGE_DLL_CHARACTERISTICS_NX_COMPAT    // 
>>>>> DllCharacteristics
>>>>>       .quad    0                    // SizeOfStackReserve
>>>>>       .quad    0                    // SizeOfStackCommit
>>>>>       .quad    0                    // SizeOfHeapReserve
>>>>
>>>>
>>>> I don't understand if this fixes something or not: what could go 
>>>> wrong if we don't do this?
>>>>
>>>> Thanks,
>>>>
>>>> Alex
>>>>
>>>
>>>
>>> Hello Alexandre,
>>>
>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/ 
>>> uefi-ca-memory-mitigation-requirements
>>> describes Microsoft's effort to improve security by avoiding memory 
>>> pages that are both executable and writable.
>>>
>>> IMAGE_DLL_CHARACTERISTICS_NX_COMPAT is an assertion by the EFI 
>>> binary that it does not use RWX pages. It may use the 
>>> EFI_MEMORY_ATTRIBUTE_PROTOCOL to set whether a page is writable or 
>>> executable (but not both).
>>>
>>> When using secure boot, compliant firmware will not allow loading a 
>>> binary if the flag is not set.
>>
>>
>> Great, so that's a necessary fix, it will get merged in the next rc 
>> or so:
>>
>> Fixes: cb7d2dd5612a ("RISC-V: Add PE/COFF header for EFI stub")
>
> Thanks for reviewing.
>
> At the time of commit cb7d2dd5612a (2020-10-02) the requirement did 
> not exist. I guess a Fixes: tag is not applicable under these 
> circumstances.


Hmm ok, indeed that would be weird since it is not the culprit, I'll 
remove it and it will simply fail to apply for kernels before this 
commit, no big deal I guess.

Thanks again Heinrich!

Alex


>
> Best regards
>
> Heinrich

