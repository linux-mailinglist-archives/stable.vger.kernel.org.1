Return-Path: <stable+bounces-41817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCD8B6CA6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C4E1F2164A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF3524D9;
	Tue, 30 Apr 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNE70eYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229ED46551
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465182; cv=none; b=gOoWxH9CGcPdlRj14bqpfARyezSi/GGMZfm8zceh+zek/HBCp559xVImuDQBS3MnuWkMhGAdK1rgSd4kE5I9HuTYIaTc6TOIl+SjlFJuNttwkT5HPaR9dnF4QwmkEP7618D65leJSgomf5sORh7Ne8c+BBZryExRVQsaA7kzV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465182; c=relaxed/simple;
	bh=USY6VaIFCv+hOylo0S920q7fSDfNEHXJ7JZxBjVH8yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfLuWU0fT6Pt6dSNBWf8IqMvF1ZJRKLGQqiL0A+4uhs9YMda8XaGvEP+x4wpK15J3FusiO5UMfC3prAanuhmQsG3g/HAYJ5j+M197+JlKa+k1R0tQn0opcgSrNfu/5OIRTEf6QgCaTqlxLaMkvHsrJqqkJ5c/kR0oe9/zcNSR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNE70eYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310E9C2BBFC;
	Tue, 30 Apr 2024 08:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714465181;
	bh=USY6VaIFCv+hOylo0S920q7fSDfNEHXJ7JZxBjVH8yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNE70eYp1BgkcqkGkPCi4rpoiDYQnco8NkfP/NHqRd9AsDyVLoJvOxvjvrMtBPSiG
	 mf8S0/teVDaf5wUTyHlcs1t6ePp0cIz4safBcp5Yma5iYlE96jqS+kX2jvOLIAz6Ja
	 dGJ/v5okEGwB3qI5URhXBiswDmBioliu4jFD5xcI=
Date: Tue, 30 Apr 2024 10:19:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <2024043020-dropper-create-2cf5@gregkh>
References: <2024042914-rectified-grab-1bbb@gregkh>
 <20240430074331.2500025-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430074331.2500025-1-linmiaohe@huawei.com>

