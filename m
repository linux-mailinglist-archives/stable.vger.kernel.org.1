Return-Path: <stable+bounces-2256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8C7F836A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A81C25823
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FE37170;
	Fri, 24 Nov 2023 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gnGS8ata"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0F3418E;
	Fri, 24 Nov 2023 19:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBAC433C7;
	Fri, 24 Nov 2023 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853439;
	bh=0xtRmwMTJlrcXwwv6ZJi6Ma4Wsk3iAmLa1WAipl8FxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnGS8ataI8P1otlKQMf1T1plPTb9QdSBh6be753YxtOwGsdDnTRAiwp3CfoLRKTZs
	 lakRwAbu/cq3QvbCUJTwFsGH9UmxijIsazpwMzEJo1hHn2mbQH9BXGO4DCdn5Jkh0G
	 bNSU9zZsUCSwwmIsKKnAf8Ll+EOZy8bgb0I613mg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Guo Xuenan <guoxuenan@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 152/297] xfs: fix exception caused by unexpected illegal bestcount in leaf dir
Date: Fri, 24 Nov 2023 17:53:14 +0000
Message-ID: <20231124172005.585151193@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guo Xuenan <guoxuenan@huawei.com>

[ Upstream commit 13cf24e00665c9751951a422756d975812b71173 ]

For leaf dir, In most cases, there should be as many bestfree slots
as the dir data blocks that can fit under i_size (except for [1]).

Root cause is we don't examin the number bestfree slots, when the slots
number less than dir data blocks, if we need to allocate new dir data
block and update the bestfree array, we will use the dir block number as
index to assign bestfree array, while we did not check the leaf buf
boundary which may cause UAF or other memory access problem. This issue
can also triggered with test cases xfs/473 from fstests.

According to Dave Chinner & Darrick's suggestion, adding buffer verifier
to detect this abnormal situation in time.
Simplify the testcase for fstest xfs/554 [1]

The error log is shown as follows:
==================================================================
BUG: KASAN: use-after-free in xfs_dir2_leaf_addname+0x1995/0x1ac0
Write of size 2 at addr ffff88810168b000 by task touch/1552
CPU: 5 PID: 1552 Comm: touch Not tainted 6.0.0-rc3+ #101
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x4d/0x66
 print_report.cold+0xf6/0x691
 kasan_report+0xa8/0x120
 xfs_dir2_leaf_addname+0x1995/0x1ac0
 xfs_dir_createname+0x58c/0x7f0
 xfs_create+0x7af/0x1010
 xfs_generic_create+0x270/0x5e0
 path_openat+0x270b/0x3450
 do_filp_open+0x1cf/0x2b0
 do_sys_openat2+0x46b/0x7a0
 do_sys_open+0xb7/0x130
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe4d9e9312b
Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0
75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00
f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
RSP: 002b:00007ffda4c16c20 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe4d9e9312b
RDX: 0000000000000941 RSI: 00007ffda4c17f33 RDI: 00000000ffffff9c
RBP: 00007ffda4c17f33 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000941
R13: 00007fe4d9f631a4 R14: 00007ffda4c17f33 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea000405a2c0 refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x10168b
flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 002fffff80000000 ffffea0004057788 ffffea000402dbc8 0000000000000000
raw: 0000000000000000 0000000000170000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810168af00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810168af80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88810168b000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88810168b080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88810168b100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
Disabling lock debugging due to kernel taint
00000000: 58 44 44 33 5b 53 35 c2 00 00 00 00 00 00 00 78
XDD3[S5........x
XFS (sdb): Internal error xfs_dir2_data_use_free at line 1200 of file
fs/xfs/libxfs/xfs_dir2_data.c.  Caller
xfs_dir2_data_use_free+0x28a/0xeb0
CPU: 5 PID: 1552 Comm: touch Tainted: G    B              6.0.0-rc3+
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x4d/0x66
 xfs_corruption_error+0x132/0x150
 xfs_dir2_data_use_free+0x198/0xeb0
 xfs_dir2_leaf_addname+0xa59/0x1ac0
 xfs_dir_createname+0x58c/0x7f0
 xfs_create+0x7af/0x1010
 xfs_generic_create+0x270/0x5e0
 path_openat+0x270b/0x3450
 do_filp_open+0x1cf/0x2b0
 do_sys_openat2+0x46b/0x7a0
 do_sys_open+0xb7/0x130
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe4d9e9312b
Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0
75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00
f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
RSP: 002b:00007ffda4c16c20 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe4d9e9312b
RDX: 0000000000000941 RSI: 00007ffda4c17f46 RDI: 00000000ffffff9c
RBP: 00007ffda4c17f46 R08: 0000000000000000 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000941
R13: 00007fe4d9f631a4 R14: 00007ffda4c17f46 R15: 0000000000000000
 </TASK>
XFS (sdb): Corruption detected. Unmount and run xfs_repair

[1] https://lore.kernel.org/all/20220928095355.2074025-1-guoxuenan@huawei.com/
Reviewed-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_dir2_leaf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
index d9b66306a9a77..cb9e950a911d8 100644
--- a/fs/xfs/libxfs/xfs_dir2_leaf.c
+++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
@@ -146,6 +146,8 @@ xfs_dir3_leaf_check_int(
 	xfs_dir2_leaf_tail_t		*ltp;
 	int				stale;
 	int				i;
+	bool				isleaf1 = (hdr->magic == XFS_DIR2_LEAF1_MAGIC ||
+						   hdr->magic == XFS_DIR3_LEAF1_MAGIC);
 
 	ltp = xfs_dir2_leaf_tail_p(geo, leaf);
 
@@ -158,8 +160,7 @@ xfs_dir3_leaf_check_int(
 		return __this_address;
 
 	/* Leaves and bests don't overlap in leaf format. */
-	if ((hdr->magic == XFS_DIR2_LEAF1_MAGIC ||
-	     hdr->magic == XFS_DIR3_LEAF1_MAGIC) &&
+	if (isleaf1 &&
 	    (char *)&hdr->ents[hdr->count] > (char *)xfs_dir2_leaf_bests_p(ltp))
 		return __this_address;
 
@@ -175,6 +176,10 @@ xfs_dir3_leaf_check_int(
 		}
 		if (hdr->ents[i].address == cpu_to_be32(XFS_DIR2_NULL_DATAPTR))
 			stale++;
+		if (isleaf1 && xfs_dir2_dataptr_to_db(geo,
+				be32_to_cpu(hdr->ents[i].address)) >=
+				be32_to_cpu(ltp->bestcount))
+			return __this_address;
 	}
 	if (hdr->stale != stale)
 		return __this_address;
-- 
2.42.0




