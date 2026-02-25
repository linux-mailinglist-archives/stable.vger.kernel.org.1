Return-Path: <stable+bounces-219613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwCD7P4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79121980BC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E482310AECC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB93B8D70;
	Wed, 25 Feb 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzXNGGFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE234F49A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025785; cv=none; b=D09GPYX7MP9p0j8dlnGltTYuQf0SsTDZwOjB2+5NvtPruyfqQz2/jgLWMFAvQnSV4k8y3951fyYurfXtR9ZyrfL45Qi0yOEh0DLR3FG2O4TOaqX9HBThJ23hP/NwKNerwWZlfYLvmFh1few7dTRLC5FF5r2M8QjRYH9LhLVs2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025785; c=relaxed/simple;
	bh=6EwtloHH8zTNCsVXU2JNfULYTrkQVwF6+z9/CToBFtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6DBTX97zYvSurh+UcThoHDNgrFlkCyBXrmrSQpRtbsyvPBbvK9tKc7QlEB+c2LC7Jbs2YidZb+6YmvwIB8ND8uX07PVUUwlIzK4ytpbwHFlP6h7GIGpyhfZ0kpkaXj0LJkrVsA2jRTtx4KuKbK1YvGHKxhORH1uWF6HxHhHPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzXNGGFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8531C2BC86;
	Wed, 25 Feb 2026 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025785;
	bh=6EwtloHH8zTNCsVXU2JNfULYTrkQVwF6+z9/CToBFtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzXNGGFwBH+GDmHy0D9CIslagTCr8Rs+uOBDkIzMI4tAPu0gAQuyRf7/v1GRaFnWb
	 HfA0xDtP8kvARL3LQAH0AEMXXtrN9RzkHXKoVDu6jfcvb+eCi6MhGre51tPhV3JYUk
	 QgxoefdMec4dBdR6Mz99K5XjLtQDEmlRxJcMxYtD6SnbcdaYTZyBqFVlPqcVUyczz+
	 zmuwRnTwWhwBt7p0P3OocfNxc2B/bbmfaITjmXNlZHx1mClVdl8wlFrJ5qIEJ3FdnY
	 xQlsaE9NVwxIbSpHdRHWgpZsIYK7M21wRLqX1dmB6v44CzuQaaupMpxsLrSm6n3cur
	 V55OViayST6Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead
Date: Wed, 25 Feb 2026 08:22:58 -0500
Message-ID: <20260225132302.222887-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225132302.222887-1-sashal@kernel.org>
References: <2026022401-arose-calm-3e73@gregkh>
 <20260225132302.222887-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219613-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B79121980BC
X-Rspamd-Action: no action

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 19b8b035a776939ceb3de0f45aded4751d7849ef ]

In cases where we have an obvious way of continuing, let's use
WARN_RATELIMITED() instead of BUG_ON().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bf53a6b283ae4..e44dd404fe407 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1533,7 +1533,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
 		if (page) {
-			BUG_ON(page->mapping != inode->i_mapping);
+			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
+	"ext4: bitmap's paging->mapping != inode->i_mapping\n")) {
+				/* should never happen */
+				unlock_page(page);
+				ret = -EINVAL;
+				goto err;
+			}
 			if (!PageUptodate(page)) {
 				ret = ext4_mb_init_cache(page, NULL, gfp);
 				if (ret) {
@@ -1569,7 +1575,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
 		if (page) {
-			BUG_ON(page->mapping != inode->i_mapping);
+			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
+	"ext4: buddy bitmap's page->mapping != inode->i_mapping\n")) {
+				/* should never happen */
+				unlock_page(page);
+				ret = -EINVAL;
+				goto err;
+			}
 			if (!PageUptodate(page)) {
 				ret = ext4_mb_init_cache(page, e4b->bd_bitmap,
 							 gfp);
@@ -2288,7 +2300,9 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 			continue;
 
 		buddy = mb_find_buddy(e4b, i, &max);
-		BUG_ON(buddy == NULL);
+		if (WARN_RATELIMIT(buddy == NULL,
+			 "ext4: mb_simple_scan_group: mb_find_buddy failed, (%d)\n", i))
+			continue;
 
 		k = mb_find_next_zero_bit(buddy, max, 0);
 		if (k >= max) {
@@ -4314,15 +4328,14 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 		if (ac->ac_f_ex.fe_len == 0)
 			return;
 		err = ext4_mb_load_buddy(ac->ac_sb, ac->ac_f_ex.fe_group, &e4b);
-		if (err) {
+		if (WARN_RATELIMIT(err,
+				   "ext4: mb_load_buddy failed (%d)", err))
 			/*
 			 * This should never happen since we pin the
 			 * pages in the ext4_allocation_context so
 			 * ext4_mb_load_buddy() should never fail.
 			 */
-			WARN(1, "mb_load_buddy failed (%d)", err);
 			return;
-		}
 		ext4_lock_group(ac->ac_sb, ac->ac_f_ex.fe_group);
 		mb_free_blocks(ac->ac_inode, &e4b, ac->ac_f_ex.fe_start,
 			       ac->ac_f_ex.fe_len);
-- 
2.51.0


