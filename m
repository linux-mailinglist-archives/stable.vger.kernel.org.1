Return-Path: <stable+bounces-87614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FB9A7190
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F801F2346F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526C1F4FA6;
	Mon, 21 Oct 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xU0NQeuF"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E521F4FB5
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533466; cv=none; b=jQi9AXjbcIpKHfdtbkXrSwXjtH/efIcCW04MsQyv0P7Ck3AOhI8Xfc5QAi5tryJUxxwuDG0V/K8eIC930/t0ALX18pBhTPNieKWDIcm+ppVZF10x0taTcdklcYvyfJmM9epltYcOZuEV5dJ65UP1YeGfBkG8MgS94A4BZRpevl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533466; c=relaxed/simple;
	bh=ykltuD/ISwba8fAgh+W7+zqUPctjSlh3wUX/gNmLJ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg4fcEsnrkGILssv9UeEhl5Jb3EHoJuDrptOpc/6ikfXHRqQvM6tZAjICXTAdz5IsWb3P3EDA1QUqdbt/2CibzOPqdHdrE0XyZIyhkFWhMaDtDFx+u1RdBJGV30ci9asT+SJm6usfSgqmxT38kPfTwI8VnCA+boaOj9wCspZXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xU0NQeuF; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Oct 2024 10:57:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729533462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgUgtE2nbHu0jbUYd7lK1pAQWkPQaUgbx1VksnZptik=;
	b=xU0NQeuF+r822oYJuRq2qZer4XWftar82dt65Iq58ThWtQpkf+k8hJBA9zqEIrF3VRLz+L
	aL4tTXRZfxP6YnsfFljN/fmYmls5KErKxV6YDOYJnnJhj9Z2zEegcuWNE3RT2KR/LI+D9I
	0Xr/KKFF3MiaQKTf8XLDgauGkjGYjOQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <pdu7tddikqiyhd6srgnsrxbsssmwk6u7k35coxhaspcnz57jul@uhm45xe7josy>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021173455.2691973-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 05:34:55PM GMT, Roman Gushchin wrote:
> Syzbot reported a bad page state problem caused by a page
> being freed using free_page() still having a mlocked flag at
> free_pages_prepare() stage:
> 
>   BUG: Bad page state in process syz.0.15  pfn:1137bb
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881137bb870 pfn:0x1137bb
>   flags: 0x400000000080000(mlocked|node=0|zone=1)
>   raw: 0400000000080000 0000000000000000 dead000000000122 0000000000000000
>   raw: ffff8881137bb870 0000000000000000 00000000ffffffff 0000000000000000
>   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>   page_owner tracks the page as allocated
>   page last allocated via order 0, migratetype Unmovable, gfp_mask
>   0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 3005, tgid
>   3004 (syz.0.15), ts 61546  608067, free_ts 61390082085
>    set_page_owner include/linux/page_owner.h:32 [inline]
>    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>    prep_new_page mm/page_alloc.c:1545 [inline]
>    get_page_from_freelist+0x3008/0x31f0 mm/page_alloc.c:3457
>    __alloc_pages_noprof+0x292/0x7b0 mm/page_alloc.c:4733
>    alloc_pages_mpol_noprof+0x3e8/0x630 mm/mempolicy.c:2265
>    kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
>    kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
>    kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5500 [inline]
>    kvm_dev_ioctl+0x13bb/0x2320 virt/kvm/kvm_main.c:5542
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:907 [inline]
>    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0x69/0x110 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   page last free pid 951 tgid 951 stack trace:
>    reset_page_owner include/linux/page_owner.h:25 [inline]
>    free_pages_prepare mm/page_alloc.c:1108 [inline]
>    free_unref_page+0xcb1/0xf00 mm/page_alloc.c:2638
>    vfree+0x181/0x2e0 mm/vmalloc.c:3361
>    delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
>    process_one_work kernel/workqueue.c:3229 [inline]
>    process_scheduled_works+0xa5c/0x17a0 kernel/workqueue.c:3310
>    worker_thread+0xa2b/0xf70 kernel/workqueue.c:3391
>    kthread+0x2df/0x370 kernel/kthread.c:389
>    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> A reproducer is available here:
> https://syzkaller.appspot.com/x/repro.c?x=1437939f980000
> 
> The problem was originally introduced by
> commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
> clearance"): it was handling focused on handling pagecache
> and anonymous memory and wasn't suitable for lower level
> get_page()/free_page() API's used for example by KVM, as with
> this reproducer.
> 
> Fix it by moving the mlocked flag clearance down to
> free_page_prepare().
> 
> The bug itself if fairly old and harmless (aside from generating these
> warnings).
> 
> Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000

Can you open the access to the syzbot report?


