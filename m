Return-Path: <stable+bounces-227540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDiXKINGvWlZ8gIAu9opvQ
	(envelope-from <stable+bounces-227540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:07:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332402DAAE7
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27319315A3A5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0EE3B7B92;
	Fri, 20 Mar 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="DJ6M2okg"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84723B8BA7;
	Fri, 20 Mar 2026 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011888; cv=none; b=nrJyQuraFqrkYrNPCvoik1K8hNKpGLKGSjBqPHOR9dUyYg9slp9Gn5WNLZIwvO75eGlohWfbio5qkQVSoK4LKn3jvkGS4p/9ud/ASqoiLslWMr+83ogdodKIY0EQl3B4Jj9rseAkWL4wJhmAkVlg6DRHPKxbLHAFWJ+sO+nDb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011888; c=relaxed/simple;
	bh=DmiItKPQ9EHlZvu5av+MtnBOpWDzI1clnWp2NdKde3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j83dJFrRlnzMiVt2Z7Lu7lqPvBw940Hg/XT85SFeJ8cQ+WBHCNTiXEdqfsceL4W/H3VqYsiFWfzA2LtEudnCAlyujDyEitS2CNj20szs47ib9ePqIEufarq8MJLskuYjGImnswXCqTBkPlEWs7imSp0+le5KE/Vr0cQKaMDqtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DJ6M2okg; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37b841bb1;
	Fri, 20 Mar 2026 21:04:41 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava@dubeyko.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava.dubeyko@ibm.com,
	zilin@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Fri, 20 Mar 2026 21:04:37 +0800
Message-Id: <20260320130438.988629-2-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320130438.988629-1-zilin@seu.edu.cn>
References: <20260320130438.988629-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0b59167f03a1kunm169b9ef12514ec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRkfVk1MHR9JTk4YHkpJTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DJ6M2okgthx3draz6GM1ZcXngMwopVg+zzlFCWVL2f7x2bzaWMAu7XStoVx1Q9TToZ7CCK4uVGkTeSbb50UkSm1rVAVCjR51WPOCiW5Dyw6OJo7J8nlq6nNhHx+N2eDZaFGhO1dEOemgINYv0OK4Xuu2vbsBn++WtdQk10zock8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=f78VzEoA9VVNkvocFaYeL3bbNDA+AApacm2I3szd6Ok=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227540-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 332402DAAE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfsplus_fill_super() calls hfs_find_init() to initialize a search
structure, which acquires tree->tree_lock. If the subsequent call to
hfsplus_cat_build_key() fails, the function jumps to the out_put_root
error label without releasing the lock. The later cleanup path then
frees the tree data structure with the lock still held, triggering a
held lock freed warning.

Fix this by adding the missing hfs_find_exit(&fd) call before jumping
to the out_put_root error label. This ensures that tree->tree_lock is
properly released on the error path.

The bug was originally detected on v6.13-rc1 using an experimental
static analysis tool we are developing, and we have verified that the
issue persists in the latest mainline kernel. The tool is specifically
designed to detect memory management issues. It is currently under active
development and not yet publicly available.

We confirmed the bug by runtime testing under QEMU with x86_64 defconfig,
lockdep enabled, and CONFIG_HFSPLUS_FS=y. To trigger the error path, we
used GDB to dynamically shrink the max_unistr_len parameter to 1 before
hfsplus_asc2uni() is called. This forces hfsplus_asc2uni() to naturally
return -ENAMETOOLONG, which propagates to hfsplus_cat_build_key() and
exercises the faulty error path. The following warning was observed
during mount:

	=========================
	WARNING: held lock freed!
	7.0.0-rc3-00016-gb4f0dd314b39 #4 Not tainted
	-------------------------
	mount/174 is freeing memory ffff888103f92000-ffff888103f92fff, with a lock still held there!
	ffff888103f920b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x154/0x1e0
	2 locks held by mount/174:
	#0: ffff888103f960e0 (&type->s_umount_key#42/1){+.+.}-{4:4}, at: alloc_super.constprop.0+0x167/0xa40
	#1: ffff888103f920b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x154/0x1e0

	stack backtrace:
	CPU: 2 UID: 0 PID: 174 Comm: mount Not tainted 7.0.0-rc3-00016-gb4f0dd314b39 #4 PREEMPT(lazy)
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
	Call Trace:
	<TASK>
	dump_stack_lvl+0x82/0xd0
	debug_check_no_locks_freed+0x13a/0x180
	kfree+0x16b/0x510
	? hfsplus_fill_super+0xcb4/0x18a0
	hfsplus_fill_super+0xcb4/0x18a0
	? __pfx_hfsplus_fill_super+0x10/0x10
	? srso_return_thunk+0x5/0x5f
	? bdev_open+0x65f/0xc30
	? srso_return_thunk+0x5/0x5f
	? pointer+0x4ce/0xbf0
	? trace_contention_end+0x11c/0x150
	? __pfx_pointer+0x10/0x10
	? srso_return_thunk+0x5/0x5f
	? bdev_open+0x79b/0xc30
	? srso_return_thunk+0x5/0x5f
	? srso_return_thunk+0x5/0x5f
	? vsnprintf+0x6da/0x1270
	? srso_return_thunk+0x5/0x5f
	? __mutex_unlock_slowpath+0x157/0x740
	? __pfx_vsnprintf+0x10/0x10
	? srso_return_thunk+0x5/0x5f
	? srso_return_thunk+0x5/0x5f
	? mark_held_locks+0x49/0x80
	? srso_return_thunk+0x5/0x5f
	? srso_return_thunk+0x5/0x5f
	? irqentry_exit+0x17b/0x5e0
	? trace_irq_disable.constprop.0+0x116/0x150
	? __pfx_hfsplus_fill_super+0x10/0x10
	? __pfx_hfsplus_fill_super+0x10/0x10
	get_tree_bdev_flags+0x302/0x580
	? __pfx_get_tree_bdev_flags+0x10/0x10
	? vfs_parse_fs_qstr+0x129/0x1a0
	? __pfx_vfs_parse_fs_qstr+0x3/0x10
	vfs_get_tree+0x89/0x320
	fc_mount+0x10/0x1d0
	path_mount+0x5c5/0x21c0
	? __pfx_path_mount+0x10/0x10
	? trace_irq_enable.constprop.0+0x116/0x150
	? trace_irq_enable.constprop.0+0x116/0x150
	? srso_return_thunk+0x5/0x5f
	? srso_return_thunk+0x5/0x5f
	? kmem_cache_free+0x307/0x540
	? user_path_at+0x51/0x60
	? __x64_sys_mount+0x212/0x280
	? srso_return_thunk+0x5/0x5f
	__x64_sys_mount+0x212/0x280
	? __pfx___x64_sys_mount+0x10/0x10
	? srso_return_thunk+0x5/0x5f
	? trace_irq_enable.constprop.0+0x116/0x150
	? srso_return_thunk+0x5/0x5f
	do_syscall_64+0x111/0x680
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7ffacad55eae
	Code: 48 8b 0d 85 1f 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 8
	RSP: 002b:00007fff1ab55718 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
	RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffacad55eae
	RDX: 000055740c64e5b0 RSI: 000055740c64e630 RDI: 000055740c651ab0
	RBP: 000055740c64e380 R08: 0000000000000000 R09: 0000000000000001
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
	R13: 000055740c64e5b0 R14: 000055740c651ab0 R15: 000055740c64e380
	</TASK>

After applying this patch, the warning no longer appears.

Fixes: 89ac9b4d3d1a ("hfsplus: fix longname handling")
CC: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/hfsplus/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7229a8ae89f9..f396fee19ab8 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -569,8 +569,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto out_put_root;
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
-	if (unlikely(err < 0))
+	if (unlikely(err < 0)) {
+		hfs_find_exit(&fd);
 		goto out_put_root;
+	}
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-- 
2.34.1


