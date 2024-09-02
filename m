Return-Path: <stable+bounces-72703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75796832C
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63076283896
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D391C32F2;
	Mon,  2 Sep 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hgfCjh3I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6932187355
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269188; cv=none; b=RyYrZBRMjxwrW3B69VKX7vgqd1kZ+Slu1xH70lrZHk7uW08BvvErJBcLm+lnJd7B2xoAno1Fv42DpTSfs/X3rzGYpbceGOMIsi5qNP6Q61YfwCHImZAH5WfR80kRtxcsCJur3n0QrVpCt0FdTZa6dMg/YpnUL4CgIRkYpabvRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269188; c=relaxed/simple;
	bh=2o0ULimK06zWkew5dzj7e6hQxDRTLukcoM9dm+eYN1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RxKP+sk3Wir+QRbanpRg9E81rE+UZHok8KH7EO1zrmqtS3VjCC3ZqnX1Oyi3aqy8/ekvXRaAjg/UX8gvL0Boi19c91vgRfC9/zay/tARhxzZVCKSSwaTrCv2iwpoCm/hZfXXWJQHazeKu5PfLjyJCy/TAk+a0lPad+luOuiM1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hgfCjh3I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso1949516a91.2
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725269185; x=1725873985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGC2/wr/WrQEE/BTETF77jc4B4si+qDhZdrDFSYRq0o=;
        b=hgfCjh3IW/xvxHRtERPvYnvpZNCC355Gd0zBEpcFjkYpYJixjQrALHMvrpFb1D+vNM
         YQuewgssaNECOtf7e+NvPbi2CJBe1X9IGKjcnXXdOtu2M8lML30trHHsOzhWtXLheNnp
         zFcnR/9aFREafCxpQ6uzcreit8e7oJGqIQPXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269185; x=1725873985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGC2/wr/WrQEE/BTETF77jc4B4si+qDhZdrDFSYRq0o=;
        b=gWGT8267hsoDf29QMLwGH2Obik9QIK8/7kPqaYpAXPe77SC0HPNlIQYHyi24CVka38
         WMO118ehr9aeLrPfP+to17qptBr99tvzfmEZtmp4q+urk56AM1RV0wIfTJIoU7iH/w3N
         zn2BG6N9IbXO9KfabrRyunvJE0wfYXAuzncn1wmI8PlZOHXzReGs5MpAShLaX+yT0ZR9
         ArrTojZnMKv7UDMgw4aSh/cO9kQAswQ2LVc/kR7dgvcvXeoJ+fp9m+VLKBTIzEVQ0OXg
         QId71gVMIjA8S6iz8m6HPiOvsU3i06ZL3uMsXAo4l0WQ3OZsjbrv1iK1Ckh6c/IX/g5m
         dL8A==
X-Gm-Message-State: AOJu0Yz6FOJtWapwGC+guKHdlSqMwf3D+73GzNspyxIhMScv6t3uPbFm
	bPzqbuaQ/hngMsapUejY5BcRTCovmkkHdaiC+3GMAO0q4ck8ggUI5nJ9Q65XClAXQ2eHjEocY7T
	cVlv2+x1EuB2SyYZE5+MUuHlpvvVR1JR9eO84+SPSjJw/1pTjuGB5ia2ttrYKceHVfVuf3KeOXw
	hYTdzWjGoj5OAQs4EgNdsgvvW4s7Mp+jmxecGqoVH77QIH1P2FWQ==
X-Google-Smtp-Source: AGHT+IFFpNABbTR0Od9shAUxCDh79Vy9bj/kSc4NPnioHYER2337/NQN6V4/JU6s6tEeQo6iwe2zmw==
X-Received: by 2002:a17:90a:eb08:b0:2d8:d254:6cdd with SMTP id 98e67ed59e1d1-2d8d2547050mr2801998a91.38.1725269184969;
        Mon, 02 Sep 2024 02:26:24 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d82a6e0700sm7904747a91.1.2024.09.02.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:26:24 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	chenyuwen <yuwen.chen@xjmz.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1] f2fs: fix to truncate preallocated blocks in f2fs_file_open()
Date: Mon,  2 Sep 2024 02:26:16 -0700
Message-Id: <20240902092616.5249-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 298b1e4182d657c3e388adcc29477904e9600ed5 ]

chenyuwen reports a f2fs bug as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000011
 fscrypt_set_bio_crypt_ctx+0x78/0x1e8
 f2fs_grab_read_bio+0x78/0x208
 f2fs_submit_page_read+0x44/0x154
 f2fs_get_read_data_page+0x288/0x5f4
 f2fs_get_lock_data_page+0x60/0x190
 truncate_partial_data_page+0x108/0x4fc
 f2fs_do_truncate_blocks+0x344/0x5f0
 f2fs_truncate_blocks+0x6c/0x134
 f2fs_truncate+0xd8/0x200
 f2fs_iget+0x20c/0x5ac
 do_garbage_collect+0x5d0/0xf6c
 f2fs_gc+0x22c/0x6a4
 f2fs_disable_checkpoint+0xc8/0x310
 f2fs_fill_super+0x14bc/0x1764
 mount_bdev+0x1b4/0x21c
 f2fs_mount+0x20/0x30
 legacy_get_tree+0x50/0xbc
 vfs_get_tree+0x5c/0x1b0
 do_new_mount+0x298/0x4cc
 path_mount+0x33c/0x5fc
 __arm64_sys_mount+0xcc/0x15c
 invoke_syscall+0x60/0x150
 el0_svc_common+0xb8/0xf8
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x84
 el0t_64_sync_handler+0x88/0xec

It is because inode.i_crypt_info is not initialized during below path:
- mount
 - f2fs_fill_super
  - f2fs_disable_checkpoint
   - f2fs_gc
    - f2fs_iget
     - f2fs_truncate

So, let's relocate truncation of preallocated blocks to f2fs_file_open(),
after fscrypt_file_open().

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Reported-by: chenyuwen <yuwen.chen@xjmz.com>
Closes: https://lore.kernel.org/linux-kernel/20240517085327.1188515-1-yuwen.chen@xjmz.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  8 --------
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a02c74875..2b540d878 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -788,6 +788,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_OPENED_FILE,         /* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c6fb179f9..62f2521cd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -538,6 +538,42 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	inode_lock(inode);
+	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	if (!file_should_truncate(inode)) {
+		set_inode_flag(inode, FI_OPENED_FILE);
+		inode_unlock(inode);
+		return 0;
+	}
+
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
+
+	truncate_setsize(inode, i_size_read(inode));
+	ret = f2fs_truncate(inode);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+	if (!ret)
+		set_inode_flag(inode, FI_OPENED_FILE);
+
+	inode_unlock(inode);
+	if (ret)
+		return ret;
+
+	file_dont_truncate(inode);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
@@ -554,7 +590,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 
 	filp->f_mode |= FMODE_NOWAIT;
 
-	return dquot_file_open(inode, filp);
+	err = dquot_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return finish_preallocate_blocks(inode);
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff4a4e92a..5b672df19 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -549,14 +549,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode) &&
-			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
-		ret = f2fs_truncate(inode);
-		if (ret)
-			goto bad_inode;
-		file_dont_truncate(inode);
-	}
-
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- 
2.39.4


