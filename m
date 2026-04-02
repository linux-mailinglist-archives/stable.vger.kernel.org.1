Return-Path: <stable+bounces-233084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKNcJFiqzmkgpQYAu9opvQ
	(envelope-from <stable+bounces-233084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:41:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580638CA42
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CF7D300AB11
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBD3BC677;
	Thu,  2 Apr 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBdv61by"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E8395250
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151640; cv=none; b=Pc2ta1GMi54HhG0zvpwRwHkqJD8PUP7RHV1NRLYnzWzdgYPwH/zsL3t+CCgo6rOZeSwREpr7OSri2tr3MlVtKVMbDA9yflf+uobqdpKatmAgn6f4i586bCMABY20qF3xuP+kbUFJcWwdJ8MdPggt4CEM+gOIkzx9gNdWkCvx4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151640; c=relaxed/simple;
	bh=E6Ku1GQ69800RD7GhETWmaQR1qPmmViDLnmlc9d25j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPTwyXq/cNoW6dOZJYx+3TJhDE6+881ddqMaaIBynHYfce0Uamb6AmIAMegugruQCYKRHp7Ovf13scLwzW4bOM+dYJR8ye88vUj5QL3wg5ZhxKhMgjb8TrDder/LM9KhmxhN5zGIWtQoGr82XrtISnN9bhUhdL2vw8bpH9XWaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBdv61by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400FCC116C6;
	Thu,  2 Apr 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151639;
	bh=E6Ku1GQ69800RD7GhETWmaQR1qPmmViDLnmlc9d25j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBdv61byGRDspSgs8H1a1gGPUZ4KoY/b3JRjJ++uJUb15SaasZsKSUyASGBig5DYE
	 SQyk4x31lmLRYtb0KT2omKR+BjkjwLekkkwzxmqQxi++hncdiKgedw/IzzJ4/dNI7j
	 VhZCxL4wwvOrZ8aGogpY7ANagxmoil24Rowl7DDPXG0+ioqhs+GKwr71gOzz1X0mBD
	 Lx/ajX2JlS52iz2u12ZIWi4+QJjwFg0G5C1XyBczYdtea59c7fyv371OyJBds1TONI
	 MkNxNoxnvvPTeXheERFG2rviou5BF1Fw04Fe1kfpTyDhkKtpYceDXa9l+QHh3drkiU
	 Qz2ndOElZnSlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: fix the might_sleep() warnings in kvfree()
Date: Thu,  2 Apr 2026 13:40:37 -0400
Message-ID: <20260402174037.1571365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033018-tiring-matching-ee63@gregkh>
References: <2026033018-tiring-matching-ee63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233084-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linux.dev:email]
X-Rspamd-Queue-Id: 3580638CA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zqiang <qiang.zhang@linux.dev>

[ Upstream commit 496bb99b7e66f48b178126626f47e9ba79e2d0fa ]

Use the kvfree() in the RCU read critical section can trigger
the following warnings:

EXT4-fs (vdb): unmounting filesystem cd983e5b-3c83-4f5a-a136-17b00eb9d018.

WARNING: suspicious RCU usage

./include/linux/rcupdate.h:409 Illegal context switch in RCU read-side critical section!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1

Call Trace:
 <TASK>
 dump_stack_lvl+0xbb/0xd0
 dump_stack+0x14/0x20
 lockdep_rcu_suspicious+0x15a/0x1b0
 __might_resched+0x375/0x4d0
 ? put_object.part.0+0x2c/0x50
 __might_sleep+0x108/0x160
 vfree+0x58/0x910
 ? ext4_group_desc_free+0x27/0x270
 kvfree+0x23/0x40
 ext4_group_desc_free+0x111/0x270
 ext4_put_super+0x3c8/0xd40
 generic_shutdown_super+0x14c/0x4a0
 ? __pfx_shrinker_free+0x10/0x10
 kill_block_super+0x40/0x90
 ext4_kill_sb+0x6d/0xb0
 deactivate_locked_super+0xb4/0x180
 deactivate_super+0x7e/0xa0
 cleanup_mnt+0x296/0x3e0
 __cleanup_mnt+0x16/0x20
 task_work_run+0x157/0x250
 ? __pfx_task_work_run+0x10/0x10
 ? exit_to_user_mode_loop+0x6a/0x550
 exit_to_user_mode_loop+0x102/0x550
 do_syscall_64+0x44a/0x500
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

