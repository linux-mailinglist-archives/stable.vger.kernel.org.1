Return-Path: <stable+bounces-49650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7788FEE47
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA511F22197
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF61C2246;
	Thu,  6 Jun 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUUrR0Tk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D35195B08;
	Thu,  6 Jun 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683641; cv=none; b=ANtDtqfj69RaEDRFEmzB7C4ftjn3ZCqri36fS7vYzjyBZDBJiii3CNoNg2J9C2FmE0kz4YlgyqoAXhYatyJcCynf1HKHIgmM639wcvbEqhCZ3xJUK1Lw+f2THAH/7UW/pCh3v2XzKoccdZUNbuL9F27iLtt/gs3u+0ErNjHuBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683641; c=relaxed/simple;
	bh=AWylH96WfwEiEXk4Cvo0EAbrxL6SljHFRh/MKP30YiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX6cXmvzXOzQeVpiZ5ch/HNV/Sas6SeJK9HNQrC3kaouM+yKQShj/dsWKU18Pc065lTLd4X0AzKvE0N+Bez6TXe0ErwRI9XUJOyRAoS2ck/Ow04N2DzuD1VXtwgxGibtsWrTuZLCkrmTjEEJYLJAHz9yFWjJ46JRgnYeaWkhDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUUrR0Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03C1C32781;
	Thu,  6 Jun 2024 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683640;
	bh=AWylH96WfwEiEXk4Cvo0EAbrxL6SljHFRh/MKP30YiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUUrR0TkqtiTk1TFTiY3kKtNFA+/vXeR0qho+UrrefGRrG7vOssONvEB6MNaFzlAq
	 bPjHym3duywFg74qBmYaEdu+hYsPbL4qHVV++Nsx3bTrw44BTGREvlUN8lntc1UfSf
	 x2sQOYA1pd46mQWDX9Ns5j7tEQRKLsYymuFglc9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 512/744] f2fs: compress: fix to update i_compr_blocks correctly
Date: Thu,  6 Jun 2024 16:03:04 +0200
Message-ID: <20240606131748.870724765@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 186e7d71534df4589405925caca5597af7626c12 ]

Previously, we account reserved blocks and compressed blocks into
@compr_blocks, then, f2fs_i_compr_blocks_update(,compr_blocks) will
update i_compr_blocks incorrectly, fix it.

Meanwhile, for the case all blocks in cluster were reserved, fix to
update dn->ofs_in_node correctly.

Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 20dc11b58bb69..206cb01875c48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3622,7 +3622,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 	while (count) {
 		int compr_blocks = 0;
-		blkcnt_t reserved;
+		blkcnt_t reserved = 0;
+		blkcnt_t to_reserved;
 		int ret;
 
 		for (i = 0; i < cluster_size; i++) {
@@ -3642,20 +3643,26 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 			 * fails in release_compress_blocks(), so NEW_ADDR
 			 * is a possible case.
 			 */
-			if (blkaddr == NEW_ADDR ||
-				__is_valid_data_blkaddr(blkaddr)) {
+			if (blkaddr == NEW_ADDR) {
+				reserved++;
+				continue;
+			}
+			if (__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
 		}
 
-		reserved = cluster_size - compr_blocks;
+		to_reserved = cluster_size - compr_blocks - reserved;
 
 		/* for the case all blocks in cluster were reserved */
-		if (reserved == 1)
+		if (to_reserved == 1) {
+			dn->ofs_in_node += cluster_size;
 			goto next;
+		}
 
-		ret = inc_valid_block_count(sbi, dn->inode, &reserved, false);
+		ret = inc_valid_block_count(sbi, dn->inode,
+						&to_reserved, false);
 		if (unlikely(ret))
 			return ret;
 
@@ -3666,7 +3673,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		*reserved_blocks += reserved;
+		*reserved_blocks += to_reserved;
 next:
 		count -= cluster_size;
 	}
-- 
2.43.0




