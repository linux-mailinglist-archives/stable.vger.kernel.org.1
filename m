Return-Path: <stable+bounces-58125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1009283A1
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645902828F3
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6F145B20;
	Fri,  5 Jul 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jfxm1gKk"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFE145B05
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167899; cv=none; b=DDl6fgaSJXJPh0SUghtEjJWbIZ/bBcGF+NeTqVn4czwc9Fp/J+7JgOM5B75SJmnoG9QJY/nlI+6F6WSTd9zwfDjJqP49uOG+TBb5xdg0Maqx35ce7Ysg9Rv0WYwj5Eu6M0saxdIsgSX5Ihxb2EQpRzn8DhJnMfNmaRYY2Mwnpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167899; c=relaxed/simple;
	bh=PjPG27toN1TRxKNx0Q+uytK+NguwMCy2ZnvAr6tWqLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=M2CfGbLHFLRwbQdF4XARLCdZ1jdE+ESPPMkRuDPR9ESbumCNEj9WkDUBYO6GlucRNjbwpzymdPAETBKv6RWKL1k5n8crTQELqQDk9M9z8pqAqoSdQiGOpptmjUWwIlEiz3C7ooiUQIxNfqAsFcEAxj7IMyRAhvhD1HPGmNSGduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jfxm1gKk; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240705082454epoutp01afe51006de263bfcc83b63be29a367b5~fQ5YZ1OyY2574125741epoutp01H
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 08:24:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240705082454epoutp01afe51006de263bfcc83b63be29a367b5~fQ5YZ1OyY2574125741epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720167894;
	bh=EZMIak11ctTq1N1qAlNXt95/3pwyphaqWwTzqm39iiA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jfxm1gKkkCYMT8VXEllfuVOobVs/NCTxHmuIC+8x05wiWwvpA2yzemmESM5hSDxvt
	 Ir/RFUOzwrncfZT5mBZp+bWTSS2Q1p27PcCx7OPTGt0/9BTJiYySTttyE4SLaEmvQA
	 D5DChLzhJTrTC950CJk9N/lSQ4ezAAT88NFyAMSc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240705082454epcas1p1f383b9db1d0296e9aea5bcc24944d545~fQ5X3YuQ40068200682epcas1p1f;
	Fri,  5 Jul 2024 08:24:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WFmln4TwKz4x9Q9; Fri,  5 Jul
	2024 08:24:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.2C.09561.5DDA7866; Fri,  5 Jul 2024 17:24:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435~fQ5XDwya_2808628086epcas1p3r;
	Fri,  5 Jul 2024 08:24:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240705082453epsmtrp2c31e59cd46e78bd4826cc539b0ba8e63~fQ5XDDWWO2748127481epsmtrp2T;
	Fri,  5 Jul 2024 08:24:53 +0000 (GMT)
X-AuditID: b6c32a39-b63ff70000002559-77-6687add5bce7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.02.19057.5DDA7866; Fri,  5 Jul 2024 17:24:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240705082453epsmtip14391ff7c3ae59486e485789af8af85bd~fQ5W5hg7t1057310573epsmtip1h;
	Fri,  5 Jul 2024 08:24:53 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net, Sunmin
	Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH v2 1/2] f2fs: use meta inode for GC of atomic file
