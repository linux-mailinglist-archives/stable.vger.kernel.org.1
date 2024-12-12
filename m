Return-Path: <stable+bounces-101324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A799EEBD4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3421670BA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78320969B;
	Thu, 12 Dec 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4DVAAbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE013792B;
	Thu, 12 Dec 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017160; cv=none; b=mSsVP7xqLno0anDNrbDQ4xJ/PA/T65pzxtyguFLz1lguwehrEmUNueOZMpz4q1YgRlJX1wgE9XJjCYJnKa7ih/s76VOrkwwylmmURyJcAcJIAJIQvJo6M8yvysD2wXYHG/FkyxczWNPvylH7MnbCdLe55ovpekBSePx0s7+EwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017160; c=relaxed/simple;
	bh=2QJbjF+6ZdLkOgShIGvqqtzeTVZQHE8mTj1PnYA4bxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha3JAmjqCCzA8GaqsNjSY6pgN4gkE/alfOf2Lxqak6ap85cj1Ej//YLpfhezNZAr2C5Rb6w9L8NdK+VTyyGGoZSdy9XRqze4cKBKrP92yI9FXH4Ts2bhEHA748m8lAZmrrN+d9qF1hgcO7qKMYquvxXZt6G+/vZDNNrI6nzLLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4DVAAbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129DFC4CECE;
	Thu, 12 Dec 2024 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017160;
	bh=2QJbjF+6ZdLkOgShIGvqqtzeTVZQHE8mTj1PnYA4bxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4DVAAbRybSQAErZKLE+rhKn9zdoz1p9/D3E9a5FYxtMcogHHT60iMGCFgK4Ui4Sx
	 hIZXDQExIrcDCYo6Nz7MmBjF+ZnuTYWLnm2SzlAKytUebrpDrgj9AqIfc4K1XFX/cV
	 O/+Fm8I2yV/QariBwm+vFI/axxENs+vlZEWFDRh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 400/466] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
Date: Thu, 12 Dec 2024 15:59:29 +0100
Message-ID: <20241212144322.561872873@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index af36c6d6542b8..4d7b9fd6ef31a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1341,7 +1341,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
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




