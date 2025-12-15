Return-Path: <stable+bounces-201078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D1CBF773
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45F9300F588
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14573225408;
	Mon, 15 Dec 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T87gxSxX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34199218AAD
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824392; cv=none; b=uiibblcpPf7yaj+8xZEy5kf2N6I+A1d9Ws6zELfS+yrqnGOcp4WzwM9CvymmmXT/3sevYw32urKj5oRGYv916Dtm3L8dGTuV9VZYUUj1zAgiGHsO0LIriK8+tYGG3JLIh38WY604erjz8B5Y8gBdu01mItIVMulSdZ9rLcWBcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824392; c=relaxed/simple;
	bh=rXKDAwDaGJawhQ8dUhZSGN3gqkdAL1GpjLf21JyUd2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUBMlhC8yHK3av1tQDh4/O4l/npbf2ciuhnTx54g+nTHDXXIOL46Vren2Ej9jrTmHjBbtRmf33VIbcmeixz+lqoumrmG06A/n8AQx2LqZWlL3ztP/cxIrrpysP3s2NJiwARzBZHQ0mIJAli+24kDa2IvsChUkjDuBxDLDQcCkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T87gxSxX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab7623f42so4475210b3a.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765824390; x=1766429190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=so5tlyJR9to0BdTSCEFt4jR4nZcyYj14BTL5CiJJyXw=;
        b=T87gxSxXVW58NKjWeHFCuw2etvOu66EU6aVSM7eomu4v1lyFSOq05gWTep3z/jTmw1
         j4yUQ6lWt4DcnHzT6AqR4MvRDgFa5ySfMOi9rmFg8lev5W8aU+D2SmixAOaIOgm+As80
         PgNOMNXcs/tWzQFCe7ZI8gtMq5fpXcuDcERuRbcfMKr3YIf+0klM7JCLk6mA86guOWaq
         HKgFFb2bP8fGkIU57Doo/R4KfMXjqcoe07AgSpYBi8krX7ACuPCOewxm8knVfDnGE3+H
         2m/fsL/pPHwF/iusTVFvAGC0z/fmNPP7iORZVGS+GQD9cxAffhAqSLDVuKwvXBz7ypMw
         hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765824390; x=1766429190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so5tlyJR9to0BdTSCEFt4jR4nZcyYj14BTL5CiJJyXw=;
        b=KooxsfY+GO1ZGSqyZA2TY082W/mAetmCl5FmdAFS+eyiaXgWAlMBQG+EHtv/wBkh0q
         RCIqibOQT7amDoHC9Bo31or32JlIWbKMZ6t2MojgSEGejgVDT+1iuU0M4xqgUaG9DZ9/
         joh0ZJrphRu6cdOMxLzNCyal2G0V22rwv7M2WZ/o5nJSJhU3sAwwczXNOROVcUBcwqZt
         Upq4ehDNPqCCNgIbSWsFfSdnU0PMaDMLoqBDgkNtfmEWQ/K9jNSGSlTO3CR+t/sHt2sm
         4uQDtwIE9uAkRTkFO9z7j9bQURSMQU59bHDVTKDE51aIhCHZqJD2Ld96KVx/Mkqn72V0
         /3CA==
X-Forwarded-Encrypted: i=1; AJvYcCVFYzwqBLdtRMMDTOJ6h7uTRd52ub+QkJIhkxDemQKr28d2H7BMiGb31vDJeNMNSG+NTiRg3x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGJs+C9RtmhJSCq/H1M29EVG6ALlCwYbER6Qc1kC1CTKePl5Q
	1POBwkJpnuRKKnAAglgKmXQtVXIyFuZN2SFRToXjl7JVVgXBbGweE9Hc
X-Gm-Gg: AY/fxX7IChEOq3AAakwlu6JGzvkzSH+VIIuXCviA8beyZXuvbdAnGxAPRHYVfCj38Xe
	YA4Jf9x1Al1iXEgI/hoAcpRKdQIBMlKTpdSdQxNukUzg0GUq0EzxIp9BbFeCFH0QY8u0IAeLyDH
	0F5saKLvtw1C+ZUo8Z13kMPeO5y6vPIwQrGCG9VAcZFWtO+jbpux7Q85PvP/EuEipwyNzzUdYLI
	c63oIVrS23wysgZSYWh00H9A6xlLPGp64i0oztKLnTcQWbzFVkb3S0ClcjcidJrbqS3ZMbnlG2a
	h6S0GWughCAYUT8k0muHYC8hT25pzigu3d1T2uF/OBFhug/o2giNx170ztZxRElapPs6fyHVmLp
	dxgQGX9u30awxUQlsx/pmgzuCn9LItLvziEf7UVAm0h4MBWtFxqbfb4uZ3r5LRK9iJtgEbSEACn
	89UhxOsSBiyJFj6JetHNviWRtN5Jk=
X-Google-Smtp-Source: AGHT+IGu6ea6lc8otFEMzkERQIvMyATBlenq1D78I8JVDiZScI5uemRxzsl4ZB4dFPjwQC5mO4tCcQ==
X-Received: by 2002:a05:6a00:8c11:b0:783:9b67:e96a with SMTP id d2e1a72fcca58-7f664d05098mr11417784b3a.0.1765824390440;
        Mon, 15 Dec 2025 10:46:30 -0800 (PST)
