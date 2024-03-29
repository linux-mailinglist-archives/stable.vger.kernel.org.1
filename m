Return-Path: <stable+bounces-33722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBB891F47
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2505F1F30729
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300E13EFED;
	Fri, 29 Mar 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv4/ooyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B36657B5
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717874; cv=none; b=EkuoL8V0vjrnj1klKemIIVZfCIUHLvG1d9dWB5InQn34o0SWCy8gjbgZ02PoVadxqrY/sWPgyS29kfLCCACZ7abrwfT7a7IsjHlpOaMjp7uSbdvwYdUsUsComaYwOWyew5Euc2Y/PDfluQ3N1NCHL5JpzTjEKMhYgjuKOC078Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717874; c=relaxed/simple;
	bh=tfAamDZFkBArXYQk+xOnlxZPSBAXsr2AZe1zzCWuRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWSAoKgqgmguPPNp9pf4vYo5qGxx5sLE3CNpTLr8DsLQgqAFv/XCWvtZkh4weg6z2/4q+GaXl7E/RalG5exy5hx7xsgz9/A0UlEz+USvjw7d3c0F5483Dgr+2BlJeoWRkZSN6F4bsUZ8FqpjX0lWdyvvOfHErWAy9zD/mYBVFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv4/ooyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98185C43390;
	Fri, 29 Mar 2024 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711717874;
	bh=tfAamDZFkBArXYQk+xOnlxZPSBAXsr2AZe1zzCWuRFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cv4/ooyzB1FifJ0Lh4uMXZk2HiK1eNmbAWEDtgDZeqcI3gtxtTuAAnu/Z8+98rGQq
	 8Suk4YqGR9htLuDuCem31QmJEE6+7JqecK3/pIjeIRi+6NZkEBndqpm6FwPOWlSDhL
	 TL/ieTVqqUvJLUMaRnFBWD9QGI3fAQ0Rf6QIwiLk=
Date: Fri, 29 Mar 2024 14:11:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq
 resources in device shutdown path.
Message-ID: <2024032918-shortlist-product-cce8@gregkh>
References: <20240312150713.3231723-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312150713.3231723-1-imran.f.khan@oracle.com>

On Wed, Mar 13, 2024 at 02:07:13AM +1100, Imran Khan wrote:
> [ Upstream commit 9fb9eb4b59acc607e978288c96ac7efa917153d4 ]

No it is not.

> 
> systems, using igb driver, crash while executing poweroff command
> as per following call stack:
> 
> crash> bt -a
> PID: 62583    TASK: ffff97ebbf28dc40  CPU: 0    COMMAND: "poweroff"
>  #0 [ffffa7adcd64f8a0] machine_kexec at ffffffffa606c7c1
>  #1 [ffffa7adcd64f900] __crash_kexec at ffffffffa613bb52
>  #2 [ffffa7adcd64f9d0] panic at ffffffffa6099c45
>  #3 [ffffa7adcd64fa50] oops_end at ffffffffa603359a
>  #4 [ffffa7adcd64fa78] die at ffffffffa6033c32
>  #5 [ffffa7adcd64faa8] do_trap at ffffffffa60309a0
>  #6 [ffffa7adcd64faf8] do_error_trap at ffffffffa60311e7
>  #7 [ffffa7adcd64fbc0] do_invalid_op at ffffffffa6031320
>  #8 [ffffa7adcd64fbd0] invalid_op at ffffffffa6a01f2a
>     [exception RIP: free_msi_irqs+408]
>     RIP: ffffffffa645d248  RSP: ffffa7adcd64fc88  RFLAGS: 00010286
>     RAX: ffff97eb1396fe00  RBX: 0000000000000000  RCX: ffff97eb1396fe00
>     RDX: ffff97eb1396fe00  RSI: 0000000000000000  RDI: 0000000000000000
>     RBP: ffffa7adcd64fcb0   R8: 0000000000000002   R9: 000000000000fbff
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff98c047af4720
>     R13: ffff97eb87cd32a0  R14: ffff97eb87cd3000  R15: ffffa7adcd64fd57
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #9 [ffffa7adcd64fc80] free_msi_irqs at ffffffffa645d0fc
>  #10 [ffffa7adcd64fcb8] pci_disable_msix at ffffffffa645d896
>  #11 [ffffa7adcd64fce0] igb_reset_interrupt_capability at ffffffffc024f335 [igb]
>  #12 [ffffa7adcd64fd08] __igb_shutdown at ffffffffc0258ed7 [igb]
>  #13 [ffffa7adcd64fd48] igb_shutdown at ffffffffc025908b [igb]
>  #14 [ffffa7adcd64fd70] pci_device_shutdown at ffffffffa6441e3a
>  #15 [ffffa7adcd64fd98] device_shutdown at ffffffffa6570260
>  #16 [ffffa7adcd64fdc8] kernel_power_off at ffffffffa60c0725
>  #17 [ffffa7adcd64fdd8] SYSC_reboot at ffffffffa60c08f1
>  #18 [ffffa7adcd64ff18] sys_reboot at ffffffffa60c09ee
>  #19 [ffffa7adcd64ff28] do_syscall_64 at ffffffffa6003ca9
>  #20 [ffffa7adcd64ff50] entry_SYSCALL_64_after_hwframe at ffffffffa6a001b1
> 
> This happens because igb_shutdown has not yet freed up allocated irqs and
> free_msi_irqs finds irq_has_action true for involved msi irqs here and this
> condition triggers BUG_ON.
> 
> Freeing irqs before proceeding further in igb_clear_interrupt_scheme,
> fixes this problem.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> 
> This issue does not happen in v5.17 or later kernel versions because
> 'commit 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")',
> explicitly frees up MSI based irqs and hence indirectly fixes this issue
> as well. Also this is why I have mentioned this commit as equivalent
> upstream commit. But this upstream change itself is dependent on a bunch
> of changes starting from 'commit 288c81ce4be7 ("PCI/MSI: Move code into a 
> separate directory")', which refactored msi driver into multiple parts.
> So another way of fixing this issue would be to backport these patches and
> get this issue implictly fixed.
> Kindly let me know if my current patch is not acceptable and in that case
> will it be fine if I backport the above mentioned msi driver refactoring
> patches to LST.

What would the real patch series look like?  How bad is the backports?
Try that out first please.

thanks,

greg k-h

