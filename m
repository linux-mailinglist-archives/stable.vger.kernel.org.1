Return-Path: <stable+bounces-201001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8DACBC8F2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 06:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6C2300ACEF
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15619324B1D;
	Mon, 15 Dec 2025 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvIpY8ux"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA95322C73
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776325; cv=none; b=rKN0Yte1wSTQbCTpIukd6PppgWEKpg/ApXvCrabh+hbEpsOEPhHVR0jC069fE4KqW4KbxhWlCOsKQPNDK3YA4HiZnMNrCtjy86NZH6okyyQdnn/pBGtxQSdR6EV8dc10VmgHmOcJPzAJ526Rw2XixrovkWv7p0aVT4ALazeIhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776325; c=relaxed/simple;
	bh=4WohUcn53T/uQEEyf6y7BAhROophdwysksZvlgisaoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lu+Nhb8BjzCWOgM5b/p/psz17KAzuvEYdkELuT7CK0CSMSBtcVyAOKjhTDWkZEol0lv63cDtt89DO3O3i4njmPT7Vh1MT0RI0vLAoapWXSNlFqgtQRLm/XWEqYH92mLSVW/mZowaMG2n0VWh+DfTu5w07fo2Y6m0F8j7s7DlG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvIpY8ux; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so3711913a91.1
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 21:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765776323; x=1766381123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyeYl+lpYngXeRFB+8S2RI9/QB/GCDHNJHtpaYarljI=;
        b=mvIpY8uxRiw4PJaXd3njzekzvzLwPRV57xQG+wtf97PTaaumM1YjWKc6OTgtdlb9cd
         sUbI8PAfELSq86T7nO9P47M3nMu0gBo/5/ZZkOA7FEtOR1d0v8gkqhmkv+aXlMQ34yO/
         v7jjlao4/BL9IBB0sSHxv70mWaNbpiyPxUk1+3ADcaBeI2RPc6Aht8kYO1NVF6L6Y6D0
         fVFWQhpC/O7I9AIl34nyXmZ+OcJJJw4kp7Ixphfdd7lnvg9XvEB0EugD5hUMScSqSN0t
         sNI+Zix2LNMGef0JCHJR1eMU32yZYclGvEDLxxvJRIPMMXU8cilk9wQfvJJLZQ5fPMPw
         YYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765776323; x=1766381123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyeYl+lpYngXeRFB+8S2RI9/QB/GCDHNJHtpaYarljI=;
        b=I0pskWIpK5fhADRO3etfuX207BUIa0jbFqqSADDjSahPnQVuaYiJXWRvfend8PqARv
         NRGOqZpWN24OkO/3+VVxxDAZhAjdr97zgS1gNeDMOdh6v8xnHyOh26SdqrprZVur3arw
         wS5PH5tINYGoFOXRdO7nxcsAWGGKBege79du53/hOuCMiutWC3uENq5eMz3jkr53QQ0F
         ywg9XYe6j5oPKORlXMxumZHdk+m6+aKwIE1NFBaglrECeLTC9prXv+NXtKDPG4MADI6c
         +o5243a7WJ7/ofWO1CV6IhtnKGPXMK6PvfNbtC7MiMNgHPfg7qFlSsONUaSwEI8iYlTF
         kYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2HxPa3O2QnP/Ny3pHx4iO3csdzInnVm6TJGJjTKSygGQQAOj3Ssfs9u87ArqT1Li0oEUrPZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cC54mY8i3PpPA5qWcmIx3jnDaYr5OpTSaacFTjlU2SzbpjxZ
	39Rda+fsn3uet3RiAXaTQORaxMqt0QoSWJmXyuTY0jcQOStn2068a99yQ6CJLjNy
