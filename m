Return-Path: <stable+bounces-157709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A79AE5541
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9E179CE3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6ED21FF2B;
	Mon, 23 Jun 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bXSKF7ry"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5591F7580
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716531; cv=none; b=kaGiASvEHKC8Pkg+YSb9mLzZJIkqLT/oMJb7VOJoRKqM+n5bReOF/WqfdJTQs/hqS+RHBRL2wXsPLObSoSuLHEdQIbhKg/g/A4XoSJ9EAccwo7SaftHTSd76l5OjxhNe4+TPPIm46K7DV2IDpzBmBaneL2V/q0RlxLSn/GhH5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716531; c=relaxed/simple;
	bh=eD5nJ93Id6JHaUcDUQCd20/vTy2jzxP08xvcZQwDF6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MseAOQ7gJj8bid/ZFPi4qfG4Gfhqp4vVmgvS45pms+m2rp1Bj9uvnixAQCt7Xa6Ie3EFEFKFBLGlSUlAAsltdn30k3wMYF5wwUZwElxI1wNZxuE2CAlKiVvC8sey7wE1bewg4gQhPAFJWnCtd5JQCEY/gC/miYWCpE4mGKNQvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bXSKF7ry; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NLfY5a004782;
	Mon, 23 Jun 2025 22:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Qv5ruZDLl5WhePHy00GMtmaM9VHwq
	xwcU7TRKwc+8Rs=; b=bXSKF7ryNRaX65VWGJYKtIWieiYtUsRAU3hfHDKybPVhf
	Vs02/qdTU6R5II2yb/QKPYj8TFtgyKe+iuY6M5huuJQgUTEn5ncgy2GAKhYvl2Qc
	ubOF0SEy0cFI8zjDQMmDP3aX8zk1fAfYRJf7xreWEtPEFqH7c5Iwzw2JxieZ4THN
	LlpAc38+JE5hO1Rny9y8r1DOb2ZBH9Zz/hVOs4viprKSDL8Rvzp+KgLCnmfkkJOl
	928rNnjUFIuVW6W87SmyO12icq6f3m9klwN2ZzovBsy2252LFG5VpY0gnlOY6Omu
	731Ok+fbkaKHy+qlDRzCD08oDIdLOx7ygUw89YEHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7aq2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 22:08:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKODfR025062;
	Mon, 23 Jun 2025 22:08:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvvd73a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 22:08:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55NM8j2Y022831;
	Mon, 23 Jun 2025 22:08:45 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehvvd72w-1;
	Mon, 23 Jun 2025 22:08:45 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: sweettea-kernel@dorminy.me, anand.jain@oracle.com, osandov@fb.com,
        dsterba@suse.com
Subject: [PATCH 5.4.y] btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
Date: Mon, 23 Jun 2025 15:08:16 -0700
Message-ID: <20250623220816.51405-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_07,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDE1MCBTYWx0ZWRfX688A4neQPW8q bAYzbee4RyckYXzpDXISKUIJq3N+FJaOJ7qxN5ilhGNWYPEnLceC5ePtzW4VheNOQ4iaPv2CRLt QO3HXiHHnPAN4nYd1IrAA5nSmTvROgUtHN3e4SBjzNR2ytO/BlHkyvzMMI1KOfOfSrrCGdwpHOk
 KsFyuCl0NIn2l97CS/5eK8nKdHuDJT6g9ium/EniTl688ALqy7m8ZbOahLNmnweFrF/AvKAI/2c Q6h7M2h9UzzK+w89LI5IjzyzXGdhWVSI9VBOdhFJM+TZCGA91PFCOmwYOv51Y3a+7vr3SAycIPI wH82wXJKrrTxxtfcaRZrzfyGbcu8zzsTuPxtZikd5N+VoaW7wa1Fe/o6vpEXGYQMOgA80QmRaM8
 balgWMJ79G6+/6aZ58J9qd8E8UNvG3T+lko1quZ3i7+vv4ut8QCnX3hZuV1ngQ9tWhYhcoCY
