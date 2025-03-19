Return-Path: <stable+bounces-125569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC61A6929D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D39C1B80A70
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4E208966;
	Wed, 19 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLGgMlky"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509D204F6A
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396099; cv=none; b=rOBm11j9gt89LmTPBUIh97cUHnKLLBhAL2Bzbn8ozki7CoJ9kSwKpEGku1LEY4jOfMFvdWz+zGI7r0L+lvIOD8HDcE0cA4lPu2YB0H38HuQPb8lyTTDsSH6gtlcb4F1LXrQilBlXSKWeL4UAlT30wb8NSnSFdOw4G9Uy1RHzO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396099; c=relaxed/simple;
	bh=KV44fz8US0cl8eBrUeHYnasyblTU+jLI9Lw0H2d89JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwHx+UlAOHKR+LbG8QkVkrx6HtfUF/+DF+aNxD5BDRyMzUWeBqLRYWju9EjVIkpjwRf0wlPY7lfEZjTEU978//L3HC2iehJ6USCpeQo7OPzhvlo8hdMO+GM1goKFG7paJDElAlV7BYHkYw1Hjz73J63r1Lr8sXPRD/KIFt3/j68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLGgMlky; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3978ef9a778so255550f8f.0
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742396095; x=1743000895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1GGsQ7FA9uZcbXRW7k1pWSZGSvJM4R9lsGZrY0+JqU=;
        b=aLGgMlkyXe8mYBQ+tQtOOgWJr5lhjxPpdDIKzRvDapA/rgh6xcdjyaU/EgP1FYlzo6
         +D1r/5Wepv9rimVn6f+zAh6dpJtrCF0wPSb2bDxw4yLD9eYFQM7Hpt9Vcw64KukLq0R+
         qO4dyCmfDW2SB8qVsqIXRJnm84xHzdFe+rYdXutIDTpgwWiufhcEWHNj+rZ+4YidiFG2
         eH7I9XJSrFCS6YKCD5ORuPShq2iS2z+psuZdsUfclrwQ974vYfHUA6T3HjsfUhpyf4VH
         +CVr6CNyOEjjxQB3Gwz7LinpSmFi8m9E0+ghi7dKbGH8f9cKJzRNY7QcegioXTDpgeLW
         B3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396095; x=1743000895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1GGsQ7FA9uZcbXRW7k1pWSZGSvJM4R9lsGZrY0+JqU=;
        b=BzAd5/jNJVj+EasGsaHyyjBwzPPBaouj6EvoUytOVWJHdXKhuG7jx9I59swUklO17z
         Jd0cMaGd6C435yWvVzkJ5mFAo6WnTQuiCywBfeowl/5KAXFg92VflhNyPStLzZxjirdw
         52q/+f3Ja1fLYbID8cSXA6NunfjIXNeLt8w0L3dsRSU1FpmdbwLPLkjDkopfZyrxznh5
         iS5dNURQzKoTScw6aZv9kIO8Y8L0erCXaoWjXSs1BdGau4x4nJw05AriQykWqhzlO6iZ
         /kXtgDq1BLwAUH1D3eWn1wnI0LOto3gsMEHxXBUp/kyAtOfuwOv9Rr5w8dunv7okjkz2
         7bDg==
X-Gm-Message-State: AOJu0YxLggOIvm4NKAeiVkKLYhmCQ2Q7NPabuDp+pLsl9SN7ACsY7+LF
	NILGtaAcwwvVQRr4n2YNgjT19eMnBOWT1wt6bjWNNsd6x9YhGGabeqdbI5pkEec=
X-Gm-Gg: ASbGncv3R71Ze7gC/HKJaJi1nNNeeo1terVnQEPAX+zjTh5dn+Sv7CjqwlMmuawz684
	hgGy/l8eqYl+Fu7AdKWttO5D07ZpvS2WuNr/etj0LCy8urEk+6tJfzMwroc7dLTUqdeFSkTlDel
	bOS2DvnvWjgidTWAVTACqzxHKC6GIEZwxxFpILLWH+1zYgQh6DRz5J+dKgwywKgn01PW39qwJKh
	uoXI1ro949n/X3z+PHDCAYkAhB1xGyB1iIl5IzKe/YJnkeHxCVmIqt7cXp74bQMn3GsBgjzU6gq
	vxZyvzxHSwvy9eOMrIEnGss3P5VPtYHYo7Oet5G2NFkyHespypPAO2V/BYB162junDEEegwQZPU
	MX2TZa+oxlYfGzjCvgPuos2I=
