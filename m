Return-Path: <stable+bounces-171697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0217B2B5C0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA6419620E9
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559127261A;
	Tue, 19 Aug 2025 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDHfXEAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DFF33F3
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566121; cv=none; b=YS1LC1rgQMo47YuUdxKYUCtH/zYnHjIZQsv2GQvZgVmjxknzTNRv6gRNQWYfHLs5KvaomPHr6IEdOhozLXSV+ySNZw3/QAz4QlVS/jvUgKW4dv1fPpuWbJ3OXY32akdbAme2lJXA7q/efjeDcc7qehEMcEUZRYI8jRbu1V7iQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566121; c=relaxed/simple;
	bh=Rs/s/6eIcBLU31rt97KC2tVgXknlym0Hh1GXYJ4jrs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIeV4AtUBbKJM7uiHusX552SIkuSTbbzKVg6EmVpmqtFjGQJV2RkSWAWRCzyNTYg0uSAl3X9mVhrfe8FY4z36US7L4qboO+a+UtWOLvB5dCWA/cM65z4YJyp8NJ5alXJeKyvhbX2LX4Iy+6m5OIVAm4uEuTNXYSEew2SAAeXAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDHfXEAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C0AC4CEEB;
	Tue, 19 Aug 2025 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566119;
	bh=Rs/s/6eIcBLU31rt97KC2tVgXknlym0Hh1GXYJ4jrs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDHfXEAIGyvlEwC5zS9RW0fGrRlhQpwEvfVx5/MXtZ6RBMhNieG0qBq1CJUl8aaTo
	 yr9XKtPRwqxhxm/T0MI2tANtcisIGlFw/lnn0wF7wUSUPeghHiO1mf/JtvffAZyNAF
	 BWyH4xZtPYcefIwW56Clr8MmlPtqDWi6ys63bZCQsxI03pjhmpfoOU+q961YKDprUr
	 JYW3TVvdI4kZnELicMsfKMK8PqrFYKNrk9C3P27aav5hFEcXpPWWiWQzaaYhuMNFHO
	 jFopDf5tkBPD+bigotbE0Fnrc6hIg2UvXEqb7nfT8drLMy3Ou6s2dATl52DoJyIXhr
	 waMy34LyHsSIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
Date: Mon, 18 Aug 2025 21:15:16 -0400
Message-ID: <20250819011516.242515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081821-startling-skiing-ca6d@gregkh>
References: <2025081821-startling-skiing-ca6d@gregkh>
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
index 4b21ca49b666..18439a37bb24 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -347,7 +347,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
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


