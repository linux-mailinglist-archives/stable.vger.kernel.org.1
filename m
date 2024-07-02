Return-Path: <stable+bounces-56342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0610923D13
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864B6287262
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AA15748A;
	Tue,  2 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r4s9xana"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10193146A68
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921668; cv=none; b=QFCsRWyHktNXLX4H/04C+h2abzToi6il1I3csBpRLdEPGYpRhscT4YzRKeg49jz2kS/d4uoE9E7OklWlW6RKyoN3t5KWvsHrG3TUWC8L6KxC2rJbTxYtUFNN8bGMO34m7m+N9o5N0qkCXttKqGe5yHlAjD+AC9bmGJPgh5EpXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921668; c=relaxed/simple;
	bh=2JDybjXoGKZIfMxuca2mJMh7XoFgvA07bvlf5sjYkX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Vc043aZFbnO6NIncRDVIKQi8KHBe8p9KWHtshL+Yu5NtXv3OsOwztlD7+CteWKha+DVeiIZyW2PzQDyfbHrDjbtooi95NZM5XSu/Gy4tHjwTLGDq4BTQhHtN1kr0+SowBm0/50FAUB9s1v24kjT/Ui9BHJhq3Zu6WYPkxkyEFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r4s9xana; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240702120103epoutp0352808610ae29d60cdbb352ad7f5d178a~eY6Pku6p21134511345epoutp03W
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:01:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240702120103epoutp0352808610ae29d60cdbb352ad7f5d178a~eY6Pku6p21134511345epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719921663;
	bh=OL/DwqCKrUnrUraSKKxPVq6AEKDn2t+gs5jsv1sqlCY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=r4s9xanaQaaLkjIyyjMkKNISSTD/NNCw4GR7nZQwLKGX3XaoLUcwgu2wgznIKEuVO
	 MJzRJXfECV1LsO1xjtgQ141Ng6bcuUQt7/iVFJZCg2DY0inJaj3dqK2idQuCzF0FKL
	 J07f34OpA2WxUjWGa/2R20fiVBy5n4OZ2QwBMuvg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240702120102epcas1p1b123a6d5a3d745b28a44aee86370e044~eY6PTXUO91238412384epcas1p1C;
	Tue,  2 Jul 2024 12:01:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WD1hZ4NkKz4x9Q0; Tue,  2 Jul
	2024 12:01:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.57.09910.EFBE3866; Tue,  2 Jul 2024 21:01:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120101epcas1p1bd085888c19e5e146a7b2806e77a4602~eY6OQFs7s0631806318epcas1p1j;
	Tue,  2 Jul 2024 12:01:01 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702120101epsmtrp161e18eda4347f3566ff22232962c7daa~eY6OPZugO0511305113epsmtrp1Y;
	Tue,  2 Jul 2024 12:01:01 +0000 (GMT)
X-AuditID: b6c32a38-c9ffa700000226b6-ea-6683ebfefc9d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.64.07412.DFBE3866; Tue,  2 Jul 2024 21:01:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120101epsmtip13c0ede86515a4d9a4cf810b1c6384a14~eY6OF-bJt0866908669epsmtip1h;
	Tue,  2 Jul 2024 12:01:01 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: daehojeong@google.com, Sunmin Jeong <s_min.jeong@samsung.com>,
	stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, Yeongjin Gil
	<youngjin.gil@samsung.com>
