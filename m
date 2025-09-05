Return-Path: <stable+bounces-177809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25BB455AC
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A5D5A6415
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7FD33EB13;
	Fri,  5 Sep 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QiBmMBRz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D534166A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070278; cv=none; b=UuhOqluGmk7fyFurMpCWmUfN+CJGiK7c4SclwUzSl+KuhfTKPviFGFbCIZbyP2Wa6Fa6Z0Q1D9AtIgyZnz4XDz3gaNtRdF1fO0Xi7rbFQSrLlnymAr9XC2TEwDZuE2CuUd61m8ipLJCxST/xxGxhfSkPHksJ9xSBdPmq6X+JDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070278; c=relaxed/simple;
	bh=zIGtUO0cIggxg230AHQRPYp6s6jf59xL2Gd/RO8qfO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2xCMQAjAcRihh6Y/Lkx4GX487OLuh7iMKGXl9O/bFLohrONEUoYhx+m8iCAvXSb5dfICN/2vjh+zxpPzp+hd1I4ebcqw2xkR6HXdDBN5gkiS+ULadTTG7M0GZc34+XZ9rX/gI1Hs1Jm/YDWANCMwxkzKbeIIVeCjVcLSAaBBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QiBmMBRz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtjCU006145;
	Fri, 5 Sep 2025 11:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MNaYV
	5BxnQkgw/UpPZBZtVyt+zfQhmLZ/FWlUIqvnf8=; b=QiBmMBRz2XrO8OCMBgNWt
	IZBWSFXS8ej+PutSMDxkJt/iwgGnTcaEtEyLfD5xqj3ys/BXJoPRvXeLreP4Vi7t
	bHYFUbn9GQmF+refQokpbcMlMwwQTiBOU6PMCfwAvnEdxTSVNMgO2yanl7rAxGPv
	Xiabp9KgEwrBxTZmmgzE9E55FXJTPYzSGZf/3Bpq1PRM3qev4HowRYo/F2yP4Am9
	YfqQVzeaO1xxWxUL+n2UbLltaRP4P31q9c9N8WprwpLGqfbmZx/bFmcPe7vTOovh
	vAP1nJJhUkfavjmy1TuR2HLsWtghpYZr3JGmVq2iyQ3XPSK8FnBvTPB2yXfFQ2kq
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa5812g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Jc86019774;
	Fri, 5 Sep 2025 11:04:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hS030057;
	Fri, 5 Sep 2025 11:04:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-10;
	Fri, 05 Sep 2025 11:04:25 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 09/15] ext4: define ext4_journal_destroy wrapper
Date: Fri,  5 Sep 2025 04:04:00 -0700
Message-ID: <20250905110406.3021567-10-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3bb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=F6WYh8u_2drjpdgj7MEA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfX/NMG7VzFUhac
 HuCpV/yDmlCdZpYEgeM1vREH1bJpVmYsIlPCwdSnFWsWt9/8l6MXsKU8dUEhtx6iBGNhgFTksn8
 GDfWn0OmBHswWMfYjMBJV5PPBPGkRcWAnT6KdVdmDtSE9EFbChdD4GMWeME9iv3PZ4J+0lYBwLf
 Rn6WlD0nkA4AhoJ5b7kBtoId8fb9hKJ7rkarlKrRdOo/s2QwXtWnPFUClziLG4lVbvZqq0XAb9J
 GeHvI3mLmrCQjqawz9YH1KjdzTQAKgE9XsiJcmGXcAeb4k0cJL6vuTvczPfj6hnyU7/oP6/uC6i
 zi6hc/JL4zX+Y0sBAYx9A+KJZu+Qc5Z8cIN8PSlJ+e9J4y1QPdhlMYbAOf9yitBjC5AgrmIl2Zm
 lfslKBsk
X-Proofpoint-ORIG-GUID: 5ocHr8HxEaZh3n65QdqGEMHZC9kc2qsS
X-Proofpoint-GUID: 5ocHr8HxEaZh3n65QdqGEMHZC9kc2qsS

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 5a02a6204ca37e7c22fbb55a789c503f05e8e89a ]

Define an ext4 wrapper over jbd2_journal_destroy to make sure we
have consistent behavior during journal destruction. This will also
come useful in the next patch where we add some ext4 specific logic
in the destroy path.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/c3ba78c5c419757e6d5f2d8ebb4a8ce9d21da86a.1742279837.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit 5a02a6204ca37e7c22fbb55a789c503f05e8e89a)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/ext4/ext4_jbd2.h | 14 ++++++++++++++
 fs/ext4/super.c     | 16 ++++++----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..930778e507cc 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -513,4 +513,18 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/*
+ * Pass journal explicitly as it may not be cached in the sbi->s_journal in some
+ * cases
+ */
+static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *journal)
+{
+	int err = 0;
+
+	err = jbd2_journal_destroy(journal);
+	sbi->s_journal = NULL;
+
+	return err;
+}
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 722ac723f49b..d0500f19bf51 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1312,8 +1312,7 @@ static void ext4_put_super(struct super_block *sb)
 
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
-		err = jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		err = ext4_journal_destroy(sbi, sbi->s_journal);
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
@@ -4957,8 +4956,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 out:
 	/* flush s_sb_upd_work before destroying the journal. */
 	flush_work(&sbi->s_sb_upd_work);
-	jbd2_journal_destroy(sbi->s_journal);
-	sbi->s_journal = NULL;
+	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
 
@@ -5649,8 +5647,7 @@ failed_mount8: __maybe_unused
 	if (sbi->s_journal) {
 		/* flush s_sb_upd_work before journal destroy. */
 		flush_work(&sbi->s_sb_upd_work);
-		jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
@@ -5958,7 +5955,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	return journal;
 
 out_journal:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 out_bdev:
 	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
@@ -6075,8 +6072,7 @@ static int ext4_load_journal(struct super_block *sb,
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
 	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
-		jbd2_journal_destroy(journal);
+		ext4_journal_destroy(EXT4_SB(sb), journal);
 		return err;
 	}
 
@@ -6094,7 +6090,7 @@ static int ext4_load_journal(struct super_block *sb,
 	return 0;
 
 err_out:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 	return err;
 }
 
-- 
2.50.1


