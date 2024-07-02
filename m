Return-Path: <stable+bounces-56344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22290923D37
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FCC2875F2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85515B54E;
	Tue,  2 Jul 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AMbOman0"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB015D5AB
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922009; cv=none; b=Oh4mRTKJYc8Unzi1suQJDRlcW1l7O5+2LMejd2hsUMOc/6iiAbsTZ/kYjzwsRs1Dsj2BaGFM1JuucpyzyLaJzhD2cVEhurxDaSdgTKvFc9QpsiYNiPuCRdrAIhBABUTIy4+dESWLb3O9b8SQoeYel6Eqj+4+bF7VCsA8LAL8wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922009; c=relaxed/simple;
	bh=2JDybjXoGKZIfMxuca2mJMh7XoFgvA07bvlf5sjYkX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Wv3vDLNVvdeh/74JxrUPcOUVlWUal1QpzmgY6tw1qUfU83F7N5zHGAcXLkLup+qJo+81C+WNL9tXXvMVaamaphBIy6Qjk9bd15PExDuftDhZITMRnTAVSamUEefpcd6l8Nz2kgvE61xWRgtFstklYrklzDT0+OCVpy0iq3PfHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AMbOman0; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240702120644epoutp014071fba9e10dc45854a144261ffd25ea~eY-NLzR1k0354303543epoutp01c
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:06:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240702120644epoutp014071fba9e10dc45854a144261ffd25ea~eY-NLzR1k0354303543epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719922004;
	bh=OL/DwqCKrUnrUraSKKxPVq6AEKDn2t+gs5jsv1sqlCY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AMbOman05yUFmnUGTDtJrEJj9y0xCWE0C73HbzC8CPMo74ntDTAMmWet9K3qQeln6
	 q5PjmnGAFJQqEUhSOysHK/WwoPg3GIrklEiON1cC+lAFJKL4cp/4OqbbcoAXe3OwX8
	 qauCkMYrRL9ls0fZ6j51VYxXlx/CoOGgL9XioglU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240702120643epcas1p458a74cfc794668b4a83f5710ac6a0684~eY-M4DnYs1010610106epcas1p41;
	Tue,  2 Jul 2024 12:06:43 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.248]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WD1q749MFz4x9Pv; Tue,  2 Jul
	2024 12:06:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.84.09847.35DE3866; Tue,  2 Jul 2024 21:06:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240702120643epcas1p4b98b4bfef3b3ef72cf50737697b67eeb~eY-MCo6A50895408954epcas1p45;
	Tue,  2 Jul 2024 12:06:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702120643epsmtrp1904a0070dae9b065e0d43b76d7484ab7~eY-MB98Ut0771107711epsmtrp1d;
	Tue,  2 Jul 2024 12:06:43 +0000 (GMT)
X-AuditID: b6c32a36-86dfa70000002677-20-6683ed536b82
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.2A.19057.25DE3866; Tue,  2 Jul 2024 21:06:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120642epsmtip19f8e731be4ffaecb6621e611d11ae4f5~eY-Lzr6Wy0968509685epsmtip1I;
	Tue,  2 Jul 2024 12:06:42 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com, Sunmin
	Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH 2/2] f2fs: use meta inode for GC of COW file