X-Gm-Gg: AY/fxX7gSnNzbSYBTyinFEcltJS5Vl7qPam/RL2NGwNgi1mP/hvCganFfomwBTC2KZ3
	J+bm1P91ffAvWICi7sVvpgiAchiz/AQ0E5TcjocubZqOYNaU6+K33oCvMDxUrbXyOK+moQ+QySO
	BbGDX3ngcmBjfYMBbgAJStEmu3zzhLojv0CFgpLigiNf0exTCOrCPRmsUXRskt6pEMk+sLFNlhH
	M+3uORJOLxNwdMSsarLn9fjPcOdEAQy2K4AH6QePOTO5a2KDhsuF0M7tjdd+i7BKWllJjK/YiFW
	MEGp66GHYnUsk6W3nBHh9Z8KPQhwIlSn4eMKAQ0uHE2Q8wQAq/yOYILG+KYQdApm+fMrnMHLYfY
	NZXZAq239m3cr3vPjcF9atMidKL47ijwRt++aupBx+2/E9uyJTHGKt1MHh2VQLzymD+n2rMSdTj
	nHw+oQGbzOdPLNJylE9UWLCv2P8oi/aXTowA+wkw==
X-Google-Smtp-Source: AGHT+IGVBhhEJenk45D58KfOANg6YA1gEaTJXYAm9m5FyDU2UPChT5MOuTUtXkkNHjW1zxUFFDj2RQ==
X-Received: by 2002:a17:90b:5288:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34abd78fcaemr9259366a91.19.1765776323536;
        Sun, 14 Dec 2025 21:25:23 -0800 (PST)
Received: from localhost.localdomain ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b9d9d6bsm11145324a12.24.2025.12.14.21.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:25:23 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	heming.zhao@suse.com
Cc: linux-kernel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] ocfs2: Add validate function for slot map blocks
Date: Mon, 15 Dec 2025 10:55:13 +0530
Message-ID: <20251215052513.18436-1-activprithvi@gmail.com>
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

This is fixed by introducing  function ocfs2_validate_slot_map_block() to
validate slot map blocks. It first checks if the buffer head passed to it
is up to date and valid, else it panics the kernel at that point itself.
Further, it contains an if condition block, which checks if `bh->b_blocknr`
is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if yes, then ocfs2_error is
called, which prints the error log, for debugging purposes, and the return
value of ocfs2_error() is returned. If the return value is zero. then error
code EIO is returned.

This function is used as validate function in calls to ocfs2_read_blocks()
in ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers().
In addition, the function also contains

Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
v2->v3:
 - Create new function ocfs2_validate_slot_map_block() to validate block 
   number of slot map blocks, to be greater then or equal to 
   OCFS2_SUPER_BLOCK_BLKNO
 - Use ocfs2_validate_slot_map_block() in calls to ocfs2_read_blocks() in
   ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers()
 - In addition to using previously formulated if block in 
   ocfs2_validate_slot_map_block(), also check if the buffer head passed 
   in this function is up to date; if not, then kernel panics at that point
 - Change title of patch to 'ocfs2: Add validate function for slot map blocks'

v2 link: https://lore.kernel.org/ocfs2-devel/nwkfpkm2wlajswykywnpt4sc6gdkesakw2sw7etuw2u2w23hul@6oby33bscwdw/T/#t

v1->v2:
 - Remove usage of le16_to_cpu() from ocfs2_error()
 - Cast bh->b_blocknr to unsigned long long
 - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
 - Fix Sparse warnings reported in v1 by kernel test robot
 - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
   'ocfs2: fix kernel BUG in ocfs2_write_block'

v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/
 fs/ocfs2/slot_map.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index e544c704b583..50ddd7f50f8f 100644
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
@@ -332,6 +336,26 @@ int ocfs2_clear_slot(struct ocfs2_super *osb, int slot_num)
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
+		if (!rc)
+			return -EIO;
+		return rc;
+	}
+	return 0;
+}
+
 static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 				  struct ocfs2_slot_info *si)
 {
@@ -383,7 +407,8 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 
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