Received: from localhost.localdomain ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa91d0sm13244346b3a.32.2025.12.15.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:46:30 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4] ocfs2: Add validate function for slot map blocks
Date: Tue, 16 Dec 2025 00:15:57 +0530
Message-ID: <20251215184600.13147-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the filesystem is being mounted, the kernel panics while the data
regarding slot map allocation to the local node, is being written to the
disk. This occurs because the value of slot map buffer head block
number, which should have been greater than or equal to
`OCFS2_SUPER_BLOCK_BLKNO` (evaluating to 2) is less than it, indicative
of disk metadata corruption. This triggers
BUG_ON(bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) in ocfs2_write_block(),
causing the kernel to panic.

This is fixed by introducing function ocfs2_validate_slot_map_block() to
validate slot map blocks. It first checks if the buffer head passed to it
is up to date and valid, else it panics the kernel at that point itself.
Further, it contains an if condition block, which checks if `bh->b_blocknr`
is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if yes, then ocfs2_error is
called, which prints the error log, for debugging purposes, and the return
value of ocfs2_error() is returned. If the if condition is false, value 0
is returned by ocfs2_validate_slot_map_block().

This function is used as validate function in calls to ocfs2_read_blocks()
in ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers().

Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
v3->v4:
 - Remove if condition in ocfs2_validate_slot_map_block() which checks if 
   `rc` is zero
 - Update commit log message 

v3 link: https://lore.kernel.org/ocfs2-devel/tagu2npibmto5bgonhorg5krbvqho4zxsv5pulvgbtp53aobas@6qk4twoysbnz/T/#m6f357a93c9426c3d2f0c2d18d71f4c54601089ec

v2->v3:
 - Create new function ocfs2_validate_slot_map_block() to validate block 
   number of slot map blocks, to be greater then or equal to 
   OCFS2_SUPER_BLOCK_BLKNO
 - Use ocfs2_validate_slot_map_block() in calls to ocfs2_read_blocks() in
   ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers()
 - In addition to using previously formulated if block in 
   ocfs2_validate_slot_map_block(), also check if the buffer head passed 
   in this function is up to date; if not, then kernel panics at that point
 - Update title of patch to 'ocfs2: Add validate function for slot map blocks'

v2 link: https://lore.kernel.org/ocfs2-devel/nwkfpkm2wlajswykywnpt4sc6gdkesakw2sw7etuw2u2w23hul@6oby33bscwdw/T/#m39bc7dbb208e09a78e0913905c6dfdfd666f3a05

v1->v2:
 - Remove usage of le16_to_cpu() from ocfs2_error()
 - Cast bh->b_blocknr to unsigned long long
 - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
 - Fix Sparse warnings reported in v1 by kernel test robot
 - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
   'ocfs2: fix kernel BUG in ocfs2_write_block'

v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/#mba4a0b092d8c5ba5b390b5d6a5c3ec7bc6caa6ae

 fs/ocfs2/slot_map.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index e544c704b583..ea4a68abc25b 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -44,6 +44,9 @@ struct ocfs2_slot_info {
 static int __ocfs2_node_num_to_slot(struct ocfs2_slot_info *si,
 				    unsigned int node_num);
 
+static int ocfs2_validate_slot_map_block(struct super_block *sb,
+					  struct buffer_head *bh);
+
 static void ocfs2_invalidate_slot(struct ocfs2_slot_info *si,
 				  int slot_num)
 {
@@ -132,7 +135,8 @@ int ocfs2_refresh_slot_info(struct ocfs2_super *osb)
 	 * this is not true, the read of -1 (UINT64_MAX) will fail.
 	 */
 	ret = ocfs2_read_blocks(INODE_CACHE(si->si_inode), -1, si->si_blocks,
-				si->si_bh, OCFS2_BH_IGNORE_CACHE, NULL);
+				si->si_bh, OCFS2_BH_IGNORE_CACHE,
+				ocfs2_validate_slot_map_block);
 	if (ret == 0) {
 		spin_lock(&osb->osb_lock);
 		ocfs2_update_slot_info(si);
@@ -332,6 +336,24 @@ int ocfs2_clear_slot(struct ocfs2_super *osb, int slot_num)
 	return ocfs2_update_disk_slot(osb, osb->slot_info, slot_num);
 }
 
+static int ocfs2_validate_slot_map_block(struct super_block *sb,
+					  struct buffer_head *bh)
+{
+	int rc;
+
+	BUG_ON(!buffer_uptodate(bh));
+
+	if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
+		rc = ocfs2_error(sb,
+				 "Invalid Slot Map Buffer Head "
+				 "Block Number : %llu, Should be >= %d",
+				 (unsigned long long)bh->b_blocknr,
+				 OCFS2_SUPER_BLOCK_BLKNO);
+		return rc;
+	}
+	return 0;
+}
+
 static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 				  struct ocfs2_slot_info *si)
 {
@@ -383,7 +405,8 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 
 		bh = NULL;  /* Acquire a fresh bh */
 		status = ocfs2_read_blocks(INODE_CACHE(si->si_inode), blkno,
-					   1, &bh, OCFS2_BH_IGNORE_CACHE, NULL);
+					   1, &bh, OCFS2_BH_IGNORE_CACHE,
+					   ocfs2_validate_slot_map_block);
 		if (status < 0) {
 			mlog_errno(status);
 			goto bail;

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