Date: Tue,  2 Jul 2024 21:06:36 +0900
Message-Id: <20240702120636.476119-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmnm7w2+Y0g7WP5CxOTz3LZDG1fS+j
	xZP1s5gtLi1yt1jQ+pvFYsu/I6wWCzY+YrSYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
	gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgY
	mQIVJmRn3O2awFrQqVrx/MRV1gbG63JdjBwcEgImEm+OK3YxcnEICexglPi8ZC4zhPOJUeLB
	lk/sXYycQM43Ront31hAbJCGPc097BBFexkllq7tZoTrmHRsKSNIFZuAjsTDqbfBOkQE1CVO
	TVrKAlLELHCVUaLr7RwmkISwgI3E7GcfWEFsFgFViZfn54E18wrYSiyav5AZYp28xMxL39kh
	4oISJ2c+ARvKDBRv3job7FYJgWvsEudnLGWDaHCRuDT9MZQtLPHq+BZ2CFtK4mV/G5RdLHF0
	/gZ2iOYGRokbX29CJewlmlub2UAhwyygKbF+lz7EMj6Jd197WCEBxivR0SYEUa0q0f1oCdSd
	0hLLjh2EmuIh8e7zSSZI0MVKLG1oYJrAKDcLyQuzkLwwC2HZAkbmVYxiqQXFuempxYYFRvCY
	TM7P3cQIToFaZjsYJ739oHeIkYmD8RCjBAezkghv4K/6NCHelMTKqtSi/Pii0pzU4kOMpsBA
	ncgsJZqcD0zCeSXxhiaWBiZmRiYWxpbGZkrivGeulKUKCaQnlqRmp6YWpBbB9DFxcEo1MJX4
	ObceL/O2N5rz60RlZd1t19fXz7+58VjK4FCV4ksOxYvStyTqmJ0Mc/1yl9y+61GSLG3otfGv
	1vodW7vNBSXvCX5Yd5dlfuDCZREuaW2cKW/VRM6dzk3qOpTKamV+JMLi5jvmaI26ghkv9t3Y
	p/I5oSIqoHe/moH0w6npwpHL4q55LmBPPeIUk19/y0tC9OmliRPeaYivO1kjdsf02PdnN//k
	KUarzdPcZh1zJUXFQSJuiWaes7dE9uS0izFXvvq2Sdu6OIkzbHt14yd3CbPRrZtaK17mCZ25
	P1G32jvUP9x6QfcO2Q5tlhClTbEPsy83CO+uZve4/m6GSqX8josL32nO5PxwcvadRuM9SizF
	GYmGWsxFxYkAqhcr6AoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnG7Q2+Y0g5MzLCxOTz3LZDG1fS+j
	xZP1s5gtLi1yt1jQ+pvFYsu/I6wWCzY+YrSYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijuGxSUnMyy1KL9O0SuDLudk1gLehUrXh+4iprA+N1uS5GTg4JAROJPc097F2MXBxC
	ArsZJeZNn8rUxcgBlJCWOPanCMIUljh8uBikXEjgA6PE0f/6IDabgI7Ew6m3WUBsEQFNiSOd
	M8HGMAvcZpT41DybDSQhLGAjMfvZB1YQm0VAVeLl+XmMIDavgK3EovkLmSFukJeYeek7O0Rc
	UOLkzCdgQ5mB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
	3E2M4EDV0trBuGfVB71DjEwcjIcYJTiYlUR4A3/VpwnxpiRWVqUW5ccXleakFh9ilOZgURLn
	/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANOvD58m9bb8PsXv07Csuzlp5LuG0ZNFJyQ0fjzJ/
	NYlUSpvNocOudftj//IE77zTP9f12/+xk7qYda35nW3AQ56G/7Mut398G2ZzIznE50OZv8QM
	9Yvbfr5mk50zQassc/fV1XJTMtmWlPewVllI3Hl+wG0lb7rxjnm9t+auYHq38lD3vorPQrfv
	cq0pmr2cR1e4U//xxAaDPyfKVq9d9TNYQS8rPHjvnKNOM5sl8r2dnxkpLfwh1HflB/+bpN+3
	Xj+UFI/N00kM+tqzoN5KSKmrRN5ubvhc8WP3jZlPehysneaaVCzZs0ks66GMzmTXtjWSF0t8
	+c3v5DLkeH8+v/376aR2jdzDsvnXpqvrKbEUZyQaajEXFScCADUokCnDAgAA
X-CMS-MailID: 20240702120643epcas1p4b98b4bfef3b3ef72cf50737697b67eeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702120643epcas1p4b98b4bfef3b3ef72cf50737697b67eeb
References: <CGME20240702120643epcas1p4b98b4bfef3b3ef72cf50737697b67eeb@epcas1p4.samsung.com>

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


