Return-Path: <stable+bounces-38222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BD8A0D95
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4719B1F22B1A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B36145B05;
	Thu, 11 Apr 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0fuq67D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D214601D;
	Thu, 11 Apr 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829923; cv=none; b=MlH9FA6RVsQk5JoYp/rF0VDbSPQeN0iGHLomukIVp1vdOgISQK1HokNdJfJXVdABjH8+Sf7cdE4VXOfG1DKBMNGnv2nZRVrzccxypQP6hYQlvvl1+QgJhU2JWImfidbAMN5G9bJZkjDscwv1WM7mZkPVoIh8k39ghW+Y2uJm1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829923; c=relaxed/simple;
	bh=c/3zxRaATM5PUzEsS17wrPtLe5uFcT/7sI5W8g/OL1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxu3dtvQmtrfDABGFIO7JaUSbedutXDe9by34oI/w5/hg+PDOFfoHA9Ot6Xj+FmQfPXWwYakOPl/9GQ/AYDT/JBgh1efTiyk0ygztWyz7RuBpf4lzGasfv9xDbMJ2Myq4rSVNg4FdCK2VWX1CyCvvJ5m87cTwMuNaMS5gEPyJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0fuq67D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF99C433C7;
	Thu, 11 Apr 2024 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829923;
	bh=c/3zxRaATM5PUzEsS17wrPtLe5uFcT/7sI5W8g/OL1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0fuq67DoGDHC3hDRZ0zcTOybbka0Hfz9iO6PwL5AoQ4+iJphibgl4rBiBDprTEjh
	 HLneC1pUArM/ZFAlO9jbuVYbodLA/9+Nk95DD187D/5n9N80SxfSZQQkJ0CPhAlJC8
	 E5CRpjeMrfvXOfrmHwSck3NpB+9P5MLcmt85ppsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 150/175] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Thu, 11 Apr 2024 11:56:13 +0200
Message-ID: <20240411095424.078608554@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ecc33e3a3c063..01e9a5afc33bf 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -182,8 +182,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0