X-Google-Smtp-Source: AGHT+IGjlpnihnAGnlWKh0ATO5JXXuMKSKjmtaNQKQdxqiZWi3kUTCqc5HC9R/vt79eBYPTqFPZT6w==
X-Received: by 2002:a5d:47ce:0:b0:390:ea34:dff3 with SMTP id ffacd0b85a97d-399739b9928mr1077939f8f.3.1742396094739;
        Wed, 19 Mar 2025 07:54:54 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a12sm21145458f8f.75.2025.03.19.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:54:54 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+f3e5d0948a1837ed1bb0@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y] fs/ntfs3: Change new sparse cluster processing
Date: Wed, 19 Mar 2025 15:54:36 +0100
Message-Id: <20250319145436.79713-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b upstream.

This patch is a backport.
Remove ntfs_sparse_cluster.
Zero clusters in attr_allocate_clusters.
Fixes xfstest generic/263

The fix has been verified by executing the syzkaller reproducer test case.

Bug: https://syzkaller.appspot.com/bug?extid=f3e5d0948a1837ed1bb0
Reported-by: syzbot+f3e5d0948a1837ed1bb0@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
(cherry picked from commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b)
---
 fs/ntfs3/attrib.c  | 176 +++++++++++++++++++++++++++++++--------------
 fs/ntfs3/file.c    | 151 +++++++++-----------------------------
 fs/ntfs3/frecord.c |   2 +-
 fs/ntfs3/index.c   |   4 +-
 fs/ntfs3/inode.c   |  12 ++--
 fs/ntfs3/ntfs_fs.h |   7 +-
 6 files changed, 166 insertions(+), 186 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0388e6b42100..3e402b597e0f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -176,7 +176,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn)
+			   CLST *new_lcn, CLST *new_len)
 {
 	int err;
 	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
@@ -196,20 +196,36 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		if (err)
 			goto out;
 
-		if (new_lcn && vcn == vcn0)
-			*new_lcn = lcn;
+		if (vcn == vcn0) {
+			/* Return the first fragment. */
+			if (new_lcn)
+				*new_lcn = lcn;
+			if (new_len)
+				*new_len = flen;
+		}
 
 		/* Add new fragment into run storage. */
-		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
+		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
 			/* Undo last 'ntfs_look_for_free_space' */
 			mark_as_free_ex(sbi, lcn, len, false);
 			err = -ENOMEM;
 			goto out;
 		}
 
+		if (opt & ALLOCATE_ZERO) {
+			u8 shift = sbi->cluster_bits - SECTOR_SHIFT;
+
+			err = blkdev_issue_zeroout(sbi->sb->s_bdev,
+						   (sector_t)lcn << shift,
+						   (sector_t)flen << shift,
+						   GFP_NOFS, 0);
+			if (err)
+				goto out;
+		}
+
 		vcn += flen;
 
-		if (flen >= len || opt == ALLOCATE_MFT ||
+		if (flen >= len || (opt & ALLOCATE_MFT) ||
 		    (fr && run->count - cnt >= fr)) {
 			*alen = vcn - vcn0;
 			return 0;
@@ -287,7 +303,8 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 		const char *data = resident_data(attr);
 
 		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
-					     ALLOCATE_DEF, &alen, 0, NULL);
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out1;
 
@@ -582,13 +599,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			/* ~3 bytes per fragment. */
 			err = attr_allocate_clusters(
 				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
-				is_mft ? ALLOCATE_MFT : 0, &alen,
+				is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
 				is_mft ? 0
 				       : (sbi->record_size -
 					  le32_to_cpu(rec->used) + 8) /
 							 3 +
 						 1,
-				NULL);
+				NULL, NULL);
 			if (err)
 				goto out;
 		}
@@ -886,8 +903,19 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	return err;
 }
 
+/*
+ * attr_data_get_block - Returns 'lcn' and 'len' for given 'vcn'.
+ *
+ * @new == NULL means just to get current mapping for 'vcn'
+ * @new != NULL means allocate real cluster if 'vcn' maps to hole
+ * @zero - zeroout new allocated clusters
+ *
+ *  NOTE:
+ *  - @new != NULL is called only for sparsed or compressed attributes.
+ *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
+ */
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new)
+			CLST *len, bool *new, bool zero)
 {
 	int err = 0;
 	struct runs_tree *run = &ni->file.run;
@@ -896,29 +924,27 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
+	unsigned int fr;
 	u64 total_size;
-	u32 clst_per_frame;
-	bool ok;
 
 	if (new)
 		*new = false;
 
+	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
-	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		*len = 0;
 	up_read(&ni->file.run_lock);
 
-	if (ok && (*lcn != SPARSE_LCN || !new)) {
-		/* Normal way. */
-		return 0;
+	if (*len) {
+		if (*lcn != SPARSE_LCN || !new)
+			return 0; /* Fast normal way without allocation. */
+		else if (clen > *len)
+			clen = *len;
 	}
 
-	if (!clen)
-		clen = 1;
-
-	if (ok && clen > *len)
-		clen = *len;
-
+	/* No cluster in cache or we need to allocate cluster in hole. */
 	sbi = ni->mi.sbi;
 	cluster_bits = sbi->cluster_bits;
 
@@ -944,12 +970,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 	}
 
-	clst_per_frame = 1u << attr_b->nres.c_unit;
-	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
-
-	if (vcn + to_alloc > asize)
-		to_alloc = asize - vcn;
-
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
 
@@ -968,36 +988,68 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
 	}
 
