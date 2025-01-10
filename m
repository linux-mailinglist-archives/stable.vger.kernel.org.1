Return-Path: <stable+bounces-108189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6652A09003
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C7A3A5053
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D32063C7;
	Fri, 10 Jan 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="viNi27V6"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2919ABDE
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510954; cv=none; b=h8fgFONzeO9yTFiF4PpzBvmr5UtknCQUSg0j81ou7PxeJK+ppkokHo03RFlNMkqHdDslythJwrQ7p+Vx+z4iVe2oarByXwlCCO13Py0M6gJBlhoj9NnAsfXij32JlkzznkeOrRqG+sb/2WnWUACGzGIo061AZM5KCJDklRsTdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510954; c=relaxed/simple;
	bh=MHfMU70Rg9/5ZTGRnjnuw0ky7DsSrip4ENXLWIMsiho=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=a0J6+v7qUfnUQD7Imbxa2fKzb39eiv09+j8JRt5VjxJJUCDaoZo6jIXytAt8Ot2f2r/QwvJXfL8Zzn07CtUjuTrxYfmzDYkO/fj97K+SjsEJMLecxYW9uq+0hySeaJY3rdyw8VJTtivIvHr89bDe+C+CkzncdLJvcPSP7Fwgy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=viNi27V6; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736510942; bh=3D+GUvmETDgkwnAu4b/P6qTxueDsQ6uEtjCE/fU39H0=;
	h=From:To:Cc:Subject:Date;
	b=viNi27V6nNboJsm9JR18o/8XZA0zk0xWvwib1SGrm0z69bCcGUHBUcQqrSN79hCu7
	 xXf8km3NqGBuqD+EMvUGoQ2nXxNMJhxXBxNf05Zl31wGDOnPf4lNGpIhvch4iJdAiI
	 4jTaOpUMSRen29pf2t6uTRJpxEzNZG4U/+w3vc10=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.133])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 231202A2; Fri, 10 Jan 2025 20:08:49 +0800
X-QQ-mid: xmsmtpt1736510929t52vjxeh7
Message-ID: <tencent_870C520322ED6ECDC9078DE499753B0E1506@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeU0a+DHu6hU1OlRJTx4yZQpLPs2CV6X9/SNJ5mtdYBkjm/1rJKx
	 J/jb0giwS52iEouP3WwCUpQ74dvxh2DhqsS2iKlDAKuFdN5wnjbKI00qU4j9O/nvxu6oQtYLzdR0
	 zFJgIdJYPNUI7zrlcVGDBZTP7U8D1mol1wnxaixtxquQFOEKXHvHIIlFXWa9GyF6I5VOCSSGMSU6
	 OY87SYHBFcZVi63eJwnFMFOoMTzeFQjj4LkbFkoP/2//ZeyIE0H/ujMp7yuUjN9CFHJexeskfoq3
	 qtdD+0eivfE2FxSg2u+/EBBIUOvGVhC+ysnYADfZxRgnq2BcSv8oqbns1ZdKjcn9rFnzJ7xJ74JX
	 U3LY51zPCWx4ofK65gOogN3racccAszpvIpkYDaaj4FFu9PmAbN8VYHAy9Ejl9Zz4TQYOhvgL+LI
	 xKULu0FIaac2SjB/Im7WGnElXrge1Bh9G7laxiyNp2X95sAyPyXW0XCyvne8Zme34HfmqpICjZ7f
	 NwVyCvLlbRaw0pIJwMz96o4HGN8c5qPM2dbDHB9wLBbKrIgW94bEuio637nWjtNqvtxlZfyRR3ZZ
	 w5vXb8sgkw2rPyrGMzAofHSyvXSGSBWDav8BbLLq9MRd2l5DYIPpXm2PLyi6imGSdJiR5zWLGF2l
	 kdizTpfoS5THEuqLIdwlvHN/kcUlkpGuM+haOEmbQstp8LzlCBoyEHCNKXm0Wf/Ghz0VvL/mk7N/
	 LPQCcrYCsKBhm8IBZoah52i1NVQSBr/AObvlaZYaR6MqJNbvOnYkYNg9C+xgtAG4J5PbzQg7e0Sy
	 ky51M934X4FjFxw+eMPei+2ChBPsxlf56C/U1ENuHR8Bb+TQkYdxu5wI0fwQHLGENuCxuBqwi1Ji
	 ZhpMy/dFoRkEmgdiwkqQ2S6jrt4OMhaz7pn9TlXyr3UENFnYDwdLqRiubJnLmIdB1+mcH83JXmVy
	 dXfCq7PXpETWSt2kRQn/kfAxjVqqf242orQGF9f3SSiuJT2QUGbR4gN5SDkD2h4cFR+QeKE49TSM
	 EW4CdmSU5ngrQSYU44oNuz6SHAR8o=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: lanbincn@qq.com
To: stable@vger.kernel.org,
	yebin10@huawei.com
Cc: lanbincn@qq.com,
	chao@kernel.org
Subject: [PATCH 6.6.y] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
Date: Fri, 10 Jan 2025 20:08:48 +0800
X-OQ-MSGID: <20250110120848.4779-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 fs/f2fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b72fa103b963..aa0e7cc2489a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4931,9 +4931,6 @@ static int __init init_f2fs_fs(void)
 	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
 	if (err)
 		goto free_sysfs;
-	err = register_filesystem(&f2fs_fs_type);
-	if (err)
-		goto free_shrinker;
 	f2fs_create_root_stats();
 	err = f2fs_init_post_read_processing();
 	if (err)
@@ -4956,7 +4953,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_casefold_cache();
 	if (err)
 		goto free_compress_cache;
+	err = register_filesystem(&f2fs_fs_type);
+	if (err)
+		goto free_casefold_cache;
 	return 0;
+free_casefold_cache:
+	f2fs_destroy_casefold_cache();
 free_compress_cache:
 	f2fs_destroy_compress_cache();
 free_compress_mempool:
@@ -4971,8 +4973,6 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 free_root_stats:
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
-free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_sysfs:
 	f2fs_exit_sysfs();
@@ -4996,6 +4996,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	unregister_filesystem(&f2fs_fs_type);
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
@@ -5004,7 +5005,6 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_iostat_processing();
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
-- 
2.43.0


