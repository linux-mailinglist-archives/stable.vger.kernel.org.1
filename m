Return-Path: <stable+bounces-27570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB387A514
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2671F21EFF
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9361B7F3;
	Wed, 13 Mar 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tq9LuCck"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B40BE4B
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322661; cv=none; b=G9z9kD2kRhF88w4vFjLN5L32eJmtGYWAXEAMxb32gz716q1v3mitxvAEmmMjkbDnZhAi2dF07RsCmbdjMUHTIzOsJCbo01roatf4IIR7uf/u7+t/dOHot/4xBNWG7w3nx+ylv2gwKZkDxSSfGhrw7vBZCmH4rwBEDQsFBa/bWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322661; c=relaxed/simple;
	bh=ibuFnaxCw1yYzoKodAZfidCXLJM4EZM9GtAsA8KxuWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hu2C3S0QXM2yaL2kcvuye4RXYRKaqdXOXRFxN+EpsZ3TYXGdhBP8xRzMvwHXXZtdU6nfgnuczePPgT2u4evbidqMTiF6+866Vp/TPM4yKujU09o5n7EKItzRUG0Dvz6UeC2B2e58mlzj8m2hbfgzidcz6ClGlu2APQnaxh8fWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tq9LuCck; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240313093736epoutp02c71ed637ba94c596e44bb99280ba9f25~8SWUK7UZw1193011930epoutp02C
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 09:37:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240313093736epoutp02c71ed637ba94c596e44bb99280ba9f25~8SWUK7UZw1193011930epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710322656;
	bh=Hm8a3x/KZKPwiJDSuXepOBMnMYOlTzyO986ys28fTTY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Tq9LuCckf7oyP5qWFOklgZd5dg1IZqxYHKu24fi/TaakjB1pcJUv4efqKrb9wikha
	 0ndnSV9bUtYMK1OkjM097WcuTVoijwt9N3cc6/Cx71yIYhERZZiR/HmsY91FsLg7GK
	 aydn5dW+/8UjjBR2nmWtyTN7aykmVsFruWZqlCNA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240313093736epcas1p3f79f4996be3fcb4b8207a4adcd6f08e2~8SWTtBLp21213712137epcas1p3i;
	Wed, 13 Mar 2024 09:37:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TvlmH6t4tz4x9Q2; Wed, 13 Mar
	2024 09:37:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.23.11177.FD371F56; Wed, 13 Mar 2024 18:37:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240313093735epcas1p1f430de620d9ef667f30cc112c7ca99c5~8SWS8fBzY0819008190epcas1p17;
	Wed, 13 Mar 2024 09:37:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240313093735epsmtrp2a3d8345d143860f055235f44d4c93ad3~8SWS76PuA2576425764epsmtrp2e;
	Wed, 13 Mar 2024 09:37:35 +0000 (GMT)
X-AuditID: b6c32a35-a17ff70000002ba9-dc-65f173dfc915
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.49.08755.FD371F56; Wed, 13 Mar 2024 18:37:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240313093735epsmtip13a305c3e90d9a8831a09e215ca39e91d~8SWSvK-371056010560epsmtip1a;
	Wed, 13 Mar 2024 09:37:35 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: s_min.jeong@samsung.com, youngjin.gil@samsung.com,
	sj1557.seo@samsung.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] f2fs: truncate page cache before clearing flags when
 aborting atomic file
