Return-Path: <stable+bounces-225009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOpuLhcfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C0278B12
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3C030205ED
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F32DC76C;
	Thu, 12 Mar 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDR00nUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC92BEFFD;
	Thu, 12 Mar 2026 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346581; cv=none; b=SxBcJ5Oam/0tykXodLcxs3SBrj+YG9QpzbXCsNS8l9eh+GOLNFyopYBtF1mJbNnpCi2MjZPfufKvA9Bxt5a1t9d4Eyb/+prK7zumLfX2Q+o6t6cyJDqrtY4l4Mok1dA0BScq1Mec9FOi2Ylz/UNg7PNM04pIAXeO0SaG0B4FkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346581; c=relaxed/simple;
	bh=BgxTtXKv2JgCgVObQ3I+m28BLFl8rOB9bDxdAIDAOLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN29fMx1cvBGNDhF2nh826gAdTLqVRsSroEOp4Ri9zBQLfI/LV7Y0Qqjzk3On9lfUxmgIshSw79LHDIn1kBJgP24dBB8mNT9FN3+nRUBUET487/Ko1sAwiHNK/kfFMIOtBtncFaJui6LK9OvIig7rVKZup2Ao3VkkAkakcoAj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDR00nUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2171AC4CEF7;
	Thu, 12 Mar 2026 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346580;
	bh=BgxTtXKv2JgCgVObQ3I+m28BLFl8rOB9bDxdAIDAOLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDR00nUYVDyDv73a5gLX7yvzBfbRXz0/Id1750mVHu0CmLQDvswMaCVLadK6aHRBO
	 Iw4GRMnl5XmlvnrVeoM7d0T3QIheOuJ0HR9iVuza61W3lO0AbN8b6G08IqWfDPTAgj
	 fjF31Pofsi9T7ySdsiQftv2iHcymsrZhFld+7RR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 075/265] ext4: factor out ext4_mb_might_prefetch()
Date: Thu, 12 Mar 2026 21:07:42 +0100
Message-ID: <20260312201020.924569922@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225009-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7C0278B12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 5abd85f667a19ef7d880ed00c201fc22de6fa707 ]

Extract ext4_mb_might_prefetch() to make the code clearer and to
prepare for the later conversion of 'choose group' to 'scan groups'.
No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250714130327.1830534-14-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 4865c768b563 ("ext4: always allocate blocks only from groups inode can use")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 62 +++++++++++++++++++++++++++++------------------
 fs/ext4/mballoc.h |  4 +++
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a32d84e3031da..af014b43d0b3f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2797,6 +2797,37 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 	return group;
 }
 
+/*
+ * Batch reads of the block allocation bitmaps to get
+ * multiple READs in flight; limit prefetching at inexpensive
+ * CR, otherwise mballoc can spend a lot of time loading
+ * imperfect groups
+ */
+static void ext4_mb_might_prefetch(struct ext4_allocation_context *ac,
+				   ext4_group_t group)
+{
+	struct ext4_sb_info *sbi;
+
+	if (ac->ac_prefetch_grp != group)
+		return;
+
+	sbi = EXT4_SB(ac->ac_sb);
+	if (ext4_mb_cr_expensive(ac->ac_criteria) ||
+	    ac->ac_prefetch_ios < sbi->s_mb_prefetch_limit) {
+		unsigned int nr = sbi->s_mb_prefetch;
+
+		if (ext4_has_feature_flex_bg(ac->ac_sb)) {
+			nr = 1 << sbi->s_log_groups_per_flex;
+			nr -= group & (nr - 1);
+			nr = umin(nr, sbi->s_mb_prefetch);
+		}
+
+		ac->ac_prefetch_nr = nr;
+		ac->ac_prefetch_grp = ext4_mb_prefetch(ac->ac_sb, group, nr,
+						       &ac->ac_prefetch_ios);
+	}
+}
+
 /*
  * Prefetching reads the block bitmap into the buffer cache; but we
  * need to make sure that the buddy bitmap in the page cache has been
@@ -2833,10 +2864,9 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
-	ext4_group_t prefetch_grp = 0, ngroups, group, i;
+	ext4_group_t ngroups, group, i;
 	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
 	int err = 0, first_err = 0;
-	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	struct ext4_buddy e4b;
@@ -2897,6 +2927,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		cr = CR_POWER2_ALIGNED;
 
 	ac->ac_e4b = &e4b;
+	ac->ac_prefetch_ios = 0;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
@@ -2906,8 +2937,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 */
 		group = ac->ac_g_ex.fe_group;
 		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
-		prefetch_grp = group;
-		nr = 0;
+		ac->ac_prefetch_grp = group;
+		ac->ac_prefetch_nr = 0;
 
 		for (i = 0, new_cr = cr; i < ngroups; i++,
 		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
@@ -2919,24 +2950,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				goto repeat;
 			}
 
-			/*
-			 * Batch reads of the block allocation bitmaps
-			 * to get multiple READs in flight; limit
-			 * prefetching at inexpensive CR, otherwise mballoc
-			 * can spend a lot of time loading imperfect groups
-			 */
-			if ((prefetch_grp == group) &&
-			    (ext4_mb_cr_expensive(cr) ||
-			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
-				nr = sbi->s_mb_prefetch;
-				if (ext4_has_feature_flex_bg(sb)) {
-					nr = 1 << sbi->s_log_groups_per_flex;
-					nr -= group & (nr - 1);
-					nr = min(nr, sbi->s_mb_prefetch);
-				}
-				prefetch_grp = ext4_mb_prefetch(sb, group,
-							nr, &prefetch_ios);
-			}
+			ext4_mb_might_prefetch(ac, group);
 
 			/* prevent unnecessary buddy loading. */
 			if (cr < CR_ANY_FREE &&
@@ -3030,8 +3044,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
 
-	if (nr)
-		ext4_mb_prefetch_fini(sb, prefetch_grp, nr);
+	if (ac->ac_prefetch_nr)
+		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
 
 	return err;
 }
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 7a60b0103e649..9f66b1d5db67a 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -192,6 +192,10 @@ struct ext4_allocation_context {
 	 */
 	ext4_grpblk_t	ac_orig_goal_len;
 
+	ext4_group_t ac_prefetch_grp;
+	unsigned int ac_prefetch_ios;
+	unsigned int ac_prefetch_nr;
+
 	__u32 ac_flags;		/* allocation hints */
 	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-- 
2.51.0