X-Proofpoint-GUID: LH4fX9re1JP31i8jFMerDbPYM0trUPm7
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=6859d06e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=lhZV_6TAlmzbfNDFBXoA:9
 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: LH4fX9re1JP31i8jFMerDbPYM0trUPm7

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 7081929ab2572920e94d70be3d332e5c9f97095a ]

If the source file descriptor to the snapshot ioctl refers to a deleted
subvolume, we get the following abort:

  BTRFS: Transaction aborted (error -2)
  WARNING: CPU: 0 PID: 833 at fs/btrfs/transaction.c:1875 create_pending_snapshot+0x1040/0x1190 [btrfs]
  Modules linked in: pata_acpi btrfs ata_piix libata scsi_mod virtio_net blake2b_generic xor net_failover virtio_rng failover scsi_common rng_core raid6_pq libcrc32c
  CPU: 0 PID: 833 Comm: t_snapshot_dele Not tainted 6.7.0-rc6 #2
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
  RIP: 0010:create_pending_snapshot+0x1040/0x1190 [btrfs]
  RSP: 0018:ffffa09c01337af8 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffff9982053e7c78 RCX: 0000000000000027
  RDX: ffff99827dc20848 RSI: 0000000000000001 RDI: ffff99827dc20840
  RBP: ffffa09c01337c00 R08: 0000000000000000 R09: ffffa09c01337998
  R10: 0000000000000003 R11: ffffffffb96da248 R12: fffffffffffffffe
  R13: ffff99820535bb28 R14: ffff99820b7bd000 R15: ffff99820381ea80
  FS:  00007fe20aadabc0(0000) GS:ffff99827dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000559a120b502f CR3: 00000000055b6000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? __warn+0x81/0x130
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? report_bug+0x171/0x1a0
   ? handle_bug+0x3a/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   create_pending_snapshots+0x92/0xc0 [btrfs]
   btrfs_commit_transaction+0x66b/0xf40 [btrfs]
   btrfs_mksubvol+0x301/0x4d0 [btrfs]
   btrfs_mksnapshot+0x80/0xb0 [btrfs]
   __btrfs_ioctl_snap_create+0x1c2/0x1d0 [btrfs]
   btrfs_ioctl_snap_create_v2+0xc4/0x150 [btrfs]
   btrfs_ioctl+0x8a6/0x2650 [btrfs]
   ? kmem_cache_free+0x22/0x340
   ? do_sys_openat2+0x97/0xe0
   __x64_sys_ioctl+0x97/0xd0
   do_syscall_64+0x46/0xf0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
  RIP: 0033:0x7fe20abe83af
  RSP: 002b:00007ffe6eff1360 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe20abe83af
  RDX: 00007ffe6eff23c0 RSI: 0000000050009417 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fe20ad16cd0
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007ffe6eff13c0 R14: 00007fe20ad45000 R15: 0000559a120b6d58
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BTRFS: error (device vdc: state A) in create_pending_snapshot:1875: errno=-2 No such entry
  BTRFS info (device vdc: state EA): forced readonly
  BTRFS warning (device vdc: state EA): Skipping commit of aborted transaction.
  BTRFS: error (device vdc: state EA) in cleanup_transaction:2055: errno=-2 No such entry

This happens because create_pending_snapshot() initializes the new root
item as a copy of the source root item. This includes the refs field,
which is 0 for a deleted subvolume. The call to btrfs_insert_root()
therefore inserts a root with refs == 0. btrfs_get_new_fs_root() then
finds the root and returns -ENOENT if refs == 0, which causes
create_pending_snapshot() to abort.

Fix it by checking the source root's refs before attempting the
snapshot, but after locking subvol_sem to avoid racing with deletion.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit 7081929ab2572920e94d70be3d332e5c9f97095a)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 92a7cc425223
btrfs: rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 674d774eb662..a29182be29fa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -793,6 +793,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return -EINVAL;
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (atomic_read(&root->nr_swapfiles)) {
 		btrfs_warn(fs_info,
 			   "cannot snapshot subvolume with active swapfile");
-- 
2.46.0


