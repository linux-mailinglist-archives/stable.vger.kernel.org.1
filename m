Return-Path: <stable+bounces-219635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN1oLFgJn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:38:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3A198D38
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA0F306A51C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9CC392802;
	Wed, 25 Feb 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQp0fc7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC58286D64
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030032; cv=none; b=a7mstCN9wNMEZGHDkmmx3mEKEJ5vCL3IZX5UApF+gleupxSkESvXfoB1eFF9wzNIx57pF30y9KQqUuX3wBRvLKvIYs9GqTBgJJhgghnIz6Y4WHQppWblloUGv4zVcCe30t3+zlEaEYUSezNJlQnsOdPANfV8IFaPxymywmyek14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030032; c=relaxed/simple;
	bh=DWwhvfOQ4s5087f3KDIgSNpW+dbFRQtW6uUYUkduE4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWjaYFveqOznNWB8TYOGgoO8ouU9jy+e9L3y8MnLsfUctxh/aOippfxflu0ndJSyP09FykTZ3ogEjGWgk/6yCz7TWDC5GEyhvchS576x2jat3KkEPnvfzKyXsqfBCE0wBFN7OYB1WedLBO+2EUlsyCiCGHAIUznyBRYuXQ6oKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQp0fc7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1334AC116D0;
	Wed, 25 Feb 2026 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772030031;
	bh=DWwhvfOQ4s5087f3KDIgSNpW+dbFRQtW6uUYUkduE4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQp0fc7qmVLWkxddQVF5KQZ89638eRZTSuqAnwop6y5pJmzxDhJ24m1EWj7p3uiAL
	 cObUvuHcaUGwtukC1bLq5PiuleO8cgj03dwgiW180XX80P6DX4qftfTfVh21D/dw13
	 NefFNUptu8WYGA9gEQNqFJXklAZsKNbJ6kF64Dl6TPWsShxJkZ3Ylk9UKbWC9/+Cur
	 fUa2b4+RNk6PiuYcT97QIB7QUqbd2dheU8vnsZib3CrT+lIEpJrrilBkN4/iIDtnpr
	 DQMO1EcFfROCNE9mG1BXXE08+usNeYQdECIZdRmIfdyCvWy8aGXuQ3MdnfFGHYainN
	 dk/xCp3o7lmAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjian Sun <sunyongjian1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: fix e4b bitmap inconsistency reports
Date: Wed, 25 Feb 2026 09:33:49 -0500
Message-ID: <20260225143349.471932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022403-jittery-reputably-8b52@gregkh>
References: <2026022403-jittery-reputably-8b52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219635-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: 16C3A198D38
X-Rspamd-Action: no action

From: Yongjian Sun <sunyongjian1@huawei.com>

[ Upstream commit bdc56a9c46b2a99c12313122b9352b619a2e719e ]

A bitmap inconsistency issue was observed during stress tests under
mixed huge-page workloads. Ext4 reported multiple e4b bitmap check
failures like:

ext4_mb_complex_scan_group:2508: group 350, 8179 free clusters as
per group info. But got 8192 blocks

Analysis and experimentation confirmed that the issue is caused by a
race condition between page migration and bitmap modification. Although
this timing window is extremely narrow, it is still hit in practice:

folio_lock                        ext4_mb_load_buddy
__migrate_folio
  check ref count
  folio_mc_copy                     __filemap_get_folio
                                      folio_try_get(folio)
                                  ......
                                  mb_mark_used
                                  ext4_mb_unload_buddy
  __folio_migrate_mapping
    folio_ref_freeze
folio_unlock

The root cause of this issue is that the fast path of load_buddy only
increments the folio's reference count, which is insufficient to prevent
concurrent folio migration. We observed that the folio migration process
acquires the folio lock. Therefore, we can determine whether to take the
fast path in load_buddy by checking the lock status. If the folio is
locked, we opt for the slow path (which acquires the lock) to close this
concurrency window.

Additionally, this change addresses the following issues:

When the DOUBLE_CHECK macro is enabled to inspect bitmap-related
issues, the following error may be triggered:

corruption in group 324 at byte 784(6272): f in copy != ff on
disk/prealloc

Analysis reveals that this is a false positive. There is a specific race
window where the bitmap and the group descriptor become momentarily
inconsistent, leading to this error report:

ext4_mb_load_buddy                   ext4_mb_load_buddy
  __filemap_get_folio(create|lock)
    folio_lock
  ext4_mb_init_cache
    folio_mark_uptodate
                                     __filemap_get_folio(no lock)
                                     ......
                                     mb_mark_used
                                       mb_mark_used_double
  mb_cmp_bitmaps
                                       mb_set_bits(e4b->bd_bitmap)
  folio_unlock

The original logic assumed that since mb_cmp_bitmaps is called when the
bitmap is newly loaded from disk, the folio lock would be sufficient to
prevent concurrent access. However, this overlooks a specific race
condition: if another process attempts to load buddy and finds the folio
is already in an uptodate state, it will immediately begin using it without
holding folio lock.

Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260106090820.836242-1-sunyongjian@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ folio -> page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0fd921ada8973..41aa6c47339a0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1570,16 +1570,17 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	/* we could use find_or_create_page(), but it locks page
 	 * what we'd like to avoid in fast path ... */
 	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
+	if (page == NULL || !PageUptodate(page) || PageLocked(page)) {
+		/*
+		 * PageLocked is employed to detect ongoing page
+		 * migrations, since concurrent migrations can lead to
+		 * bitmap inconsistency. And if we are not uptodate that
+		 * implies somebody just created the page but is yet to
+		 * initialize it. We can drop the page reference and
+		 * try to get the page with lock in both cases to avoid
+		 * concurrency.
+		 */
 		if (page)
-			/*
-			 * drop the page reference and try
-			 * to get the page with lock. If we
-			 * are not uptodate that implies
-			 * somebody just created the page but
-			 * is yet to initialize the same. So
-			 * wait for it to initialize.
-			 */
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
 		if (page) {
@@ -1614,7 +1615,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	poff = block % blocks_per_page;
 
 	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
+	if (page == NULL || !PageUptodate(page) || PageLocked(page)) {
 		if (page)
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
-- 
2.51.0


