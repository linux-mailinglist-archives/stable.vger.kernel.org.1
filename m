Return-Path: <stable+bounces-225008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KNKCxYfs2mSSQAAu9opvQ
	(envelope-from <stable+bounces-225008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A5278B0B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9163C301474F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C291E7660;
	Thu, 12 Mar 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OT2y/psp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC328C009;
	Thu, 12 Mar 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346577; cv=none; b=tOaOhgiHmE9wD1hFAuO9fckDQx1HiFwZsQrDT/Ql/w9fekQeXoX7IY9Y/blAGs6yHOjD79W2D1B5sEqCGTW7I44IB7EY+GoqM5uhzFrpb2I6izYbgPAwa1gN9azxkG18OfNxFWix2cgMAhLs3ekFULIv0VXy2ObC5qv8yn0k4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346577; c=relaxed/simple;
	bh=d9fem3j+Jl1ps/mdENlHKtRY2HUeG10uGGN/9YaPq4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM+usqV1uUJLTc3ukryuKfrBP2gg2VOlvzq88ZQ8Pu/Z/Ol+q4ID2AmaoH5/PwcbnZFUX3+JMLRXw/+dRVTqy6MEOttudz9md8uU1HrarfxRR5amPwL7QzllUAghGJmdOaB9AR++8SDCI6ov3KnXkNIULXwZswQ5eBl4/OTPPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OT2y/psp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1179CC4CEF7;
	Thu, 12 Mar 2026 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346576;
	bh=d9fem3j+Jl1ps/mdENlHKtRY2HUeG10uGGN/9YaPq4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OT2y/psph/OX2zuCTKmBT7mYd7AhoVfPOViv4qz/w5Nz2o5q3re2cjGKo2gf0Mchh
	 WzuystM3ZMqgIrTVFnn4mbHIW3bwA3ts6FgPlXGDMG4aTRjQH4lGFsgg9mOiSKEj6r
	 6lWuln8hZIYrVest1hlPmNvfuMSvRdMchIIfQzcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 074/265] ext4: factor out __ext4_mb_scan_group()
Date: Thu, 12 Mar 2026 21:07:41 +0100
Message-ID: <20260312201020.888611227@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225008-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C4A5278B0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 45704f92e55853fe287760e019feb45eeb9c988e ]

Extract __ext4_mb_scan_group() to make the code clearer and to
prepare for the later conversion of 'choose group' to 'scan groups'.
No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250714130327.1830534-13-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 4865c768b563 ("ext4: always allocate blocks only from groups inode can use")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 45 +++++++++++++++++++++++++++------------------
 fs/ext4/mballoc.h |  2 ++
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 329fe83cbe814..a32d84e3031da 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2584,6 +2584,30 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	}
 }
 
+static void __ext4_mb_scan_group(struct ext4_allocation_context *ac)
+{
+	bool is_stripe_aligned;
+	struct ext4_sb_info *sbi;
+	enum criteria cr = ac->ac_criteria;
+
+	ac->ac_groups_scanned++;
+	if (cr == CR_POWER2_ALIGNED)
+		return ext4_mb_simple_scan_group(ac, ac->ac_e4b);
+
+	sbi = EXT4_SB(ac->ac_sb);
+	is_stripe_aligned = false;
+	if ((sbi->s_stripe >= sbi->s_cluster_ratio) &&
+	    !(ac->ac_g_ex.fe_len % EXT4_NUM_B2C(sbi, sbi->s_stripe)))
+		is_stripe_aligned = true;
+
+	if ((cr == CR_GOAL_LEN_FAST || cr == CR_BEST_AVAIL_LEN) &&
+	    is_stripe_aligned)
+		ext4_mb_scan_aligned(ac, ac->ac_e4b);
+
+	if (ac->ac_status == AC_STATUS_CONTINUE)
+		ext4_mb_complex_scan_group(ac, ac->ac_e4b);
+}
+
 /*
  * This is also called BEFORE we load the buddy bitmap.
  * Returns either 1 or 0 indicating that the group is either suitable
@@ -2871,6 +2895,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 */
 	if (ac->ac_2order)
 		cr = CR_POWER2_ALIGNED;
+
+	ac->ac_e4b = &e4b;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
@@ -2948,24 +2974,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				continue;
 			}
 
-			ac->ac_groups_scanned++;
-			if (cr == CR_POWER2_ALIGNED)
-				ext4_mb_simple_scan_group(ac, &e4b);
-			else {
-				bool is_stripe_aligned =
-					(sbi->s_stripe >=
-					 sbi->s_cluster_ratio) &&
-					!(ac->ac_g_ex.fe_len %
-					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
-
-				if ((cr == CR_GOAL_LEN_FAST ||
-				     cr == CR_BEST_AVAIL_LEN) &&
-				    is_stripe_aligned)
-					ext4_mb_scan_aligned(ac, &e4b);
-
-				if (ac->ac_status == AC_STATUS_CONTINUE)
-					ext4_mb_complex_scan_group(ac, &e4b);
-			}
+			__ext4_mb_scan_group(ac);
 
 			ext4_unlock_group(sb, group);
 			ext4_mb_unload_buddy(&e4b);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index f8280de3e8820..7a60b0103e649 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -204,6 +204,8 @@ struct ext4_allocation_context {
 	__u8 ac_2order;		/* if request is to allocate 2^N blocks and
 				 * N > 0, the field stores N, otherwise 0 */
 	__u8 ac_op;		/* operation, for history only */
+
+	struct ext4_buddy *ac_e4b;
 	struct folio *ac_bitmap_folio;
 	struct folio *ac_buddy_folio;
 	struct ext4_prealloc_space *ac_pa;
-- 
2.51.0




