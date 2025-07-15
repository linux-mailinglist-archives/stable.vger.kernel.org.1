Return-Path: <stable+bounces-162823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB6DB05F86
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C57BE6EA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11D2EB5AD;
	Tue, 15 Jul 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZV0W1aOZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F52E7651;
	Tue, 15 Jul 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587570; cv=none; b=RNcgThtOMLxqutN9OzuOBAQNx7WQT+hFTwkLo/QCopVIs38R0rYPvW7ETa9hZVbQH9DrkE2GSA6fcTV431gxsPLmR1HCVEVlh5RB36Jkz9rQNWr7hs+Tj+a8hH9q0H0eNHdr3EQklJ1JWdwZ7mWQJk2YOp+rgIUa9b8zBAmyLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587570; c=relaxed/simple;
	bh=eTD3ISTDCWmM5N2ffSFkPwUMIhgHksAhjBexzjl8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyCI8l558bOi6mdTWp0vtwLMKJs/5dJFZ/royFDgJ6UF3D18sOwcKUEAApc/si/HBLqDb+M1GK+38o6wJpvB9PcwNbVb1pIYcLsPzflZF5ryfYtQ5LHqs/DRIM/FuKK6AIbiYBGD7WboORsvAJqPyofcnHrR2PmiTno040c3/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZV0W1aOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B668C4CEE3;
	Tue, 15 Jul 2025 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587569;
	bh=eTD3ISTDCWmM5N2ffSFkPwUMIhgHksAhjBexzjl8Wy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV0W1aOZSNiUH3SPtUw4JSFJEAqmn40jCOIL/opGzjbTeSt11zaiCGE6rdCi1L6KP
	 TkmxNwJH6pAKMFIvGyQWiSbOPQ/X84Fae0FGJEmwtSb5QUBkM948YZ6OQyja1BWQLG
	 /F8PhT4j1qW6IIAlwtAcpNMefETWB6uJeENEfQxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/208] fs/jfs: consolidate sanity checking in dbMount
Date: Tue, 15 Jul 2025 15:12:19 +0200
Message-ID: <20250715130812.039695847@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit 0d250b1c52484d489e31df2cf9118b7c4bd49d31 ]

Sanity checks have been added to dbMount as individual if clauses with
identical error handling. Move these all into one clause.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Stable-dep-of: 37bfb464ddca ("jfs: validate AG parameters in dbMount() to prevent crashes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 9dccebbee55ad..ba60e24b30a45 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,45 +178,26 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
-
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
-		bmp->db_l2nbperpage < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
-	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
-		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
-	if (!bmp->db_agwidth) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
-	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-	    bmp->db_agl2size < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 
-	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
+	if ((bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) ||
+	    (bmp->db_l2nbperpage < 0) ||
+	    !bmp->db_numag || (bmp->db_numag > MAXAG) ||
+	    (bmp->db_maxag >= MAXAG) || (bmp->db_maxag < 0) ||
+	    (bmp->db_agpref >= MAXAG) || (bmp->db_agpref < 0) ||
+	    !bmp->db_agwidth ||
+	    (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) ||
+	    (bmp->db_agl2size < 0) ||
+	    ((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
-- 
2.39.5




