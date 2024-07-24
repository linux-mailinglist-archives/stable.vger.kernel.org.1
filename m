Return-Path: <stable+bounces-61312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31B93B5F8
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1582855C2
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8E16A956;
	Wed, 24 Jul 2024 17:28:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031115FA7E;
	Wed, 24 Jul 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842129; cv=none; b=AhR0kdY3wD+kjFV2gr5/s0EG494KwoBxJ+bLV8zPtUkafPXNktac2Cli2gIWsfugq1nHJ1YlYUvWOpdvkxyTcSJ0jQ2Y32lxDNpHlJ387QHS7qrUDcK17f++YilD3ZSMCa69Lxb4sgGbkl8M28Bowh1SA5PrqG1aAnI3ZzzS0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842129; c=relaxed/simple;
	bh=hzvzimYwTkKOfU32wPbfz51QUdMbS0TMQSJhLlV3Hjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7uOlr5dPGpnRomkDWwMAUHqGksWp7qSe7IcAJExuqd/rDBazHkpjaVPQFypwhG0YwU8JggCW6RMLNNrt7265lDSR2uUEzVrrw0NntuTOnxeas33mEqaPwfiQe4aHRyKneR/JjB0ik+0nNjzD+OuuACLxkfunJ3V49YnKupwOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Jul
 2024 20:28:45 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 24 Jul
 2024 20:28:44 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH] f2fs: fix several potential integer overflows in file offsets
Date: Wed, 24 Jul 2024 10:28:38 -0700
Message-ID: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

When dealing with large extents and calculating file offsets by
summing up according extent offsets and lengths of unsigned int type,
one may encounter possible integer overflow if the values are
big enough.

Prevent this from happening by expanding one of the addends to
(pgoff_t) type.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: d323d005ac4a ("f2fs: support file defragment")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
As the patch covers several code fragments, one singular Fixes: tag
is hard to pinpoint. Hopefully, it's not critical at this stage.

 fs/f2fs/extent_cache.c | 4 ++--
 fs/f2fs/file.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index fd1fc06359ee..62ac440d9416 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -366,7 +366,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 static void __drop_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	if (fofs < et->largest.fofs + et->largest.len &&
+	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
 			fofs + len > et->largest.fofs) {
 		et->largest.len = 0;
 		et->largest_updated = true;
@@ -456,7 +456,7 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 
 	if (type == EX_READ &&
 			et->largest.fofs <= pgofs &&
-			et->largest.fofs + et->largest.len > pgofs) {
+			(pgoff_t)et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
 		stat_inc_largest_node_hit(sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..c598cfe5e0ed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2710,7 +2710,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * block addresses are continuous.
 	 */
 	if (f2fs_lookup_read_extent_cache(inode, pg_start, &ei)) {
-		if (ei.fofs + ei.len >= pg_end)
+		if ((pgoff_t)ei.fofs + ei.len >= pg_end)
 			goto out;
 	}
 

