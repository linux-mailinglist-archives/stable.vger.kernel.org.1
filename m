Return-Path: <stable+bounces-171695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A81BB2B5AC
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186F61895389
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDE43169;
	Tue, 19 Aug 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+0HTxya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A183AC3B
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565296; cv=none; b=qhawipGG8J6RzaFVgfZJpI7SKD81hkPYOJH1qGcLbWg9f+zw7cN5NzXxUHpBfcNxha74u9hbtwKvgo30+HLtYP9lxjo8aLObv81AamhGJhMATCKk3ZkDLm269i57eZa3vS/4vdpY+Xyg3XNUb/3FHLVnpyzBboYgaTkGJZYhgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565296; c=relaxed/simple;
	bh=UIgvap0fQpQ9JBzTsuC4Vi/sKzbRdWjiSqr5VswPSII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lT7utesAy0OFoQpUXVC+YhoKucsqgTQtk9l2OClInKT3gsv5xaW8Apz0nxMwLfdrrxDFNeYFK04ZMqPdsgNI65y3N5AIZhEx6LgC9lRLvNSvsDtyNRyfOXNR3cfeK2xrQ9PRiUBziJX9aYNVBsvGErw2e4kag606tSY7zcUwxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+0HTxya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F55CC4CEEB;
	Tue, 19 Aug 2025 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565295;
	bh=UIgvap0fQpQ9JBzTsuC4Vi/sKzbRdWjiSqr5VswPSII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+0HTxyaT3j0yYpWovV/Eoiu1yDcmt+OxJKsvPbKjx7ZAAj/eh/b8ggXn73L+9c+3
	 TROl9uk0ZnuKLWxcuPOVU1FmE6K84XOYslX1X1hZ0ggJvI6zoMc7iIcRA/bxG2BHJo
	 Hdvi1rvvfTIO6+9OlFrQ5TBogIFh7j3NWXZSLCUzFrTAtTxdo/QFxY+0EWIjKjUbNG
	 c41kCNoXmtK5VrZtk0li+ycYbwTg11Zm0rfHQUKzXogPDnSiQ6cjstQeiCGxB8ZaTm
	 6XDqoB0HUYPhpYyKJRzBXTdZooz4g55tu7hdq4/AOhjfUgVq0Vo9KrWK7TRjoDnfhb
	 myY1462nqKURw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
Date: Mon, 18 Aug 2025 21:01:32 -0400
Message-ID: <20250819010132.236821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081815-strut-suspend-7a53@gregkh>
References: <2025081815-strut-suspend-7a53@gregkh>
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
index 29c164597401..6bc718f96545 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -350,7 +350,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
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


