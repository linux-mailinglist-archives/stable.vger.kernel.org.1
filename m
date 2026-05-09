Return-Path: <stable+bounces-244857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q2k4HVyB/mmFsAAAu9opvQ
	(envelope-from <stable+bounces-244857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D44FD10A
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A8F03009CF1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812E1DE4E0;
	Sat,  9 May 2026 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSypIiW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5231DC1AB
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286938; cv=none; b=BQwQV/GWlNhlnCsVS+5I4ntu9oyC04K6oFUnclF6LUMhQP09oQMDEHi6TA/6HXvY0T77RPyievWtA6eMgToDG12qnm5izCcomWsqz5Ta9MgJLjq9NeCIHPRrAjxgT36iJN5QXYFFV5oZezIgFSPIQZVJlaBfBJ+sjZow/z5+FUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286938; c=relaxed/simple;
	bh=vBr8GDHxFE0ekwU1Z306u5DzXAvx7eJSzN+8It8flw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtglvfryq0QbPfevWgAvbPewEVQeeP6cbWOrjo5mLWOV75kFvD8xV6RXrm6Nb0fsinPfNPI2mXT+Ca8X1l2zg0cNxA1U5HOjCsHlQSxHRINnIfVmoipZYsOoJ9aCxjKYBh/sP8KcZe42thG/KLwSaKI67CWy2nLU65ssdP/Ri0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSypIiW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9717CC2BCC9;
	Sat,  9 May 2026 00:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778286938;
	bh=vBr8GDHxFE0ekwU1Z306u5DzXAvx7eJSzN+8It8flw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSypIiW+RJmPAp7Cr8Ddmu5BtsrB1t/PlkZEo+U0edUVkj3SWVwf0V7EXwTWiqyFv
	 3XdwhJHGkRBATxI4ifE+9LlRn6RQ+9TS3Y95dzLpRf93Ajcd0C8mayqQF0DTG65Yk8
	 HdevPMh9tcehAmJdpVL7vqor+UGRkHOl9LDALxwOeoYhV/lplYNg6Ks2cQ/Yu3JQmX
	 vto8K1VO5Ug7PG8gFQh66Smqo6RhxYpK1RDBdPNtDB2ujkvAakf3W7vV2lvkLpMpCR
	 1IRGjKtxILM/nFC6+drVBF/7y1sxcPkJfUhTm7vb8ZllT9JwPxnucxW0s7jvEBghC0
	 UCgoRYexTsD6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Fri,  8 May 2026 20:35:34 -0400
Message-ID: <20260509003534.2360473-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509003534.2360473-1-sashal@kernel.org>
References: <2026050451-driven-stylus-18e6@gregkh>
 <20260509003534.2360473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 040D44FD10A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244857-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 90c500e4fd83fa33c09bc7ee23b6d9cc487ac733 ]

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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 59ea956c72018..e1e2833f528d1 100644
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
 	if (!hfsplus_brec_read_cat(&fd, &entry)) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-- 
2.53.0


