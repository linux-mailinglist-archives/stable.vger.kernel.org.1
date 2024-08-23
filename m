Return-Path: <stable+bounces-69942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEB95C556
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD48283424
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0847345B;
	Fri, 23 Aug 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dpEap9qM"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8004A08
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394078; cv=none; b=s/LmcDeRoJKLVh1aQtNZsn28Q1b49hEfxhxPkvHdPpnjHgi0RK9ZAUZo/bSrqYo6uAhyeHZQWYnO3rznHRY5UKG5JRW4OTfj9lu2alrfkOqGwxIi1fsm35Y1DYjTpnU4uQOX0LTV2Uwt1E5HqJIVNwAcApKHc3GpOCiUGMOjFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394078; c=relaxed/simple;
	bh=mGGcx9FbBMYK5oO+D4u2W2uRIgvqYmfnpAUS3Rhj7AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuJm3Ys0GTUU7dtlvuoX0/Bvq4S6XpJJJZa21YKFdQnIPHyfGRkqfXglZ1CWdte0m7qFF+UURrcdcmvfmxWC/IwFbYgZ+Hk4dcqXRC66apofndShQTOslfhAxjhHsWBT+bI6ObqjHM6RkySov6T3hxCK3f2CzuplPyEwWGOOPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dpEap9qM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724394071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaLM4r9F0h2ORPAVWBkvfTjggq9qCherBRJzxkFeUE8=;
	b=dpEap9qMcxSRukFGYOSK/BUA0w+Jn01PBwnuCRlDTxbMd0pa732PBGJbPJO0hFsgLeQGMq
	YY6ziKvt2jDkfkPZX0f6QvIzfo7EWVPBMALQRnSbIK4ppBE+TxSfRHNk2Zme/g+dee2Sc7
	1m0ohJ3jCynxnaTQ4yWekBGiG7wxb2I=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	kent.overstreet@linux.dev,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pasha.tatashin@soleen.com,
	surenb@google.com
Cc: hao.ge@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <gehao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] codetag: debug: mark codetags for poisoned page as empty
Date: Fri, 23 Aug 2024 14:20:02 +0800
Message-Id: <20240823062002.21165-1-hao.ge@linux.dev>
In-Reply-To: <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
References: <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

The PG_hwpoison page will be caught and isolated on the entrance to
the free buddy page pool.

But for poisoned pages which software injected errors,
we can reclaim it through unpoison_memory.

So mark codetags for it as empty,just like when a page
is first added to the buddy system.

It was detected by [1] and the following WARN occurred:

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

Link [1]: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise11.c

Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() helper function")
Cc: stable@vger.kernel.org # v6.10
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c565de8f48e9..7ccd2157d092 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1054,6 +1054,14 @@ __always_inline bool free_pages_prepare(struct page *page,
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
 		pgalloc_tag_sub(page, 1 << order);
+
+		/*
+		 * For poisoned pages which software injected errors,
+		 * we can reclaim it through unpoison_memory.
+		 * so mark codetags for it as empty,
+		 * just like when a page is first added to the buddy system.
+		 */
+		clear_page_tag_ref(page);
 		return false;
 	}
 
-- 
2.25.1