On Tue, Apr 30, 2024 at 03:43:31PM +0800, Miaohe Lin wrote:
> When I did memory failure tests recently, below warning occurs:
> 
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
> Modules linked in: mce_inject hwpoison_inject
> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__lock_acquire+0xccb/0x1ca0
> RSP: 0018:ffffa7a1c7fe3bd0 EFLAGS: 00000082
> RAX: 0000000000000000 RBX: eb851eb853975fcf RCX: ffffa1ce5fc1c9c8
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffffa1ce5fc1c9c0
> RBP: ffffa1c6865d3280 R08: ffffffffb0f570a8 R09: 0000000000009ffb
> R10: 0000000000000286 R11: ffffffffb0f2ad50 R12: ffffa1c6865d3d10
> R13: ffffa1c6865d3c70 R14: 0000000000000000 R15: 0000000000000004
> FS:  00007ff9f32aa740(0000) GS:ffffa1ce5fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff9f3134ba0 CR3: 00000008484e4000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  lock_acquire+0xbe/0x2d0
>  _raw_spin_lock_irqsave+0x3a/0x60
>  hugepage_subpool_put_pages.part.0+0xe/0xc0
>  free_huge_folio+0x253/0x3f0
>  dissolve_free_huge_page+0x147/0x210
>  __page_handle_poison+0x9/0x70
>  memory_failure+0x4e6/0x8c0
>  hard_offline_page_store+0x55/0xa0
>  kernfs_fop_write_iter+0x12c/0x1d0
>  vfs_write+0x380/0x540
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xbc/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff9f3114887
> RSP: 002b:00007ffecbacb458 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007ff9f3114887
> RDX: 000000000000000c RSI: 0000564494164e10 RDI: 0000000000000001
> RBP: 0000564494164e10 R08: 00007ff9f31d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007ff9f321b780 R14: 00007ff9f3217600 R15: 00007ff9f3216a00
>  </TASK>
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  panic+0x326/0x350
>  check_panic_on_warn+0x4f/0x50
>  __warn+0x98/0x190
>  report_bug+0x18e/0x1a0
>  handle_bug+0x3d/0x70
>  exc_invalid_op+0x18/0x70
>  asm_exc_invalid_op+0x1a/0x20
> RIP: 0010:__lock_acquire+0xccb/0x1ca0
> RSP: 0018:ffffa7a1c7fe3bd0 EFLAGS: 00000082
> RAX: 0000000000000000 RBX: eb851eb853975fcf RCX: ffffa1ce5fc1c9c8
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffffa1ce5fc1c9c0
> RBP: ffffa1c6865d3280 R08: ffffffffb0f570a8 R09: 0000000000009ffb
> R10: 0000000000000286 R11: ffffffffb0f2ad50 R12: ffffa1c6865d3d10
> R13: ffffa1c6865d3c70 R14: 0000000000000000 R15: 0000000000000004
>  lock_acquire+0xbe/0x2d0
>  _raw_spin_lock_irqsave+0x3a/0x60
>  hugepage_subpool_put_pages.part.0+0xe/0xc0
>  free_huge_folio+0x253/0x3f0
>  dissolve_free_huge_page+0x147/0x210
>  __page_handle_poison+0x9/0x70
>  memory_failure+0x4e6/0x8c0
>  hard_offline_page_store+0x55/0xa0
>  kernfs_fop_write_iter+0x12c/0x1d0
>  vfs_write+0x380/0x540
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xbc/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff9f3114887
> RSP: 002b:00007ffecbacb458 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007ff9f3114887
> RDX: 000000000000000c RSI: 0000564494164e10 RDI: 0000000000000001
> RBP: 0000564494164e10 R08: 00007ff9f31d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007ff9f321b780 R14: 00007ff9f3217600 R15: 00007ff9f3216a00
>  </TASK>
> 
> After git bisecting and digging into the code, I believe the root cause is
> that _deferred_list field of folio is unioned with _hugetlb_subpool field.
> In __update_and_free_hugetlb_folio(), folio->_deferred_list is
> initialized leading to corrupted folio->_hugetlb_subpool when folio is
> hugetlb.  Later free_huge_folio() will use _hugetlb_subpool and above
> warning happens.
> 
> But it is assumed hugetlb flag must have been cleared when calling
> folio_put() in update_and_free_hugetlb_folio().  This assumption is broken
> due to below race:
> 
> CPU1					CPU2
> dissolve_free_huge_page			update_and_free_pages_bulk
>  update_and_free_hugetlb_folio		 hugetlb_vmemmap_restore_folios
> 					  folio_clear_hugetlb_vmemmap_optimized
>   clear_flag = folio_test_hugetlb_vmemmap_optimized
>   if (clear_flag) <-- False, it's already cleared.
>    __folio_clear_hugetlb(folio) <-- Hugetlb is not cleared.
>   folio_put
>    free_huge_folio <-- free_the_page is expected.
> 					 list_for_each_entry()
> 					  __folio_clear_hugetlb <-- Too late.
> 
> Fix this issue by checking whether folio is hugetlb directly instead of
> checking clear_flag to close the race window.
> 
> Link: https://lkml.kernel.org/r/20240419085819.1901645-1-linmiaohe@huawei.com
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a17950160395..3a0f6b78f925 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1782,7 +1782,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  	 * If vmemmap pages were allocated above, then we need to clear the
>  	 * hugetlb destructor under the hugetlb lock.
>  	 */
> -	if (clear_dtor) {
> +	if (folio_test_hugetlb(folio)) {
>  		spin_lock_irq(&hugetlb_lock);
>  		__clear_hugetlb_destructor(h, folio);
>  		spin_unlock_irq(&hugetlb_lock);
> -- 
> 2.33.0
> 
> 

Again, this breaks the build, did you not test it?  Always do so before
sending it out :(

thanks,

greg k-h

