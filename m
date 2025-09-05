Return-Path: <stable+bounces-177807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E0B455AD
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75800A03872
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72F33EB1F;
	Fri,  5 Sep 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0r/LA+F"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E91321422
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070277; cv=none; b=lWicIr7WfRjNR/LYwYwVZNu6lbQc0L0rW9RQhZmpjtXHuQBHVsy9cRwPuniy193M48TcR6ZI7clFoVU+nofo7VDII82sNPMkwkaD3f2zFAGLgiz2do817Ma/oCi/EO1m/+jxPN/ZonHzg6I3Ba1QMkoxm/xQJzwJcGEb5ZISj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070277; c=relaxed/simple;
	bh=1al0pBv8T7uSsaUAxwfsGbG1QamaxFIDPPYx6QCAKeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZChQC+X82iz8ymaqCoXqc8B7hIYmTVkgE/vmZ3LkVcxV5uNMB4HkhUj8eFuiJh8K02wl7pCMiyfDOF2SO2/owhrc6cgmcjp2/gI5glTnIaB3nCElB46hCJWZuruMBTBr1P2GKqFRkIekox1m2wwgbgUIoxuQjfge/JFeE6kzz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P0r/LA+F; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0OZM027144;
	Fri, 5 Sep 2025 11:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3UKbg
	eaFp9ute8Gg7PQXYZxl8w0CVJwXGHVkib6jxgY=; b=P0r/LA+FHOo4T9xPaZ4Nk
	Z1oGKiQPw7PHa3rIS8vExc6fttuCNOB13Sx+zhCTvcaaldTBRlUPJ91y8qpz0KzG
	kCPbNBZtn1VMIaFKAuzhpkRcNBgHMnnJEiWsytAFrpYARLNAwGLsCUBu5+j1blQI
	cSty8nCpsxE8WRkUrZzO8GdfxUvbtr23+uYQryxQ7zrtP5UjrunBnUoNKtaJx5Je
	TxBswzZ6GjCohnUbt0H3fbuVl7W/wB2FjmweALV6g3VbBZboa1oUzh/zWgwZY/98
	E/t2ZHTLuhKHroBk8MEWtOv/2/QjTMImbn0+pqnOYxvRy2mlbAl7n9S31AQH9xA2
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JbbF019742;
	Fri, 5 Sep 2025 11:04:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hU030057;
	Fri, 5 Sep 2025 11:04:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-11;
	Fri, 05 Sep 2025 11:04:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Mahesh Kumar <maheshkumar657g@gmail.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 10/15] ext4: avoid journaling sb update on error if journal is destroying
Date: Fri,  5 Sep 2025 04:04:01 -0700
Message-ID: <20250905110406.3021567-11-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfX3464LXtdUK22
 TIogoE3CAPIsgLYZCWRt2hD1Wt/WsFJERXGIHVc4en42ynS1qpP1bZpFKPLu6ORGQybq1gj9+tz
 g3V09HfBrCaln5H6xAd7SI8Vib4cKHwKx+bL3YjTZfPqtQSEZqtdJhXyO2CMirxrCnyXFlVCkNz
 665HkbUQlwsV/D2inaRJf5rOKM3PqNk5QN5u5p91yvetyS4yEsx4WAZGy3upi8TdB8pGPCwYkAM
 jJWwK0nPmynIl5puZxjYv0rpQiRAQP3ntkfRtdEQzcmhAANlLHQX7UrLCgU+FDXPjyy1QB2MO0s
 wVrYue/fzskoUPnlhtrkuhbSS6qmd8H5JIgcYrkZSfNQfabgSDz1s+T+9PXqHSLzhHlFwJiA0MH
 O9EXi7vY
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3bd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=vp_r6XFS9DC9921vF3YA:9 a=EBa_rOYxF3VBboPlVeQ_:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: wakWV8Vsl8AYnbOEkdJeBKAYUuG7Dj1-
X-Proofpoint-GUID: wakWV8Vsl8AYnbOEkdJeBKAYUuG7Dj1-

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit ce2f26e73783b4a7c46a86e3af5b5c8de0971790 ]

Presently we always BUG_ON if trying to start a transaction on a journal marked
with JBD2_UNMOUNT, since this should never happen. However, while ltp running
stress tests, it was observed that in case of some error handling paths, it is
possible for update_super_work to start a transaction after the journal is
destroyed eg:

