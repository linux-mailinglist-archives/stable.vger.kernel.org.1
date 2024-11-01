Return-Path: <stable+bounces-89501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40B9B9489
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E661F21DE9
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640751C75EC;
	Fri,  1 Nov 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9RH/af0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1821CB530
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475417; cv=none; b=bnCwy7YCB5ttceDrWfApnjVz+iLejnPI0lc24pD82byMz0/zJHLNN/Dkv0McqbHLoBHiYzt9mivxawgUJfjgXtnhWr7oKAsZmvJQoeic1nSpkqBt4q4wgJAYPZjAfsbnnfR/KpmXxxoUTBER7DbRBd4n7U1CFYEHgmsaHPhQLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475417; c=relaxed/simple;
	bh=jOOyAjCPm76NGvajEHMJrmQl40qqao5bcxtd0CGZbwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFny73HdZPFbAhV9nJB2OgRyysff00dSNwKVvuQo80L2BaQaIzSFNxcWJTerhDjYo7GJTczo0p+hj7TXb06SzYiRgnCjYbboF9AnxutxAQOdfZAXB6O+fWN8xxOyEnPTJmT7iIyN+It/QwLEJjQWEPoDW5vQT0TMzWEtERXmbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9RH/af0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730475414; x=1762011414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOOyAjCPm76NGvajEHMJrmQl40qqao5bcxtd0CGZbwg=;
  b=U9RH/af0iLTWcrQd4hXlPIAO0EDoOyyfQftofKKjS3nblF7vE2j+OeCz
   L5WJap+auy+P8BmHaEnAw9a3rEJUTzl1YfLmwQ1vxWuaEbgesJP20mDgC
   DjjOv8nhieZmM4sFw9n8IIteoC7JzjLqKRZffaOxPPRznTpg0mHIjpESX
   wrKIXjuVhORKCZhSu0La2UbY9z7KGaJkXEcIdpuBv/EkbIG/lE5m66MXU
   5pU+8l8OBotnrOCWzJ+56tZT5EIlzJN4y6mSSgR6L3DYE7nimlwoLkWIs
   QL24M18ReEdoHDMxIATDDAs0mXYN7hciCZ1Y5H7sGvdcCyenhcB7PTHhv
   Q==;
X-CSE-ConnectionGUID: A6d4FwGvSPO9rCmUeRKsJg==
X-CSE-MsgGUID: ndH2jT7eSki9lwUfp1Mutg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34039331"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="34039331"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:36:54 -0700
X-CSE-ConnectionGUID: p4XD9EuBQMaBZ3TUf2GNkg==
X-CSE-MsgGUID: Pim9jKrDQjSsXhdWxaXmrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="88119724"
Received: from rrashetn-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:36:53 -0700
Date: Fri, 1 Nov 2024 08:36:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: stable@vger.kernel.org, andrew.cooper3@citrix.com,
	dave.hansen@linux.intel.com, gregkh@linuxfoundation.org,
	xiexiuqi@huawei.com
Subject: Re: [PATCH stable 5.10.y] x86/bugs: Use code segment selector for
 VERW operand
Message-ID: <20241101152917.qmkdj4nxpangvgzp@desk>
References: <20241101102609.187566-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101102609.187566-1-wangxiongfeng2@huawei.com>

On Fri, Nov 01, 2024 at 06:26:09PM +0800, Xiongfeng Wang wrote:
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> commit e4d2102018542e3ae5e297bc6e229303abff8a0f upstream.
> 
> Robert Gill reported below #GP in 32-bit mode when dosemu software was
> executing vm86() system call:
> 
>   general protection fault: 0000 [#1] PREEMPT SMP
>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>   EIP: restore_all_switch_stack+0xbe/0xcf
>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>   Call Trace:
>    show_regs+0x70/0x78
>    die_addr+0x29/0x70
>    exc_general_protection+0x13c/0x348
>    exc_bounds+0x98/0x98
>    handle_exception+0x14d/0x14d
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
> 
> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
> are enabled. This is because segment registers with an arbitrary user value
> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> following behavior for VERW instruction:
> 
>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> 	   FS, or GS segment limit.
> 
> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> space. Use %cs selector to reference VERW operand. This ensures VERW will
> not #GP for an arbitrary user %ds.
> 
> [ mingo: Fixed the SOB chain. ]
> 
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: stable@vger.kernel.org # 5.10+
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> [xiongfeng: fix conflicts caused by the runtime patch jmp]
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 87e1ff064025..7978d5fe1ce6 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -199,7 +199,16 @@
>   */
>  .macro CLEAR_CPU_BUFFERS
>  	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
> -	verw _ASM_RIP(mds_verw_sel)
> +#ifdef CONFIG_X86_64
> +	verw mds_verw_sel(%rip)
> +#else
> +	/*
> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> +	 * segments may not be usable (vm86 mode), and the stack segment may not
> +	 * be flat (ESPFIX32).
> +	 */
> +	verw %cs:mds_verw_sel
> +#endif
>  .Lskip_verw_\@:
>  .endm

I sent these backports sometime back, seems they were not picked:

5.10: https://lore.kernel.org/stable/f9c84ff992511890556cd52c19c2875b440b98c6.1729538774.git.pawan.kumar.gupta@linux.intel.com/
5.15: https://lore.kernel.org/stable/d2fca828795e4980e0708a179bd60b2a89bc8089.1729538132.git.pawan.kumar.gupta@linux.intel.com/
6.1:  https://lore.kernel.org/stable/7aad4bddc4cf131ee88657da20960c4a714aa756.1729536596.git.pawan.kumar.gupta@linux.intel.com/

