Return-Path: <stable+bounces-271806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAhCDajIR2oDfQAAu9opvQ
	(envelope-from <stable+bounces-271806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:35:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81854703767
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:35:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AozwUc5t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271806-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271806-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14A0303C421
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB23C98BE;
	Fri,  3 Jul 2026 14:26:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65A1A6834
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088804; cv=none; b=s3TCjK+wSI+1RO61kSf56PM7pF94pfSENhY+I3s+Fs9muv7WiSMmLYcgHoyxeTvopXazmXmqH8/Iz35R8WOXk9uVwCoyjewYYvge+F+mMtmsgBzxWtbvQ84sab0E2uVNxjSOck4ECEVz68ffpXiXK7zzq5rT/NMvaAdEMBudKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088804; c=relaxed/simple;
	bh=vtixMAGMoDVIvfdpy0X0wDjvA0YYh7hkJ3Sdi8LFW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLUWMiujdMWJslday6SWPzsGdtJrh1FKnU/gBGVwxW3+x/L2HJ60HEBp1CELT/mRsfcpBEhRA6aKXRhicehLuXfZmgB7sJNB1Eyh8qHKppjZmhE4q9eVia4N6AZ+TbAiM9+YZy/mO09WbfOCYZbeW8QnL+o8M7jWa+nYqM5B4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AozwUc5t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F5E1F000E9;
	Fri,  3 Jul 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088802;
	bh=4ObHP8rN+EinSo1gSyEb7mt4Ew7J3YmHLnIRYlCc8oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AozwUc5tIi95ulY15RQV7oEYES/90t5TPS0e7/JhzbwjNeh0fBqMI/69A8shPwMjD
	 kEQ1+ZZsRf6jlzmCCFELdHlbOkK15ykj9wVbJcptZRhTiM+R1lXNQqtSHxqxRRIU3N
	 FEBUG4Pr7YsBQiTtUF3aeyilaf0O1Lhf+yb8T1qsVpCh5lVbjmK0mUXRJglwCVN/AL
	 30hWNirG7EvU6fwSfdi3V8plMLD+FOikwLJSiOhq9LDAeJNwKHLNOXms+ZgHgP9F4o
	 bXmTu8Wi1tTRXMsLAEuBIjSbzxqbqvuBbJpTQTSNGKQfRb/6eS4GZ/de8tUYpxE/L2
	 hBQ4xkmYtIyeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: read COW data with the original inode during atomic write
Date: Fri,  3 Jul 2026 10:26:40 -0400
Message-ID: <20260703142640.55833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070221-snort-vantage-43cb@gregkh>
References: <2026070221-snort-vantage-43cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271806-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:m.lobanov@rosa.ru,m:chao@kernel.org,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rosa.ru:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81854703767

From: Mikhail Lobanov <m.lobanov@rosa.ru>

[ Upstream commit a41075acde0124d2f8a5f563068a5d63e8ffd57b ]

When updating an atomic-write file, f2fs_write_begin() may read the
previously written data back from the COW inode:
prepare_atomic_write_begin() locates the block in the COW inode and sets
use_cow, and the read bio is then built with the COW inode:

	f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode : inode,
			      ...);

and f2fs_grab_read_bio() decides whether to schedule fs-layer decryption
(STEP_DECRYPT) for the bio based on that inode via
fscrypt_inode_uses_fs_layer_crypto().

However, the folio being filled belongs to the original inode
(folio->mapping->host == inode), and the data stored in the COW block was
encrypted (or left as plaintext) using the original inode's context, not
the COW inode's -- see f2fs_encrypt_one_page(), which keys off
fio->page->mapping->host.  fscrypt_decrypt_pagecache_blocks() likewise
operates on folio->mapping->host.

The COW inode is created as a tmpfile in the parent directory and inherits
its encryption policy from there.  With test_dummy_encryption the newly
created COW inode gets the dummy policy and becomes encrypted, while a
pre-existing regular file -- created before the policy applied, e.g.
already present in the on-disk image -- stays unencrypted.  The read
path then sets STEP_DECRYPT based on the encrypted COW inode and calls
fscrypt_decrypt_pagecache_blocks() on a folio whose host (the unencrypted
original inode) has a NULL ->i_crypt_info, dereferencing it:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:fscrypt_decrypt_pagecache_blocks+0xa0/0x310
  Workqueue: f2fs_post_read_wq f2fs_post_read_work
  Call Trace:
   fscrypt_decrypt_bio+0x1eb/0x340
   f2fs_post_read_work+0xba/0x140
   process_one_work+0x91c/0x1a40
   worker_thread+0x677/0xe90
   kthread+0x2bc/0x3a0

The COW inode is only needed to locate the on-disk block, and that block
address is already resolved into @blkaddr by prepare_atomic_write_begin()
via __find_data_block(cow_inode, ...); f2fs_submit_page_read() then reads
from that physical @blkaddr directly, so the inode argument only selects
the post-read crypto context, not which block is fetched.  Reading with
@inode therefore returns the same (latest, not-yet-committed) COW data,
while making both the fs-layer decryption decision and the inline crypto
path use the correct (original inode's) key.

With the COW inode no longer used at the read site, the use_cow flag has no
remaining consumer; drop it from f2fs_write_begin() and
prepare_atomic_write_begin().

Fixes: 591fc34e1f98 ("f2fs: use cow inode data when updating atomic write")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 234444794b5571..62a19ba8b010ff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3559,7 +3559,7 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 			struct folio *folio, loff_t pos, unsigned int len,
-			block_t *blk_addr, bool *node_changed, bool *use_cow)
+			block_t *blk_addr, bool *node_changed)
 {
 	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
@@ -3573,12 +3573,11 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 
 	/* Look for the block in COW inode first */
 	err = __find_data_block(cow_inode, index, blk_addr);
-	if (err) {
+	if (err)
 		return err;
-	} else if (*blk_addr != NULL_ADDR) {
-		*use_cow = true;
+
+	if (*blk_addr != NULL_ADDR)
 		return 0;
-	}
 
 	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
 		goto reserve_block;
@@ -3608,7 +3607,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
-	bool use_cow = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
@@ -3670,7 +3668,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, folio, pos, len,
-					&blkaddr, &need_balance, &use_cow);
+					&blkaddr, &need_balance);
 	else
 		err = prepare_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
@@ -3710,9 +3708,15 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			err = -EFSCORRUPTED;
 			goto put_folio;
 		}
-		err = f2fs_submit_page_read(use_cow ?
-				F2FS_I(inode)->cow_inode : inode,
-				folio, blkaddr, 0, true);
+		/*
+		 * Although the block may be stored in the COW inode, the folio
+		 * belongs to @inode and its data was encrypted (or not) using
+		 * @inode's context (see f2fs_encrypt_one_page()).  Read with
+		 * @inode so the post-read decryption decision matches the
+		 * folio's owner; otherwise an unencrypted @inode whose COW inode
+		 * is encrypted hits a NULL ->i_crypt_info on decryption.
+		 */
+		err = f2fs_submit_page_read(inode, folio, blkaddr, 0, true);
 		if (err)
 			goto put_folio;
 
-- 
2.53.0


