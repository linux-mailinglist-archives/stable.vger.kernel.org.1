Return-Path: <stable+bounces-58126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C599283A3
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8FD1C2438F
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E8145A16;
	Fri,  5 Jul 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jxi04vmT"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D9145A03
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167916; cv=none; b=AM4vd4zdAagJq+oS4TnBlEDFT3yRmFcyRbU7UD2aBhybIVAysDXAVIwGRG7oLuvDFrzSY0oBwRx95b94qsLLYVWJi+K+3TciknU8Z3U/f/zz57E8JfFxHStvPjqCTUFL5n77kDNjZOn2MudEgc3kzDRDfsj3JJQis0bRlX3tpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167916; c=relaxed/simple;
	bh=NR/1D+BcRV/TsLKrMtyxlQAtAuDdLOC2Gn95KDoEHJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hjd2ZK/95n8fPHqlV1kGHn4CKLQBbe+PLUm3NsbiOkXq8JgzPskFNizPn8AfZWj3FjSs2HzPUacJRouo6vX5F6a4Ol4R+qPvLevcQxrsRTaJj9Wzg23AIUtaGC4bWkf17hwOsSR7eYc1m4Gi7B5LuRslUYbG/iRWJu8Ahc400oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Jxi04vmT; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240705082512epoutp03abb35c71f0bf44b4b99a349621deca70~fQ5o0HN7A2207122071epoutp03J
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 08:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240705082512epoutp03abb35c71f0bf44b4b99a349621deca70~fQ5o0HN7A2207122071epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720167912;
	bh=yjiQRI88LrEgQXuAT2KgD2ughIWt1fQ1A7RP58k7J2c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Jxi04vmTYWHQisaGxNAO70Q2M6JX7mljei6uRTxJtWEUM4R23uC0fagtvJ0UmSuyD
	 um3blOlRqxt+ekkc/0lysq5wtPhVexIoStdVWJl8P5g5Ty1/POTsMrjv/hHGmNCK/O
	 YIBLw+VAmLS3oRSGW2xSbZ3kZ9ty32AiSlAQA2+s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240705082511epcas1p10cdb1a06d4257b48d6db75d1968c2e44~fQ5oinNMn1756817568epcas1p1U;
	Fri,  5 Jul 2024 08:25:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WFmm7488Nz4x9Pt; Fri,  5 Jul
	2024 08:25:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.06.09910.7EDA7866; Fri,  5 Jul 2024 17:25:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69~fQ5n6U0hh1315913159epcas1p23;
	Fri,  5 Jul 2024 08:25:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240705082511epsmtrp23c1de109b1ef9173de99959af431a8d5~fQ5n5ubAW2780227802epsmtrp2d;
	Fri,  5 Jul 2024 08:25:11 +0000 (GMT)
X-AuditID: b6c32a38-c9ffa700000226b6-97-6687ade7a06e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.40.29940.7EDA7866; Fri,  5 Jul 2024 17:25:11 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240705082511epsmtip2df6cc542e7a1643d3f4e762addc5c5e8~fQ5nu0crb2772627726epsmtip2X;
	Fri,  5 Jul 2024 08:25:11 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net, Sunmin
	Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH v2 2/2] f2fs: use meta inode for GC of COW file
Date: Fri,  5 Jul 2024 17:25:03 +0900
Message-Id: <20240705082503.805358-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmge7zte1pBn/+yFucnnqWyWJq+15G
	iyfrZzFbXFrkbrGg9TeLxZZ/R1gtFmx8xGgxY/9TdgcOjwWbSj02repk89i94DOTR9+WVYwe
	nzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
	AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAw
	MgUqTMjOmLLqFGtBq1bFr09pDYzXlLoYOTkkBEwkLm9oY+ti5OIQEtjBKHFoxTQo5xOjxLp7
	TxghnG+MErM27WGBaTm/4DArRGIvUEvjZVaQBFhL8/EyEJtNQEfi4dTbYA0iAuoSpyYtZQFp
	YBa4yijRvu85WEJYwF7iy6TzzCA2i4CqxNwnO8DivAK2EkeOvGOC2CYvMfPSd3aIuKDEyZlP
	wGqYgeLNW2czgwyVELjELnFp430ghwPIcZE4tUEOoldY4tXxLewQtpTE53d72SDsYomj8zew
	Q/Q2MErc+HoTqsheorm1mQ1kDrOApsT6XfoQu/gk3n3tYYUYzyvR0SYEUa0q0f1oCTOELS2x
	7NhBdogSD4mXPy0gQRIr8WRvC/sERrlZSB6YheSBWQi7FjAyr2IUSy0ozk1PLTYsMIHHY3J+
	7iZGcPrTstjBOPftB71DjEwcjIcYJTiYlUR4pd43pwnxpiRWVqUW5ccXleakFh9iNAUG6URm
	KdHkfGACziuJNzSxNDAxMzKxMLY0NlMS5z1zpSxVSCA9sSQ1OzW1ILUIpo+Jg1OqgUlcsK56
	FWdSdRtn08Zp2o0Tee5t8Ld9U2i2I0PrtIi31YWvVs1GOTJunCtzX+dJfGCb9mP60mk/6nor
	LrQ0+CS95j2xMU9YyW3nYb814nobdzkuMVR0lr285IP8xbUC4kscrq/6c+r1sbPqPMsUVi32
	TJwx10x94aY+nTUsib3O3u+Nj+4S/JexeV5aSqn6P80JJ30uZ+lM61V/5HJjrbZcwbmJrz94
	6B9+tUhP3lLlkFaSClPpenPVv2f3Ofdud1+hoKhicMjjom9nuaROh8Gj1Qpa371lnBW8J6lm
	bys4uPxwSJrFTo0dexbLWE5vm7vsGcce13SV/W1zRZ9VW/uv/cmUOWdF/sQHMwx3pimxFGck
	GmoxFxUnAgA8oXEeCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO7zte1pBv/Pc1ucnnqWyWJq+15G
	iyfrZzFbXFrkbrGg9TeLxZZ/R1gtFmx8xGgxY/9TdgcOjwWbSj02repk89i94DOTR9+WVYwe
	nzfJBbBGcdmkpOZklqUW6dslcGVMWXWKtaBVq+LXp7QGxmtKXYycHBICJhLnFxxm7WLk4hAS
	2M0ocWXWfPYuRg6ghLTEsT9FEKawxOHDxRAlHxgl5m25zgTSyyagI/Fw6m0WEFtEQFPiSOdM
	dpAiZoHbjBLfV7SDJYQF7CW+TDrPDGKzCKhKzH2yAyzOK2ArceTIOyaII+QlZl76zg4RF5Q4
	OfMJWA0zULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJ
	ERyoWpo7GLev+qB3iJGJg/EQowQHs5IIr9T75jQh3pTEyqrUovz4otKc1OJDjNIcLErivOIv
	elOEBNITS1KzU1MLUotgskwcnFINTK4WbpHHIz/fc1wnsUrPoWz+CqYSW51255fRnGKLLh11
	veOmxsmR+tfspHJwp9TC5bwLX53ilPYNtp2/cV0979yvhrJi+1/2/0rzZywS19TbV7r2uIe/
	5Oq4us45WVWOvU9Yur/c67jqxqV8b39L3+oCj+VainWsYS/Pz8xn92zO/KL79Jv79INGc/7e
	8r1XKvDuRrOrc6zYxx1Z+/ecfnPZrFA7vbssYqLtZ7vVV7YrVWz4dpRHQ1RucaXspNkTgn+x
	PVkXxs2stK7U41XwxMAuh6MpBfXaGQIzUm7v0rftbZ/f5sRztvBOp8RzL+tQibPzDVY8+6Vp
	ZnnAUzP4vvkCVr1zc5gFv1wIKDujxFKckWioxVxUnAgAhOw/HMMCAAA=
