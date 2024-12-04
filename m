Return-Path: <stable+bounces-98499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51889E4225
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70326287349
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338B22F39E;
	Wed,  4 Dec 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKE1gvt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D12206F2B;
	Wed,  4 Dec 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332346; cv=none; b=IYixrxKcrxaTIwJuLY+B0P7OUDulZZLvNH/i7YsHa5+1fW0whQXgFnyaULy7PEv8lGBCRJN4H1PcG2+WzS0aeRoCblmbDkacEqIsjgKl5FLz5g8GRiABfGv8hrNcwG4QztV/tTPAcMiksNsSutsrE8waHWCP7MRZZKdP5M+RCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332346; c=relaxed/simple;
	bh=BDcY9jP3Y82p/ki8rX0LX77R2FO03nOBjVn+X3fyvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlYhtg828+jiroNXpf6iS3HTxqbtZB1bA8wbxyJWehrcUHLgLcD+yvgUpmMPDQrpX9RtIxl2HC9n/oZYzNgpaemugcP1qMeFhlkFMSMr535oXuMvqf6bJPH19WJCmc9yR2yA+/HTX15meAsIr8GON2ZN47kdvTUj59mT1FkXzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKE1gvt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7492FC4CED6;
	Wed,  4 Dec 2024 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332345;
	bh=BDcY9jP3Y82p/ki8rX0LX77R2FO03nOBjVn+X3fyvAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKE1gvt6rZua6Zhrh/2l8Ny9sB9RiSKm2IEZS2gdbm64iSYYrND+TM7ZBZ/JYda5U
	 BJQ14qmluPGbXE9iEHNnBvF3YH8caP36d5OqiOb47yTrtYCr0akbl54E+g7la1eyW0
	 SknSh2SRDhLlWEI/MSkCEAwqYqHQB3H4vs9+GP2JtuavleovFtZV6em7sDVkmsI4YK
	 6zNVx15O99sWChMHlF/dOAVPmLQfJL8DrROYNFXwbD4FPr7yXNiWtcVII8jWWmVGHA
	 pO0mvhl3C6bXiTTGqNOE3ODfc/kDIv/2z5mxeCM5740UXKCHF9oAII06bmeX9JcHCU
	 JdHjr29Pls//w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 12/13] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
Date: Wed,  4 Dec 2024 11:00:37 -0500
Message-ID: <20241204160044.2216380-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index b72ef96f7e33a..6ed4b1b2e7d94 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1331,7 +1331,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
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