BUG: sleeping function called from invalid context at mm/vmalloc.c:3441
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 556, name: umount
preempt_count: 1, expected: 0
CPU: 3 UID: 0 PID: 556 Comm: umount
Call Trace:
 <TASK>
 dump_stack_lvl+0xbb/0xd0
 dump_stack+0x14/0x20
 __might_resched+0x275/0x4d0
 ? put_object.part.0+0x2c/0x50
 __might_sleep+0x108/0x160
 vfree+0x58/0x910
 ? ext4_group_desc_free+0x27/0x270
 kvfree+0x23/0x40
 ext4_group_desc_free+0x111/0x270
 ext4_put_super+0x3c8/0xd40
 generic_shutdown_super+0x14c/0x4a0
 ? __pfx_shrinker_free+0x10/0x10
 kill_block_super+0x40/0x90
 ext4_kill_sb+0x6d/0xb0
 deactivate_locked_super+0xb4/0x180
 deactivate_super+0x7e/0xa0
 cleanup_mnt+0x296/0x3e0
 __cleanup_mnt+0x16/0x20
 task_work_run+0x157/0x250
 ? __pfx_task_work_run+0x10/0x10
 ? exit_to_user_mode_loop+0x6a/0x550
 exit_to_user_mode_loop+0x102/0x550
 do_syscall_64+0x44a/0x500
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The above scenarios occur in initialization failures and teardown
paths, there are no parallel operations on the resources released
by kvfree(), this commit therefore remove rcu_read_lock/unlock() and
use rcu_access_pointer() instead of rcu_dereference() operations.

Fixes: 7c990728b99e ("ext4: fix potential race between s_flex_groups online resizing and access")
Fixes: df3da4ea5a0f ("ext4: fix potential race between s_group_info online resizing and access")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260319094545.19291-1-qiang.zhang@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ adapted inline rcu_read_lock/rcu_dereference/rcu_read_unlock removal ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 10 +++-------
 fs/ext4/super.c   |  6 ++----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d1a616bbb5bdb..e2d79b7642623 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2890,9 +2890,7 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	rcu_read_unlock();
 	iput(sbi->s_buddy_cache);
 err_freesgi:
-	rcu_read_lock();
-	kvfree(rcu_dereference(sbi->s_group_info));
-	rcu_read_unlock();
+	kvfree(rcu_access_pointer(sbi->s_group_info));
 	return -ENOMEM;
 }
 
@@ -3084,7 +3082,8 @@ int ext4_mb_release(struct super_block *sb)
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
 	int count;
 
-	if (sbi->s_group_info) {
+	group_info = rcu_access_pointer(sbi->s_group_info);
+	if (group_info) {
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
@@ -3102,12 +3101,9 @@ int ext4_mb_release(struct super_block *sb)
 		num_meta_group_infos = (ngroups +
 				EXT4_DESC_PER_BLOCK(sb) - 1) >>
 			EXT4_DESC_PER_BLOCK_BITS(sb);
-		rcu_read_lock();
-		group_info = rcu_dereference(sbi->s_group_info);
 		for (i = 0; i < num_meta_group_infos; i++)
 			kfree(group_info[i]);
 		kvfree(group_info);
-		rcu_read_unlock();
 	}
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 41e49fee35e5a..c86663e5e1d9a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1207,18 +1207,16 @@ static void ext4_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		ext4_commit_super(sb, 1);
 
-	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
+	group_desc = rcu_access_pointer(sbi->s_group_desc);
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(group_desc[i]);
 	kvfree(group_desc);
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
+	flex_groups = rcu_access_pointer(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
 			kvfree(flex_groups[i]);
 		kvfree(flex_groups);
 	}
-	rcu_read_unlock();
 	percpu_counter_destroy(&sbi->s_freeclusters_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
-- 
2.53.0


