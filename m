Return-Path: <stable+bounces-98511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FF9E4241
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B5F162858
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5E2080A4;
	Wed,  4 Dec 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9YaH1mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F52080A7;
	Wed,  4 Dec 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332374; cv=none; b=BFcYrsLE64nlvNhJYh+nMkyn0CaQKZqfnaw17D8SALrlEnt9RUBOqs5gR2wqBVuc2zN+0Z/Gt2SYpQ5dM+Vzs0KmzSZlL7ZYOdeHgWVWTZXYc3CXQrt5DAZx61KjFm0AK3jUV/vpaSsY6dXuuGY0FBgkWUPvRdug4G7dyFGIaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332374; c=relaxed/simple;
	bh=2OlqHmELl46jB5lrqzFLdLovDDf5gGuie87yirSOO2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD4qVoePAgNnzFOIlES3roQVx9ZDIVY8Xfio5WvZOZiVzAx6YmH4Td8U2VEdyRrE3XPhVJlzL2aHDCJHVs/2ZWpCYubU9AUbF7CiLUJkfUMPTe8Uf9TnZcnkyTeHaC1GrFonBpXdpllS7X6nGuJyxNXfH3PkgnzLGneKqbhk8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9YaH1mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3AFC4CECD;
	Wed,  4 Dec 2024 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332374;
	bh=2OlqHmELl46jB5lrqzFLdLovDDf5gGuie87yirSOO2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9YaH1mPZx2k4ofjQjpFro7Vp/YKFcvlBdX2mq/JcBOkzul7EnjXDPFSAGuDYXYwv
	 NCuko20qN1+GYeAtZfPKJ/wgLlUdGaqln9UrJYtnO6OngrNULgLJ/qDuYcNNbxyO6w
	 y0tN90LM+y0g/9RBkmAS+HfHmaOF2ariymnCjZnWKCe7cI6d9Uo5UZh1UCvSnbHb3O
	 xRc63l4c5d7CjMoAaxnYY/fMAErPsfftF/hEWHQp9qN9WXU/BVLSJAirfsdNmYm98L
	 JKStrKz4jgiLsOZ7Z3aBSZ4ORkykHx4Nd615DcV0e5i8ar1cXI7QhQw4Wv5sofwvxH
	 mJKgqs8nrPWQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 11/12] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
Date: Wed,  4 Dec 2024 11:01:08 -0500
Message-ID: <20241204160115.2216718-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 81520c684ca67aea6a589461a3caebb9b11dcc90 ]

If fs corruption occurs in f2fs_new_node_page(), let's print
more information about corrupted metadata into kernel log.

Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
NULL_ADDR which means nat bitmap and nat entry is inconsistent.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c765bda3beaac..a555201d81584 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1321,7 +1321,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		err = -EFSCORRUPTED;
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+		f2fs_warn_ratelimited(sbi,
+			"f2fs_new_node_page: inconsistent nat entry, "
+			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
+			new_ni.ino, new_ni.nid, new_ni.blk_addr,
+			new_ni.version, new_ni.flag);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
 		goto fail;
 	}
 #endif
-- 
2.43.0


