Return-Path: <stable+bounces-127317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCAA77966
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E233AA53A
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CE1EEA48;
	Tue,  1 Apr 2025 11:16:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2251E5B7E;
	Tue,  1 Apr 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506181; cv=none; b=rb8KjGwHAXfdNaXgt0wxduxYREjVbthKFIr9cItslyeZ68JDrZu9FObVZglvHdzv+pS+CgEvj0ZMBZs/zJ9IRK6zoBLw3z/qim3V2Ezit603E5n/Ma1arAG7Cad5kIvawrfKUywpJUo2R0S+kMx5Du7qu2Ia2XQJ7dVZZ+iqfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506181; c=relaxed/simple;
	bh=zJ3kLovwcr8+0e7SOkpB718W/KjQg3TgUmzwOppugwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXpoGokqPXCCCd/jLFsY6TuKE7klpaREjxzgyhhxVva5xbt6TU8ukxOujJf1rAYQ3rfGaD+FNuvalWsBxEswbjgWYtlGOG1T9tkztcwoQiC7XbDG0eGWL3h7Vm3696b9Ytt9zdBwX1Wp6lZI4qcE2HFGhDGhAj8foMk+IrXeoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8742A14BF;
	Tue,  1 Apr 2025 04:16:20 -0700 (PDT)
Received: from [10.163.46.196] (unknown [10.163.46.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A15103F694;
	Tue,  1 Apr 2025 04:16:14 -0700 (PDT)
Message-ID: <03b4456f-de06-42c6-91e0-4ea21de665ad@arm.com>
Date: Tue, 1 Apr 2025 16:46:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: Don't call NULL in do_compat_alignment_fixup
To: Angelos Oikonomopoulos <angelos@igalia.com>,
 linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, stable@vger.kernel.org
References: <20250401085150.148313-1-angelos@igalia.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250401085150.148313-1-angelos@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/25 14:21, Angelos Oikonomopoulos wrote:
> do_alignment_t32_to_handler only fixes up alignment faults for specific
> instructions; it returns NULL otherwise. When that's the case, signal to
> the caller that it needs to proceed with the regular alignment fault
> handling (i.e. SIGBUS). Without this patch, we get:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   Mem abort info:
>     ESR = 0x0000000086000006
>     EC = 0x21: IABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x06: level 2 translation fault
>   user pgtable: 4k pages, 48-bit VAs, pgdp=00000800164aa000
>   [0000000000000000] pgd=0800081fdbd22003, p4d=0800081fdbd22003, pud=08000815d51c6003, pmd=0000000000000000
>   Internal error: Oops: 0000000086000006 [#1] SMP
>   Modules linked in: cfg80211 rfkill xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat br_netfilter veth nvme_fa>
>    libcrc32c crc32c_generic raid0 multipath linear dm_mod dax raid1 md_mod xhci_pci nvme xhci_hcd nvme_core t10_pi usbcore igb crc64_rocksoft crc64 crc_t10dif crct10dif_generic crct10dif_ce crct10dif_common usb_common i2c_algo_bit i2c>
>   CPU: 2 PID: 3932954 Comm: WPEWebProcess Not tainted 6.1.0-31-arm64 #1  Debian 6.1.128-1
>   Hardware name: GIGABYTE MP32-AR1-00/MP32-AR1-00, BIOS F18v (SCP: 1.08.20211002) 12/01/2021
>   pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : 0x0
>   lr : do_compat_alignment_fixup+0xd8/0x3dc
>   sp : ffff80000f973dd0
>   x29: ffff80000f973dd0 x28: ffff081b42526180 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>   x23: 0000000000000004 x22: 0000000000000000 x21: 0000000000000001
>   x20: 00000000e8551f00 x19: ffff80000f973eb0 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>   x11: 0000000000000000 x10: 0000000000000000 x9 : ffffaebc949bc488
>   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>   x5 : 0000000000400000 x4 : 0000fffffffffffe x3 : 0000000000000000
>   x2 : ffff80000f973eb0 x1 : 00000000e8551f00 x0 : 0000000000000001
>   Call trace:
>    0x0
>    do_alignment_fault+0x40/0x50
>    do_mem_abort+0x4c/0xa0
>    el0_da+0x48/0xf0
>    el0t_32_sync_handler+0x110/0x140
>    el0t_32_sync+0x190/0x194
>   Code: bad PC value
>   ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Angelos Oikonomopoulos <angelos@igalia.com>
> Fixes: 3fc24ef32d3b93 ("arm64: compat: Implement misalignment fixups for multiword loads")
> Cc: stable@vger.kernel.org

Commit message looks good and attributed commit ID in "Fixes: "
tag also checks out.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/compat_alignment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/compat_alignment.c b/arch/arm64/kernel/compat_alignment.c
> index deff21bfa680..b68e1d328d4c 100644
> --- a/arch/arm64/kernel/compat_alignment.c
> +++ b/arch/arm64/kernel/compat_alignment.c
> @@ -368,6 +368,8 @@ int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
>  		return 1;
>  	}
>  
> +	if (!handler)
> +		return 1;
>  	type = handler(addr, instr, regs);
>  
>  	if (type == TYPE_ERROR || type == TYPE_FAULT)

