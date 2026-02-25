Return-Path: <stable+bounces-219184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENwHILpvnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF16191427
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C2343040F97
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F52BD00C;
	Wed, 25 Feb 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5bESUWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AA79CD
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990967; cv=none; b=ft5A4HEr5j7KUaRxMjSTiQIGWFt7hEpCGteguxCEV5UHPm4KbVVNV2tEhgFOVogl5CUFxOUpVs4tkMrpL454RznBtwa+dQG/p5SfmAyILz6rKXAA4bkAN9c1ynPoR4+6TXD8rqqoVAdE2l7jB8Eq0yR8A10gAG47VOKe1F8ACio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990967; c=relaxed/simple;
	bh=NSpTvldN8MlEoPm2nZqgwoCzFucZSlU0nYB5mPYtWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ7vD0RmLJF4+55yCUJg0p4e+NivyjKSM8VtVdUXmnk0CmTDhBZb/jr+KkeYhHn3J/qxvPDI4WxayfeniaKh28oDcC3wnJTNjjwZH71MXh01opCcgBis9aJ0miOl3fwZzbOeIfFzz/tEozghFABT4IEKVy0ONP/7kw5v+ovubKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5bESUWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A327CC116D0;
	Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771990967;
	bh=NSpTvldN8MlEoPm2nZqgwoCzFucZSlU0nYB5mPYtWOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5bESUWocrsqoX+FRizc3xK4mVpDhW85iwS6Erm46tJFSEyflFMNAK4ikwQ9AovCK
	 vg+hc7l6i7+w8kYh5fxzpIj/ksJ6TpcnVmXUivrQ9BjqiY59vZK2mwCGR7JXuzFhVd
	 6zNwx5jtU753SIa4avwbUQkMxCKMjKC0gaKLxpxP5nmFG2O/AANNt+iUENOQJ1VtET
	 vW5PUM1IZ99Ewbjy6XJGQ06XghJUqsrLCuSMI6X7kGfzYCAhchI4s0Lh9HRJFgyk6R
	 axszEh4dGKrS2r9TLN4LmbZxtPC6bfXUcZTTOyOyHXYskO1IQelrBg3/ntruRbA18z
	 16+vnapT4OX8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjian Sun <sunyongjian1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] ext4: fix e4b bitmap inconsistency reports
Date: Tue, 24 Feb 2026 22:42:42 -0500
Message-ID: <20260225034242.3893844-4-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219184-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,huawei.com:email,suse.cz:email]
X-Rspamd-Queue-Id: EEF16191427
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e0a9ded2d009f..62e758dd582c5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1636,16 +1636,17 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	/* Avoid locking the folio in the fast path ... */
 	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
+		/*
+		 * folio_test_locked is employed to detect ongoing folio
+		 * migrations, since concurrent migrations can lead to
+		 * bitmap inconsistency. And if we are not uptodate that
+		 * implies somebody just created the folio but is yet to
+		 * initialize it. We can drop the folio reference and
+		 * try to get the folio with lock in both cases to avoid
+		 * concurrency.
+		 */
 		if (!IS_ERR(folio))
-			/*
-			 * drop the folio reference and try
-			 * to get the folio with lock. If we
-			 * are not uptodate that implies
-			 * somebody just created the folio but
-			 * is yet to initialize it. So
-			 * wait for it to initialize.
-			 */
 			folio_put(folio);
 		folio = __filemap_get_folio(inode->i_mapping, pnum,
 				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
@@ -1687,7 +1688,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	poff = block % blocks_per_page;
 
 	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
 		if (!IS_ERR(folio))
 			folio_put(folio);
 		folio = __filemap_get_folio(inode->i_mapping, pnum,
-- 
2.51.0