Date: Wed, 13 Mar 2024 18:37:31 +0900
Message-Id: <20240313093731.1059621-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmge794o+pBlfemFksaP3NYrHl3xFW
	iwUbHzFazNj/lN2BxaNvyypGj8+b5AKYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
	DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
	zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMx7f72UreMVbcf3+T+YGxrNcXYycHBICJhKnV/Qz
	dzFycQgJ7GCU+HrkOROE84lR4sOVFSwQzjdGibXnVrLDtKzbPI0RIrGXUeJ2czc7XEtfx3s2
	kCo2AR2Jh1NvA7VzcIgI+Etc7HYCCTMLSEms+3SIDSQsLJAgMXu5MEiYRUBV4ua8WUwgNq+A
	ncSEY6eYIXbJS8y89J0dIi4ocXLmExaIMfISzVtng50tIbCMXWLa7ylMEA0uEi0/vrNC2MIS
	r45vgTpaSuLzu71sEHaxxNH5G9ghmhsYJW58vQlVZC/R3NoMdhyzgKbE+l36EMv4JN597WEF
	CUsI8Ep0tAlBVKtKdD9aAnWntMSyYwehpnhITD97DSwuJBArcfrgFaYJjHKzkLwwC8kLsxCW
	LWBkXsUollpQnJueWmxYYAiPyOT83E2M4PSlZbqDceLbD3qHGJk4GA8xSnAwK4nw1il+TBXi
	TUmsrEotyo8vKs1JLT7EaAoM1InMUqLJ+cAEmlcSb2hiaWBiZmRiYWxpbKYkznvmSlmqkEB6
	YklqdmpqQWoRTB8TB6dUA1Pe/VuaSfOu7Da/NXmWwtmvKzJWH3yi2/trR/JfFnZhKXu9vPCE
	ZBZ3Ge+8CSt+bvu2fc/dHbcZvDoqWt4ZHNvgNcvo14tJH/ZxLvqyb6eS3BOOH6dFv178YHNK
	d4tOdOArkaQlBhozIm63XxMrXylXdPLb1v2m3CKPvhUUrF78iK9drEHslsakCja+rELhoI/t
	klnfk8U3Lvy+xnrbtd5c5dmpKyvWRj/dWnhs+/QYwXcMW72FwsuXLr8ldFD9xXppbovn6vXv
	r+bbv14y4QDH68aXV7TnOj32TLD4KFv1OverL2/YpIzG0NjEubmR/7JZ7p1PedYg4n7gu3vA
	04mKZqLHHv3dt+1Z387kVvXPSizFGYmGWsxFxYkA/ci5hegDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTvd+8cdUg+N/RC0WtP5msdjy7wir
	xYKNjxgtZux/yu7A4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZj+/3shW84q24fv8ncwPj
	Wa4uRk4OCQETiXWbpzF2MXJxCAnsZpT4/HMbaxcjB1BCWuLYnyIIU1ji8OFiiJIPjBJLHxxg
	BullE9CReDj1NguILSIQKLHszWlWEJtZQEpi3adDbCC2sECcxP1jN8HqWQRUJW7Om8UEYvMK
	2ElMOHaKGeIGeYmZl76zQ8QFJU7OfMICMUdeonnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55b
	bFhgmJdarlecmFtcmpeul5yfu4kRHGZamjsYt6/6oHeIkYmD8RCjBAezkghvneLHVCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MR6tv8PaZvQr/9eHC
	nX23tntVBPjmiIn83yW5ZmrOhI2CEtEPvh9iyn537JjOnbzcEJl//5leBVqwlb3cLnDihB1z
	mU/CiQm1Vw2K7R/PWmycePZ8a4Pgp932mW8/v7yx0mE930Y//7RbfQIeD653vdlds3+/aqDv
	93cRrS+qWRTnKF2vblr+R/ZnTduiw8eKM99MFPjfwdKusNlDRt/EJsBZMb1xQZ+b0KaznTce
	ePxlOW3BIP6dV6PNdk48A4d2iET86pM2IosXStxLSHhquVlPdFs4h2HwHtVZQfePVi4v2msh
	e14vlOWk3G1Or8vewRLRZ06uqZq+uGXDrpJDX/a7sXBcy3qh637tSkKuEktxRqKhFnNRcSIA
	X4uTwqICAAA=
X-CMS-MailID: 20240313093735epcas1p1f430de620d9ef667f30cc112c7ca99c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240313093735epcas1p1f430de620d9ef667f30cc112c7ca99c5
References: <CGME20240313093735epcas1p1f430de620d9ef667f30cc112c7ca99c5@epcas1p1.samsung.com>

In f2fs_do_write_data_page, FI_ATOMIC_FILE flag selects the target inode
between the original inode and COW inode. When aborting atomic write and
writeback occur simultaneously, invalid data can be written to original
inode if the FI_ATOMIC_FILE flag is cleared meanwhile.

To prevent the problem, let's truncate all pages before clearing the flag

Atomic write thread              Writeback thread
  f2fs_abort_atomic_write
    clear_inode_flag(inode, FI_ATOMIC_FILE)
                                  __writeback_single_inode
                                    do_writepages
                                      f2fs_do_write_data_page
                                        - use dn of original inode
    truncate_inode_pages_final

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7901ede58113..7e47b8054413 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,6 +192,9 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
+	if (clean)
+		truncate_inode_pages_final(inode->i_mapping);
+
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
@@ -201,7 +204,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	F2FS_I(inode)->atomic_write_task = NULL;
 
 	if (clean) {
-		truncate_inode_pages_final(inode->i_mapping);
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
-- 
2.25.1


