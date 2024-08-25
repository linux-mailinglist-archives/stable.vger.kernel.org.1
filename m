Return-Path: <stable+bounces-70113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC695E461
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 18:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1142EB20FC1
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B515530F;
	Sun, 25 Aug 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aImeBj+X"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CA2E636
	for <stable@vger.kernel.org>; Sun, 25 Aug 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603822; cv=none; b=Ia6ZH1dnSSQ7WMK3AvsnUnMY9e5sxmbUvI2eAyH70mP+u0REteF1wTU0HeaF9fSO1SLWDzajy6BfUJ3ZFiwpg8JSdFIZTrYhMs2gWHDvMMwgu2qWEen0/mdBmQQA3eKXuImZdaydtM1aS5UX0ep9aEIPbqIA/Vniy/2T6gSj5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603822; c=relaxed/simple;
	bh=BKejqw/69aK4ZVOdm6Ak7N9wzVVhqIvVKhZAUikd9Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLSNiKZDkrsPmAB+4/xf981K2BRWSRbjNXxKO6igygJqjjrF7+IGof/EKEYRO9m+GCywWGTnSjR3nNmbBv7KHo8f4X/23b1j31iULmrLKG7GiFYkVnSTvdiWKqP8XhsCiyZ/IGI+DPx7KMT5qyxYGu9Q1Oc9TI2eZueHz15apEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aImeBj+X; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724603818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeMNQe0tBKS3oiPHgYZoJ2ZhIrMsmPhNpyzgPq5fx+k=;
	b=aImeBj+X5Tdaji6fVQN5YhFXRfjZGFHg6IFQPEigGIvNQj9L0IQpiNuD6s3q56H8si4y4B
	T+8p7O6SmEZ4CYduT9EKdmhfKFsUeDH2nfpKUJytaBTEL9/2+88DdoGB8SXa3F7I1TvNGd
	p/z0nWVmYdSlu7tXt7D4aSDIbjGyuBA=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org,
	surenb@google.com,
	linmiaohe@huawei.com
Cc: hao.ge@linux.dev,
	david@redhat.com,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nao.horiguchi@gmail.com,
	pasha.tatashin@soleen.com,
	Hao Ge <gehao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] codetag: debug: mark codetags for poisoned page as empty
Date: Mon, 26 Aug 2024 00:36:49 +0800
Message-Id: <20240825163649.33294-1-hao.ge@linux.dev>
In-Reply-To: <aa6bde95-68e5-4d94-0ce4-c9a1d90fdcdc@linux.dev>
References: <aa6bde95-68e5-4d94-0ce4-c9a1d90fdcdc@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When PG_hwpoison pages are freed,they are treated differently in
free_pages_prepare() and instead of being released they are isolated.

Page allocation tag counters are decremented at this point since the
page is considered not in use. Later on when such pages are released
by unpoison_memory(), the allocation tag counters will be decremented
again and the following warning gets reported:

[  113.930443][ T3282] ------------[ cut here ]------------
[  113.931105][ T3282] alloc_tag was not set
[  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at ./include/linux/alloc_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
[  113.932866][ T3282] Modules linked in: hwpoison_inject fuse ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_man4
[  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 Kdump: loaded Tainted: G        W          6.11.0-rc4-dirty #18
[  113.943003][ T3282] Tainted: [W]=WARN
[  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
[  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
[  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
[  113.946706][ T3282] sp : ffff800087093a10
[  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 x27: ffff80008249f0a0
[  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 x24: 0000000000000000
[  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000000
[  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 x18: ffffffffffffffff
[  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081746210
[  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 x12: 5b5d353031313339
[  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d x9 : 00000000ffffffd0
[  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 x6 : c0000000ffff7fff
[  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 x3 : 0000000000000001
[  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 x0 : 0000000000000000
[  113.957962][ T3282] Call trace:
[  113.958350][ T3282]  pgalloc_tag_sub.part.66+0x154/0x164
[  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
[  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
[  113.960096][ T3282]  __folio_put+0xd4/0x120
[  113.960614][ T3282]  folio_put+0x24/0x50
[  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
[  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
[  113.962436][ T3282]  simple_attr_write_xsigned.isra.34+0xec/0x1cc
[  113.963183][ T3282]  simple_attr_write+0x38/0x48
[  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
[  113.964330][ T3282]  full_proxy_write+0x68/0x98
[  113.964880][ T3282]  vfs_write+0xdc/0x4d0
[  113.965372][ T3282]  ksys_write+0x78/0x100
[  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
[  113.966440][ T3282]  invoke_syscall+0x7c/0x104
[  113.966984][ T3282]  el0_svc_common.constprop.1+0x88/0x104
[  113.967652][ T3282]  do_el0_svc+0x2c/0x38
[  113.968893][ T3282]  el0_svc+0x3c/0x1b8
[  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
[  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
[  113.970511][ T3282] ---[ end trace 0000000000000000 ]---

To fix this, clear the page tag reference after the page got isolated
and accounted for.

Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
Cc: stable@vger.kernel.org # v6.10
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: adjusting the commit message and comments in the code
    based on Suren's suggestions.
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c565de8f48e9..91ace8ca97e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1054,6 +1054,13 @@ __always_inline bool free_pages_prepare(struct page *page,
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
 		pgalloc_tag_sub(page, 1 << order);
+
+		/*
+		 * The page is isolated and accounted for.
+		 * Mark the codetag as empty to avoid accounting error
+		 * when the page is freed by unpoison_memory().
+		 */
+		clear_page_tag_ref(page);
 		return false;
 	}
 
-- 
2.25.1


