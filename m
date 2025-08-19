Return-Path: <stable+bounces-171688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3EB2B56B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FB562537E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A313FEE;
	Tue, 19 Aug 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJvCk5Uk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F7C120
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563931; cv=none; b=mlqN+TZSZ2YwL6MCq90BpNrznrvFpg3egMoMGUYUva5hDhc3AzdLIcmZygpvhjBseEgbKICGUflpZUOxDC96VPrWXNNLl4ErCG6/rSdwG88LJSaNdWebGE6lm9f8a30LQB6+7O6pzJr+Swu9L/GOk+EtZkb58ZIo+gw9MgIKP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563931; c=relaxed/simple;
	bh=1e0CbNRQYt6uL6D39abTaM1QnClAvTmFRDSodArb3Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZHiLJhvVHMDQWKlvvLhskFCdSeYnxaaJgyxZXYc2AUY38ecU2WEgfrn69QzoMD0U+e3qV+K/l/AbWWUA/PCVHc0/IDu93vwg3r1kVwsrZki47KAKl7Hi5DJd0ehsAMV03BcxDHMk14Jna4FSmU+N4WnV9S2m42zYzJ+sPXXJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJvCk5Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A6C4CEEB;
	Tue, 19 Aug 2025 00:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563930;
	bh=1e0CbNRQYt6uL6D39abTaM1QnClAvTmFRDSodArb3Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJvCk5UkTnTSGCUKWgbQjWRuOkXnj2FjaP/XVDQXmKiQeVfUGXWCXzVf7Cptrkk4o
	 ZtuXvDvFRIxSUC7RburjK8cz1AMUkeSdyN9cM3/rGZOiZNo04ogIX6fRp8NyCl0hdg
	 WNnHQUlIMdKeyatufdw36PXVJXTWKDidvZz3leUIqAi6NjvhprPTeIdF5k3BSGNUis
	 8FNzgMCPSDtQZsTmpPFVo+ToDPOFhsruj94tnYbEn7x0NJSXm9Izldy+JHxGauxa2M
	 EgGEnxO0y7rujYCvLr2uuX3gwtzVShsne7oQNp7AG1x010YtssHL26bvQaB/hTf1Fg
	 JIE7y7F6mnUeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y] btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
Date: Mon, 18 Aug 2025 20:38:40 -0400
Message-ID: <20250819003840.226789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081814-cotton-endpoint-c7b3@gregkh>
References: <2025081814-cotton-endpoint-c7b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 33e8f24b52d2796b8cfb28c19a1a7dd6476323a8 ]

If we find an unexpected generation for the extent buffer we are cloning
at btrfs_copy_root(), we just WARN_ON() and don't error out and abort the
transaction, meaning we allow to persist metadata with an unexpected
generation. Instead of warning only, abort the transaction and return
-EUCLEAN.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 648531fe0900..df06c9c3d406 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -283,7 +283,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(btrfs_header_generation(buf) > trans->transid);
+	if (unlikely(btrfs_header_generation(buf) > trans->transid)) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 	else
-- 
2.50.1


