Return-Path: <stable+bounces-58262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98692AF6E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 07:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5ECAB21239
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814223B78D;
	Tue,  9 Jul 2024 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFTjHksl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4763A
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503208; cv=none; b=iie7HJPABBdr4ketmgEevmM6bltV+P3v6+B0T3SmaRDTPeiNwmHzPesVPQnHfq/YS7eumrkfz+ch2I+Kp76qvaEejxfBoLojInRmynyMzqcQ4JZMrQUaI09yq4AKVP6VMO6y2+NPGPeJ+FCisgC+RRpZ2RHGBfXx0Fuj59TczEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503208; c=relaxed/simple;
	bh=d4alURZNvV6R5cOqoWKs2soxsHFDee+0gNpbuhdbcc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMISkoAmNsGSQooxYxoiBf6QXGekOZcOwDJic4qp4RXMzkpCrIXt4Le0RPk2oBrf8+P7IE0dCbftdNk5KbDMATMYm/ZECckZ2Uycc6qxBTZQHTvvy72T0DE6OHd5P2o/1elW64J/zv6ZNt6pSZWgteGZJFYV+C2C2odvqD9xPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFTjHksl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-72ed1fbc5d9so3117310a12.0
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 22:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503203; x=1721108003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3HbPA06WadswGRXtLttyGSVaS5iOxmiRrU+LFfHNuQ=;
        b=IFTjHkslkYNmpY+xdcWEqggh6QsrY9i5EzkL59qrJRebHWb7qB7oyROu0bNlqig2RC
         CoV+lnyFG/w1HWMZ5KNZ0S9cAQJFPCp3pxtBlEbetp8zVxXpbmqUL3uP3p+Ak9g4NDii
         U+2zb1pjVN6qk/Th9zfGzeDzi350cE5AkIZw7tLIWefbU4PeUkA9cGujAF1CaPnAzRFL
         rldviwn/9+Ir1BBKFc6PI4FsHO9hVQnFqSYSpxYwbYx0QTU8njBLeXLatD/GicWheA4E
         2WDne2jt0ZXy56gIaHdrBVQTIgS/S0ALKXSfBCfdVZPvogqOg1caRYPnDBx5BAcodMIo
         dlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503203; x=1721108003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3HbPA06WadswGRXtLttyGSVaS5iOxmiRrU+LFfHNuQ=;
        b=hujjrzuPQIbmo00wOGb4EmfOPriBIO1+o/zrXRb7p36LMKr9al2d3C8qnaGXpXy3wE
         ADq5fbhHq0UAYfO+PKOkTvDfWmL0w1oleehjuR1IAfnnJ99Izpc3uPWGl69JO3YvcsPN
         YlsRPZUwFmhS2p6S1JCwGg2SJknnDmq44qijtQwOXYY4Vi6lDyFAi2GuStsNDZa04iO8
         S7L0iXldJf2JAZNQSjnbN8sVxKA6B0D/QB3OrtltaX1fhUC57ILZERT6fYcioTxVPlaO
         herZz0z5aRUYx/OgBd/19RTlAHAYWienIj+2fNA9E2TnpJoZohuV3PULOTUF4GTvLAG3
         RJjQ==
X-Gm-Message-State: AOJu0YzCWyqf4wnRqmVDNMT1Lo775fo62t2gQyUUrYJ8zt6AbH/VL8IF
	90l/xDY+wQqIsbHTXd7FgyponycfaK2N16Y2m4FHqkOReb0Y8YjArS9mKg==
X-Google-Smtp-Source: AGHT+IHoyzLHPg0nqNPm32H93AOkQyVJ02VZpqGy2XqLQpYQNm4yUTgIQlxjhdCU1z8dSq5zVOhihQ==
X-Received: by 2002:a05:6a20:4a1e:b0:1c2:8b78:880 with SMTP id adf61e73a8af0-1c2984c85e5mr1550436637.41.1720503203325;
        Mon, 08 Jul 2024 22:33:23 -0700 (PDT)
