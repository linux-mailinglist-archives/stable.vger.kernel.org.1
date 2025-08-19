Return-Path: <stable+bounces-171683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0012EB2B539
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5BC622574
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F891C69D;
	Tue, 19 Aug 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKjA0ISJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EF134CF
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562604; cv=none; b=hSM1WBruqBCsQBO1BpUMGP2Jnq2q4EX3jINxGztyRdkGEFLeR6LRh0HNdQLfOk7jitIbPoybm5s25fDkoac+jXXm5Acrntm1QsWRVS4mKDQCvXlPotb2XHifpLDMtZRun9JGKhP08KFlhSAodLTK22nq96x7Q8RAm4oMb5Vqw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562604; c=relaxed/simple;
	bh=QhLBbPCPA27ASvhikm5cQbciHoEeBQmTpG77x0MFHSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSLZZZIbU2L91PsX9hv5z+M53ZCqWNURk9bgLXAUkwqTU1lXxErgeEPPgatLtJhrYG4mwcxq6EBbWJ59ivC/ZjGSLrrH5NMMOE1NyKeHpwxlaoHJSCkoThSF7o+epG1Nt71h+mDVJOhLMal4uoWpdFf3MMnM4GiM0T7iF4aCD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKjA0ISJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD08C4CEEB;
	Tue, 19 Aug 2025 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755562602;
	bh=QhLBbPCPA27ASvhikm5cQbciHoEeBQmTpG77x0MFHSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKjA0ISJqzZxix5Jc81kZu4Kz6wFSzSgTyuuoJXa8HRbCTAT24y87hO7ucziUqc7C
	 qrB7OIw9X6CDhxmJv1JmyM74AGpPpN+hzvZoXWDFHEjtDwrqf73P1i22/OeYSYadx7
	 JW3QleT9TUMHCkhxLsLAoy5y149Nm0qSOmx3RyKvML3KKmCUkBjRlsRGJ5TC1yu0X+
	 T9NwySjs6v6fP/XFqbsKmn0EibYH3AtOG6d5UvJVUzbY/naupYf8ultaKuXjJXj5g/
	 rLot/Q/Ym8/T8ICx5fmsQpXmyDjHvgqXfbD6QV1IyzGrwSNNRrGv9THQYetgJ5+hqq
	 V5zeN54cshiCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] btrfs: move transaction aborts to the error site in add_block_group_free_space()
Date: Mon, 18 Aug 2025 20:16:38 -0400
Message-ID: <20250819001639.204027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081808-unneeded-unstuffed-e294@gregkh>
References: <2025081808-unneeded-unstuffed-e294@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit b63c8c1ede4407835cb8c8bed2014d96619389f3 ]

Transaction aborts should be done next to the place the error happens,
which was not done in add_block_group_free_space().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 1f06c942aa70 ("btrfs: always abort transaction on failure to add block group to free space tree")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a83c268f7f87..11f488c096a6 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1456,16 +1456,17 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.50.1


