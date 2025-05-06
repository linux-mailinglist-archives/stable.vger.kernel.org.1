Return-Path: <stable+bounces-141781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B53AAC0EE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68A23A18CE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14927467C;
	Tue,  6 May 2025 10:08:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6641F4E34;
	Tue,  6 May 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526126; cv=none; b=sTfuxzsSsaselJfbgxzSuU/g3Quaw2bGxzZMSUmq7WUyQ9dfPO6ajN7N4mSK6t9bUejugZR9nULvN1kas1522dikKdb8Y+qHzeys1+XUtVErCl5a8t32qacfIUDUrH8w9D+k6yk3YJPdpq9/mHNhvg9w/mP68g2QPX1ray5iDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526126; c=relaxed/simple;
	bh=U/sHJ0rllBZTo4yrsxKaCC6IiisHumKHo3x1yJ7lEeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir9NA/mYm+/c9sOQOJHWd3DhI7kXBHBM/anU1fn/Jr/nmqp5r9KhkhcMIMrk9y3wIcimP1v0vxlzuMK6RPvQI4NIQPZs/e1LnWGdkq3pU8aAxxCx0PidmotJpUJi8tYk21ojeNBQYPhBnWw73K6UIzkiOF5ImsBaMTAHO/4ZExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4E2113E;
	Tue,  6 May 2025 03:08:34 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799073F5A1;
	Tue,  6 May 2025 03:08:40 -0700 (PDT)
Message-ID: <aa4241ce-02ea-4931-b60c-5ad0deba202d@arm.com>
Date: Tue, 6 May 2025 11:08:38 +0100
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com,
 shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
 hardevsinh.palaniya@siliconsignals.io, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com> <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com> <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 10:41, Ard Biesheuvel wrote:
> On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
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
> 
> Indeed.
> 
>> I've noticed a similar problem in the past and it would be nice to fix it so
>> that PI code maps __ro_after_init RW.
>>
> 
> The issue is that the store occurs via the ID map, which only consists
> of one R-X and one RW- section. I'm not convinced that it's worth the
> hassle to relax this.
> 
> If moving the variable to .data works, then let's just do that.

Yeah, fair enough.



