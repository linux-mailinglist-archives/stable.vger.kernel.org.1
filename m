Return-Path: <stable+bounces-157126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D0AE5297
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEEA27A6CE1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496922577C;
	Mon, 23 Jun 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTI36FWv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656E225413;
	Mon, 23 Jun 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715097; cv=none; b=GexW+An7CviE68wJd2joonhIGPJgeOhOAGFv0w/F3ZWyJwloc5vdoHIh3GzHnTF0mKJDqcWg8Wd7pk9l7tMTRktsHRhxuXMEbU/553tGh/ZYtsGxoviBfdcFE+riDBefnRFCsqTNK4SSHptvKgkUbzdsyQcszD0j+CUVflE6PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715097; c=relaxed/simple;
	bh=8Rm+gGjZKJ6P5/ZmnSdXs32pRpqB55BnYBs9KchHZuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1fhlkKwRlrL9End3ChE0zAiLAhlrpA5g8TZ47sHMzRQEfMXP8ak3LpYt2GYuZCp01vc6LIeirr/HOgyb1C9ZEiKfD/iLqwgh5f2yrxmiZFz6cO2+UjoHdWF9SZRJJwRIfdt2XCGUKbO1n0sYIINmdiAACVh+4J5bOd3m5MaVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTI36FWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AF7C4CEED;
	Mon, 23 Jun 2025 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715097;
	bh=8Rm+gGjZKJ6P5/ZmnSdXs32pRpqB55BnYBs9KchHZuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xTI36FWvj8IXFrgUNyVzvF19Jg+1qwsZtat26RvLfu53ekh6Swmv2L/vjcm8LKxZz
	 ar7hhQp2o2UkpPPLdlRkfFJbj8RPGkXqdnOs9FBZvLzkAYuFX/Pv1C7ZobCaVX80At
	 1KKjDdhQe/OHvr5m6EIL0pVMOYWBLppmH4J9cmMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	kdevops@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 5.15 228/411] ext4: fix calculation of credits for extent tree modification
Date: Mon, 23 Jun 2025 15:06:12 +0200
Message-ID: <20250623130639.401665649@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 32a93f5bc9b9812fc710f43a4d8a6830f91e4988 upstream.

Luis and David are reporting that after running generic/750 test for 90+
hours on 2k ext4 filesystem, they are able to trigger a warning in
jbd2_journal_dirty_metadata() complaining that there are not enough
credits in the running transaction started in ext4_do_writepages().

Indeed the code in ext4_do_writepages() is racy and the extent tree can
change between the time we compute credits necessary for extent tree
computation and the time we actually modify the extent tree. Thus it may
happen that the number of credits actually needed is higher. Modify
ext4_ext_index_trans_blocks() to count with the worst case of maximum
tree depth. This can reduce the possible number of writers that can
operate in the system in parallel (because the credit estimates now won't
fit in one transaction) but for reasonably sized journals this shouldn't
really be an issue. So just go with a safe and simple fix.

Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
Reported-by: Davidlohr Bueso <dave@stgolabs.net>
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: kdevops@lists.linux.dev
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250429175535.23125-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2372,18 +2372,19 @@ int ext4_ext_calc_credits_for_single_ext
 int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 {
 	int index;
-	int depth;
 
 	/* If we are converting the inline data, only one is needed here. */
 	if (ext4_has_inline_data(inode))
 		return 1;
 
-	depth = ext_depth(inode);
-
+	/*
+	 * Extent tree can change between the time we estimate credits and
+	 * the time we actually modify the tree. Assume the worst case.
+	 */
 	if (extents <= 1)
-		index = depth * 2;
+		index = EXT4_MAX_EXTENT_DEPTH * 2;
 	else
-		index = depth * 3;
+		index = EXT4_MAX_EXTENT_DEPTH * 3;
 
 	return index;
 }



