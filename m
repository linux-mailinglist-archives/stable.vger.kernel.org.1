Return-Path: <stable+bounces-56343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27939923D36
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C91F24D5B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AA15B54E;
	Tue,  2 Jul 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pr9+hmER"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC214D703
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921999; cv=none; b=NQQuPvSJ2SS58JNFjyjrUjKT3E2XGSbMZ92u3eqrs9I8KzUbdgXakW+P3b1ksaPrQrjfwdIBmAz2MgRqhcP+IYLqtRTxS+AlNQjVebVbPZNr4z77J86Io3/0BovQTQoGYAboECcERX/nlM7XJnkaNVMguTYu9hAJAvnOUJviCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921999; c=relaxed/simple;
	bh=DuyNG6WDwJd056BUH/Jwaigh/eo+q5wJse/L1VevWL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=R/8r0mFVLt/LLBA95Ph46nmlJgvR0jVDJpjEPHQl8CwmIuZrAYmsNUGo2YNgrwsSioB2W6pto2n993bmiiH+7sRRlM/pv3GHxvPgpVOWBguBIZT9PuAEOa8CpetEgSlGyifwL4L2fqg5exwQ1gAoO/iU0GlgK/na90f7tnLAiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pr9+hmER; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240702120633epoutp0422a802ac4f0c56869edddaaf367a5659~eY-C5GKAs2677426774epoutp04S
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240702120633epoutp0422a802ac4f0c56869edddaaf367a5659~eY-C5GKAs2677426774epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719921993;
	bh=n7bVkJMnRU7Mlc/hN2ckbv1SrBU+L0lB2TRSSvXzKuY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Pr9+hmER4C58fODF0+aSvM+rQVomfU4mTyFAvGE4xIOYjVxPqtHbk4FN1F/r1LJBw
	 JhOEFgPIDguZgSLOuRGzMxHpyuCkb4Oit6h2AO5KOutkzLb5HBolBkOAtKEQFL4vPd
	 VH5NytzbFeomobMsvGh47/5d74EsgJcNB1TY39Ic=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240702120632epcas1p45ade09d4511ab60b9807a75c8bf513fe~eY-ChQ66R0895308953epcas1p45;
	Tue,  2 Jul 2024 12:06:32 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.242]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WD1pw3YdJz4x9Ps; Tue,  2 Jul
	2024 12:06:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.75.08602.84DE3866; Tue,  2 Jul 2024 21:06:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99~eY-BOnj2a1487914879epcas1p1z;
	Tue,  2 Jul 2024 12:06:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702120631epsmtrp1bd088745aea8d562f54ddaccc39a5a25~eY-BNMEty0771107711epsmtrp1Q;
	Tue,  2 Jul 2024 12:06:31 +0000 (GMT)
X-AuditID: b6c32a33-66ffa7000000219a-67-6683ed48cd33
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.B4.07412.74DE3866; Tue,  2 Jul 2024 21:06:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702120631epsmtip1d563847d3def3ca480bec6950d252da6~eY-BA_LQQ0993309933epsmtip1s;
	Tue,  2 Jul 2024 12:06:31 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com, Sunmin
	Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH 1/2] f2fs: use meta inode for GC of atomic file
