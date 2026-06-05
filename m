Return-Path: <stable+bounces-260676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e0F9JTSpImrBbgEAu9opvQ
	(envelope-from <stable+bounces-260676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:47:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EF6477B4
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rosa.ru header.s=mail header.b=knUqC+WD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260676-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260676-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rosa.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB38B3016D1A
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AB3F822D;
	Fri,  5 Jun 2026 10:44:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB33466B72;
	Fri,  5 Jun 2026 10:43:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656246; cv=none; b=OBtLaVK3kaJo5j+7QEMrch4/KPEzjp0U4ZT4pCw8bWtb46dX0x76SKJoMQlm1bvkCihku1wsPhwHIsa+EUb2Zcw/TpzqbLz3drKVzQ2KL4cmKxoowL4NCustmajB1ndgvrvlCcrz7fuECmQlqAidsKK3t66fOmv6iA5iQHaoImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656246; c=relaxed/simple;
	bh=LkYqiCDqco6mevM8zai4datk6nmQUALOCQEH0MFK+NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6cK4VhiLFbF45An6WEABsbBnfqcH9b0MjDyBwiPa5AXEDrH7yzo4s3MDK0kehvb81Rwu6tegvx1MMBa/CcGMoTEetalC4kr1lGHdS/t3/F5WNt9gQ+K7CJliWPu6kZDenTZI8/3U0JuKDaNSIrS+sqJSsbbYOQbjxydKFQtbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=knUqC+WD; arc=none smtp.client-ip=178.154.239.91
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id C1261845BA;
	Fri, 05 Jun 2026 13:38:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c18:0:640:5600:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C1E9F804C0;
	Fri, 05 Jun 2026 13:38:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZcffmqLe7a60-kaRNz9XR;
	Fri, 05 Jun 2026 13:38:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1780655918; bh=roqDwFCKSOfqoEvMH3HcV0q1plvbGQsfEEkLVszHKiA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=knUqC+WDUAgnqxDKtEh2dL3DL5dQWXYQLusjUQPo7MUozKS5ebwl+3MFZW/HGzuUp
	 mM+9j+8wjSbropEF3yhxkZ6LbDLvPa1kBwQhOa82kf0UcoCI+z3A33aL1bQ42RAUe1
	 m6Ona2oyCubeeWta9gejEwsVQTeY9p9AcgP0bT7U=
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>
Cc: daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] f2fs: read COW data with the original inode during atomic write
Date: Fri,  5 Jun 2026 13:38:34 +0300
Message-Id: <20260605103834.14894-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rosa.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rosa.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260676-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jaegeuk@kernel.org,m:chao@kernel.org,m:daehojeong@google.com,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m.lobanov@rosa.ru,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m.lobanov@rosa.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[rosa.ru:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,rosa.ru:mid,rosa.ru:dkim,rosa.ru:from_mime,rosa.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF9EF6477B4

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
address is already resolved into @blkaddr; the data's crypto state belongs
to the original inode.  Read with the original inode so the post-read
decryption decision matches the folio's owner.  This also makes the inline
crypto path use the correct (original inode's) key.

Fixes: 591fc34e1f98 ("f2fs: use cow inode data when updating atomic write")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
 fs/f2fs/data.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cf05014fa5e3..8f6c22537e9f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3961,8 +3961,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 			err = -EFSCORRUPTED;
 			goto put_folio;
 		}
-		f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode :
-						inode,
+		/*
+		 * Although the block is stored in the COW inode, the folio
+		 * belongs to @inode and its data was encrypted (or left as
+		 * plaintext) using @inode's context, not the COW inode's; see
+		 * f2fs_encrypt_one_page(), which keys off fio->page->mapping->
+		 * host.  fscrypt_decrypt_pagecache_blocks() likewise operates
+		 * on folio->mapping->host.  Read with @inode so the post-read
+		 * decryption decision matches the folio's owner; otherwise an
+		 * unencrypted @inode whose COW inode is encrypted would hit a
+		 * NULL ->i_crypt_info during decryption.
+		 */
+		f2fs_submit_page_read(inode,
 				      NULL, /* can't write to fsverity files */
 				      folio, blkaddr, 0, true);
 
-- 
2.39.5 (Apple Git-154)