Subject: [PATCH 2/2] f2fs: use meta inode for GC of COW file
Date: Tue,  2 Jul 2024 21:00:57 +0900
Message-Id: <20240702120057.475944-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmge6/181pBteeKFicnnqWyWJq+15G
	iyfrZzFbLGj9zWKx5d8RVosFGx8xWszY/5Tdgd1jwaZSj02rOtk8+rasYvT4vEkugCUq2yYj
	NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
	UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG3a4J
	rAWdqhXPT1xlbWC8LtfFyMkhIWAisWpLN1MXIxeHkMAORomtS9cxgSSEBD4xStxcLwphf2OU
	eHhcD6Zh3sHtrBANexklfjTtg+oGanhyew8bSBWbgI7Ew6m3WUBsEQF1iVOTloLZzAJrGSX6
	H4LZwgI2ErOffQCaxMHBIqAq8fdlMIjJK2Ar8W6ROcQueYmZl76zg9i8AoISJ2c+gZoiL9G8
	dTYzyFoJgWPsEldPvmCEaHCRmN+xmx3CFpZ4dXwLlC0l8bK/Dcouljg6fwM7RHMDo8SNrzeh
	EvYSza3NbCBHMAtoSqzfpQ+xjE/i3dcesDMlBHglOtqEIKpVJbofLWGGsKUllh07CDXFQ2L5
	3vkskHCLldg45SDLBEa5WUhemIXkhVkIyxYwMq9iFEstKM5NTy02LDCBR2Nyfu4mRnCq07LY
	wTj37Qe9Q4xMHIyHGCU4mJVEeAN/1acJ8aYkVlalFuXHF5XmpBYfYjQFBulEZinR5Hxgss0r
	iTc0sTQwMTMysTC2NDZTEuc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoEp6JG+/LVp2sf5Tr5l
	OOggfeXkkeOWvyuzeLzX2c3MrrV9oy/Xeefiy/P/GYvVby2rkVit2Xmk9LjO7QUbfq3ZKt8o
	pl6d+b686q281NSD96J+NZqWeHdcKjOckymTs7x4+/+j35gZ57HuSp68z7/SfIIak+BrIXub
	vHAZ9m+XDvMXeC40DvI8sDv356VHEo9PnbjqeK/k2OyuOXO0v8xYbXprMePWLenMhQnC07Pv
	8n54eJjtk3vsq/Rm87NLT6wt0apfybvbr3WJuu9b9Rk79oVdXb9NpXlTz4HgXcELhFuX7Xpx
	+uYScbncI62vw1PTuybqHfktHxGbb8J49mdW/W27g4nq2ilr5r50Ps8goMRSnJFoqMVcVJwI
	AO/idYj+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnO7f181pBvev6lucnnqWyWJq+15G
	iyfrZzFbLGj9zWKx5d8RVosFGx8xWszY/5Tdgd1jwaZSj02rOtk8+rasYvT4vEkugCWKyyYl
	NSezLLVI3y6BK+Nu1wTWgk7ViucnrrI2MF6X62Lk5JAQMJGYd3A7K4gtJLCbUWLv54guRg6g
	uLTEsT9FEKawxOHDxRAVHxgl+rZxg9hsAjoSD6feZgGxRQQ0JY50zmTvYuTiYBbYyCjReOci
	WEJYwEZi9rMPrCBzWARUJf6+DAYxeQVsJd4tMoc4QF5i5qXv7CA2r4CgxMmZT8A6mYHizVtn
	M09g5JuFJDULSWoBI9MqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzggNTS2MF4b/4/
	vUOMTByMhxglOJiVRHgDf9WnCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1
	tSC1CCbLxMEp1cCU2fcgMbEmuZ5hydn8d+oTTga9ORa0S1Hh+9nfEvv8LbbZlyW2R3/5cZWV
	4SfvS+2YBY4Ci/+VOfM+l3/vKL9m1nalfblrFOeUurx+uvmTqf8F1yWxk/nP7Qua33MgeNWE
	+wc5Qy583Pwg67IqA//+9M9G3/8+VNSrv6d33Kf3dTFH4ayLv/9WfVu3U5Fpku6Fjw4vD0Tv
	DfvHn961qHMlE5OzsHmJ7qJZXLbyRy1PNv9fvpP7t4l+nYz+qVsf/j/YeCRpjvLvLlWO93fj
	rFcrdwj3+VQdbRTU3h48qWZJd2eM1IETBZvdd20I/808/8aqI/miH4oP/7x/x3jp18pTcSp/
	7PnXGjt9LGqJW5c3SYmlOCPRUIu5qDgRAA0NDt23AgAA
X-CMS-MailID: 20240702120101epcas1p1bd085888c19e5e146a7b2806e77a4602
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702120101epcas1p1bd085888c19e5e146a7b2806e77a4602
References: <CGME20240702120101epcas1p1bd085888c19e5e146a7b2806e77a4602@epcas1p1.samsung.com>

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
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   |  7 ++++++-
 fs/f2fs/file.c   |  3 +++
 fs/f2fs/gc.c     | 12 ++++++++++--
 fs/f2fs/inline.c |  2 +-
 fs/f2fs/inode.c  |  3 ++-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 05158f89ef32..90ff0f6f7f7f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2651,7 +2651,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (IS_NOQUOTA(inode))
 		return true;
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_used_in_atomic_write(inode))
 		return true;
 	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
 	if (f2fs_compressed_file(inode) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 59c5117e54b1..4f9fd1c1d024 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4267,9 +4267,14 @@ static inline bool f2fs_post_read_required(struct inode *inode)
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
index 25b119cf3499..c9f0ba658cfd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2116,6 +2116,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
+
+		/* Set the COW inode's cow_inode to the atomic inode */
+		F2FS_I(fi->cow_inode)->cow_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 136b9e8180a3..76854e732b35 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1188,7 +1188,11 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	};
 	int err;
 
-	page = f2fs_grab_cache_page(mapping, index, true);
+	if (f2fs_is_cow_file(inode))
+		page = f2fs_grab_cache_page(F2FS_I(inode)->cow_inode->i_mapping,
+						index, true);
+	else
+		page = f2fs_grab_cache_page(mapping, index, true);
 	if (!page)
 		return -ENOMEM;
 
@@ -1287,7 +1291,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
 
 	/* do not read out */
-	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
+	if (f2fs_is_cow_file(inode))
+		page = f2fs_grab_cache_page(F2FS_I(inode)->cow_inode->i_mapping,
+						bidx, false);
+	else
+		page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ac00423f117b..0186ec049db6 100644
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
index c26effdce9aa..c810304e2681 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -807,8 +807,9 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_abort_atomic_write(inode, true);
 
-	if (fi->cow_inode) {
+	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
 		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
+		F2FS_I(fi->cow_inode)->cow_inode = NULL;
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
 	}
-- 
2.25.1


