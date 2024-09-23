Return-Path: <stable+bounces-76935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14C97F16D
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE041C217BA
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFABC19F42B;
	Mon, 23 Sep 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eA0VMEbQ"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1C1CA84;
	Mon, 23 Sep 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121471; cv=none; b=DncUnhu8AnPCfR5vkMXRRkrmCL6Ujf+7CWp7EwpCPlUWyzUNFjphRDAfPKDwueyasYYccqQZvMRGwqYbCG5PqUTdH7xo578zYe7549ApKe/sSQUfiB3OAQplv3Rh7xbLuEJZZx9eBzwWP341Gie82U1YABLJz0i+5lAUgO1NR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121471; c=relaxed/simple;
	bh=j3GLpyNYImX/2q/swXZVeynGwkFbrkAuEiTemEHwQfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv7zn1NmRNVi56oi1ad6wZyuOtQ/vDcMzibgKRXmf6DTcpqDmP/jKo5Yr+ZecyMaI52Jff3l7mOVfa2pm8svbReTGLU0EMb3HVIgZAfRVhSpSg7F7BLNHvYx8rYUM49VAU85jspcQOlxh32lNuDJyNQBkzCb2S//XdoyFlQez5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eA0VMEbQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XVNIglgCnWlcmQeWjuludc9gerVDM3DtscyXtyevQA0=; b=eA0VMEbQv8Vvzhas7owyR9f0xB
	IUJVLeEU3befr/ZRhRs/Udxp1DkOmE24hGCK0FIXDFGqOIgs1TNiUSopHQXYc7BfEc0gYkG8Oyyxu
	3QFeE45ki5oa8ERVOLe7Z4bJ9SRKFYGD7ImywD1/BzajFU2LuPwbMqHzUQ4ASO4RlaGKqE1tjwdlr
	qCJWl0p8P7KWOkSinAKMpU4gztoIrwI4qwytpm4nGQlYfE7tCVQPmg74LfpR6a0ot85vXuqMViTlX
	8NWDM08ZSRnlxZgmOYiQhi3dUbg4lFjApyFUKnTtUH8laP8gq90JErScf/2W4McmFCcFLB3oVXQcj
	okDBN9Ww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sspBb-0000000GstZ-16he;
	Mon, 23 Sep 2024 19:57:31 +0000
Date: Mon, 23 Sep 2024 20:57:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
Message-ID: <ZvHIK80Hxd6DK2jw@casper.infradead.org>
References: <20240922151708.33949-1-aha310510@gmail.com>
 <31e90b74-8bd1-4bfe-9384-8d479735d2be@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e90b74-8bd1-4bfe-9384-8d479735d2be@redhat.com>

On Mon, Sep 23, 2024 at 05:56:40PM +0200, David Hildenbrand wrote:
> On 22.09.24 17:17, Jeongjun Park wrote:
> > I found a report from syzbot [1]
> > 
> > When __folio_test_movable() is called in migrate_folio_unmap() to read
> > folio->mapping, a data race occurs because the folio is read without
> > protecting it with folio_lock.
> > 
> > This can cause unintended behavior because folio->mapping is initialized
> > to a NULL value. Therefore, I think it is appropriate to call
> > __folio_test_movable() under the protection of folio_lock to prevent
> > data-race.
> 
> We hold a folio reference, would we really see PAGE_MAPPING_MOVABLE flip?
> Hmm

No; this shows a page cache folio getting truncated.  It's fine; really
a false alarm from the tool.  I don't think the proposed patch
introduces any problems, but it's all a bit meh.

> Even a racing __ClearPageMovable() would still leave PAGE_MAPPING_MOVABLE
> set.
> 
> > [1]
> > 
> > ==================================================================
> > BUG: KCSAN: data-race in __filemap_remove_folio / migrate_pages_batch
> > 
> > write to 0xffffea0004b81dd8 of 8 bytes by task 6348 on cpu 0:
> >   page_cache_delete mm/filemap.c:153 [inline]
> >   __filemap_remove_folio+0x1ac/0x2c0 mm/filemap.c:233
> >   filemap_remove_folio+0x6b/0x1f0 mm/filemap.c:265
> >   truncate_inode_folio+0x42/0x50 mm/truncate.c:178
> >   shmem_undo_range+0x25b/0xa70 mm/shmem.c:1028
> >   shmem_truncate_range mm/shmem.c:1144 [inline]
> >   shmem_evict_inode+0x14d/0x530 mm/shmem.c:1272
> >   evict+0x2f0/0x580 fs/inode.c:731
> >   iput_final fs/inode.c:1883 [inline]
> >   iput+0x42a/0x5b0 fs/inode.c:1909
> >   dentry_unlink_inode+0x24f/0x260 fs/dcache.c:412
> >   __dentry_kill+0x18b/0x4c0 fs/dcache.c:615
> >   dput+0x5c/0xd0 fs/dcache.c:857
> >   __fput+0x3fb/0x6d0 fs/file_table.c:439
> >   ____fput+0x1c/0x30 fs/file_table.c:459
> >   task_work_run+0x13a/0x1a0 kernel/task_work.c:228
> >   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >   syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >   do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > read to 0xffffea0004b81dd8 of 8 bytes by task 6342 on cpu 1:
> >   __folio_test_movable include/linux/page-flags.h:699 [inline]
> >   migrate_folio_unmap mm/migrate.c:1199 [inline]
> >   migrate_pages_batch+0x24c/0x1940 mm/migrate.c:1797
> >   migrate_pages_sync mm/migrate.c:1963 [inline]
> >   migrate_pages+0xff1/0x1820 mm/migrate.c:2072
> >   do_mbind mm/mempolicy.c:1390 [inline]
> >   kernel_mbind mm/mempolicy.c:1533 [inline]
> >   __do_sys_mbind mm/mempolicy.c:1607 [inline]
> >   __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
> >   __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
> >   x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:238
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > value changed: 0xffff888127601078 -> 0x0000000000000000
> 
> Note that this doesn't flip PAGE_MAPPING_MOVABLE, just some unrelated bits.
> 
> > 
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 7e2a5e5ab217 ("mm: migrate: use __folio_test_movable()")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >   mm/migrate.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 923ea80ba744..e62dac12406b 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1118,7 +1118,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >   	int rc = -EAGAIN;
> >   	int old_page_state = 0;
> >   	struct anon_vma *anon_vma = NULL;
> > -	bool is_lru = !__folio_test_movable(src);
> > +	bool is_lru;
> >   	bool locked = false;
> >   	bool dst_locked = false;
> > @@ -1172,6 +1172,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >   	locked = true;
> >   	if (folio_test_mlocked(src))
> >   		old_page_state |= PAGE_WAS_MLOCKED;
> > +	is_lru = !__folio_test_movable(src);
> 
> 
> Looks straight forward, though
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

