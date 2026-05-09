Return-Path: <stable+bounces-244868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGK2Iq2G/mnDsQAAu9opvQ
	(envelope-from <stable+bounces-244868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E44FD274
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444B53021EA2
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E523C4F3;
	Sat,  9 May 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwyoBvt9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B43B1B3
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288293; cv=none; b=BB9Y6vLb9pA2BGfaX259rkt9z7CmzGqnUb7h5fGn7Wlacq4Zh9MHuVF1FyuvXiMaO26O+nt7ohC3av63EBrZVPxDdXYdG3K74vUgE8yVvvMsopeKm51BJLk40dhS2MANCs1n5gHMlQrQfSNZUMLIenqyy0s2GrsWSISQVKi6WDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288293; c=relaxed/simple;
	bh=Phz54fPbnHFeax6os2QVwwQuGhonjODCQtECk5miEnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djAZ6ABD5kypUi1P7r8wr0xg338DfrCI4v6r1iH5MsLRxY/5EnxYEGtaqNQBJKDwAsXCtyEuzCXL25ktV8MkIQ2DUKCM/KOsaWIpUvqgawx4JoefULh/fHDcxmb76HwcaderTjB4pyb860mtyl8dJfEdm1UF+al6n4LYmT9mjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwyoBvt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD96C2BCC9;
	Sat,  9 May 2026 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288293;
	bh=Phz54fPbnHFeax6os2QVwwQuGhonjODCQtECk5miEnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwyoBvt9cGK7FvVEZ42uen1hanJgMr8UWVNH7YbMPeXYpbgB6iTJeqlZxuxVLgz3b
	 r0L7DBfSUQ+rLD59FmmSwZKt9VAuhVf7Ek0nqNDKax5B6Rti+wPRxNmTr+c9qjt6Rc
	 /b8XOgpVwvoA/7BliTMiJvjFca+nNYLmR73333MEJNOpflOZtdyo+kDjNw7p8v1Hfi
	 b55NnXejZkS2mGmkjZrqZYxKzyFYL0ZFGgsAhUPfP09lJqbFsdC9cutUnp1Cj80tMS
	 9lDpF59h9hRFGK5X6JJOGipwyy/WaVLQpc/PdJsBiMlIqj/qGjeEuENs8JcZ/slIOV
	 /33ZE7+dKHv8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Fri,  8 May 2026 20:58:08 -0400
Message-ID: <20260509005809.2569358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509005809.2569358-1-sashal@kernel.org>
References: <2026050455-strangle-trimming-ea52@gregkh>
 <20260509005809.2569358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E10E44FD274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244868-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email,seu.edu.cn:email]
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
index 4790ddd92a8c1..0d15e440d6869 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -539,8 +539,10 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
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