Date: Fri,  5 Jul 2024 17:24:48 +0900
Message-Id: <20240705082448.805306-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnu7Vte1pBjOWyVmcnnqWyWJq+15G
	iyfrZzFbXFrkbrGg9TeLxZZ/R1gtFmx8xGgxY/9TdgcOjwWbSj02repk89i94DOTR9+WVYwe
	nzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
	AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAw
	MgUqTMjOmDxlEXPBL42K/W//sTcw/lDoYuTkkBAwkTg8oZupi5GLQ0hgB6NE473/UM4nRon1
	mzeyQTjfGCX23r7PDtNyaMVUFhBbSGAvo8S20xVwHSubfoIVsQnoSDycehusSERAXeLUpKUs
	IEXMAlcZJdr3PQdLCAs4SdxY/RbMZhFQlfgxey8TiM0rYCsx6+hnJoht8hIzL31nh4gLSpyc
	+QSsnhko3rx1NjPIUAmBS+wSEx/9ZoNocJH4cQmiSEJAWOLV8S1QZ0tJfH63F6qmWOLo/A3s
	EM0NjBI3vt6EKrKXaG5tBiriANqgKbF+lz7EMj6Jd197WEHCEgK8Eh1tQhDVqhLdj5YwQ9jS
	EsuOHYSa4iExddFyNkgIxUqsuniSaQKj3CwkL8xC8sIshGULGJlXMYqlFhTnpqcWGxaYwqMy
	OT93EyM4CWpZ7mCc/vaD3iFGJg7GQ4wSHMxKIrxS75vThHhTEiurUovy44tKc1KLDzGaAgN1
	IrOUaHI+MA3nlcQbmlgamJgZmVgYWxqbKYnznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAxH6V
	/XrxRpeoWzk/5ntPi3sgtrg5Usk126Wp5OTxTI+8s++DHlYpPWA+MOtpXX/e6uQGFukNR7Zz
	7LOve3j+D7vclfMFH0uL/OY7Ltr19YFGxTM+u6+/Jx2p9/lpLuEYkdNwxff/3TlelzYcuauz
	5vWyv+uWFTPOvx1+R18iM3122sn/Zqd3zp74KTVr7TblFWsLn4fvm+IeoKBRG5aw0fr4U/kk
	ieNsJSKCCc9eCJqZyFWe+LUscr/zw7xzBz5dnnrxf8GDViu/RyGhCta10/qbGW9N3mq1nGVP
	1rkrzXwPE5SFQiY/f3hs399e8T+BdnxJO1P3JH8ITFHWKlXkmXeh1uXQTKkOCeHfuyNPTFBi
	Kc5INNRiLipOBABu4kpaCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnO7Vte1pBq0H2S1OTz3LZDG1fS+j
	xZP1s5gtLi1yt1jQ+pvFYsu/I6wWCzY+YrSYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijuGxSUnMyy1KL9O0SuDImT1nEXPBLo2L/23/sDYw/FLoYOTkkBEwkDq2YytLFyMUh
	JLCbUWL+i7/sXYwcQAlpiWN/iiBMYYnDh4shSj4wSnRP/84E0ssmoCPxcOptFhBbREBT4kjn
	THaQImaB24wS31e0gyWEBZwkbqx+C2azCKhK/Ji9F6yZV8BWYtbRz0wQR8hLzLz0nR0iLihx
	cuYTsHpmoHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cT
	IzhUtbR2MO5Z9UHvECMTB+MhRgkOZiURXqn3zWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+9
	7k0REkhPLEnNTk0tSC2CyTJxcEo1MLHNc6oxyUiNPNTJGrHvGLclm6NcwsJzrhy+FRUXz7n5
	HG/bt7tsS9pl4T/5ZyV9Vl2157ldtPqAQzFjePJyucNLtRx27fEWO54TVHL9TPv6lvOsH8JO
	x/2SPditdmNhfdnyyU2/V1aFi6TIFjG/fK1+I3L766bzh54Y24foq9X9ufjmjEZZk+ethNcV
	Dqwu+iHCO2uv2B/6yCwecWvyS/btLxnm8z/xsVqvI2/t3hd5f846Hs+tfYVNB/W7OSr+lue+
	nslz43KBaJyC8fPpgoZiB1hbZ0/fcDf2trBVtf3PDb1bQjVclhy6mdD1z6hTXsVQd1FVkIba
	f8tZS2K8I7d8Xfmv68CM0ogTWUZ3lViKMxINtZiLihMBdyKVy8QCAAA=
X-CMS-MailID: 20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435
References: <CGME20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435@epcas1p3.samsung.com>

The page cache of the atomic file keeps new data pages which will be
stored in the COW file. It can also keep old data pages when GCing the
atomic file. In this case, new data can be overwritten by old data if a
GC thread sets the old data page as dirty after new data page was
evicted.

Also, since all writes to the atomic file are redirected to COW inodes,
GC for the atomic file is not working well as below.

f2fs_gc(gc_type=FG_GC)
  - select A as a victim segment
  do_garbage_collect
    - iget atomic file's inode for block B
    move_data_page
      f2fs_do_write_data_page
        - use dn of cow inode
        - set fio->old_blkaddr from cow inode
    - seg_freed is 0 since block B is still valid
  - goto gc_more and A is selected as victim again

To solve the problem, let's separate GC writes and updates in the atomic
file by using the meta inode for GC writes.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2:
- replace post_read to meta_gc
 fs/f2fs/data.c    | 4 ++--
 fs/f2fs/f2fs.h    | 7 ++++++-
 fs/f2fs/gc.c      | 6 +++---
 fs/f2fs/segment.c | 6 +++---
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b6dcb3bcaef7..9a213d03005d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2693,7 +2693,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	}
 
 	/* wait for GCed page writeback via META_MAPPING */
-	if (fio->post_read)
+	if (fio->meta_gc)
 		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
 	/*
@@ -2788,7 +2788,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
 		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
-		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
+		.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7ee6c5e371e..796ae11c0fa3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1211,7 +1211,7 @@ struct f2fs_io_info {
 	unsigned int in_list:1;		/* indicate fio is in io_list */
 	unsigned int is_por:1;		/* indicate IO is from recovery or not */
 	unsigned int encrypted:1;	/* indicate file is encrypted */
-	unsigned int post_read:1;	/* require post read */
+	unsigned int meta_gc:1;		/* require meta inode GC */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
@@ -4263,6 +4263,11 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 		f2fs_compressed_file(inode);
 }
 
+static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
+{
+	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
+}
+
 /*
  * compress.c
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ef667fec9a12..cb3006551ab5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1589,7 +1589,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
 								ofs_in_node;
 
-			if (f2fs_post_read_required(inode)) {
+			if (f2fs_meta_inode_gc_required(inode)) {
 				int err = ra_data_block(inode, start_bidx);
 
 				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -1640,7 +1640,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_post_read_required(inode))
+			if (f2fs_meta_inode_gc_required(inode))
 				err = move_data_block(inode, start_bidx,
 							gc_type, segno, off);
 			else
@@ -1648,7 +1648,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 								segno, off);
 
 			if (!err && (gc_type == FG_GC ||
-					f2fs_post_read_required(inode)))
+					f2fs_meta_inode_gc_required(inode)))
 				submitted++;
 
 			if (locked) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4db1add43e36..77ef46b384b4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3851,7 +3851,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (fio->post_read)
+	if (fio->meta_gc)
 		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
@@ -4021,7 +4021,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *cpage;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	if (!__is_valid_data_blkaddr(blkaddr))
@@ -4040,7 +4040,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	for (i = 0; i < len; i++)
-- 
2.25.1


