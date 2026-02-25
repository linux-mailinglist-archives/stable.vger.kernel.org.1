Return-Path: <stable+bounces-219182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB3tC2FwnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:45:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4A191472
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76BF430D2166
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003112BDC27;
	Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id//OPdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9079CD
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990965; cv=none; b=GGPfgsEHJB3kybZ1hY2Yy4I4YwTWrE76vrchh+33NON6LOIlbt9IaG02jQdB/KZjubyFmStSgvFteAtFaS3QcInVjrThaxaQUyi5aJgXFq2stcwUsOMjSeV9jH9JK7wsH0NMKQY/zzK1p8++qeLnnrGwCDrEWgtasmoQrGdRChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990965; c=relaxed/simple;
	bh=l/0cXONcUvP65EsjOiLJ+OzL+5lCmffqUcL40Wo1+m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+6tnCBysiqps4LvksFcRu1Z3OyNlsYPMJmWf6Cd4vUgJGOCY9jEcmU+Dq8BhxyIPGmcFtHRvinLNY0jC8Bs+Vu0yTJnyWS/+Nw8HQyE40Xd/oLrJD/nJAGTZUVuhwt+8J/Rf0RiWzHQoPtKiMRUl90yqKD22dx91pWSsRP7O5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id//OPdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C59C19421;
	Wed, 25 Feb 2026 03:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771990965;
	bh=l/0cXONcUvP65EsjOiLJ+OzL+5lCmffqUcL40Wo1+m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=id//OPdQ/sajGUBfK6SKyu5MfpzXvrmmevtuW55dJpNsKaRy2SG+6Accg/KD6hK3o
	 d2TUe5Z3q9pvKfD0tGqz5fLCNz2aRhi+R4ovGiYPHK5LoU1JVzps8izvwqaGOgVB5p
	 +sMHZRD08b1fFc/ed0YDi3wt5WrI3y4D3CBCCSSS8R1GS/A0PpkvnJcu8IxOPnU6Dw
	 yxV/2LRh+KHY4Qvc9n2eFsPvvZ4ZHFfJkINF/QFftxko/VmUHIbdgpHLeVqbtdz++f
	 kyAtwTIW1beOjyN4Cl5tGTyyPdDUKSXaWiiZ0H1WogjYfrCfyO00XKOpEQkp4ZNu+X
	 B2KYNA0xwsCQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] ext4: convert bd_bitmap_page to bd_bitmap_folio
Date: Tue, 24 Feb 2026 22:42:40 -0500
Message-ID: <20260225034242.3893844-2-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219182-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3A4A191472
X-Rspamd-Action: no action

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 99b150d84e4939735cfce245e32e3d29312c68ec ]

There is no need to make this a multi-page folio, so leave all the
infrastructure around it in pages.  But since we're locking it, playing
with its refcount and checking whether it's uptodate, it needs to move
to the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20240416172900.244637-2-willy@infradead.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 98 ++++++++++++++++++++++++-----------------------
 fs/ext4/mballoc.h |  2 +-
 2 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2a80c587ec7c9..4e5fbcf29fc29 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1463,9 +1463,10 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	int block, pnum, poff;
 	int blocks_per_page;
 	struct page *page;
+	struct folio *folio;
 
 	e4b->bd_buddy_page = NULL;
-	e4b->bd_bitmap_page = NULL;
+	e4b->bd_bitmap_folio = NULL;
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	/*
@@ -1476,12 +1477,13 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	block = group * 2;
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
-	page = find_or_create_page(inode->i_mapping, pnum, gfp);
-	if (!page)
-		return -ENOMEM;
-	BUG_ON(page->mapping != inode->i_mapping);
-	e4b->bd_bitmap_page = page;
-	e4b->bd_bitmap = page_address(page) + (poff * sb->s_blocksize);
+	folio = __filemap_get_folio(inode->i_mapping, pnum,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	BUG_ON(folio->mapping != inode->i_mapping);
+	e4b->bd_bitmap_folio = folio;
+	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
 	if (blocks_per_page >= 2) {
 		/* buddy and bitmap are on the same page */