(umount)
ext4_kill_sb
  kill_block_super
    generic_shutdown_super
      sync_filesystem /* commits all txns */
      evict_inodes
        /* might start a new txn */
      ext4_put_super
	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
        jbd2_journal_destroy
          journal_kill_thread
            journal->j_flags |= JBD2_UNMOUNT;
          jbd2_journal_commit_transaction
            jbd2_journal_get_descriptor_buffer
              jbd2_journal_bmap
                ext4_journal_bmap
                  ext4_map_blocks
                    ...
                    ext4_inode_error
                      ext4_handle_error
                        schedule_work(&sbi->s_sb_upd_work)

                                               /* work queue kicks in */
                                               update_super_work
                                                 jbd2_journal_start
                                                   start_this_handle
                                                     BUG_ON(journal->j_flags &
                                                            JBD2_UNMOUNT)

Hence, introduce a new mount flag to indicate journal is destroying and only do
a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
fallback to an un-journaled commit.

Further, in the journal destroy path, we have the following sequence:

  1. Set mount flag indicating journal is destroying
  2. force a commit and wait for it
  3. flush pending sb updates

This sequence is important as it ensures that, after this point, there is no sb
update that might be journaled so it is safe to update the sb outside the
journal. (To avoid race discussed in 2d01ddc86606)

Also, we don't need a similar check in ext4_grp_locked_error since it is only
called from mballoc and AFAICT it would be always valid to schedule work here.

Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/9613c465d6ff00cd315602f99283d5f24018c3f7.1742279837.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit ce2f26e73783b4a7c46a86e3af5b5c8de0971790)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/ext4/ext4.h      |  3 ++-
 fs/ext4/ext4_jbd2.h | 15 +++++++++++++++
 fs/ext4/super.c     | 16 ++++++++--------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a95525bfb99c..d8120b88fa00 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1823,7 +1823,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 930778e507cc..ada46189b086 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -521,6 +521,21 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
 {
 	int err = 0;
 
+	/*
+	 * At this point only two things can be operating on the journal.
+	 * JBD2 thread performing transaction commit and s_sb_upd_work
+	 * issuing sb update through the journal. Once we set
+	 * EXT4_JOURNAL_DESTROY, new ext4_handle_error() calls will not
+	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
+	 * ext4_handle_error() calls from the running transaction commit are
+	 * finished. Hence no new s_sb_upd_work can be queued after we
+	 * flush it here.
+	 */
+	ext4_set_mount_flag(sbi->s_sb, EXT4_MF_JOURNAL_DESTROY);
+
+	ext4_force_commit(sbi->s_sb);
+	flush_work(&sbi->s_sb_upd_work);
+
 	err = jbd2_journal_destroy(journal);
 	sbi->s_journal = NULL;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d0500f19bf51..58d125ad2371 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -719,9 +719,13 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * In case the fs should keep running, we need to writeout
 		 * superblock through the journal. Due to lock ordering
 		 * constraints, it may not be safe to do it right here so we
-		 * defer superblock flushing to a workqueue.
+		 * defer superblock flushing to a workqueue. We just need to be
+		 * careful when the journal is already shutting down. If we get
+		 * here in that case, just update the sb directly as the last
+		 * transaction won't commit anyway.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal &&
+		    !ext4_test_mount_flag(sb, EXT4_MF_JOURNAL_DESTROY))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
@@ -1306,7 +1310,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_li_request(sb);
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 
-	flush_work(&sbi->s_sb_upd_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
 	ext4_release_orphan_info(sb);
 
@@ -1316,7 +1319,8 @@ static void ext4_put_super(struct super_block *sb)
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
-	}
+	} else
+		flush_work(&sbi->s_sb_upd_work);
 
 	ext4_es_unregister_shrinker(sbi);
 	timer_shutdown_sync(&sbi->s_err_report);
@@ -4954,8 +4958,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	return 0;
 
 out:
-	/* flush s_sb_upd_work before destroying the journal. */
-	flush_work(&sbi->s_sb_upd_work);
 	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
@@ -5645,8 +5647,6 @@ failed_mount8: __maybe_unused
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		/* flush s_sb_upd_work before journal destroy. */
-		flush_work(&sbi->s_sb_upd_work);
 		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:
-- 
2.50.1


