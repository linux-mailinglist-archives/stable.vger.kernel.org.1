Return-Path: <stable+bounces-216867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB/qMbOllGnTGAIAu9opvQ
	(envelope-from <stable+bounces-216867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:30:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D714E9C9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E209030180B7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEE36E48D;
	Tue, 17 Feb 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlAYICpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29D27F18F
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349421; cv=none; b=swrLDX8EWSR+FKZZ/dwBA13UReeGWqyNDeRNu4ULpE2NSs8ivyc0QSgkvX5lIdTr5oo5MSA7FryyTGWeq3cC3kJemkOaJTjWeecsm+WbO8BpjTCixeD1nz9opRTLijSXQFI48INh22eU/Xq6OnkGd1MyBjd5xgtY+spnVxcfkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349421; c=relaxed/simple;
	bh=ODcAIF+4pjCYTLUw8PhuDa2nIWW9tU+bjGXgvgE2Fio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBBRJJYbmulUASfJJq8qK59x65rV12npC3Hx071JrJpCgDY41nmj3WpUwdVwpRLlrx5APcBbQqDkGkTtD0fUkLnGxzUNFcPyECFn8nElYjJ0dLfWiixagc2BKTybcfquRuuzJJXeMhoVWkes0bWZt8yv406LSKc/SASrrY2lESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlAYICpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82CC2BC9E;
	Tue, 17 Feb 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771349420;
	bh=ODcAIF+4pjCYTLUw8PhuDa2nIWW9tU+bjGXgvgE2Fio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VlAYICpAJJYfwLUJfp6thoR/zkAtx7RLSjqtfugiZcWpCfpzijjwA5WFDdrz3YB+a
	 DjO5GhrBQXRArrHqyNqYwOIJ7SpOgJSpD5ORM7IE/LP8LIeBygEisLVci0E1wftJxr
	 EcXzfGoYhihWYrXxUz7ASEG7dxJdmTGZMB6dzRpXiM+5q//MIqS36BNNk6MTQUy62C
	 irbmr7g21Ff+7MkJxDnorsybLRphzq7xMVXZEUpxz0OAPtK6Baq5ya9KTnmgl+8INj
	 j2FxZJi+CYjg/IxcMGERaOAsAG6SxHQW51s7AwMwRtA0TsaGMdhd8jtpcv12stF3CQ
	 p8+6+qHnZc75Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 2/2] f2fs: fix to do sanity check on node footer in {read,write}_end_io
Date: Tue, 17 Feb 2026 12:30:17 -0500
Message-ID: <20260217173017.3790988-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217173017.3790988-1-sashal@kernel.org>
References: <2026021741-extradite-expert-29ab@gregkh>
 <20260217173017.3790988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216867-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,803dd716c4310d16ff3a];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 3B6D714E9C9
X-Rspamd-Action: no action

From: Chao Yu <chao@kernel.org>

[ Upstream commit 50ac3ecd8e05b6bcc350c71a4307d40c030ec7e4 ]

-----------[ cut here ]------------
kernel BUG at fs/f2fs/data.c:358!
Call Trace:
 <IRQ>
 blk_update_request+0x5eb/0xe70 block/blk-mq.c:987
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1149
 blk_complete_reqs block/blk-mq.c:1224 [inline]
 blk_done_softirq+0x107/0x160 block/blk-mq.c:1229
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>

In f2fs_write_end_io(), it detects there is inconsistency in between
node page index (nid) and footer.nid of node page.

If footer of node page is corrupted in fuzzed image, then we load corrupted
node page w/ async method, e.g. f2fs_ra_node_pages() or f2fs_ra_node_page(),
in where we won't do sanity check on node footer, once node page becomes
dirty, we will encounter this bug after node page writeback.

Cc: stable@kernel.org
Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 13 +++++++++++--
 fs/f2fs/f2fs.h | 12 ++++++++++++
 fs/f2fs/node.c | 20 +++++++++++---------
 fs/f2fs/node.h |  8 --------
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a623..3ea92ed4172d3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -151,6 +151,12 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
+
+		if (F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
+				folio, folio->index, NODE_TYPE_REGULAR, true))
+			bio->bi_status = BLK_STS_IOERR;
+
 		folio_end_read(folio, bio->bi_status == BLK_STS_OK);
 	}
 
@@ -352,8 +358,11 @@ static void f2fs_write_end_io(struct bio *bio)
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		f2fs_bug_on(sbi, is_node_folio(folio) &&
-				folio->index != nid_of_node(folio));
+		if (is_node_folio(folio)) {
+			f2fs_sanity_check_node_footer(sbi, folio,
+				folio->index, NODE_TYPE_REGULAR, true);
+			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
+		}
 
 		dec_page_count(sbi, type);
 		if (f2fs_in_warm_node_list(sbi, folio))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20edbb99b814a..6f4b3f0d26b83 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1525,6 +1525,15 @@ enum f2fs_lookup_mode {
 	LOOKUP_AUTO,
 };
 
+/* For node type in __get_node_folio() */
+enum node_type {
+	NODE_TYPE_REGULAR,
+	NODE_TYPE_INODE,
+	NODE_TYPE_XATTR,
+	NODE_TYPE_NON_INODE,
+};
+
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -3857,6 +3866,9 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 						enum node_type node_type);
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
+					struct folio *folio, pgoff_t nid,
+					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a963c4165bc4b..5310b092c5959 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1500,9 +1500,9 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_folio_put(afolio, err ? true : false);
 }
 
-static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
-					enum node_type ntype)
+					enum node_type ntype, bool in_irq)
 {
 	if (unlikely(nid != nid_of_node(folio)))
 		goto out_err;
@@ -1527,12 +1527,13 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 		goto out_err;
 	return 0;
 out_err:
-	f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
-		  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-		  ntype, nid, nid_of_node(folio), ino_of_node(folio),
-		  ofs_of_node(folio), cpver_of_node(folio),
-		  next_blkaddr_of_node(folio));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_warn_ratelimited(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
+		"node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+		ntype, nid, nid_of_node(folio), ino_of_node(folio),
+		ofs_of_node(folio), cpver_of_node(folio),
+		next_blkaddr_of_node(folio));
+
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	return -EFSCORRUPTED;
 }
@@ -1578,7 +1579,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 page_hit:
-	err = sanity_check_node_footer(sbi, folio, nid, ntype);
+	err = f2fs_sanity_check_node_footer(sbi, folio, nid, ntype, false);
 	if (!err)
 		return folio;
 out_err:
@@ -1752,7 +1753,8 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
 
-	if (sanity_check_node_footer(sbi, folio, nid, NODE_TYPE_REGULAR)) {
+	if (f2fs_sanity_check_node_footer(sbi, folio, nid,
+					NODE_TYPE_REGULAR, false)) {
 		f2fs_handle_critical_error(sbi, STOP_CP_REASON_CORRUPTED_NID);
 		goto redirty_out;
 	}
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 9cb8dcf8d4176..824ac9f0e6e42 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -52,14 +52,6 @@ enum {
 	IS_PREALLOC,		/* nat entry is preallocated */
 };
 
-/* For node type in __get_node_folio() */
-enum node_type {
-	NODE_TYPE_REGULAR,
-	NODE_TYPE_INODE,
-	NODE_TYPE_XATTR,
-	NODE_TYPE_NON_INODE,
-};
-
 /*
  * For node information
  */
-- 
2.51.0


