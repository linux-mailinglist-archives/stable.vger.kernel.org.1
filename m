Return-Path: <stable+bounces-41816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E18B6CA5
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9541F212A3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E60524D9;
	Tue, 30 Apr 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PuDeZoEv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ysyvtcs8"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552A46551
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465164; cv=none; b=nAj+MtklO4zmw9h0edTSuPeJW/PlFyX9Oz8hnsGgjWfmTuiNxRbp4qOqyu4BMEMpHEo6YkwvnwxBiff/Pfqhhd30hor+9k5RX7LES0SLzZqxjclb5Dxkvn+0ytwKDO6fxQzyE+S7nOIYaM4/2P1DzlJZQFCaonBX7IbJKu30A4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465164; c=relaxed/simple;
	bh=vf+qr9lw0jufVv0hxIW8drQ7rEcld7mTJrnfbsgH/50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTrfekZjnhTOHa6HqIhv3yp/GYBNhGF/ZA7gwEvtvrCUHynnVKP0NqwL71D5A+g/mB616qUaiSfPDMXYRfTPXbpXdfn1RQ7opqOy/ohFNwrcMGXEp4NFCsPwdfHlxVEiKcm0pl/nexVsuR7dLQO7GMXyicRuxy70Omgya4GEshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=PuDeZoEv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ysyvtcs8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC4FF1380A10;
	Tue, 30 Apr 2024 04:19:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 04:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714465160; x=1714551560; bh=3eUPAVtApu
	kqh9b+L2rbqq4hW7VvW1ve5V0F3FY5jZk=; b=PuDeZoEvH7poqWeZ+PImFzHAn+
	f9rINidGYGO5+rUV/h1dBKPeiScBzSFTIKNBPEIvDahP1f0qOnL8lpofEdCDGa6h
	OkSkCFtG9DAGkf+lim9aud9jetB1s08Tuw2sjBunjLC0R5ywOneL/dO014nC/qZa
	/trYGzGh7Wk+BQ+i5qI3gElrBN27SHHu2IOPHFJs32OQ2Iqw7UK6tOVR9cxe//5w
	LirA0X3NMtISdLpw5iqbZwzXCCwtTb5SMXKYtHq7xD8aN/vWP+ob4nS9ugoOVkdw
	47d5CXU4pApblmS/Vm3UF2ENud5Z/JWyBK7XZlxofZnDlMKpvwCOrTs5nfcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714465160; x=1714551560; bh=3eUPAVtApukqh9b+L2rbqq4hW7Vv
	W1ve5V0F3FY5jZk=; b=Ysyvtcs8KOHnjJEVboWz0UnwBKyH2yaA7CmxPmGFc3t1
	SWvyFDv1/xsx4sAZxYnnAEnfjW7WJr0OGk9uyx2bghlnOzBG+Bah0+UwDEHRyFKU
	scwuHpDYi3FJ7VS+wQvkIJaaMBReGmRfM/yuLcydIYD474i1Ql7q9wDcsTGcsnzI
	W0Trrs8pImTIxCOJhOlsaopK3UTHdXudZSnY1ciJ3VR8maobX+X0fKKplPS4yU9V
	+kuHGrPjNtFcLh2KocrCrLNGCr5uayUevJn4fnK/d7G+6xahWB7OE62Y+20nTVP8
	89wgFwgn3nMTKsnm0UEzN823Ut5lsrOfNfyRQxOTJQ==
X-ME-Sender: <xms:iKkwZjiqgzI1bdj9nk_TTEPhPx6-5WZlzOuxrmK3FYt4wTo6Q8rC3A>
    <xme:iKkwZgDmk5C8_l9jouD6d4YGZb3fcZFKGyAJbIWvrLUJEZytQGvAHvO4LdjFfrTCQ
    JlICye5ghFOqQ>
X-ME-Received: <xmr:iKkwZjFG_W4oCFiAcM5kEeCggYXBkOMpenom_m0er9UoOxevXYrCSJqatgRsK76hqUf4svXPfInPyLQ80WxIV1n3DlHGCFH-fWaJ6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepfffgie
    ekfedvtddtheevtdegieehheefieehtedvkefghffglefhlefhudffhfejnecuffhomhgr
    ihhnpehqvghmuhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:iKkwZgRV9kaP9nwfAwfkRrw-nczNa8sDIxDtw40e6IXfn5aGP0ydXw>
    <xmx:iKkwZgyPN5ty4o6u9MGvlkRnDh61E56duCIOtoZ3fhBcea-yLd_Oag>
    <xmx:iKkwZm5MI8mjeQnRQALU0NiKO3Ke1ElYiuQCvJpUPXNfTr2MViX4Yg>
    <xmx:iKkwZlzwt6aPwK-1D90AECTfGALCGPonq3tjN_rVsz4Z9J6iQWzW4g>
    <xmx:iKkwZvkcvo52Z7xnxRHeyEK-_aL43_foXJwd06Df_Lc7m8-4Ezup_sfa>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 04:19:19 -0400 (EDT)
Date: Tue, 30 Apr 2024 10:19:17 +0200
From: Greg KH <greg@kroah.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <2024043004-entwine-violation-9545@gregkh>
References: <2024042912-visibly-carpool-70bd@gregkh>
 <20240430074146.2489498-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430074146.2489498-1-linmiaohe@huawei.com>

On Tue, Apr 30, 2024 at 03:41:46PM +0800, Miaohe Lin wrote:
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
> index 37288a7f0fa6..8573da127939 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1796,7 +1796,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	 * If vmemmap pages were allocated above, then we need to clear the
>  	 * hugetlb destructor under the hugetlb lock.
>  	 */
> -	if (clear_dtor) {
> +	if (folio_test_hugetlb(folio)) {
>  		spin_lock_irq(&hugetlb_lock);
>  		__clear_hugetlb_destructor(h, page);
>  		spin_unlock_irq(&hugetlb_lock);
> -- 
> 2.33.0
> 
> 

You failed to at least test-build this change, why?  :(