@@ -1499,9 +1501,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 
 static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
 {
-	if (e4b->bd_bitmap_page) {
-		unlock_page(e4b->bd_bitmap_page);
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio) {
+		folio_unlock(e4b->bd_bitmap_folio);
+		folio_put(e4b->bd_bitmap_folio);
 	}
 	if (e4b->bd_buddy_page) {
 		unlock_page(e4b->bd_buddy_page);
@@ -1521,6 +1523,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	struct ext4_group_info *this_grp;
 	struct ext4_buddy e4b;
 	struct page *page;
+	struct folio *folio;
 	int ret = 0;
 
 	might_sleep();
@@ -1547,11 +1550,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 
-	page = e4b.bd_bitmap_page;
-	ret = ext4_mb_init_cache(page, NULL, gfp);
+	folio = e4b.bd_bitmap_folio;
+	ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
 	if (ret)
 		goto err;
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
@@ -1593,6 +1596,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	int pnum;
 	int poff;
 	struct page *page;
+	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1611,7 +1615,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_sb = sb;
 	e4b->bd_group = group;
 	e4b->bd_buddy_page = NULL;
-	e4b->bd_bitmap_page = NULL;
+	e4b->bd_bitmap_folio = NULL;
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 		/*
@@ -1632,53 +1636,53 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
 
-	/* we could use find_or_create_page(), but it locks page
-	 * what we'd like to avoid in fast path ... */
-	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
-		if (page)
+	/* Avoid locking the folio in the fast path ... */
+	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		if (!IS_ERR(folio))
 			/*
-			 * drop the page reference and try
-			 * to get the page with lock. If we
+			 * drop the folio reference and try
+			 * to get the folio with lock. If we
 			 * are not uptodate that implies
-			 * somebody just created the page but
-			 * is yet to initialize the same. So
+			 * somebody just created the folio but
+			 * is yet to initialize it. So
 			 * wait for it to initialize.
 			 */
-			put_page(page);
-		page = find_or_create_page(inode->i_mapping, pnum, gfp);
-		if (page) {
-			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
-	"ext4: bitmap's paging->mapping != inode->i_mapping\n")) {
+			folio_put(folio);
+		folio = __filemap_get_folio(inode->i_mapping, pnum,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+		if (!IS_ERR(folio)) {
+			if (WARN_RATELIMIT(folio->mapping != inode->i_mapping,
+	"ext4: bitmap's mapping != inode->i_mapping\n")) {
 				/* should never happen */
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = -EINVAL;
 				goto err;
 			}
-			if (!PageUptodate(page)) {
-				ret = ext4_mb_init_cache(page, NULL, gfp);
+			if (!folio_test_uptodate(folio)) {
+				ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
 				if (ret) {
-					unlock_page(page);
+					folio_unlock(folio);
 					goto err;
 				}
-				mb_cmp_bitmaps(e4b, page_address(page) +
+				mb_cmp_bitmaps(e4b, folio_address(folio) +
 					       (poff * sb->s_blocksize));
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
 
 	/* Pages marked accessed already */
-	e4b->bd_bitmap_page = page;
-	e4b->bd_bitmap = page_address(page) + (poff * sb->s_blocksize);
+	e4b->bd_bitmap_folio = folio;
+	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
 	block++;
 	pnum = block / blocks_per_page;
@@ -1726,8 +1730,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 err:
 	if (page)
 		put_page(page);
-	if (e4b->bd_bitmap_page)
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio)
+		folio_put(e4b->bd_bitmap_folio);
 
 	e4b->bd_buddy = NULL;
 	e4b->bd_bitmap = NULL;
@@ -1742,8 +1746,8 @@ static int ext4_mb_load_buddy(struct super_block *sb, ext4_group_t group,
 
 static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 {
-	if (e4b->bd_bitmap_page)
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio)
+		folio_put(e4b->bd_bitmap_folio);
 	if (e4b->bd_buddy_page)
 		put_page(e4b->bd_buddy_page);
 }
@@ -2169,7 +2173,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * double allocate blocks. The reference is dropped
 	 * in ext4_mb_release_context
 	 */
-	ac->ac_bitmap_page = e4b->bd_bitmap_page;
+	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
 	get_page(ac->ac_bitmap_page);
 	ac->ac_buddy_page = e4b->bd_buddy_page;
 	get_page(ac->ac_buddy_page);
@@ -3904,7 +3908,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
 		put_page(e4b.bd_buddy_page);
-		put_page(e4b.bd_bitmap_page);
+		folio_put(e4b.bd_bitmap_folio);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
 	ext4_mb_unload_buddy(&e4b);
@@ -6350,7 +6354,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	struct rb_node *parent = NULL, *new_node;
 
 	BUG_ON(!ext4_handle_valid(handle));
-	BUG_ON(e4b->bd_bitmap_page == NULL);
+	BUG_ON(e4b->bd_bitmap_folio == NULL);
 	BUG_ON(e4b->bd_buddy_page == NULL);
 
 	new_node = &new_entry->efd_node;
@@ -6363,7 +6367,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
 		get_page(e4b->bd_buddy_page);
-		get_page(e4b->bd_bitmap_page);
+		folio_get(e4b->bd_bitmap_folio);
 	}
 	while (*n) {
 		parent = *n;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index dd16050022f52..2d0aca8dc02e8 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -218,7 +218,7 @@ struct ext4_allocation_context {
 struct ext4_buddy {
 	struct page *bd_buddy_page;
 	void *bd_buddy;
-	struct page *bd_bitmap_page;
+	struct folio *bd_bitmap_folio;
 	void *bd_bitmap;
 	struct ext4_group_info *bd_info;
 	struct super_block *bd_sb;
-- 
2.51.0


