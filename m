Return-Path: <stable+bounces-122804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EBEA5A148
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0732E3AD263
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E6232792;
	Mon, 10 Mar 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aw/wDvNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D322ACDC;
	Mon, 10 Mar 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629545; cv=none; b=Bh4BLDG9WwBQQeYbT9wzIJysOq34BVPxN1cI4WVw4CLJ2VUYI1/VlZ7C6rdtfisJoohj92dmA0GCOAW/KvePBlYBthwmKrw/9pUmNRCl55jp97VDNnutrukUzqoWPE/oquetEOLHQwYcPql4o6gGyrwaDlmX9aTkqItHbGTPWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629545; c=relaxed/simple;
	bh=/gixgWOSG9+e8kjm2jK7g5DokdOKP7P4xi6Oysb5LDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU6wQ98Kj/URnpiuk2+RQf6PwpvJKLKWGN7ADwtLWZ+9AlP1wJNF+EfBc7lRWuSNCj5wV/S0eBfM3Bvx3IjRpqrmFMjtktl1wUp9PAFavqSN7gpJ5HO/6JJUi5ZMLpdAZrkx+HzIGthOGllQKMfHFDLyz5w4LZyNRT0qmJq41ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aw/wDvNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD7BC4CEE5;
	Mon, 10 Mar 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629545;
	bh=/gixgWOSG9+e8kjm2jK7g5DokdOKP7P4xi6Oysb5LDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aw/wDvNdTPd1BN4GAD/PNEHI5M6QLxiDqVGizV/lU+RGK/ULrB9zGnkndh2nJ74cq
	 2+OZ3E5SYFimpeoiFttPo8nnUVFGCd5tqwqVLr50CzIDQg6mrnU7dZolIvpcjX+Ccc
	 OKYaPZpfEq/os/0xuvspClISUEJwn75Cp7HAqucY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiacheng Xu <stitch@zju.edu.cn>,
	syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com,
	Su Yue <glass.su@suse.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 332/620] ocfs2: check dir i_size in ocfs2_find_entry
Date: Mon, 10 Mar 2025 18:02:58 +0100
Message-ID: <20250310170558.710408314@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Yue <glass.su@suse.com>

commit b0fce54b8c0d8e5f2b4c243c803c5996e73baee8 upstream.

syz reports an out of bounds read:

==================================================================
BUG: KASAN: slab-out-of-bounds in ocfs2_match fs/ocfs2/dir.c:334
[inline]
BUG: KASAN: slab-out-of-bounds in ocfs2_search_dirblock+0x283/0x6e0
fs/ocfs2/dir.c:367
Read of size 1 at addr ffff88804d8b9982 by task syz-executor.2/14802

CPU: 0 UID: 0 PID: 14802 Comm: syz-executor.2 Not tainted 6.13.0-rc4 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
04/01/2014
Sched_ext: serialise (enabled+all), task: runnable_at=-10ms
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:94 [inline]
dump_stack_lvl+0x229/0x350 lib/dump_stack.c:120
print_address_description mm/kasan/report.c:378 [inline]
print_report+0x164/0x530 mm/kasan/report.c:489
kasan_report+0x147/0x180 mm/kasan/report.c:602
ocfs2_match fs/ocfs2/dir.c:334 [inline]
ocfs2_search_dirblock+0x283/0x6e0 fs/ocfs2/dir.c:367
ocfs2_find_entry_id fs/ocfs2/dir.c:414 [inline]
ocfs2_find_entry+0x1143/0x2db0 fs/ocfs2/dir.c:1078
ocfs2_find_files_on_disk+0x18e/0x530 fs/ocfs2/dir.c:1981
ocfs2_lookup_ino_from_name+0xb6/0x110 fs/ocfs2/dir.c:2003
ocfs2_lookup+0x30a/0xd40 fs/ocfs2/namei.c:122
lookup_open fs/namei.c:3627 [inline]
open_last_lookups fs/namei.c:3748 [inline]
path_openat+0x145a/0x3870 fs/namei.c:3984
do_filp_open+0xe9/0x1c0 fs/namei.c:4014
do_sys_openat2+0x135/0x1d0 fs/open.c:1402
do_sys_open fs/open.c:1417 [inline]
__do_sys_openat fs/open.c:1433 [inline]
__se_sys_openat fs/open.c:1428 [inline]
__x64_sys_openat+0x15d/0x1c0 fs/open.c:1428
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01076903ad
Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01084acfc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f01077cbf80 RCX: 00007f01076903ad
RDX: 0000000000105042 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f01077cbf80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001ff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01077cbf80 R14: 00007f010764fc90 R15: 00007f010848d000
</TASK>
==================================================================

And a general protection fault in ocfs2_prepare_dir_for_insert:

