Return-Path: <stable+bounces-56341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9319F923D11
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B718F1C22CCD
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E815CD75;
	Tue,  2 Jul 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dc0uwASS"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CC15CD46
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921660; cv=none; b=PwuFBQSmyYx+U8pCERTvS/c8b68yAW6zv3Q0YbWvh17TXLJoCr/eUadKGKQttB9yEK8sJKWkIg47wrOf/qrPlguWqj0rp9RO2f0HZzzIfPlTlneloHEYVoDUJyoIWAJTytM/rok1IhgbiqTzXxJsS6glKjnLJV2r8tRBXHN0inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921660; c=relaxed/simple;
	bh=DuyNG6WDwJd056BUH/Jwaigh/eo+q5wJse/L1VevWL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=HzZNfW1HDS3d6FpESRoMKIRE8VBk3F4a7cl+9yKPd2rUzANqhsr5KSenflE0OKq/uNii4T0ZGhf8JQobQOuI6cInr88gKSYjgdSzsnracJxht4PsIopjBa/WVdIpMGqZjZB4IpkTvl+u2Z38DEqLoEnxvTEGkeFL/esyy5EkkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dc0uwASS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240702120052epoutp017eea56292e8468ce6a7b55a51f1c1bc4~eY6FjLPDp3082530825epoutp01z
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:00:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240702120052epoutp017eea56292e8468ce6a7b55a51f1c1bc4~eY6FjLPDp3082530825epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719921652;
	bh=n7bVkJMnRU7Mlc/hN2ckbv1SrBU+L0lB2TRSSvXzKuY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=dc0uwASSL2bBpao85LGhCK6lD17MXebt9fjiK/DHzb5Owq+IXcqbKhEkPLwqr//u1
	 UH8Q4iRMJOgwA1vQ5JDaw64BA7iD5JK5gxUFT8P2OvQ+6poahe9ip+PRfMx8jjjscd
	 1jrFW6GS5lVTQpF5tMMICpBqf8dygRKhU1Tb+N4o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240702120052epcas1p4f36f3b5645f6302be2b192aeea398713~eY6FI4FPE1497214972epcas1p4y;
	Tue,  2 Jul 2024 12:00:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WD1hM4xzZz4x9Pq; Tue,  2 Jul
	2024 12:00:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.29.09622.3FBE3866; Tue,  2 Jul 2024 21:00:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240702120051epcas1p35f2ff6260c1b8a768f07ced5413377b6~eY6Eeck2X0252402524epcas1p3K;
	Tue,  2 Jul 2024 12:00:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240702120051epsmtrp248acc9f8e664765928311e1f74739dca~eY6Edzzqy0633606336epsmtrp2Z;
	Tue,  2 Jul 2024 12:00:51 +0000 (GMT)
X-AuditID: b6c32a37-e17ff70000002596-76-6683ebf3fb18
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.D9.19057.3FBE3866; Tue,  2 Jul 2024 21:00:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120051epsmtip15ed45217d19bf5bf4d57d7263c641fde~eY6EUXiLT0852108521epsmtip1q;
	Tue,  2 Jul 2024 12:00:51 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: daehojeong@google.com, Sunmin Jeong <s_min.jeong@samsung.com>,
	stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, Yeongjin Gil
	<youngjin.gil@samsung.com>
