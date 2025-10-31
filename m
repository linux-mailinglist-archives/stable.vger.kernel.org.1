Return-Path: <stable+bounces-191787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D7C235F9
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D25C3B4F9D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494D25BEE8;
	Fri, 31 Oct 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="G4kA+cU6"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087533191BF
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891445; cv=none; b=jxdcgQrmt7RTjy1cL+chTGwI/iQbxvB8LlWvp0yLHbFEqd8xoaIEH6blnjZxl40qedwNtsnCqAz31qwUwhkVCBSxhCpGuHhe5Uo10kEZXgpYMmjcAR/UOovBBV2X7/kZ8v2/DJv6xLnHtmPrmMfWtf5auPsSz9xLIQ0mmF+SYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891445; c=relaxed/simple;
	bh=IagTXxqhIbY0V1/YP676HAorYZohjhIaoWtytqikdCk=;
	h=From:To:Subject:Date:Message-Id; b=HGsST4Ed9lNMva8sCuzQOAfe1/9uxQW3Us5LJqB442TZ8/fPBtPsVhTyvNGGT4I+SPbvTUxPUOb59Wj8qJ+xT9BBv2c8B0K62yZWu5YUVC3JsKG4hZgYSNXsVBb1U2kCUjZ9pgG3CNowJTTGUCHSomcxNkiIr+FDFoXRC667dfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=G4kA+cU6; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=G4kA+cU6SaYIJhZniDMdH5xNV4RDOJMAZMHMevXmTtc3U40dp/iXpk/4BE7onifaUU6RJZg4gmSF+
	 UC3SKTLQUZlM9aV57ClujY5s8VhIXiqVp79qNIrYn6rHyPPKPXgilicDJynBngKAdQtD2CckmyNnaV
	 IvTRoRJRrkGxoHkU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f166904546bb3e-0ebe6;
	Fri, 31 Oct 2025 14:17:16 +0800 (CST)
X-RM-TRANSID:2f166904546bb3e-0ebe6
From: Rajani Kantha <681739313@139.com>
To: chao@kernel.org,
	jaegeuk@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] f2fs: fix to avoid panic once fallocation fails for pinfile
Date: Fri, 31 Oct 2025 14:17:10 +0800
Message-Id: <20251031061710.2854-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Chao Yu <chao@kernel.org>

[ Upstream commit 48ea8b200414ac69ea96f4c231f5c7ef1fbeffef ]

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2746!
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
RIP: 0010:get_new_segment fs/f2fs/segment.c:2746 [inline]
RIP: 0010:new_curseg+0x1f52/0x1f70 fs/f2fs/segment.c:2876
Call Trace:
 <TASK>
 __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3210
 f2fs_allocate_new_section fs/f2fs/segment.c:3224 [inline]
 f2fs_allocate_pinning_section+0xfa/0x4e0 fs/f2fs/segment.c:3238
 f2fs_expand_inode_data+0x696/0xca0 fs/f2fs/file.c:1830
 f2fs_fallocate+0x537/0xa10 fs/f2fs/file.c:1940
 vfs_fallocate+0x569/0x6e0 fs/open.c:327
 do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Concurrent pinfile allocation may run out of free section, result in
panic in get_new_segment(), let's expand pin_sem lock coverage to
include f2fs_gc(), so that we can make sure to reclaim enough free
space for following allocation.

In addition, do below changes to enhance error path handling:
- call f2fs_bug_on() only in non-pinfile allocation path in
get_new_segment().
- call reset_curseg_fields() to reset all fields of curseg in
new_curseg()

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Reported-by: syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/675cd64e.050a0220.37aaf.00bb.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/f2fs/file.c    |  8 +++++---
 fs/f2fs/segment.c | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2a108c561e8b..6317dd523ecd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1836,18 +1836,20 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = sec_blks;
 next_alloc:
+		f2fs_down_write(&sbi->pin_sem);
+
 		if (has_not_enough_free_secs(sbi, 0, f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
 			stat_inc_gc_call_count(sbi, FOREGROUND);
 			err = f2fs_gc(sbi, &gc_control);
-			if (err && err != -ENODATA)
+			if (err && err != -ENODATA) {
+				f2fs_up_write(&sbi->pin_sem);
 				goto out_err;
+			}
 		}
 
-		f2fs_down_write(&sbi->pin_sem);
-
 		err = f2fs_allocate_pinning_section(sbi);
 		if (err) {
 			f2fs_up_write(&sbi->pin_sem);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e48b5e2efea2..8ac6206110a1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2749,7 +2749,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
-			f2fs_bug_on(sbi, 1);
+			f2fs_bug_on(sbi, !pinning);
 			goto out_unlock;
 		}
 	}
@@ -2795,7 +2795,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 out_unlock:
 	spin_unlock(&free_i->segmap_lock);
 
-	if (ret == -ENOSPC)
+	if (ret == -ENOSPC && !pinning)
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
 	return ret;
 }
@@ -2868,6 +2868,13 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	return curseg->segno;
 }
 
+static void reset_curseg_fields(struct curseg_info *curseg)
+{
+	curseg->inited = false;
+	curseg->segno = NULL_SEGNO;
+	curseg->next_segno = 0;
+}
+
 /*
  * Allocate a current working segment.
  * This function always allocates a free segment in LFS manner.
@@ -2886,7 +2893,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	ret = get_new_segment(sbi, &segno, new_sec, pinning);
 	if (ret) {
 		if (ret == -ENOSPC)
-			curseg->segno = NULL_SEGNO;
+			reset_curseg_fields(curseg);
 		return ret;
 	}
 
@@ -3640,13 +3647,6 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
 		get_random_u32_inclusive(1, sbi->max_fragment_hole);
 }
 
-static void reset_curseg_fields(struct curseg_info *curseg)
-{
-	curseg->inited = false;
-	curseg->segno = NULL_SEGNO;
-	curseg->next_segno = 0;
-}
-
 int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
-- 
2.17.1