Date: Tue,  2 Jul 2024 21:06:24 +0900
Message-Id: <20240702120624.476067-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmga7H2+Y0g+6rohanp55lspjavpfR
	4sn6WcwWlxa5Wyxo/c1iseXfEVaLBRsfMVrM2P+U3YHDY8GmUo9NqzrZPHYv+Mzk0bdlFaPH
	501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
	QJcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyM
	TIEKE7IzFpx4xFJwU6biyeRvzA2MneJdjJwcEgImEte+NbB0MXJxCAnsYJTYumw7M4TziVFi
	1etJUM43Roldc3czwbSsOX6TESKxl1Hi5pI+JriWg3cvMIJUsQnoSDycepsFxBYRUJc4NWkp
	2BJmgauMEl1v54CNEhawl3h9fhkriM0ioCpxYnMbO4jNK2ArseDzXVaIdfISMy99h4oLSpyc
	+QRsKDNQvHnrbLD7JASusUt8a5zPDNHgInFu+W0oW1ji1fEt7BC2lMTL/jYou1ji6PwN7BDN
	DYwSN77ehErYSzS3NrN1MXIAbdCUWL9LH2IZn8S7rz2sIGEJAV6JjjYhiGpVie5HS6BWSUss
	O3YQaoqHxN+l88HuFBKIlTjXNJ91AqPcLCQvzELywiyEZQsYmVcxiqUWFOempyYbFhjC4zI5
	P3cTIzgNahnvYLw8/5/eIUYmDsZDjBIczEoivIG/6tOEeFMSK6tSi/Lji0pzUosPMZoCA3Ui
	s5Rocj4wEeeVxBuaWBqYmBmZWBhbGpspifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cDkpT57
	j3fg9WcqKuKrpB/MfOQ55ZjL0/2abxctmH/92YL31+ZdKmv+PW1Tjm5yxBERrw8eV6bN2HDW
	rrNEr7ZAOTfk0rr7V/mk1/ELGSebCYut31v74XL0+XVKbmb1Ks/CSt07j91Rjg1k/hUz78uX
	wympR0Qfhr9+cEG1Z0eo96eT2+9E/XU8uHSui/n9BxfYb3Rfrr5pXXdW2GI+//oHJztuJs78
	OeVqSnjxp4li069MfLjlwaaw32tvTjy7NE33alap4/K5hofexojWJJoGRRtsND7CIbfn/3rf
	P73CfRcXd62zM2+50eqtU7X5ZQmTH9cmlqqqWQU3ON/8eHF8uvaqylfiS522620Kkt8X+F+J
	pTgj0VCLuag4EQCGY6+aDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK772+Y0g6uLRCxOTz3LZDG1fS+j
	xZP1s5gtLi1yt1jQ+pvFYsu/I6wWCzY+YrSYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijuGxSUnMyy1KL9O0SuDIWnHjEUnBTpuLJ5G/MDYyd4l2MnBwSAiYSa47fZOxi5OIQ
	EtjNKDGtu5epi5EDKCEtcexPEYQpLHH4cDFEyQdGiX8TFzKC9LIJ6Eg8nHqbBcQWEdCUONI5
	kx2kiFngNqPEp+bZbCAJYQF7idfnl7GC2CwCqhInNrexg9i8ArYSCz7fZYU4Ql5i5qXvUHFB
	iZMzn4ANZQaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNz
	NzGCQ1VLYwfjvfn/9A4xMnEwHmKU4GBWEuEN/FWfJsSbklhZlVqUH19UmpNafIhRmoNFSZzX
	cMbsFCGB9MSS1OzU1ILUIpgsEwenVANT7K/6tU3/+Wd8sz21n+31o4tz5vTFHMvIFbubGaFW
	+NGOw0lw7pI4/hkewm+vKRtJdRV8knOV9b7HfmlLoWpU4ybTycnFBnvZvb/Feu1S2LV+BcO+
	Mr98y0PbbixYUMkf5CD0MO3w7eA5k+Xic3SCdnZbPlFoy5tzqSmuZt7HIz2reov/PMhnWrT2
	eNzEF8/q3KX3HwuUeC+2XcAmPvoK89vpd77z3vefXHRz9R+jFexiWk0L333/sGKxSq3I4wls
	U4SZGu+fFXzsrLLWVcOGyyF53s9/4n4H1NNM//CxWjaVpZWxZB5USjCU1nfIdDlc/NnE6p7/
	78MLFpTNvmUQOytnfvXutErpz9FHlncpsRRnJBpqMRcVJwIAYscT5sQCAAA=
X-CMS-MailID: 20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99
References: <CGME20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99@epcas1p1.samsung.com>

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