Subject: [PATCH 1/2] f2fs: use meta inode for GC of atomic file
Date: Tue,  2 Jul 2024 21:00:06 +0900
Message-Id: <20240702120006.475870-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmnu7n181pBqfmqVicnnqWyWJq+15G
	iyfrZzFbLGj9zWKx5d8RVosFGx8xWszY/5Tdgd1jwaZSj02rOtk8+rasYvT4vEkugCUq2yYj
	NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
	UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGghOP
	WApuylQ8mfyNuYGxU7yLkZNDQsBE4vHVfexdjFwcQgI7GCVeXLvGAuF8YpSY9L2TEcL5xijx
	9+QtJpiWs7camCASexklTu57ywjX0nftFwtIFZuAjsTDqbfBbBEBdYlTk5aC2cwCaxkl+h+C
	2cIC9hKvzy9j7WLk4GARUJV4v0IeJMwrYCtxZHET1DJ5iZmXvrNDxAUlTs58AjVGXqJ562xm
	kL0SAsfYJU58n8AO0eAisevAf2YIW1ji1fEtUHEpic/v9rJB2MUSR+dvYIdobmCUuPH1JlSR
	vURzazMbyEHMApoS63fpQyzjk3j3tQfsTgkBXomONiGIalWJ7kdLoFZJSyw7dhBqiofEyS8t
	YKuEBGIl+g59ZZvAKDcLyQuzkLwwC2HZAkbmVYxiqQXFuempxYYFxvCYTM7P3cQITnha5jsY
	p739oHeIkYmD8RCjBAezkghv4K/6NCHelMTKqtSi/Pii0pzU4kOMpsAwncgsJZqcD0y5eSXx
	hiaWBiZmRiYWxpbGZkrivGeulKUKCaQnlqRmp6YWpBbB9DFxcEo1MHWbKwa5GG3Za71gzmLm
	aUf8sxVmTuqImb3gwoODD5pqsnfIVWpWfF+a+TkqYaPx0pnq7yXy7I0YVp4VZo/U4ZCTq4wt
	lpsfXvuan/WZWfFN8de+lUafdDWqbtrP8Jv7bVfXH1vTCYsFm5tqNu95MfWkXW3QFddPn9ud
	pm75vfWf3Ra9Hvv6uc6vVYJ0b60Wnrr3hNzV0OfrN72Mtvlj4b/n2auCtTHL+euFlQ2Ofd/M
	cOuYzJWJs+8/+C65WtO+95eijeLq55e2KfKYvyh4IVZamaXC2vFpkdiam1bVza/lHN86RC2U
	iXnnv3mibqKx8KJKJdmY6LbSR+EqS49nmb9wOqh8lVlzthBDfFBwrRJLcUaioRZzUXEiAA5U
	1mYBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO7n181pBs+aBC1OTz3LZDG1fS+j
	xZP1s5gtFrT+ZrHY8u8Iq8WCjY8YLWbsf8ruwO6xYFOpx6ZVnWwefVtWMXp83iQXwBLFZZOS
	mpNZllqkb5fAlbHgxCOWgpsyFU8mf2NuYOwU72Lk5JAQMJE4e6uBCcQWEtjNKLG4V7aLkQMo
	Li1x7E8RhCkscfhwcRcjF1DFB0aJ+9P2gpWzCehIPJx6mwXEFhHQlDjSOZMdpIhZYCOjROOd
	i2AJYQF7idfnl7GCDGIRUJV4v0IeJMwrYCtxZHETE8QJ8hIzL31nh4gLSpyc+QSslRko3rx1
	NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDkotrR2Me1Z9
	0DvEyMTBeIhRgoNZSYQ38Fd9mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNT
	UwtSi2CyTBycUg1MU1jCbGrKj3sZ5ZkkmxkrWzw88THn94rDn1dwfsoLS4+ZduLEPbl/zTZX
	DJlWPi7xXx0889AJowPfwvn6I5wW8vrpn//AXdR78lPAH6/IA+ELY+aYeTw1cY+b/vNOHBNr
	pZZtw/u3b6VD8g+vErt6M+BvrmbX+rU6vbt9H8uq/473+TaV/RZXYuLpzSpXUy8ZCQgUNa39
	6fu57dWhjjkWama215MbDB/qrXg5eZ/P2jlcy0Si294kJu53krHuK1giXPii7Vv9edOGH47r
	1kZF+y57vl1td//cVPPCiWJvJqjL6Qhbr7VL8+FYYJOqIc1kYLpyfvdzxnOHjC46T/LL7s4s
	nsAxZ/q9GRN11NOUWIozEg21mIuKEwHbqxD+uQIAAA==
X-CMS-MailID: 20240702120051epcas1p35f2ff6260c1b8a768f07ced5413377b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702120051epcas1p35f2ff6260c1b8a768f07ced5413377b6
References: <CGME20240702120051epcas1p35f2ff6260c1b8a768f07ced5413377b6@epcas1p3.samsung.com>

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
 fs/f2fs/f2fs.h    | 5 +++++
 fs/f2fs/gc.c      | 6 +++---
 fs/f2fs/segment.c | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a000cb024dbe..59c5117e54b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4267,6 +4267,11 @@ static inline bool f2fs_post_read_required(struct inode *inode)
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
index a079eebfb080..136b9e8180a3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1580,7 +1580,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
 								ofs_in_node;
 
-			if (f2fs_post_read_required(inode)) {
+			if (f2fs_meta_inode_gc_required(inode)) {
 				int err = ra_data_block(inode, start_bidx);
 
 				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -1631,7 +1631,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_post_read_required(inode))
+			if (f2fs_meta_inode_gc_required(inode))
 				err = move_data_block(inode, start_bidx,
 							gc_type, segno, off);
 			else
@@ -1639,7 +1639,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 								segno, off);
 
 			if (!err && (gc_type == FG_GC ||
-					f2fs_post_read_required(inode)))
+					f2fs_meta_inode_gc_required(inode)))
 				submitted++;
 
 			if (locked) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7e47b8054413..b55fc4bd416a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3823,7 +3823,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *cpage;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	if (!__is_valid_data_blkaddr(blkaddr))
@@ -3842,7 +3842,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	for (i = 0; i < len; i++)
-- 
2.25.1


