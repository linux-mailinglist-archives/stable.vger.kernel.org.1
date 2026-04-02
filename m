Return-Path: <stable+bounces-233065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDC1NsObzmnfowYAu9opvQ
	(envelope-from <stable+bounces-233065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:39:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC5838C079
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CE430EE2E9
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBD3E1232;
	Thu,  2 Apr 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8ZYNlN7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D12F25F4
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147480; cv=none; b=KeBqlIFw2JBJPZTYV+5uoTTUFkE6DzP+w5CaT6A5vbcut/k9GKhIH765VR3hqn2PAqS4oemS1e7Yfzdbyjfm8lpdgbghpjYtjhYy6c6b9Pu3NYotoX0p2dwgYKd9SyomwxMaRqEHJFrkro+ddTlgzEIoAw+0SgRfphAK7qquVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147480; c=relaxed/simple;
	bh=62nh+2Cv/KZUF06cF/IIBz0VU2JqGZSBM8siTgX2HHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUX20+9TbhaiM6lyoGx0rF2gQ/NJj9sS7ZbhoAz+BC53X68u9JVVCBhr8BZuByfTilrLKOowZwQ2FOIf9OMsdI1jW8XkbHJKr6hZauIdqV/EVZrTe50RLbkqN6A6inlpcWmrDaTYZEM13VideaflEUReWVdWzqM23+lOvPqp8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8ZYNlN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A20DC19423;
	Thu,  2 Apr 2026 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147480;
	bh=62nh+2Cv/KZUF06cF/IIBz0VU2JqGZSBM8siTgX2HHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8ZYNlN79JKvnb1GjTNYeES1+3OUBXtCdRcWVezA2j/mIUk6WNJtn7puzc76BxtWS
	 WaeJAS5WAwNn7nG+7dL/m1U3YPAGu0nJgMurpZIhoKBWQKusQ2Oot/mIMueu2Yo2l1
	 kOEQid3OfCcHxukfdkOJS0PjjrPvLa6lT07JR//m6bkVIUDhFSw+7OmKYpnFwg4vdf
	 yMkj5S5/pW5hOC/Zh9DOtj5MVZcGx/5f8yXP+K1P5MzRPKEZoJXaY43+1nrsBsoKgl
	 laHqpX4nnraDFUpFAsyykmvBqEDtWXnFRar3sS/WAddvUIUCBK3Y+D3C6eA/1KLFd3
	 rRV+64R8zgG1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] ext4: fix the might_sleep() warnings in kvfree()
Date: Thu,  2 Apr 2026 12:31:15 -0400
Message-ID: <20260402163115.1385749-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402163115.1385749-1-sashal@kernel.org>
References: <2026033016-eagle-gangrene-7fc7@gregkh>
 <20260402163115.1385749-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233065-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EC5838C079
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 10 +++-------
 fs/ext4/super.c   |  8 ++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e204f16e33ad3..9127e5184c1ae 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3294,9 +3294,7 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	rcu_read_unlock();
 	iput(sbi->s_buddy_cache);
 err_freesgi:
-	rcu_read_lock();
-	kvfree(rcu_dereference(sbi->s_group_info));
-	rcu_read_unlock();
+	kvfree(rcu_access_pointer(sbi->s_group_info));
 	return -ENOMEM;
 }
 
@@ -3595,7 +3593,8 @@ int ext4_mb_release(struct super_block *sb)
 		WARN_ON_ONCE(!list_empty(&sbi->s_discard_list));
 	}
 
-	if (sbi->s_group_info) {
+	group_info = rcu_access_pointer(sbi->s_group_info);
+	if (group_info) {
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
@@ -3613,12 +3612,9 @@ int ext4_mb_release(struct super_block *sb)
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
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 85286a50dcb2f..c004aaa722201 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1241,12 +1241,10 @@ static void ext4_group_desc_free(struct ext4_sb_info *sbi)
 	struct buffer_head **group_desc;
 	int i;
 
-	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
+	group_desc = rcu_access_pointer(sbi->s_group_desc);
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(group_desc[i]);
 	kvfree(group_desc);
-	rcu_read_unlock();
 }
 
 static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
@@ -1254,14 +1252,12 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	struct flex_groups **flex_groups;
 	int i;
 
-	rcu_read_lock();
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
+	flex_groups = rcu_access_pointer(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
 			kvfree(flex_groups[i]);
 		kvfree(flex_groups);
 	}
-	rcu_read_unlock();
 }
 
 static void ext4_put_super(struct super_block *sb)
-- 
2.53.0