+	/* Load in cache actual information. */
 	err = attr_load_runs(attr, ni, run, NULL);
 	if (err)
 		goto out;
 
-	if (!ok) {
-		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
-		if (ok && (*lcn != SPARSE_LCN || !new)) {
-			/* Normal way. */
-			err = 0;
-			goto ok;
-		}
+	if (!*len) {
+		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+			if (*lcn != SPARSE_LCN || !new)
+				goto ok; /* Slow normal way without allocation. */
 
-		if (!ok && !new) {
-			*len = 0;
-			err = 0;
+			if (clen > *len)
+				clen = *len;
+		} else if (!new) {
+			/* Here we may return -ENOENT.
+			 * In any case caller gets zero length. */
 			goto ok;
 		}
-
-		if (ok && clen > *len) {
-			clen = *len;
-			to_alloc = (clen + clst_per_frame - 1) &
-				   ~(clst_per_frame - 1);
-		}
 	}
 
 	if (!is_attr_ext(attr_b)) {
+		/* The code below only for sparsed or compressed attributes. */
 		err = -EINVAL;
 		goto out;
 	}
 
+	vcn0 = vcn;
+	to_alloc = clen;
+	fr = (sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1;
+	/* Allocate frame aligned clusters.
+	 * ntfs.sys usually uses 16 clusters per frame for sparsed or compressed.
+	 * ntfs3 uses 1 cluster per frame for new created sparsed files. */
+	if (attr_b->nres.c_unit) {
+		CLST clst_per_frame = 1u << attr_b->nres.c_unit;
+		CLST cmask = ~(clst_per_frame - 1);
+
+		/* Get frame aligned vcn and to_alloc. */
+		vcn = vcn0 & cmask;
+		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
+		if (fr < clst_per_frame)
+			fr = clst_per_frame;
+		zero = true;
+
+		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
+		if (vcn < svcn || evcn1 <= vcn) {
+			/* Load attribute for truncated vcn. */
+			attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0,
+					    &vcn, &mi);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+			err = attr_load_runs(attr, ni, run, NULL);
+			if (err)
+				goto out;
+		}
+	}
+
+	if (vcn + to_alloc > asize)
+		to_alloc = asize - vcn;
+
 	/* Get the last LCN to allocate from. */
 	hint = 0;
 
@@ -1011,18 +1063,33 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		hint = -1;
 	}
 
-	err = attr_allocate_clusters(
-		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
-		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
-		lcn);
+	/* Allocate and zeroout new clusters. */
+	err = attr_allocate_clusters(sbi, run, vcn, hint + 1, to_alloc, NULL,
+				     zero ? ALLOCATE_ZERO : ALLOCATE_DEF, &alen,
+				     fr, lcn, len);
 	if (err)
 		goto out;
 	*new = true;
 
-	end = vcn + *len;
-
+	end = vcn + alen;
 	total_size = le64_to_cpu(attr_b->nres.total_size) +
-		     ((u64)*len << cluster_bits);
+		     ((u64)alen << cluster_bits);
+
+	if (vcn != vcn0) {
+		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (*lcn == SPARSE_LCN) {
+			/* Internal error. Should not happened. */
+			WARN_ON(1);
+			err = -EINVAL;
+			goto out;
+		}
+		/* Check case when vcn0 + len overlaps new allocated clusters. */
+		if (vcn0 + *len > end)
+			*len = end - vcn0;
+	}
 
 repack:
 	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
@@ -1547,7 +1614,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST svcn, evcn1, next_svcn, len;
 	CLST vcn, end, clst_data;
 	u64 total_size, valid_size, data_size;
 
@@ -1623,8 +1690,9 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 		}
 
 		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
