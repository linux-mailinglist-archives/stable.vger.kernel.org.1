Return-Path: <stable+bounces-171707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DFB2B646
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B841C527B0C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770ED1F09A5;
	Tue, 19 Aug 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPQ0jVwh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD71EFF9A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567274; cv=none; b=NK51lx8ZB6tlqOURyWj2PB+TlM07clNELe2BSNmvEnv2M1gDmavwcY6Hiwqes0unS4YSeLNswceEmHUz4Znp8O9cTgtyChtRnoHqL56ELUy7ak1rk6MTmzQU7LPpnB+Ne1PrfCP3PZqjNsOHNRp3wjoP5Q/V6V8+Z+rvR/PpEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567274; c=relaxed/simple;
	bh=QNwkUQ3BqANrCOp5Ku3kf6/G5BJk+7uuk15enqhPCwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDiqqaNS/+wEoZwqpGaqaGpuQvVoedP4uUv1AGSN577OA6C4bHFc6CtEXctr2Oi57/SlhNP0MZ8wHNwjeao1J7pQ1TrgxDYUVZ2xYduwKeayQpcO1yyBy4Esfu2EDRPLA9IfeHgS6OWTg2k9HG6hQq7v8o8KmVSZKxSG4du0LRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPQ0jVwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4094C4CEEB;
	Tue, 19 Aug 2025 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567273;
	bh=QNwkUQ3BqANrCOp5Ku3kf6/G5BJk+7uuk15enqhPCwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPQ0jVwhfAei9XleDlXmiGHzGdWp4dMZESl0MGEhUNVkVtN07zrpAyiZDS4X3tKJA
	 JQbHQhaXg6EBuo2SJqOW5F5GVDQaOPHGwg2HWgEKguemmMlnim6QHKaVFt2TG2EBFI
	 BhAyM2w7f8JWM4quSHiVvoOot9WSI3iNhu7qzf55ylzwsAtg9b9LTD71gQ1hqpPVw7
	 TyUBiyb+x9TNHc6NNY1NVl6gbi9gc8iTRGpX1Cbt7Kk7Of7zBKzKIjxeNwJU6hBRJ7
	 Lcaplu5/eX+M2PaoNsMZd6vnnlc6llfRtK9v3gunpeO4q5TlPxSnkvGyQw/x48Fgos
	 g2QZiilAiWEhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
Date: Mon, 18 Aug 2025 21:34:31 -0400
Message-ID: <20250819013431.249337-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081821-debating-askew-bf1e@gregkh>
References: <2025081821-debating-askew-bf1e@gregkh>
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
index c7171b286de7..9620bf289f78 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -237,7 +237,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
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


