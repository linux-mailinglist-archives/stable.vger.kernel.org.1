Return-Path: <stable+bounces-219616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMa7F8D4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3771980DE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE243113406
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A483B8D4A;
	Wed, 25 Feb 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Bw13RQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E583AE701
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025787; cv=none; b=OlHYcnqS2z+4hr/skFvM18TmzQ24pMzwsGkUkTvKB9i5ut0UH8o1AIcPDUaq54l/E7pKxe3OJJhwoadWEYf11GqkztOG1rLIXvbiMWVnG6iAak1Gx59Kmg9nsqg9GxMg8KgCLa2XJr8g4TZaTlrUcjf6swJkpSYkAdIUVucDIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025787; c=relaxed/simple;
	bh=Kb+ImaUKiq0NDEjMJhNzhXLeBt3QjEBZUiHlexf4bJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ8+JOVglWIE6pNBRXQ22k/OKMWamg4pnpkNfNUMqsWlehCYAG+88gtGGLsTc6Nz4cotLekEqpuH+5ktizjJ3EpIhEWxyR4blzt73dCd9/Djqtz8boxdAjDE1aJWxre3BjLXRzvKZwFP3KFAz1mAhv9a6FfExImOsxHZ2elFeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Bw13RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EBC116D0;
	Wed, 25 Feb 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025787;
	bh=Kb+ImaUKiq0NDEjMJhNzhXLeBt3QjEBZUiHlexf4bJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2Bw13RQ6uzXDrqlvWRXUsldOHZBkSHogh1jeGCvqh5SAIK3JFU7zkhhes1RRhFLE
	 Kr0qMiZKAtyK3hY8WpupVbAOdpIH2MjZnSzG17dLw5+0DHKxWD2ONcyCQxsJCZ8BcC
	 nGYXC6+iEXmVyGiSoeXDfl7Li0fu/X1IZsDhjNu0mULXOXIKKieS4ImpXK0sGZ7xS1
	 JrPI87n9zcUTSHILlEUhC8BQeUYktDKGvTIaaK7GSTYYBeeUkdS+1wEMb5cp3aCij/
	 3Nr7WFH49LF/RK333SL50b/SoGU39n9h+BYKfexC5+3VUocVmfC8F+RUtxdEF+d1K7
	 AAdgAOCkmy/Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] ext4: convert bd_buddy_page to bd_buddy_folio
Date: Wed, 25 Feb 2026 08:23:01 -0500
Message-ID: <20260225132302.222887-5-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219616-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE3771980DE
X-Rspamd-Action: no action

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 5eea586b47f05b5f5518cf8f9dd9283a01a8066d ]

There is no need to make this a multi-page folio, so leave all the
infrastructure around it in pages.  But since we're locking it, playing
with its refcount and checking whether it's uptodate, it needs to move
to the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20240416172900.244637-3-willy@infradead.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 91 +++++++++++++++++++++++------------------------
 fs/ext4/mballoc.h |  2 +-
 2 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4cbe4c837f817..1d3eadf177234 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1338,7 +1338,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
  * Lock the buddy and bitmap pages. This make sure other parallel init_group
  * on the same buddy page doesn't happen whild holding the buddy page lock.
  * Return locked buddy and bitmap pages on e4b struct. If buddy and bitmap
- * are on the same page e4b->bd_buddy_page is NULL and return value is 0.
+ * are on the same page e4b->bd_buddy_folio is NULL and return value is 0.
  */
 static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		ext4_group_t group, struct ext4_buddy *e4b, gfp_t gfp)
@@ -1346,10 +1346,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	struct inode *inode = EXT4_SB(sb)->s_buddy_cache;
 	int block, pnum, poff;
 	int blocks_per_page;
-	struct page *page;
 	struct folio *folio;
 
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
@@ -1375,11 +1374,12 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	}
 
 	/* blocks_per_page == 1, hence we need another page for the buddy */
-	page = find_or_create_page(inode->i_mapping, block + 1, gfp);
-	if (!page)
-		return -ENOMEM;
-	BUG_ON(page->mapping != inode->i_mapping);
-	e4b->bd_buddy_page = page;
+	folio = __filemap_get_folio(inode->i_mapping, block + 1,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	BUG_ON(folio->mapping != inode->i_mapping);
+	e4b->bd_buddy_folio = folio;
 	return 0;
 }
 
@@ -1389,9 +1389,9 @@ static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
 		folio_unlock(e4b->bd_bitmap_folio);
 		folio_put(e4b->bd_bitmap_folio);
 	}
-	if (e4b->bd_buddy_page) {
-		unlock_page(e4b->bd_buddy_page);
-		put_page(e4b->bd_buddy_page);
+	if (e4b->bd_buddy_folio) {
+		folio_unlock(e4b->bd_buddy_folio);
+		folio_put(e4b->bd_buddy_folio);
 	}
 }
 
