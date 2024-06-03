Return-Path: <stable+bounces-47840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB78D797A
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 03:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F6A1C20B76
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 01:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5410F1;
	Mon,  3 Jun 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8I6psrO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C715C3;
	Mon,  3 Jun 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376872; cv=none; b=IGedzKrTmRYIvd7m4XxPWKlOdmmqbMytkLKp2yd6K/e1W25nYKZbZ5mKI1sBMKKZ4F3crWLcnNaOIrzVB8FSn1g3bbsYewaMYLYzDLOc4j3rzBb2E5/P32PASbb2/dcwhP9tC2SqTyK64uA7DJOqPlKzbbMndTXpC77z584r4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376872; c=relaxed/simple;
	bh=GyS3Y18rQu9OR8fVI2mcAQN7lotZDqwO7TwKorRv4EU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbbksNBeSvjra6wOIU2xygXGpYeQIvZQeITSDHzgLFX5F1YBbcXPpwo3M65f98i+x18cT/6nAMDkVVlh9qvMwEE23v82ecTtxmkglftwsupdG+PAVs6f951A/+eCBDknC+5H6s0G64fygvIVQYMjUkmrXYYDiJNYUPLiaJswinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8I6psrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA742C2BBFC;
	Mon,  3 Jun 2024 01:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717376871;
	bh=GyS3Y18rQu9OR8fVI2mcAQN7lotZDqwO7TwKorRv4EU=;
	h=From:To:Cc:Subject:Date:From;
	b=D8I6psrOyyBzeNkPVfedoZlzta/z5THqXNORMTgZ5A0RQI/v+TJOqRqmH4D7+/PUj
	 gHTflezQyoMqWeED145AQQ3KUlN3HipnoZnclRTN8m2aodbbtowkSf7PoWHuoUy7UO
	 L1lLnFlyxMedO0CZhiH6sqPRMouCrLxpJ5tnpgeYtp8pelFoNC9jCCtMgllMvemqPI
	 FWIMtR4GWWlz8i1M2OQ/GbhOkyb9xO3xpG3qowJE88M+jv/CiAasmw1xSH6ueqTuTz
	 gRHkq4SxsKSKuvle9yl8+4TCYQpgBYI3vQ+QYC8lHDhp+CtM/ToFNNxniYIx06zlLV
	 avCdw2mc20OHA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix return value of f2fs_convert_inline_inode()
Date: Mon,  3 Jun 2024 09:07:45 +0800
Message-Id: <20240603010745.2246488-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If device is readonly, make f2fs_convert_inline_inode()
return EROFS instead of zero, otherwise it may trigger
panic during writeback of inline inode's dirty page as
below:

 f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2888
 f2fs_write_cache_pages fs/f2fs/data.c:3187 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3342 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3369
 do_writepages+0x359/0x870 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
 f2fs_do_sync_file+0x68a/0x1ae0 fs/f2fs/file.c:276
 generic_write_sync include/linux/fs.h:2806 [inline]
 f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4977
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cc: stable@vger.kernel.org
Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0203c3baabb6..1fba5728be70 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -221,8 +221,10 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	struct page *ipage, *page;
 	int err = 0;
 
-	if (!f2fs_has_inline_data(inode) ||
-			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
+	if (f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (!f2fs_has_inline_data(inode))
 		return 0;
 
 	err = f2fs_dquot_initialize(inode);
-- 
2.40.1