-					     hint + 1, len - clst_data, NULL, 0,
-					     &alen, 0, &lcn);
+					     hint + 1, len - clst_data, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 70b38465aee3..72e25842f5dc 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -122,8 +122,8 @@ static int ntfs_extend_initialized_size(struct file *file,
 			bits = sbi->cluster_bits;
 			vcn = pos >> bits;
 
-			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen,
-						  NULL);
+			err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL,
+						  false);
 			if (err)
 				goto out;
 
@@ -196,18 +196,18 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	struct address_space *mapping = inode->i_mapping;
 	u32 blocksize = 1 << inode->i_blkbits;
 	pgoff_t idx = vbo >> PAGE_SHIFT;
-	u32 z_start = vbo & (PAGE_SIZE - 1);
+	u32 from = vbo & (PAGE_SIZE - 1);
 	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	loff_t page_off;
 	struct buffer_head *head, *bh;
-	u32 bh_next, bh_off, z_end;
+	u32 bh_next, bh_off, to;
 	sector_t iblock;
 	struct page *page;
 
-	for (; idx < idx_end; idx += 1, z_start = 0) {
+	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
-		z_end = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
-							: PAGE_SIZE;
+		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
+						     : PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
 		page = find_or_create_page(mapping, idx,
@@ -224,7 +224,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		do {
 			bh_next = bh_off + blocksize;
 
-			if (bh_next <= z_start || bh_off >= z_end)
+			if (bh_next <= from || bh_off >= to)
 				continue;
 
 			if (!buffer_mapped(bh)) {
@@ -258,7 +258,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
-		zero_user_segment(page, z_start, z_end);
+		zero_user_segment(page, from, to);
 
 		unlock_page(page);
 		put_page(page);
@@ -269,81 +269,6 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	return err;
 }
 
-/*
- * ntfs_sparse_cluster - Helper function to zero a new allocated clusters.
- *
- * NOTE: 512 <= cluster size <= 2M
- */
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u64 vbo = (u64)vcn << sbi->cluster_bits;
-	u64 bytes = (u64)len << sbi->cluster_bits;
-	u32 blocksize = 1 << inode->i_blkbits;
-	pgoff_t idx0 = page0 ? page0->index : -1;
-	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
-	loff_t end = ntfs_up_cluster(sbi, vbo + bytes);
-	pgoff_t idx = vbo_clst >> PAGE_SHIFT;
-	u32 from = vbo_clst & (PAGE_SIZE - 1);
-	pgoff_t idx_end = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	loff_t page_off;
-	u32 to;
-	bool partial;
-	struct page *page;
-
-	for (; idx < idx_end; idx += 1, from = 0) {
-		page = idx == idx0 ? page0 : grab_cache_page(mapping, idx);
-
-		if (!page)
-			continue;
-
-		page_off = (loff_t)idx << PAGE_SHIFT;
-		to = (page_off + PAGE_SIZE) > end ? (end - page_off)
-						  : PAGE_SIZE;
-		partial = false;
-
-		if ((from || PAGE_SIZE != to) &&
-		    likely(!page_has_buffers(page))) {
-			create_empty_buffers(page, blocksize, 0);
-		}
-
-		if (page_has_buffers(page)) {
-			struct buffer_head *head, *bh;
-			u32 bh_off = 0;
-
-			bh = head = page_buffers(page);
-			do {
-				u32 bh_next = bh_off + blocksize;
-
-				if (from <= bh_off && bh_next <= to) {
-					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
-				} else if (!buffer_uptodate(bh)) {
-					partial = true;
-				}
-				bh_off = bh_next;
-			} while (head != (bh = bh->b_this_page));
-		}
-
-		zero_user_segment(page, from, to);
-
-		if (!partial) {
-			if (!PageUptodate(page))
-				SetPageUptodate(page);
-			set_page_dirty(page);
-		}
-
-		if (idx != idx0) {
-			unlock_page(page);
-			put_page(page);
-		}
-		cond_resched();
-	}
-	mark_inode_dirty(inode);
-}
-
 /*
  * ntfs_file_mmap - file_operations::mmap
  */
@@ -385,13 +310,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 			for (; vcn < end; vcn += len) {
 				err = attr_data_get_block(ni, vcn, 1, &lcn,
-							  &len, &new);
+							  &len, &new, true);
 				if (err)
 					goto out;
-
-				if (!new)
-					continue;
-				ntfs_sparse_cluster(inode, NULL, vcn, 1);
 			}
 		}
 
@@ -532,7 +453,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t end = vbo + len;
-	loff_t vbo_down = round_down(vbo, PAGE_SIZE);
+	loff_t vbo_down = round_down(vbo, max_t(unsigned long,
+						sbi->cluster_size, PAGE_SIZE));
 	bool is_supported_holes = is_sparsed(ni) || is_compressed(ni);
 	loff_t i_size, new_size;
 	bool map_locked;
