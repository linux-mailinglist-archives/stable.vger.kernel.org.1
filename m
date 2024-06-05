Return-Path: <stable+bounces-47995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B198FCAE2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C531C2165A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE221193096;
	Wed,  5 Jun 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgPBKgiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A877193090;
	Wed,  5 Jun 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588171; cv=none; b=cnc8Q9wRYu32DQsRK92f3ahJ3IfrliK9d+CGONbEIvJB7ZJi/bDd7dMLO3FAGMt+X6HPLOfbnFv/n9+pWFVoNttvm0q0e1r6sHrkl8FHR4/4XrHdXCIsy9yMuC9f6Rowal4W9VmD9FoBFKJKKfwar1xl2iVbfeWb3NdBWi+/tFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588171; c=relaxed/simple;
	bh=uPCGWMeOdnY4K7O2ka/QvfwHXB9VtLOgHdRbGb7d3jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCBrtYk0ofjfhu+2LNcup8RdDxdT7D9et9Zh7ClRMY3SKB72BNaZLyNTAR2tz+pKgQlDpEsfEBeuEmnprYlOUBkph7dHT/J6YEKVIcNCKX6RetbRk6HLSJJ5ASJtEvptuO7bpgBAp4FbZbpWWDUTGdgjulRgiKz8uqj0ZV0gW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgPBKgiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EE0C4AF07;
	Wed,  5 Jun 2024 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588170;
	bh=uPCGWMeOdnY4K7O2ka/QvfwHXB9VtLOgHdRbGb7d3jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgPBKgiEN7JPQE+zsi7S2hEqHcAIexlICgl02jXyem8/9EWEDD2DzeyHhKJZ9/veI
	 7AkBc5p5Q3hsCBQcb8iddPX81z89CSKQ9oRxl1OtwE9eG30xainPJTaa0CO6QuJqiW
	 Y7/fgd4HsxZLxHDffkhPXFC6FS5SIW2rIP3kmFJokE+0bhaBhz70xFG90Kjdg7atEu
	 ekOSREN8hZXn5Tayro583kO9TjqMpzPdrcSfUF3tNJf6Qj6+n3Nx2GE2ppdEqURHMo
	 DH4tuy5yP2xP1pL+MZHf1STS0uZZ7KcPAOyJxI9tuVUUmz7SG2K5To8khRDKFqGUf3
	 Vb9Iotk1+AB5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Roman Smirnov <r.smirnov@omp.ru>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.9 02/28] f2fs: fix to detect inconsistent nat entry during truncation
Date: Wed,  5 Jun 2024 07:48:31 -0400
Message-ID: <20240605114927.2961639-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 92c556ed6318e13c16746495a8d4513129eb9b0f ]

As Roman Smirnov reported as below:

"
There is a possible bug in f2fs_truncate_inode_blocks():

    if (err < 0 && err != -ENOENT)
    			goto fail;
        ...
        offset[1] = 0;
        offset[0]++;
        nofs += err;

If err = -ENOENT then nofs will sum with an error code,
which is strange behaviour. Also if nofs < ENOENT this will
cause an overflow. err will be equal to -ENOENT with the
following call stack:

truncate_nodes()
  f2fs_get_node_page()
     __get_node_page()
        read_node_page()
"

If nat is corrupted, truncate_nodes() may return -ENOENT, and
f2fs_truncate_inode_blocks() doesn't handle such error correctly,
fix it.

Reported-by: Roman Smirnov <r.smirnov@omp.ru>
Closes: https://lore.kernel.org/linux-f2fs-devel/085b27fd2b364a3c8c3a9ca77363e246@omp.ru
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb021..bb57bbaff7b4f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1187,7 +1187,17 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		default:
 			BUG();
 		}
-		if (err < 0 && err != -ENOENT)
+		if (err == -ENOENT) {
+			set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+			f2fs_err_ratelimited(sbi,
+				"truncate node fail, ino:%lu, nid:%u, "
+				"offset[0]:%d, offset[1]:%d, nofs:%d",
+				inode->i_ino, dn.nid, offset[0],
+				offset[1], nofs);
+			err = 0;
+		}
+		if (err < 0)
 			goto fail;
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
-- 
2.43.0


