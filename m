Return-Path: <stable+bounces-223406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lswsKryUq2k5egEAu9opvQ
	(envelope-from <stable+bounces-223406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:00:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DE229B55
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55405303CD35
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 03:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCF2E11BC;
	Sat,  7 Mar 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="thDzOELM"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473068287E;
	Sat,  7 Mar 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852405; cv=none; b=OkGhWr+h24mPBfTNBtO2SHE6GSpBCjbEPPML0WV8OjTw28rnboWLCEycilHDSDfNtoqZzRLRV/8VoiBVWf/RsjEabbRoxRXaf1uj2I9q2T6L79983Hba1afEbnYCYS5REgTOlX/tQBvisr+bffsSZ405SAVunn8fl7VLqTKop8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852405; c=relaxed/simple;
	bh=fSeQF9QFhwUlzZ5CwrkNdIyaSa/TQ+ErlSkbiAiE+P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i4xEIJatmBIPWvqXH5IwF0HsgaU5nZZ+dSxe5Mtv3uEPZq02IDMdpr9Id32EE4CG8DyGTZJgo0SIY7xI/AJoNQmL0JbQF1UMa98bpT7lbsF12baywxnbDwX1j86WQ3TPpqtdxJMRHKPR94LBB9xcvambaAdp6aK3xylexAqdeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=thDzOELM; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=thDzOELMQz89qgKQyfw3CkqW7bRk7hEWgjeu6xQZQW+5KalsR5yh/qSoSY7Itz601U6Q9zvxow20w
	 NstnLCsQqzYcS8g2JuEhVydhdiB8b1La3ZeCGYg9xWIJ0ef7wVmrReGglbl2Gnh7XQdWXvYmN1yW+5
	 oV6nRSFM5Brj16Jo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-139-kernel-team (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef569ab949c39f-023ce;
	Sat, 07 Mar 2026 10:59:49 +0800 (CST)
X-RM-TRANSID:2ef569ab949c39f-023ce
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	Ye Bin <yebin10@huawei.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
Date: Sat,  7 Mar 2026 10:59:39 +0800
Message-Id: <20260307025939.1170999-1-lanbincn@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 548DE229B55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223406-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,huawei.com,139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.049];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,139.com:mid,139.com:email]
X-Rspamd-Action: no action

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit b7d0a97b28083084ebdd8e5c6bccd12e6ec18faa ]

There's issue as follows when concurrently installing the f2fs.ko
module and mounting the f2fs file system:
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
RIP: 0010:__bio_alloc+0x2fb/0x6c0 [f2fs]
Call Trace:
 <TASK>
 f2fs_submit_page_bio+0x126/0x8b0 [f2fs]
 __get_meta_page+0x1d4/0x920 [f2fs]
 get_checkpoint_version.constprop.0+0x2b/0x3c0 [f2fs]
 validate_checkpoint+0xac/0x290 [f2fs]
 f2fs_get_valid_checkpoint+0x207/0x950 [f2fs]
 f2fs_fill_super+0x1007/0x39b0 [f2fs]
 mount_bdev+0x183/0x250
 legacy_get_tree+0xf4/0x1e0
 vfs_get_tree+0x88/0x340
 do_new_mount+0x283/0x5e0
 path_mount+0x2b2/0x15b0
 __x64_sys_mount+0x1fe/0x270
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Above issue happens as the biset of the f2fs file system is not
initialized before register "f2fs_fs_type".
To address above issue just register "f2fs_fs_type" at the last in
init_f2fs_fs(). Ensure that all f2fs file system resources are
initialized.

Fixes: f543805fcd60 ("f2fs: introduce private bioset")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Minor context conflict resolved. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/f2fs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6f6368400ee4..08fe8fa95924 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4634,9 +4634,6 @@ static int __init init_f2fs_fs(void)
 	err = register_shrinker(&f2fs_shrinker_info);
 	if (err)
 		goto free_sysfs;
-	err = register_filesystem(&f2fs_fs_type);
-	if (err)
-		goto free_shrinker;
 	f2fs_create_root_stats();
 	err = f2fs_init_post_read_processing();
 	if (err)
@@ -4660,6 +4657,7 @@ static int __init init_f2fs_fs(void)
 	if (err)
 		goto free_compress_cache;
 	err = f2fs_init_xattr_cache();
+	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_casefold_cache;
 	return 0;
@@ -4679,8 +4677,6 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 free_root_stats:
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
-free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_sysfs:
 	f2fs_exit_sysfs();
@@ -4704,6 +4700,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	unregister_filesystem(&f2fs_fs_type);
 	f2fs_destroy_xattr_cache();
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
@@ -4713,7 +4710,6 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_iostat_processing();
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
-- 
2.43.0