@@ -1406,7 +1406,6 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 
 	struct ext4_group_info *this_grp;
 	struct ext4_buddy e4b;
-	struct page *page;
 	struct folio *folio;
 	int ret = 0;
 
@@ -1443,7 +1442,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 
-	if (e4b.bd_buddy_page == NULL) {
+	if (e4b.bd_buddy_folio == NULL) {
 		/*
 		 * If both the bitmap and buddy are in
 		 * the same page we don't need to force
@@ -1453,11 +1452,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 	/* init buddy cache */
-	page = e4b.bd_buddy_page;
-	ret = ext4_mb_init_cache(page, e4b.bd_bitmap, gfp);
+	folio = e4b.bd_buddy_folio;
+	ret = ext4_mb_init_cache(&folio->page, e4b.bd_bitmap, gfp);
 	if (ret)
 		goto err;
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
@@ -1479,7 +1478,6 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	int block;
 	int pnum;
 	int poff;
-	struct page *page;
 	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
@@ -1498,7 +1496,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_info = grp;
 	e4b->bd_sb = sb;
 	e4b->bd_group = group;
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -1564,7 +1562,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		goto err;
 	}
 
-	/* Pages marked accessed already */
+	/* Folios marked accessed already */
 	e4b->bd_bitmap_folio = folio;
 	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
@@ -1572,48 +1570,49 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
 
-	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
-		if (page)
-			put_page(page);
-		page = find_or_create_page(inode->i_mapping, pnum, gfp);
-		if (page) {
-			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
-	"ext4: buddy bitmap's page->mapping != inode->i_mapping\n")) {
+	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		if (!IS_ERR(folio))
+			folio_put(folio);
+		folio = __filemap_get_folio(inode->i_mapping, pnum,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+		if (!IS_ERR(folio)) {
+			if (WARN_RATELIMIT(folio->mapping != inode->i_mapping,
+	"ext4: buddy bitmap's mapping != inode->i_mapping\n")) {
 				/* should never happen */
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = -EINVAL;
 				goto err;
 			}
-			if (!PageUptodate(page)) {
-				ret = ext4_mb_init_cache(page, e4b->bd_bitmap,
+			if (!folio_test_uptodate(folio)) {
+				ret = ext4_mb_init_cache(&folio->page, e4b->bd_bitmap,
 							 gfp);
 				if (ret) {
-					unlock_page(page);
+					folio_unlock(folio);
 					goto err;
 				}
 			}
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 	}
-	if (page == NULL) {
-		ret = -ENOMEM;
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		goto err;
 	}
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
 
-	/* Pages marked accessed already */
-	e4b->bd_buddy_page = page;
-	e4b->bd_buddy = page_address(page) + (poff * sb->s_blocksize);
+	/* Folios marked accessed already */
+	e4b->bd_buddy_folio = folio;
+	e4b->bd_buddy = folio_address(folio) + (poff * sb->s_blocksize);
 
 	return 0;
 
 err:
-	if (page)
-		put_page(page);
+	if (folio)
+		folio_put(folio);
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
 
@@ -1632,8 +1631,8 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 {
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
-	if (e4b->bd_buddy_page)
-		put_page(e4b->bd_buddy_page);
+	if (e4b->bd_buddy_folio)
+		folio_put(e4b->bd_buddy_folio);
 }
 
 
@@ -2058,7 +2057,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 */
 	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
 	get_page(ac->ac_bitmap_page);
-	ac->ac_buddy_page = e4b->bd_buddy_page;
+	ac->ac_buddy_page = &e4b->bd_buddy_folio->page;
 	get_page(ac->ac_buddy_page);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
@@ -3720,7 +3719,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
-		put_page(e4b.bd_buddy_page);
+		folio_put(e4b.bd_buddy_folio);
 		folio_put(e4b.bd_bitmap_folio);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
@@ -5895,7 +5894,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 
 	BUG_ON(!ext4_handle_valid(handle));
 	BUG_ON(e4b->bd_bitmap_folio == NULL);
-	BUG_ON(e4b->bd_buddy_page == NULL);
+	BUG_ON(e4b->bd_buddy_folio == NULL);
 
 	new_node = &new_entry->efd_node;
 	cluster = new_entry->efd_start_cluster;
@@ -5906,7 +5905,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		 * otherwise we'll refresh it from
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
-		get_page(e4b->bd_buddy_page);
+		folio_get(e4b->bd_buddy_folio);
 		folio_get(e4b->bd_bitmap_folio);
 	}
 	while (*n) {
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 24e7c7a04f674..fe4dbbbbe8725 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -201,7 +201,7 @@ struct ext4_allocation_context {
 #define AC_STATUS_BREAK		3
 
 struct ext4_buddy {
-	struct page *bd_buddy_page;
+	struct folio *bd_buddy_folio;
 	void *bd_buddy;
 	struct folio *bd_bitmap_folio;
 	void *bd_bitmap;
-- 
2.51.0


