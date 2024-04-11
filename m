Return-Path: <stable+bounces-38063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236508A0A6B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C7F1C21711
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180F13FD66;
	Thu, 11 Apr 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZedflA2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9E524A
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821584; cv=none; b=inFe5UErfPQysZSsYwIrSIPsX2bKP3PeEdc+nYL+PU7fki/CyFLZ1JVQacCJtFlMpEfyNZYuudN5R6m/p6sL7A/SrkulLVu4OAn3R8ya9StYypQLp8XW5q8FmV5lrZt/HNF0Rgd6wncAh7JCqrm48G+bMe5p/5ABk3GHoxO4KgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821584; c=relaxed/simple;
	bh=xx70iLLYKBH73ht5VbcZgaaIfUOSNixtnl7hLP+fJ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i02Td5iF0dHTMSyJJ9zgCMaLeKXU3gu6HzZRx92tmQdEyzVSlm/2HsjV06QtAD1xaVXMw7gJB36F4dnItOtFhhQa2W9NU0wD+OQZ6EGv9SGSsR6n070sjJQc2Tqh8m+Y4REye9ttmj779C+1cVTtWMjRB9RGLCg7+UtYl2qqbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZedflA2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A423DC433C7;
	Thu, 11 Apr 2024 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712821584;
	bh=xx70iLLYKBH73ht5VbcZgaaIfUOSNixtnl7hLP+fJ7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZedflA2ujMdZfhFX08M4Ufi9h/hn7g+qKZrWlDzMLpZ+vDhokmtaJeP2dYFUNnflE
	 LNW/jVNCY0ZCCErjsGDSbII+qo06orm0ISNRFGNLPmB0i7Kyh/QMh4ivESLQkpNai1
	 BlkwRXSqCHL/h9CJGeZmi4TRHHJANk+uwP5sxe4o=
Date: Thu, 11 Apr 2024 09:46:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org, Wupeng Ma <mawupeng1@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4.19.y] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-ID: <2024041112-moneywise-petroleum-a3a3@gregkh>
References: <2024040851-hamster-canary-7b07@gregkh>
 <20240410095131.201579-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410095131.201579-1-david@redhat.com>

