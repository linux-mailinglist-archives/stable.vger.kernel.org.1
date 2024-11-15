Return-Path: <stable+bounces-93081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4049CD689
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E5628308B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963C13D297;
	Fri, 15 Nov 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/u8Wnox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77152646
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647881; cv=none; b=upBlcFyYk5/Y8L/qaN/ve1/Rt7/hM4tIBqH9rToL5GUS0mEt9VHpLDltlNuDCyF5N99vCeQDqsSxHtF2uGt/so1n+Lqd/o93SppZ0HpTudogcKCb6g1H0AWPm8FA8K0o4lTI/cVNlv24ze1Uw1MHKWAUh9QwyMxJ2j/DmP72d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647881; c=relaxed/simple;
	bh=Ehk4DKAlNTYCDMCa+Ww5BRZ91YOtiCmTpS6hA99VBx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqyUhohpEpwiwLsDa/HPe/V161pn/L5PvT8U+2p5zsFgChq0uGpI1gaALZwLDrxrFWYEMpE7MzXUpnmMXBQaIq7P9nRrIw0/B7mRFcN+RQufsl8+u7tES+kZ5mXB4y5Ez+yRUP2Cu6aEbnNvu/eIhFRSifuaTZecwXByUedFoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/u8Wnox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B0CC4CECF;
	Fri, 15 Nov 2024 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731647881;
	bh=Ehk4DKAlNTYCDMCa+Ww5BRZ91YOtiCmTpS6hA99VBx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/u8WnoxdI9XUbGKKEPv/U/7DnOMufmGhzbSIg8cooEuFD6sRJ9mVW0AgKofDzJtq
	 oJxfkrutSEh/d875Lh03JoGfM2YWHdScMzagDPIRAmd3bULtlyAADBaqyaDhYvU1KM
	 2zqPlsPhfWRUVdYv0VJ0cNcBSkZeIU49Xk8tC3PA=
Date: Fri, 15 Nov 2024 06:17:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	Yuanzheng Song <songyuanzheng@huawei.com>
Subject: Re: [PATCH stable 5.15] mm/memory: add non-anonymous page check in
 the copy_present_page()
Message-ID: <2024111547-tying-selected-6a5e@gregkh>
References: <20241113163118.54834-2-vbabka@suse.cz>
 <99a77c9a-68ca-4445-bcbf-4681ca20a482@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a77c9a-68ca-4445-bcbf-4681ca20a482@redhat.com>

On Wed, Nov 13, 2024 at 05:45:43PM +0100, David Hildenbrand wrote:
> On 13.11.24 17:31, Vlastimil Babka wrote:
> > From: Yuanzheng Song <songyuanzheng@huawei.com>
> > 
> > The vma->anon_vma of the child process may be NULL because
> > the entire vma does not contain anonymous pages. In this
> > case, a BUG will occur when the copy_present_page() passes
> > a copy of a non-anonymous page of that vma to the
> > page_add_new_anon_rmap() to set up new anonymous rmap.
> > 
> > ------------[ cut here ]------------
> > kernel BUG at mm/rmap.c:1052!
> > Internal error: Oops - BUG: 0 [#1] SMP
> > Modules linked in:
> > CPU: 4 PID: 4652 Comm: test Not tainted 5.15.75 #1
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : __page_set_anon_rmap+0xc0/0xe8
> > lr : __page_set_anon_rmap+0xc0/0xe8
> > sp : ffff80000e773860
> > x29: ffff80000e773860 x28: fffffc13cf006ec0 x27: ffff04f3ccd68000
> > x26: ffff04f3c5c33248 x25: 0000000010100073 x24: ffff04f3c53c0a80
> > x23: 0000000020000000 x22: 0000000000000001 x21: 0000000020000000
> > x20: fffffc13cf006ec0 x19: 0000000000000000 x18: 0000000000000000
> > x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000 x9 : ffffdddc5581377c
> > x8 : 0000000000000000 x7 : 0000000000000011 x6 : ffff2717a8433000
> > x5 : ffff80000e773810 x4 : ffffdddc55400000 x3 : 0000000000000000
> > x2 : ffffdddc56b20000 x1 : ffff04f3c9a48040 x0 : 0000000000000000
> > Call trace:
> >   __page_set_anon_rmap+0xc0/0xe8
> >   page_add_new_anon_rmap+0x13c/0x200
> >   copy_pte_range+0x6b8/0x1018
> >   copy_page_range+0x3a8/0x5e0
> >   dup_mmap+0x3a0/0x6e8
> >   dup_mm+0x78/0x140
> >   copy_process+0x1528/0x1b08
> >   kernel_clone+0xac/0x610
> >   __do_sys_clone+0x78/0xb0
> >   __arm64_sys_clone+0x30/0x40
> >   invoke_syscall+0x68/0x170
> >   el0_svc_common.constprop.0+0x80/0x250
> >   do_el0_svc+0x48/0xb8
> >   el0_svc+0x48/0x1a8
> >   el0t_64_sync_handler+0xb0/0xb8
> >   el0t_64_sync+0x1a0/0x1a4
> > Code: 97f899f4 f9400273 17ffffeb 97f899f1 (d4210000)
> > ---[ end trace dc65e5edd0f362fa ]---
> > Kernel panic - not syncing: Oops - BUG: Fatal exception
> > SMP: stopping secondary CPUs
> > Kernel Offset: 0x5ddc4d400000 from 0xffff800008000000
> > PHYS_OFFSET: 0xfffffb0c80000000
> > CPU features: 0x44000cf1,00000806
> > Memory Limit: none
> > ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> > 
> > This problem has been fixed by the commit <fb3d824d1a46>
> > ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap()
> > and page_try_dup_anon_rmap()"), but still exists in the
> > linux-5.15.y branch.
> > 
> > This patch is not applicable to this version because
> > of the large version differences. Therefore, fix it by
> > adding non-anonymous page check in the copy_present_page().
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> > Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > Hi, this was posted in [1] but seems stable@ was not actually included
> > in the recipients.
> > The 5.10 version [2] was applied as 935a8b62021 but 5.15 is missing.
> > 
> > [1] https://lore.kernel.org/all/20221028075244.3112566-1-songyuanzheng@huawei.com/T/#u
> > [2] https://lore.kernel.org/all/20221028030705.2840539-1-songyuanzheng@huawei.com/
> > 
> > 
> >   mm/memory.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6d058973a97e..4785aecca9a8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -903,6 +903,17 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
> >   	if (likely(!page_needs_cow_for_dma(src_vma, page)))
> >   		return 1;
> > +	/*
> > +	 * The vma->anon_vma of the child process may be NULL
> > +	 * because the entire vma does not contain anonymous pages.
> > +	 * A BUG will occur when the copy_present_page() passes
> > +	 * a copy of a non-anonymous page of that vma to the
> > +	 * page_add_new_anon_rmap() to set up new anonymous rmap.
> > +	 * Return 1 if the page is not an anonymous page.
> > +	 */
> > +	if (!PageAnon(page))
> > +		return 1;
> > +
> >   	new_page = *prealloc;
> >   	if (!new_page)
> >   		return -EAGAIN;
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Now queued up, thanks.

greg k-h

