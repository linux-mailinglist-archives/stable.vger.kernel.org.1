Return-Path: <stable+bounces-25052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E7869786
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288BD1F246B1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42F9140391;
	Tue, 27 Feb 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkgPu8qW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119813B2B4;
	Tue, 27 Feb 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043728; cv=none; b=X1E8KuqD06xmOBDZsBHmuK8Oo2344vxRNdJTis8iujt/JQshbzMeam2FyMPC73N84is5KDfmjLlE7cOBf2Au4G4wDd/3c0UWwvJam75jqXAOEJdRESVsjpIAqztfnxlbItS6wVbFPheCXsw/fsgHUd3Ze/yHpw70UbRMtCsfHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043728; c=relaxed/simple;
	bh=JCNv8yZPYiQ+ocGTCpZ1G/Be7Loplm78dJMaq++AORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKDBdZnpkIyfdqtXx6ebkDT/DHm7ytqErhySDF3cNLuBVrBtaDDXPObBkQlbX68jHP8Vs8uSSINnZCMi0OcGCZE3SZQt/EWEfMiipz/RJ0OlOq5I4etYMqLr1cf1F99DKiP8OP+gwAzg4ZHaofMogZ9JqvxnpvHv8haV6Q8QIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkgPu8qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A36C433F1;
	Tue, 27 Feb 2024 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043726;
	bh=JCNv8yZPYiQ+ocGTCpZ1G/Be7Loplm78dJMaq++AORg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkgPu8qWOOVNJDoT887Vedt2odp6vGmm2GfVJuRoXxTll9IdPuU5LVF0PsaqT6e0v
	 zbfwHFPt88kqTJsuTiWn9A3jbHUxUfyAMxS/bwaoOn9LJyreox9ecvXp2eoUr2mw5A
	 hFCAZBhRUfWK7MYoH41YB5kG8qU4J4vH35s90Cac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, "GONG, Ruiqi" <gongruiqi1@huawei.com>,
	Michal Hocko <mhocko@suse.com>, GONG@web.codeaurora.org
Subject: [PATCH 5.4 07/84] memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()
Date: Tue, 27 Feb 2024 14:26:34 +0100
Message-ID: <20240227131553.109209736@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.

NOTE: This is a partial backport since we only need the refcnt between
memcg and stock to fix the problem stated below, and in this way
multiple versions use the same code and align with each other.

There was a kernel panic happened on an in-house environment running
3.10, and the same problem was reproduced on 4.19:

general protection fault: 0000 [#1] SMP PTI
CPU: 1 PID: 2085 Comm: bash Kdump: loaded Tainted: G             L    4.19.90+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010 drain_all_stock+0xad/0x140
Code: 00 00 4d 85 ff 74 2c 45 85 c9 74 27 4d 39 fc 74 42 41 80 bc 24 28 04 00 00 00 74 17 49 8b 04 24 49 8b 17 48 8b 88 90 02 00 00 <48> 39 8a 90 02 00 00 74 02 eb 86 48 63 88 3c 01 00 00 39 8a 3c 01
RSP: 0018:ffffa7efc5813d70 EFLAGS: 00010202
RAX: ffff8cb185548800 RBX: ffff8cb89f420160 RCX: ffff8cb1867b6000
RDX: babababababababa RSI: 0000000000000001 RDI: 0000000000231876
RBP: 0000000000000000 R08: 0000000000000415 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8cb186f89040
R13: 0000000000020160 R14: 0000000000000001 R15: ffff8cb186b27040
FS:  00007f4a308d3740(0000) GS:ffff8cb89f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe4d634a68 CR3: 000000010b022000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mem_cgroup_force_empty_write+0x31/0xb0
 cgroup_file_write+0x60/0x140
 ? __check_object_size+0x136/0x147
 kernfs_fop_write+0x10e/0x190
 __vfs_write+0x37/0x1b0
 ? selinux_file_permission+0xe8/0x130
 ? security_file_permission+0x2e/0xb0
 vfs_write+0xb6/0x1a0
 ksys_write+0x57/0xd0
 do_syscall_64+0x63/0x250
 ? async_page_fault+0x8/0x30
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
Modules linked in: ...

It is found that in case of stock->nr_pages == 0, the memcg on
stock->cached could be freed due to its refcnt decreased to 0, which
made stock->cached become a dangling pointer. It could cause a UAF
problem in drain_all_stock() in the following concurrent scenario. Note
that drain_all_stock() doesn't disable irq but only preemption.

CPU1                             CPU2
==============================================================================
stock->cached = memcgA (freed)
                                 drain_all_stock(memcgB)
                                  rcu_read_lock()
                                  memcg = CPU1's stock->cached (memcgA)
                                  (interrupted)
refill_stock(memcgC)
 drain_stock(memcgA)
 stock->cached = memcgC
 stock->nr_pages += xxx (> 0)
                                  stock->nr_pages > 0
                                  mem_cgroup_is_descendant(memcgA, memcgB) [UAF]
                                  rcu_read_unlock()

This problem is, unintentionally, fixed at 5.9, where commit
1a3e1f40962c ("mm: memcontrol: decouple reference counting from page
accounting") adds memcg refcnt for stock. Therefore affected LTS
versions include 4.19 and 5.4.

For 4.19, memcg's css offline process doesn't call drain_all_stock(). so
it's easier for the released memcg to be left on the stock. For 5.4,
although mem_cgroup_css_offline() does call drain_all_stock(), but the
flushing could be skipped when stock->nr_pages happens to be 0, and
besides the async draining could be delayed and take place after the UAF
problem has happened.

Fix this problem by adding (and decreasing) memcg's refcnt when memcg is
put onto (and removed from) stock, just like how commit 1a3e1f40962c
("mm: memcontrol: decouple reference counting from page accounting")
does. After all, "being on the stock" is a kind of reference with
regards to memcg. As such, it's guaranteed that a css on stock would not
be freed.

It's good to mention that refill_stock() is executed in an irq-disabled
context, so the drain_stock() patched with css_put() would not actually
free memcgA until the end of refill_stock(), since css_put() is an RCU
free and it's still in grace period. For CPU2, the access to CPU1's
stock->cached is protected by rcu_read_lock(), so in this case it gets
either NULL from stock->cached or a memcgA that is still good.

Cc: stable@vger.kernel.org      # 4.19 5.4
Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2214,6 +2214,9 @@ static void drain_stock(struct memcg_sto
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
@@ -2221,6 +2224,8 @@ static void drain_stock(struct memcg_sto
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2256,6 +2261,7 @@ static void refill_stock(struct mem_cgro
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;



