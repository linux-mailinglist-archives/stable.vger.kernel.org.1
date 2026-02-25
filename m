Return-Path: <stable+bounces-219183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPnXG7lvnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45B19141F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CB83303EFEB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6B2BE644;
	Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3kpOgZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582779CD
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990966; cv=none; b=ChOysYPCkS60Rl0wxnPMIOyGNb246yYgTGOOSHbDG0o7RfHl8mV1vgrey0w+5F/C5U+CqwBjd6rlovixucyB06A5BD4ec1JLz5TL2rVUaNVcPR2wVki5NMqqF6md+4M/PKdIqhOAQG/Wa1yifkMt9JQGbx59rYVaqEStOzPMtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990966; c=relaxed/simple;
	bh=UbNk/9/qn4Z4i3J1Mwm45z276RRzNp2p1FobZdkQuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVniHx4qHgzJOY6bqIkNYIXFJeilcLQBjk3DdiiCzMDjiueNgmGYsVOX0zI0GQiaofIQfnLh3/nj8HrW7slUvW7e8MOVN0SiNMwFDHstQ2982IA8mVQkIxgj1IXU/GQrlKSGWMmTUvE2v4ur1Gj8MWtu3A9WavR4+q9x6s7+/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3kpOgZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE66FC19422;
	Wed, 25 Feb 2026 03:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771990966;
	bh=UbNk/9/qn4Z4i3J1Mwm45z276RRzNp2p1FobZdkQuJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3kpOgZE3JtecmK8NhV/wptWkJ/zBJcpf2ekyVEp74m5bTsQoAgiyvfx7DHotA3EK
	 98mACSBO48rxUYl4vt4QetYc+py0N6FunPGWIqgDqHxL4+yWyQUwoUWvF55vYmEz/P
	 IPwQu/rQcTGkwixzbRdMLTnJy5PNKJvUHQkbK/YnKYRqUnKm2TesTTGHohwWFEV/AO
	 P+7NgdTNUs4y6xH5f2AbgZyhPe+iiz0je4+fMrz0DgTu1i+eLOIR4yy3f0yBgh3FYz
	 8AUyDbXeJ7/n49mvm5tnOwt87V8JbKH48o4CsGJgGvw65zBH1Y6KNywNLXRhtoHI8c
	 e7TAWrsesntxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] ext4: convert bd_buddy_page to bd_buddy_folio
Date: Tue, 24 Feb 2026 22:42:41 -0500
Message-ID: <20260225034242.3893844-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225034242.3893844-1-sashal@kernel.org>
References: <2026022400-riverbank-wavy-2e99@gregkh>
 <20260225034242.3893844-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219183-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: DE45B19141F
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
index 4e5fbcf29fc29..e0a9ded2d009f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1454,7 +1454,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
  * Lock the buddy and bitmap pages. This make sure other parallel init_group
  * on the same buddy page doesn't happen whild holding the buddy page lock.
  * Return locked buddy and bitmap pages on e4b struct. If buddy and bitmap
- * are on the same page e4b->bd_buddy_page is NULL and return value is 0.
+ * are on the same page e4b->bd_buddy_folio is NULL and return value is 0.
  */
 static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		ext4_group_t group, struct ext4_buddy *e4b, gfp_t gfp)
@@ -1462,10 +1462,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	struct inode *inode = EXT4_SB(sb)->s_buddy_cache;
 	int block, pnum, poff;
 	int blocks_per_page;
-	struct page *page;
 	struct folio *folio;
 
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
@@ -1491,11 +1490,12 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
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
 
@@ -1505,9 +1505,9 @@ static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
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
 
@@ -1522,7 +1522,6 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 
 	struct ext4_group_info *this_grp;
 	struct ext4_buddy e4b;
-	struct page *page;
 	struct folio *folio;
 	int ret = 0;
 
@@ -1559,7 +1558,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 
-	if (e4b.bd_buddy_page == NULL) {
+	if (e4b.bd_buddy_folio == NULL) {
 		/*
 		 * If both the bitmap and buddy are in
 		 * the same page we don't need to force
@@ -1569,11 +1568,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
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
@@ -1595,7 +1594,6 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	int block;
 	int pnum;
 	int poff;
-	struct page *page;
 	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
@@ -1614,7 +1612,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_info = grp;
 	e4b->bd_sb = sb;
 	e4b->bd_group = group;
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -1680,7 +1678,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		goto err;
 	}
 
-	/* Pages marked accessed already */
+	/* Folios marked accessed already */
 	e4b->bd_bitmap_folio = folio;
 	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
@@ -1688,48 +1686,49 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
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
 
@@ -1748,8 +1747,8 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 {
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
-	if (e4b->bd_buddy_page)
-		put_page(e4b->bd_buddy_page);
+	if (e4b->bd_buddy_folio)
+		folio_put(e4b->bd_buddy_folio);
 }
 
 
@@ -2175,7 +2174,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 */
 	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
 	get_page(ac->ac_bitmap_page);
-	ac->ac_buddy_page = e4b->bd_buddy_page;
+	ac->ac_buddy_page = &e4b->bd_buddy_folio->page;
 	get_page(ac->ac_buddy_page);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
@@ -3907,7 +3906,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
-		put_page(e4b.bd_buddy_page);
+		folio_put(e4b.bd_buddy_folio);
 		folio_put(e4b.bd_bitmap_folio);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
@@ -6355,7 +6354,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 
 	BUG_ON(!ext4_handle_valid(handle));
 	BUG_ON(e4b->bd_bitmap_folio == NULL);
-	BUG_ON(e4b->bd_buddy_page == NULL);
+	BUG_ON(e4b->bd_buddy_folio == NULL);
 
 	new_node = &new_entry->efd_node;
 	cluster = new_entry->efd_start_cluster;
@@ -6366,7 +6365,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		 * otherwise we'll refresh it from
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
-		get_page(e4b->bd_buddy_page);
+		folio_get(e4b->bd_buddy_folio);
 		folio_get(e4b->bd_bitmap_folio);
 	}
 	while (*n) {
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 2d0aca8dc02e8..0dd6bc69ab611 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -216,7 +216,7 @@ struct ext4_allocation_context {
 #define AC_STATUS_BREAK		3
 
 struct ext4_buddy {
-	struct page *bd_buddy_page;
+	struct folio *bd_buddy_folio;
 	void *bd_buddy;
 	struct folio *bd_bitmap_folio;
 	void *bd_bitmap;
-- 
2.51.0


