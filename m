Return-Path: <stable+bounces-171690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE7B2B569
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308DB16F2C8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE1156F45;
	Tue, 19 Aug 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7SzzbFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4413FEE
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563947; cv=none; b=U3Tq6olOSUY1aN/iZ1FLuR8HfwFqAkg7q8r2Uoh0pUYjcnwvDG57tjCyNFhl2yLJFRyP2wF5ZFSf7tLjSoju26Cbnv2nYAith+E++aXVCXYU4lmu+cSAXoMpdHjpOVynyXW2H01Nq5Wv2cEAOdwN6wudcfGI+SG/FwhnLf/LwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563947; c=relaxed/simple;
	bh=igsqncgaCraDSeeyuJo/V7crRzQBfkR0dD3+GdRQ3vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuQjM5DXw/ikqX6XwLuGVRVrClDKZ/W643QO8nafyasBKIm7Gyg+oPaM0jMYRUZKCQ2cRd5ayziVScuR4+xP6KSjgvgwdQTk79lsJfS5sQ4ZkXCNZsGTyowkc0vqtqAwyngNIakOvDcRqfXHcKe4rtiZO+KrNnXD5LL9+0b1i90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7SzzbFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC2C4CEEB;
	Tue, 19 Aug 2025 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563945;
	bh=igsqncgaCraDSeeyuJo/V7crRzQBfkR0dD3+GdRQ3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7SzzbFZ7ClYPXXpYuUZa0lxmC5A6MC6Xk9JFibMSjKU8fMk/e0sQBiBtwxnYiAca
	 OyJZS3qZyED0Ju694czU+fdhzTFK3Q3SwyAdLbYetkT6x/D/smcVR8xBN5W0fxqcgm
	 P0l+K92Wc6RmgeWyuLljFHwE3ZoS0psjp5SUGOb4IioyRiPPnf2OGqwGFFaK9vuaXk
	 xJljzMMMls5M3J3Sg3Uk3CPfEWgtlqWoVXHrWuz37BabV2xmrb6XXBypazRwGRm6fs
	 EIKnDYOOSc4byTQRmVRQNBUtXL3Sdu9xoJ4RZoO9vzi8Rng8ttc7pC8+3z134sjIIi
	 0/tD8cGcxKDNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] btrfs: move transaction aborts to the error site in add_block_group_free_space()
Date: Mon, 18 Aug 2025 20:39:02 -0400
Message-ID: <20250819003903.227152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081809-unwatched-rejoicing-21e4@gregkh>
References: <2025081809-unwatched-rejoicing-21e4@gregkh>
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
index 308abbf8855b..6f5ccb7b7db9 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1404,16 +1404,17 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
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