@@ -585,11 +507,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		u32 frame_size;
 		loff_t mask, vbo_a, end_a, tmp;
 
-		err = filemap_write_and_wait_range(mapping, vbo, end - 1);
-		if (err)
-			goto out;
-
-		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, vbo_down,
+						   LLONG_MAX);
 		if (err)
 			goto out;
 
@@ -692,39 +611,35 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			goto out;
 
 		if (is_supported_holes) {
-			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
 			CLST vcn = vbo >> sbi->cluster_bits;
 			CLST cend = bytes_to_cluster(sbi, end);
+			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
 			CLST lcn, clen;
 			bool new;
 
+			if (cend_v > cend)
+				cend_v = cend;
+
 			/*
-			 * Allocate but do not zero new clusters. (see below comments)
-			 * This breaks security: One can read unused on-disk areas.
+			 * Allocate and zero new clusters.
 			 * Zeroing these clusters may be too long.
-			 * Maybe we should check here for root rights?
+			 */
+			for (; vcn < cend_v; vcn += clen) {
+				err = attr_data_get_block(ni, vcn, cend_v - vcn,
+							  &lcn, &clen, &new,
+							  true);
+				if (err)
+					goto out;
+			}
+			/*
+			 * Allocate but not zero new clusters.
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
-							  &lcn, &clen, &new);
+							  &lcn, &clen, &new,
+							  false);
 				if (err)
 					goto out;
-				if (!new || vcn >= vcn_v)
-					continue;
-
-				/*
-				 * Unwritten area.
-				 * NTFS is not able to store several unwritten areas.
-				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters.
-				 *
-				 * Dangerous in case:
-				 * 1G of sparsed clusters + 1 cluster of data =>
-				 * valid_size == 1G + 1 cluster
-				 * fallocate(1G) will zero 1G and this can be very long
-				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'.
-				 */
-				ntfs_sparse_cluster(inode, NULL, vcn,
-						    min(vcn_v - vcn, clen));
 			}
 		}
 
@@ -945,8 +860,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		frame_vbo = valid & ~(frame_size - 1);
 		off = valid & (frame_size - 1);
 
-		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0, &lcn,
-					  &clen, NULL);
+		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
+					  &clen, NULL, false);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d41ddc06f207..fb572688f919 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2297,7 +2297,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new);
+						  &clen, &new, false);
 			if (err)
 				goto out;
 		}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2589f6d1215f..2dfe74a3de75 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1442,8 +1442,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	run_init(&run);
 
-	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
-				     NULL);
+	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, ALLOCATE_DEF,
+				     &alen, 0, NULL, NULL);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 057aa3cec902..5baf6a2b3d48 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -592,7 +592,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	off = vbo & sbi->cluster_mask;
 	new = false;
 
-	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL);
+	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL,
+				  create && sbi->cluster_size > PAGE_SIZE);
 	if (err)
 		goto out;
 
@@ -610,11 +611,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 		WARN_ON(1);
 	}
 
-	if (new) {
+	if (new)
 		set_buffer_new(bh);
-		if ((len << cluster_bits) > block_size)
-			ntfs_sparse_cluster(inode, page, vcn, len);
-	}
 
 	lbo = ((u64)lcn << cluster_bits) + off;
 
@@ -1533,8 +1531,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
 
 			err = attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
-						     clst, NULL, 0, &alen, 0,
-						     NULL);
+						     clst, NULL, ALLOCATE_DEF,
+						     &alen, 0, NULL, NULL);
 			if (err)
 				goto out5;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 26dbe1b46fdd..05d9abd66b37 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -126,6 +126,7 @@ struct ntfs_buffers {
 enum ALLOCATE_OPT {
 	ALLOCATE_DEF = 0, // Allocate all clusters.
 	ALLOCATE_MFT = 1, // Allocate for MFT.
+	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters
 };
 
 enum bitmap_mutex_classes {
@@ -416,7 +417,7 @@ enum REPARSE_SIGN {
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn);
+			   CLST *new_lcn, CLST *new_len);
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
 			  u64 new_size, struct runs_tree *run,
@@ -426,7 +427,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
 		  struct ATTRIB **ret);
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new);
+			CLST *len, bool *new, bool zero);
 int attr_data_read_resident(struct ntfs_inode *ni, struct page *page);
 int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
@@ -491,8 +492,6 @@ extern const struct file_operations ntfs_dir_operations;
 /* Globals from file.c */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len);
 int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct iattr *attr);
 int ntfs_file_open(struct inode *inode, struct file *file);
-- 
2.34.1