X-CMS-MailID: 20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69
References: <CGME20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69@epcas1p2.samsung.com>

In case of the COW file, new updates and GC writes are already
separated to page caches of the atomic file and COW file. As some cases
that use the meta inode for GC, there are some race issues between a
foreground thread and GC thread.

To handle them, we need to take care when to invalidate and wait
writeback of GC pages in COW files as the case of using the meta inode.
Also, a pointer from the COW inode to the original inode is required to
check the state of original pages.

For the former, we can solve the problem by using the meta inode for GC
of COW files. Then let's get a page from the original inode in
move_data_block when GCing the COW file to avoid race condition.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2:
- use union for cow inode to point to atomic inode
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   | 13 +++++++++++--
 fs/f2fs/file.c   |  3 +++
 fs/f2fs/gc.c     | 12 ++++++++++--
 fs/f2fs/inline.c |  2 +-
 fs/f2fs/inode.c  |  3 ++-
 6 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a213d03005d..f6b1782f965a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2606,7 +2606,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (IS_NOQUOTA(inode))
 		return true;
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_used_in_atomic_write(inode))
 		return true;
 	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
 	if (f2fs_compressed_file(inode) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 796ae11c0fa3..4a8621e4a33a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -843,7 +843,11 @@ struct f2fs_inode_info {
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
 					/* cached extent_tree entry */
-	struct inode *cow_inode;	/* copy-on-write inode for atomic write */
+	union {
+		struct inode *cow_inode;	/* copy-on-write inode for atomic write */
+		struct inode *atomic_inode;
+					/* point to atomic_inode, available only for cow_inode */
+	};
 
 	/* avoid racing between foreground op and gc */
 	struct f2fs_rwsem i_gc_rwsem[2];
@@ -4263,9 +4267,14 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 		f2fs_compressed_file(inode);
 }
 
+static inline bool f2fs_used_in_atomic_write(struct inode *inode)
+{
+	return f2fs_is_atomic_file(inode) || f2fs_is_cow_file(inode);
+}
+
 static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
 {
-	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
+	return f2fs_post_read_required(inode) || f2fs_used_in_atomic_write(inode);
 }
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e4a7cff00796..547e7ec32b1f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2183,6 +2183,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
+
+		/* Set the COW inode's atomic_inode to the atomic inode */
+		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cb3006551ab5..61913fcefd9e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1186,7 +1186,11 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	};
 	int err;
 
-	page = f2fs_grab_cache_page(mapping, index, true);
+	if (f2fs_is_cow_file(inode))
+		page = f2fs_grab_cache_page(F2FS_I(inode)->atomic_inode->i_mapping,
+						index, true);
+	else
+		page = f2fs_grab_cache_page(mapping, index, true);
 	if (!page)
 		return -ENOMEM;
 
@@ -1282,7 +1286,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
 
 	/* do not read out */
-	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
+	if (f2fs_is_cow_file(inode))
+		page = f2fs_grab_cache_page(F2FS_I(inode)->atomic_inode->i_mapping,
+						bidx, false);
+	else
+		page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1fba5728be70..cca7d448e55c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -16,7 +16,7 @@
 
 static bool support_inline_data(struct inode *inode)
 {
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_used_in_atomic_write(inode))
 		return false;
 	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
 		return false;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7a3e2458b2d9..18dea43e694b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -804,8 +804,9 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_abort_atomic_write(inode, true);
 
-	if (fi->cow_inode) {
+	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
 		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
+		F2FS_I(fi->cow_inode)->atomic_inode = NULL;
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
 	}
-- 
2.25.1


