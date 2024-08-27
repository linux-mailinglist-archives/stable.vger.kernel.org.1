Return-Path: <stable+bounces-70562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF389960ECB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC68286EFB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E11C6F5E;
	Tue, 27 Aug 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVOVdV2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7351C57A9;
	Tue, 27 Aug 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770319; cv=none; b=Xqn33ggyXencCdC78k3uxrzceGFob5PwFr2OLU7KFe2ROiDv7e/F6vqQBwMiqOjwPZ/2JiAClETDOyaHsZy9Le4BW3wA2DaRCRBKDRSMAtN92fE9npyfu3+Q2W2LaOSo3tL9p0lhiLtPHoT/3q8nZL7QrlLK67W33AHE7pHuHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770319; c=relaxed/simple;
	bh=ALe79kDi8ngO6t2sFtGkDvn0a9VsptVQE8PgBp3BOpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na0sUMZqSVNh9/XgcXJTSuo1ZFAGZn7DX8vGbMNzuBT4cwgPqFBcLK9ENF/zDgNfn2zPPzyVA6vqFq9clXAlY7yptTyvrLfdO5DgWA5A2wFfGxvczYXVxsqu5aNt0P0pBDc9riw8MkgqWb9KsRjghb3YVGOS9KNLhHPRS2wPIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVOVdV2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFBC4DE06;
	Tue, 27 Aug 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770319;
	bh=ALe79kDi8ngO6t2sFtGkDvn0a9VsptVQE8PgBp3BOpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVOVdV2or8WTnW+UZPR+8b/O9jyzuPP2h3x2MKZ13x71JB5cG/DUHwNfh1RtXLDce
	 TCR1qsprZEVb7fLRnsdjSyOXl1nI1Vfj234N6csunhQ0z1KsZf9PEcqsCIlGMN8d09
	 tbfTfqto3nhMlCgUtnXO6ETmw7EHBjIEusr/7mW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 186/341] btrfs: change BUG_ON to assertion when checking for delayed_node root
Date: Tue, 27 Aug 2024 16:36:57 +0200
Message-ID: <20240827143850.490585183@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit be73f4448b607e6b7ce41cd8ef2214fdf6e7986f ]

The pointer to root is initialized in btrfs_init_delayed_node(), no need
to check for it again. Change the BUG_ON to assertion.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 12ff91d6f570f..32c5f5a8a0e93 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -973,7 +973,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		BUG_ON(!delayed_node->root);
+		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
-- 
2.43.0