==================================================================
loop0: detected capacity change from 0 to 32768
JBD2: Ignoring recovery information on journal
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data
mode.
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5096 Comm: syz-executor792 Not tainted
6.11.0-rc4-syzkaller-00002-gb0da640826ba #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_find_dir_space_id fs/ocfs2/dir.c:3406 [inline]
RIP: 0010:ocfs2_prepare_dir_for_insert+0x3309/0x5c70 fs/ocfs2/dir.c:4280
Code: 00 00 e8 2a 25 13 fe e9 ba 06 00 00 e8 20 25 13 fe e9 4f 01 00 00
e8 16 25 13 fe 49 8d 7f 08 49 8d 5f 09 48 89 f8 48 c1 e8 03 <42> 0f b6
04 20 84 c0 0f 85 bd 23 00 00 48 89 d8 48 c1 e8 03 42 0f
RSP: 0018:ffffc9000af9f020 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000009 RCX: ffff88801e27a440
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000008
RBP: ffffc9000af9f830 R08: ffffffff8380395b R09: ffffffff838090a7
R10: 0000000000000002 R11: ffff88801e27a440 R12: dffffc0000000000
R13: ffff88803c660878 R14: f700000000000088 R15: 0000000000000000
FS:  000055555a677380(0000) GS:ffff888020800000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560bce569178 CR3: 000000001de5a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
ocfs2_mknod+0xcaf/0x2b40 fs/ocfs2/namei.c:292
vfs_mknod+0x36d/0x3b0 fs/namei.c:4088
do_mknodat+0x3ec/0x5b0
__do_sys_mknodat fs/namei.c:4166 [inline]
__se_sys_mknodat fs/namei.c:4163 [inline]
__x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4163
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2dafda3a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
64 89 01 48
RSP: 002b:00007ffe336a6658 EFLAGS: 00000246 ORIG_RAX:
0000000000000103
RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f2dafda3a99
RDX: 00000000000021c0 RSI: 0000000020000040 RDI:
00000000ffffff9c
RBP: 00007f2dafe1b5f0 R08: 0000000000004480 R09:
000055555a6784c0
R10: 0000000000000103 R11: 0000000000000246 R12:
00007ffe336a6680
R13: 00007ffe336a68a8 R14: 431bde82d7b634db R15:
00007f2dafdec03b
</TASK>
==================================================================

The two reports are all caused invalid negative i_size of dir inode.  For
ocfs2, dir_inode can't be negative or zero.

Here add a check in which is called by ocfs2_check_dir_for_entry().  It
fixes the second report as ocfs2_check_dir_for_entry() must be called
before ocfs2_prepare_dir_for_insert().  Also set a up limit for dir with
OCFS2_INLINE_DATA_FL.  The i_size can't be great than blocksize.

Link: https://lkml.kernel.org/r/20250106140640.92260-1-glass.su@suse.com
Reported-by: Jiacheng Xu <stitch@zju.edu.cn>
Link: https://lore.kernel.org/ocfs2-devel/17a04f01.1ae74.19436d003fc.Coremail.stitch@zju.edu.cn/T/#u
Reported-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000005894f3062018caf1@google.com/T/
Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/dir.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1065,26 +1065,39 @@ int ocfs2_find_entry(const char *name, i
 {
 	struct buffer_head *bh;
 	struct ocfs2_dir_entry *res_dir = NULL;
+	int ret = 0;
 
 	if (ocfs2_dir_indexed(dir))
 		return ocfs2_find_entry_dx(name, namelen, dir, lookup);
 
+	if (unlikely(i_size_read(dir) <= 0)) {
+		ret = -EFSCORRUPTED;
+		mlog_errno(ret);
+		goto out;
+	}
 	/*
 	 * The unindexed dir code only uses part of the lookup
 	 * structure, so there's no reason to push it down further
 	 * than this.
 	 */
-	if (OCFS2_I(dir)->ip_dyn_features & OCFS2_INLINE_DATA_FL)
+	if (OCFS2_I(dir)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		if (unlikely(i_size_read(dir) > dir->i_sb->s_blocksize)) {
+			ret = -EFSCORRUPTED;
+			mlog_errno(ret);
+			goto out;
+		}
 		bh = ocfs2_find_entry_id(name, namelen, dir, &res_dir);
-	else
+	} else {
 		bh = ocfs2_find_entry_el(name, namelen, dir, &res_dir);
+	}
 
 	if (bh == NULL)
 		return -ENOENT;
 
 	lookup->dl_leaf_bh = bh;
 	lookup->dl_entry = res_dir;
-	return 0;
+out:
+	return ret;
 }
 
 /*
@@ -2011,6 +2024,7 @@ int ocfs2_lookup_ino_from_name(struct in
  *
  * Return 0 if the name does not exist
  * Return -EEXIST if the directory contains the name
+ * Return -EFSCORRUPTED if found corruption
  *
  * Callers should have i_mutex + a cluster lock on dir
  */
@@ -2024,9 +2038,12 @@ int ocfs2_check_dir_for_entry(struct ino
 	trace_ocfs2_check_dir_for_entry(
 		(unsigned long long)OCFS2_I(dir)->ip_blkno, namelen, name);
 
-	if (ocfs2_find_entry(name, namelen, dir, &lookup) == 0) {
+	ret = ocfs2_find_entry(name, namelen, dir, &lookup);
+	if (ret == 0) {
 		ret = -EEXIST;
 		mlog_errno(ret);
+	} else if (ret == -ENOENT) {
+		ret = 0;
 	}
 
 	ocfs2_free_dir_lookup_result(&lookup);



