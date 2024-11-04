Return-Path: <stable+bounces-89591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295B9BAA16
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 02:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470CC1C2145B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 01:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944A14D2B1;
	Mon,  4 Nov 2024 01:12:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DD14E2FD
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730682758; cv=none; b=S0al8yIyCeFMr/KXwGtpBqnI7Iatvga/owA0zYALsoOHB9NA6d9RJO+oK5jKe9geHMcfpyZFLubMbuVuVMWkfhADahI4Er75VoPAwb7T7MzzSo2b0v2nvziAUtnWua0GL3z4bXknnoBJZwE3vJ+evcWIMqVG1ngu+cZ6quZ1Mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730682758; c=relaxed/simple;
	bh=dU+VrSMOtOD0kKCabpKr4pbAHN47boL72Ku1FGj7LX4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UPf9rYyUyGNvFYXCh4uYbYCJShb7fVM13lgFu+LZ+RTCgphs3Ss9DtCNsH3eAn1AJZwZlfgc7omQz86HNB2tWVPfHdmwExodQnwRcFWaOeDbJgmGzKg0Kl+kcl9Dkw32ypzKBkOLlNurAvvFu42w2vbptXO/SSbeiI5jH+lJ7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XhYLV2LrXz2FbqB;
	Mon,  4 Nov 2024 09:10:42 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F876140120;
	Mon,  4 Nov 2024 09:12:20 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by kwepemd100023.china.huawei.com
 (7.221.188.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 09:12:19 +0800
Subject: Re: [PATCH stable 5.10.y] x86/bugs: Use code segment selector for
 VERW operand
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: <stable@vger.kernel.org>, <andrew.cooper3@citrix.com>,
	<dave.hansen@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<xiexiuqi@huawei.com>
References: <20241101102609.187566-1-wangxiongfeng2@huawei.com>
 <20241101152917.qmkdj4nxpangvgzp@desk>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <ea611502-1c9d-6d8b-0fc0-056ce3c06658@huawei.com>
Date: Mon, 4 Nov 2024 09:12:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241101152917.qmkdj4nxpangvgzp@desk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100023.china.huawei.com (7.221.188.33)

Hi, Pawan

On 2024/11/1 23:36, Pawan Gupta wrote:
> On Fri, Nov 01, 2024 at 06:26:09PM +0800, Xiongfeng Wang wrote:
>> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>
>> commit e4d2102018542e3ae5e297bc6e229303abff8a0f upstream.
>>
>> Robert Gill reported below #GP in 32-bit mode when dosemu software was
>> executing vm86() system call:
>>
>>   general protection fault: 0000 [#1] PREEMPT SMP
>>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>>   EIP: restore_all_switch_stack+0xbe/0xcf
>>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>>   Call Trace:
>>    show_regs+0x70/0x78
>>    die_addr+0x29/0x70
>>    exc_general_protection+0x13c/0x348
>>    exc_bounds+0x98/0x98
>>    handle_exception+0x14d/0x14d
>>    exc_bounds+0x98/0x98
>>    restore_all_switch_stack+0xbe/0xcf
>>    exc_bounds+0x98/0x98
>>    restore_all_switch_stack+0xbe/0xcf
>>
>> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
>> are enabled. This is because segment registers with an arbitrary user value
>> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
>> following behavior for VERW instruction:
>>
>>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
>> 	   FS, or GS segment limit.
>>
>> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
>> space. Use %cs selector to reference VERW operand. This ensures VERW will
>> not #GP for an arbitrary user %ds.
>>
>> [ mingo: Fixed the SOB chain. ]
>>
>> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
>> Reported-by: Robert Gill <rtgill82@gmail.com>
>> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: stable@vger.kernel.org # 5.10+
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
>> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Suggested-by: Brian Gerst <brgerst@gmail.com>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> [xiongfeng: fix conflicts caused by the runtime patch jmp]
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index 87e1ff064025..7978d5fe1ce6 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -199,7 +199,16 @@
>>   */
>>  .macro CLEAR_CPU_BUFFERS
>>  	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
>> -	verw _ASM_RIP(mds_verw_sel)
>> +#ifdef CONFIG_X86_64
>> +	verw mds_verw_sel(%rip)
>> +#else
>> +	/*
>> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
>> +	 * segments may not be usable (vm86 mode), and the stack segment may not
>> +	 * be flat (ESPFIX32).
>> +	 */
>> +	verw %cs:mds_verw_sel
>> +#endif
>>  .Lskip_verw_\@:
>>  .endm
> 
> I sent these backports sometime back, seems they were not picked:
> 
> 5.10: https://lore.kernel.org/stable/f9c84ff992511890556cd52c19c2875b440b98c6.1729538774.git.pawan.kumar.gupta@linux.intel.com/
> 5.15: https://lore.kernel.org/stable/d2fca828795e4980e0708a179bd60b2a89bc8089.1729538132.git.pawan.kumar.gupta@linux.intel.com/
> 6.1:  https://lore.kernel.org/stable/7aad4bddc4cf131ee88657da20960c4a714aa756.1729536596.git.pawan.kumar.gupta@linux.intel.com/

Thanks for let me know !

Thanks,
Xiongfeng

> 
> .
> 

