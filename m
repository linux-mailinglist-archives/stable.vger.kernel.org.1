Return-Path: <stable+bounces-166908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15000B1F43E
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54796245D2
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E6213E85;
	Sat,  9 Aug 2025 10:46:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280871EBA1E;
	Sat,  9 Aug 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754736368; cv=none; b=qtKWoF4jb/2G0i330vG9jqBWqKMazSnYUUHv8v9l9lJQFnbvHaKDsJz01Y+dWFf6kF0misO4/WM6nlAVB+riuabDo3XgB5zUjDCI5dvmcE5NtCGosx+CC+I85UUKwK3yeZHjFYZMvh47g1hwg85IPVpAqEbby2E73Muc1hFtdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754736368; c=relaxed/simple;
	bh=e2W8cpGKcTIuz7KbJANbJAnWgZe54jAwdMNNVIIP9go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojjmcxxuJQHZHensM2siamiktd1uUYYjkxWcahirjYboMPHWLn09TeCI0x7JUhcBPG+SdM9br8tOVDFNA0cgLaj9YqJLvnJBcwR97w7KyND11sBzr69eKujrDNk8f1SuZOlQtroW9A1PgDgyGUH6p9GfY9laILw3XbxjjaPeZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C28143A1C;
	Sat,  9 Aug 2025 10:46:00 +0000 (UTC)
Message-ID: <b0fdcb23-4d68-4d0f-a8ac-2b389a0ce856@ghiti.fr>
Date: Sat, 9 Aug 2025 12:45:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Only allow LTO with CMODEL_MEDANY
To: Nathan Chancellor <nathan@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org>
 <20250808215303.GA3695089@ax162>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250808215303.GA3695089@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeigeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeettedutdekffeigfejfffffefgkefffeetfffgffevffelieeiueffffefhfdtudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpihhnfhhrrgguvggrugdrohhrghenucfkphepudekhedrvddufedrudehgedrudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrddugeefpdhhvghloheplgdutddrudegrddtrddufegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheptghonhhorheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhop
 ehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Nathan,

On 8/8/25 23:53, Nathan Chancellor wrote:
> Ping? This is still getting hit.


This is the second time your patches do not reach the linux-riscv 
mailing list [1] [2], not even my personal mailbox.

[1] 
https://lore.kernel.org/linux-riscv/?q=riscv%3A+Only+allow+LTO+with+CMODEL_MEDANY 

[2] 
https://lore.kernel.org/linux-riscv/?q=riscv%3A+uaccess%3A+Fix+-Wuninitialized+and+-Wshadow+in+__put_user_nocheck

I don't know what's going on, do you have any idea?

I'll pick this up in my fixes branch.

Thanks,

Alex


>
> On Thu, Jul 10, 2025 at 01:25:26PM -0700, Nathan Chancellor wrote:
>> When building with CONFIG_CMODEL_MEDLOW and CONFIG_LTO_CLANG, there is a
>> series of errors due to some files being unconditionally compiled with
>> '-mcmodel=medany', mismatching with the rest of the kernel built with
>> '-mcmodel=medlow':
>>
>>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 899908), and 'i32 1' from vmlinux.a(net-traces.o at 1014628)
>>
>> Only allow LTO to be performed when CONFIG_CMODEL_MEDANY is enabled to
>> ensure there will be no code model mismatch errors. An alternative
>> solution would be disabling LTO for the files with a different code
>> model than the main kernel like some specialized areas of the kernel do
>> but doing that for individual files is not as sustainable than
>> forbidding the combination altogether.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202506290255.KBVM83vZ-lkp@intel.com/
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>>   arch/riscv/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 36061f4732b7..4eee737a050f 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -68,7 +68,7 @@ config RISCV
>>   	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>>   	select ARCH_SUPPORTS_HUGETLBFS if MMU
>>   	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
>> -	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
>> +	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000 && CMODEL_MEDANY
>>   	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
>>   	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>>   	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>>
>> ---
>> base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
>> change-id: 20250710-riscv-restrict-lto-to-medany-f1b7dd5c9bba
>>
>> Best regards,
>> --
>> Nathan Chancellor <nathan@kernel.org>
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