Received: from carrot.. (i222-151-34-139.s42.a014.ap.plala.or.jp. [222.151.34.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad1217sm7363685ad.280.2024.07.08.22.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:33:22 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	hdanton@sina.com,
	jack@suse.cz,
	willy@infradead.org
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix incorrect inode allocation from reserved inodes
Date: Tue,  9 Jul 2024 14:33:18 +0900
Message-Id: <20240709053318.4528-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 93aef9eda1cea9e84ab2453fcceb8addad0e46f1 upstream.

If the bitmap block that manages the inode allocation status is corrupted,
nilfs_ifile_create_inode() may allocate a new inode from the reserved
inode area where it should not be allocated.

Previous fix commit d325dc6eb763 ("nilfs2: fix use-after-free bug of
struct nilfs_root"), fixed the problem that reserved inodes with inode
numbers less than NILFS_USER_INO (=11) were incorrectly reallocated due to
bitmap corruption, but since the start number of non-reserved inodes is
read from the super block and may change, in which case inode allocation
may occur from the extended reserved inode area.

If that happens, access to that inode will cause an IO error, causing the
file system to degrade to an error state.

Fix this potential issue by adding a wraparound option to the common
metadata object allocation routine and by modifying
nilfs_ifile_create_inode() to disable the option so that it only allocates
inodes with inode numbers greater than or equal to the inode number read
in "nilfs->ns_first_ino", regardless of the bitmap status of reserved
inodes.

Link: https://lkml.kernel.org/r/20240623051135.4180-4-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the patch that failed.

This patch is tailored to avoid conflicts with a series involving
extensive conversions and can be applied from v4.8 to v6.8.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/alloc.c | 18 ++++++++++++++----
 fs/nilfs2/alloc.h |  4 ++--
 fs/nilfs2/dat.c   |  2 +-
 fs/nilfs2/ifile.c |  7 ++-----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 7342de296ec3..25881bdd212b 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -377,11 +377,12 @@ void *nilfs_palloc_block_get_entry(const struct inode *inode, __u64 nr,
  * @target: offset number of an entry in the group (start point)
  * @bsize: size in bits
  * @lock: spin lock protecting @bitmap
+ * @wrap: whether to wrap around
  */
 static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 					    unsigned long target,
 					    unsigned int bsize,
-					    spinlock_t *lock)
+					    spinlock_t *lock, bool wrap)
 {
 	int pos, end = bsize;
 
@@ -397,6 +398,8 @@ static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 
 		end = target;
 	}
+	if (!wrap)
+		return -ENOSPC;
 
 	/* wrap around */
 	for (pos = 0; pos < end; pos++) {
@@ -495,9 +498,10 @@ int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
  * nilfs_palloc_prepare_alloc_entry - prepare to allocate a persistent object
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the allocation
+ * @wrap: whether to wrap around
  */
 int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
-				     struct nilfs_palloc_req *req)
+				     struct nilfs_palloc_req *req, bool wrap)
 {
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
@@ -516,7 +520,7 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 	entries_per_group = nilfs_palloc_entries_per_group(inode);
 
 	for (i = 0; i < ngroups; i += n) {
-		if (group >= ngroups) {
+		if (group >= ngroups && wrap) {
 			/* wrap around */
 			group = 0;
 			maxgroup = nilfs_palloc_group(inode, req->pr_entry_nr,
@@ -541,7 +545,13 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 				bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
 				pos = nilfs_palloc_find_available_slot(
 					bitmap, group_offset,
-					entries_per_group, lock);
+					entries_per_group, lock, wrap);
+				/*
+				 * Since the search for a free slot in the
+				 * second and subsequent bitmap blocks always
+				 * starts from the beginning, the wrap flag
+				 * only has an effect on the first search.
+				 */
 				if (pos >= 0) {
 					/* found a free entry */
 					nilfs_palloc_group_desc_add_entries(
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index b667e869ac07..d825a9faca6d 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -50,8 +50,8 @@ struct nilfs_palloc_req {
 	struct buffer_head *pr_entry_bh;
 };
 
-int nilfs_palloc_prepare_alloc_entry(struct inode *,
-				     struct nilfs_palloc_req *);
+int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
+				     struct nilfs_palloc_req *req, bool wrap);
 void nilfs_palloc_commit_alloc_entry(struct inode *,
 				     struct nilfs_palloc_req *);
 void nilfs_palloc_abort_alloc_entry(struct inode *, struct nilfs_palloc_req *);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9cf6ba58f585..351010828d88 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -75,7 +75,7 @@ int nilfs_dat_prepare_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	int ret;
 
-	ret = nilfs_palloc_prepare_alloc_entry(dat, req);
+	ret = nilfs_palloc_prepare_alloc_entry(dat, req, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index a8a4bc8490b4..ac10a62a41e9 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -55,13 +55,10 @@ int nilfs_ifile_create_inode(struct inode *ifile, ino_t *out_ino,
 	struct nilfs_palloc_req req;
 	int ret;
 
-	req.pr_entry_nr = 0;  /*
-			       * 0 says find free inode from beginning
-			       * of a group. dull code!!
-			       */
+	req.pr_entry_nr = NILFS_FIRST_INO(ifile->i_sb);
 	req.pr_entry_bh = NULL;
 
-	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req);
+	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req, false);
 	if (!ret) {
 		ret = nilfs_palloc_get_entry_block(ifile, req.pr_entry_nr, 1,
 						   &req.pr_entry_bh);
-- 
2.43.5


