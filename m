Return-Path: <stable+bounces-141784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840EAAC10A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E091C23A8A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334A2749FA;
	Tue,  6 May 2025 10:13:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D35201270;
	Tue,  6 May 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526413; cv=none; b=UTLdtQA+ycMQ1xYrP1XUdTx8Sv5H+fjvJ5X5A2UByylnEXtebzvdc0JVetEdpGUT/7ShwdumNtbAKFiz4+QN1Jj7eBiyfPF5h26Ac9/SBfLm9d2PJaoOJ7T/6wkOjIqKnoqbwUFrRlPVSmflbtve7OY5+NPfrCiY/XtGn/Kw+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526413; c=relaxed/simple;
	bh=Ot3NyZhKlD2rHDVxFNgfAAOdq0V8+f83kWGglkfAPcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+SrVbhawBaKU/lenzuN6MOiGRDGqDZdSO9HImYW71P2aYnnqG2Jrgn96KXcTFtWkPmpCqaVdr+ORZf9Mqmw/tG73swMFXQE76Af9V7PzM5a7NzpQA0S5EsmS+jseKgOFmltYv7TzS09gyHYLacuiB8D/3/Ln5t+C1X4LvADxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC07C113E;
	Tue,  6 May 2025 03:13:21 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921833F5A1;
	Tue,  6 May 2025 03:13:28 -0700 (PDT)
Message-ID: <5bc7e8a4-c79b-4977-a6a3-720381d13794@arm.com>
Date: Tue, 6 May 2025 11:13:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com,
 shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
 hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com> <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com> <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <aBnOJS6TZxlZiYQ/@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aBnOJS6TZxlZiYQ/@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 09:53, Yeoreum Yun wrote:
> Hi Ryan,
> 
>> On 06/05/2025 09:09, Yeoreum Yun wrote:
>>> Hi Catalin,
>>>
>>>> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
>>>>> Hi Catalin,
>>>>>
>>>>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
>>>>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
>>>>>>>> create_init_idmap() could be called before .bss section initialization
>>>>>>>> which is done in early_map_kernel().
>>>>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
>>>>>>>>
>>>>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
>>>>>>>> and this variable places in .bss section.
>>>>>>>>
>>>>>>>> [...]
>>>>>>>
>>>>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
>>>>>>> comment, thanks!
>>>>>>>
>>>>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
>>>>>>>       https://git.kernel.org/arm64/c/12657bcd1835
>>>>>>
>>>>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
>>>>>> version I have around (Debian sid) fails to boot, gets stuck early on:
>>>>>>
>>>>>> $ clang --version
>>>>>> Debian clang version 19.1.5 (1)
>>>>>> Target: aarch64-unknown-linux-gnu
>>>>>> Thread model: posix
>>>>>> InstalledDir: /usr/lib/llvm-19/bin
>>>>>>
>>>>>> I didn't have time to investigate, disassemble etc. I'll have a look
>>>>>> next week.
>>>>>
>>>>> Just for your information.
>>>>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
>>>>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
>>>>>
>>>>> and the default version for sid is below:
>>>>>
>>>>> $ clang-19 --version
>>>>> Debian clang version 19.1.7 (3)
>>>>> Target: aarch64-unknown-linux-gnu
>>>>> Thread model: posix
>>>>> InstalledDir: /usr/lib/llvm-19/bin
>>>>>
>>>>> When I tested with above version with arm64-linux's for-next/fixes
>>>>> including this patch. it works well.
>>>>
>>>> It doesn't seem to be toolchain related. It fails with gcc as well from
>>>> Debian stable but you'd need some older CPU (even if emulated, e.g.
>>>> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
>>>> Neoverse-N2. Also changing the annotation from __ro_after_init to
>>>> __read_mostly also works.
>>
>> I think this is likely because __ro_after_init is also "ro before init" - i.e.
>> if you try to write to it in the PI code an exception is generated due to it
>> being mapped RO. Looks like early_map_kernel() is writiing to it.
>>
>> I've noticed a similar problem in the past and it would be nice to fix it so
>> that PI code maps __ro_after_init RW.
>>
> 
> Personally, I don't believe this because the create_init_idmap()
> maps the the .rodata section with PAGE_KERNEL pgprot
> from __initdata_begin to _end.

But __ro_after_init is in the ".data..ro_after_init" section, which is in the
.rodata section. That's mapped PAGE_KERNEL_ROX as Ard says.

> 
> and at the mark_readonly() the pgprot is changed to PAGE_KERNEL_RO
> But, arm64_use_ng_mappings is accessed with write before mark_readonly()
> only via smp_cpus_done().
> 
> JFYI here is map information:
> 
> // mark_readlonly() changes to ro perm below ranges:
> ffff800081b30000 g       .rodata	0000000000000000 __start_rodata
> ffff800082560000 g       .rodata.text	0000000000000000 __init_begin
> 
> // create_init_idmap() maps below range with PAGE_KERNEL.
> ffff8000826d0000 g       .altinstructions	0000000000000000 __initdata_begin
> ffff800082eb0000 g       .bss	0000000000000000 _end
> 
> ffff8000824596d0 g     O .rodata	0000000000000001 arm64_use_ng_mappings
> 
> Thanks.
> 
> 
>> Thanks,
>> Ryan
>>
>>>
>>> Thanks to let me know. But still I've failed to reproduce this
>>> on Cortex-a72 and any older cpu on qeum.
>>> If you don't mind, would you share your Kconfig?
>>>
>>>> I haven't debugged it yet but I wonder whether something wants to write
>>>> this variable after it was made read-only (well, I couldn't find any by
>>>> grep'ing the code, so it needs some step-by-step debugging).
>>>>
>>> [...]
>>>
>>> Thanks!
>>>
>>> --
>>> Sincerely,
>>> Yeoreum Yun
>>
> 
> --
> Sincerely,
> Yeoreum Yun