On Wed, Apr 10, 2024 at 11:51:31AM +0200, David Hildenbrand wrote:
> PAT handling won't do the right thing in COW mappings: the first PTE (or,
> in fact, all PTEs) can be replaced during write faults to point at anon
> folios.  Reliably recovering the correct PFN and cachemode using
> follow_phys() from PTEs will not work in COW mappings.
> 
> Using follow_phys(), we might just get the address+protection of the anon
> folio (which is very wrong), or fail on swap/nonswap entries, failing
> follow_phys() and triggering a WARN_ON_ONCE() in untrack_pfn() and
> track_pfn_copy(), not properly calling free_pfn_range().
> 
> In free_pfn_range(), we either wouldn't call memtype_free() or would call
> it with the wrong range, possibly leaking memory.
> 
> To fix that, let's update follow_phys() to refuse returning anon folios,
> and fallback to using the stored PFN inside vma->vm_pgoff for COW mappings
> if we run into that.
> 
> We will now properly handle untrack_pfn() with COW mappings, where we
> don't need the cachemode.  We'll have to fail fork()->track_pfn_copy() if
> the first page was replaced by an anon folio, though: we'd have to store
> the cachemode in the VMA to make this work, likely growing the VMA size.
> 
> For now, lets keep it simple and let track_pfn_copy() just fail in that
> case: it would have failed in the past with swap/nonswap entries already,
> and it would have done the wrong thing with anon folios.
> 
> Simple reproducer to trigger the WARN_ON_ONCE() in untrack_pfn():
> 
> <--- C reproducer --->
>  #include <stdio.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
>  #include <liburing.h>
> 
>  int main(void)
>  {
>          struct io_uring_params p = {};
>          int ring_fd;
>          size_t size;
>          char *map;
> 
>          ring_fd = io_uring_setup(1, &p);
>          if (ring_fd < 0) {
>                  perror("io_uring_setup");
>                  return 1;
>          }
>          size = p.sq_off.array + p.sq_entries * sizeof(unsigned);
> 
>          /* Map the submission queue ring MAP_PRIVATE */
>          map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
>                     ring_fd, IORING_OFF_SQ_RING);
>          if (map == MAP_FAILED) {
>                  perror("mmap");
>                  return 1;
>          }
> 
>          /* We have at least one page. Let's COW it. */
>          *map = 0;
>          pause();
>          return 0;
>  }
> <--- C reproducer --->
> 
> On a system with 16 GiB RAM and swap configured:
>  # ./iouring &
>  # memhog 16G
>  # killall iouring
> [  301.552930] ------------[ cut here ]------------
> [  301.553285] WARNING: CPU: 7 PID: 1402 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0xf4/0x100
> [  301.553989] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_g
> [  301.558232] CPU: 7 PID: 1402 Comm: iouring Not tainted 6.7.5-100.fc38.x86_64 #1
> [  301.558772] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebu4
> [  301.559569] RIP: 0010:untrack_pfn+0xf4/0x100
> [  301.559893] Code: 75 c4 eb cf 48 8b 43 10 8b a8 e8 00 00 00 3b 6b 28 74 b8 48 8b 7b 30 e8 ea 1a f7 000
> [  301.561189] RSP: 0018:ffffba2c0377fab8 EFLAGS: 00010282
> [  301.561590] RAX: 00000000ffffffea RBX: ffff9208c8ce9cc0 RCX: 000000010455e047
> [  301.562105] RDX: 07fffffff0eb1e0a RSI: 0000000000000000 RDI: ffff9208c391d200
> [  301.562628] RBP: 0000000000000000 R08: ffffba2c0377fab8 R09: 0000000000000000
> [  301.563145] R10: ffff9208d2292d50 R11: 0000000000000002 R12: 00007fea890e0000
> [  301.563669] R13: 0000000000000000 R14: ffffba2c0377fc08 R15: 0000000000000000
> [  301.564186] FS:  0000000000000000(0000) GS:ffff920c2fbc0000(0000) knlGS:0000000000000000
> [  301.564773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.565197] CR2: 00007fea88ee8a20 CR3: 00000001033a8000 CR4: 0000000000750ef0
> [  301.565725] PKRU: 55555554
> [  301.565944] Call Trace:
> [  301.566148]  <TASK>
> [  301.566325]  ? untrack_pfn+0xf4/0x100
> [  301.566618]  ? __warn+0x81/0x130
> [  301.566876]  ? untrack_pfn+0xf4/0x100
> [  301.567163]  ? report_bug+0x171/0x1a0
> [  301.567466]  ? handle_bug+0x3c/0x80
> [  301.567743]  ? exc_invalid_op+0x17/0x70
> [  301.568038]  ? asm_exc_invalid_op+0x1a/0x20
> [  301.568363]  ? untrack_pfn+0xf4/0x100
> [  301.568660]  ? untrack_pfn+0x65/0x100
> [  301.568947]  unmap_single_vma+0xa6/0xe0
> [  301.569247]  unmap_vmas+0xb5/0x190
> [  301.569532]  exit_mmap+0xec/0x340
> [  301.569801]  __mmput+0x3e/0x130
> [  301.570051]  do_exit+0x305/0xaf0
> ...
> 
> Link: https://lkml.kernel.org/r/20240403212131.929421-3-david@redhat.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
> Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
> Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
> Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221)
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/pat.c | 50 ++++++++++++++++++++++++++++++++++-------------
>  mm/memory.c       |  4 ++++
>  2 files changed, 40 insertions(+), 14 deletions(-)

All now queued up, thanks.

greg k-h

