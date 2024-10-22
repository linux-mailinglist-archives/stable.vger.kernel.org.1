Return-Path: <stable+bounces-87655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D699A9605
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 04:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9662836C5
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157D612C81F;
	Tue, 22 Oct 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gArLKNrC"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9E85C47;
	Tue, 22 Oct 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563078; cv=none; b=GawLVADn0PWjzZcQLf+mlGu4+RsT2fLhNsSL+wLHI3Cy94FnT6l5uF/rBEHr5KDDZZtH1k5a2n+ZDm4R8csiqUBHsi0qvF/s+uKPsINef54kWVTC38kfNf/h4WmmsQ37HfPkxYBP3n2Op1iog7vEmk+/25SGfe9y3BP5vEFC0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563078; c=relaxed/simple;
	bh=Xqg//kUTNhwqrus8m/mjkou05l1A6fc8nBiqeLVMsEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhXx0L27sgDb7EfAo9SAkUuUUydDlO/WTuYSPP3JD6UEbgUUoam6Kpe0VJu04QXmi8SuIv91pAlBrRT+nQnpxQXM7ofWNz/Hq3d0BE1naMHc+9UcWs4WxF4/BbvlCyPj38sKrY4Uixu5I+7Q4QBCIY4N5u2Q2e76uTACinnJmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gArLKNrC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 02:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729563072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33cM6FKw0K/vjsCwdtJ9HyCY2bf6tJBVkKFfDfvbkfE=;
	b=gArLKNrC0peponoFd/AB6hdq3NsUyCWm8XfgN5deXJeCl36mCchZXTFvevtmIzr2is3Ave
	y3AZax/TI0TD09FzLEh0ZdU75cT3MfiYzp76FNwhMa3WTzRzsn4lTf+7Xwj6AOjfK/R+n+
	jSzORoOk32bGGA53vv+AhLGnaqMAwQk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZxcJtN-k6U6LfwqG@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <pdu7tddikqiyhd6srgnsrxbsssmwk6u7k35coxhaspcnz57jul@uhm45xe7josy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pdu7tddikqiyhd6srgnsrxbsssmwk6u7k35coxhaspcnz57jul@uhm45xe7josy>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 10:57:35AM -0700, Shakeel Butt wrote:
> On Mon, Oct 21, 2024 at 05:34:55PM GMT, Roman Gushchin wrote:
> > Syzbot reported a bad page state problem caused by a page
> > being freed using free_page() still having a mlocked flag at
> > free_pages_prepare() stage:
> > 
> >   BUG: Bad page state in process syz.0.15  pfn:1137bb
> >   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881137bb870 pfn:0x1137bb
> >   flags: 0x400000000080000(mlocked|node=0|zone=1)
> >   raw: 0400000000080000 0000000000000000 dead000000000122 0000000000000000
> >   raw: ffff8881137bb870 0000000000000000 00000000ffffffff 0000000000000000
> >   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> >   page_owner tracks the page as allocated
> >   page last allocated via order 0, migratetype Unmovable, gfp_mask
> >   0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 3005, tgid
> >   3004 (syz.0.15), ts 61546  608067, free_ts 61390082085
> >    set_page_owner include/linux/page_owner.h:32 [inline]
> >    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
> >    prep_new_page mm/page_alloc.c:1545 [inline]
> >    get_page_from_freelist+0x3008/0x31f0 mm/page_alloc.c:3457
> >    __alloc_pages_noprof+0x292/0x7b0 mm/page_alloc.c:4733
> >    alloc_pages_mpol_noprof+0x3e8/0x630 mm/mempolicy.c:2265
> >    kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
> >    kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
> >    kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5500 [inline]
> >    kvm_dev_ioctl+0x13bb/0x2320 virt/kvm/kvm_main.c:5542
> >    vfs_ioctl fs/ioctl.c:51 [inline]
> >    __do_sys_ioctl fs/ioctl.c:907 [inline]
> >    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
> >    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >    do_syscall_64+0x69/0x110 arch/x86/entry/common.c:83
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   page last free pid 951 tgid 951 stack trace:
> >    reset_page_owner include/linux/page_owner.h:25 [inline]
> >    free_pages_prepare mm/page_alloc.c:1108 [inline]
> >    free_unref_page+0xcb1/0xf00 mm/page_alloc.c:2638
> >    vfree+0x181/0x2e0 mm/vmalloc.c:3361
> >    delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
> >    process_one_work kernel/workqueue.c:3229 [inline]
> >    process_scheduled_works+0xa5c/0x17a0 kernel/workqueue.c:3310
> >    worker_thread+0xa2b/0xf70 kernel/workqueue.c:3391
> >    kthread+0x2df/0x370 kernel/kthread.c:389
> >    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > 
> > A reproducer is available here:
> > https://syzkaller.appspot.com/x/repro.c?x=1437939f980000
> > 
> > The problem was originally introduced by
> > commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
> > clearance"): it was handling focused on handling pagecache
> > and anonymous memory and wasn't suitable for lower level
> > get_page()/free_page() API's used for example by KVM, as with
> > this reproducer.
> > 
> > Fix it by moving the mlocked flag clearance down to
> > free_page_prepare().
> > 
> > The bug itself if fairly old and harmless (aside from generating these
> > warnings).
> > 
> > Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000
> 
> Can you open the access to the syzbot report?
> 

Unfortunately I can't, but I asked the syzkaller team to run the reproducer
against upsteam again and generate a publicly available report.

