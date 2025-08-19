Return-Path: <stable+bounces-171730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF9B2B721
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFEA3BD8F9
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238C286897;
	Tue, 19 Aug 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlZ2UQsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210E25B663
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571224; cv=none; b=Xo8Ij8r5z7CggF5G/mwhlYtTwIja0wwn2qLKd3K6qAcM+drMxXDRdRw5vWYhL0lsGPsMktdDCJ8x6ZZNmNSy7H+H4HKvCw0xN4kJszFA28N3Z2H9uGSt5sjQBl00tsJnbsK7Qnv0/bpC8KMGjFWjQm2jdRYD4os4EJWrLZAhSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571224; c=relaxed/simple;
	bh=ld4KtKz22X9/ZzYi8jON/G4ueh/2kCmtEfQvFeCzkls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaIIrLhGKOog63RbMbM58yZfvPVHLIHHQSDuj6CB6dfbIuwX56CFD6wcix3siV3NueIbyoF5udOH9o5esI4/HEJIvxskRyAZ63CUXQXD0FUwrv3Zi283pg9my8otYZ4PYrAi5UfRpnScPScjikQbWOaf77jIRhrj+7wfGKvnrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlZ2UQsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0EDC116C6;
	Tue, 19 Aug 2025 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571223;
	bh=ld4KtKz22X9/ZzYi8jON/G4ueh/2kCmtEfQvFeCzkls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlZ2UQsvUqw69hDrfeUf93VN7r46MO3jkhxebmHzDL6NArCmTAiQZ3C5PPL1wkYj/
	 XkZ6SZNZFYtIG8TxakVMZsntOa8/ki0Pw1G85QdbzYGfEinJ9U7U8R9P3ORE/yakUY
	 IZB3hmpw7WJbo7PnHBprZiHvZBki8VjrqSrg1kiV3GATtovzcBIVYEoPtj2lL5W/X/
	 53ivNjd+Vrn9ydlKlp5mb9hL0XZ7CGorpP5o4b/QFiLBm+ZbhXcIu39Lr5+4cCV/wL
	 pDr66Aqua/wqxasJyGGHuosVfeRDZ+x2XioriUB5AyLcyamKyjyV7DGtbFuQcWcouK
	 Ihh3/ZAEUNm3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] btrfs: send: add and use helper to rename current inode when processing refs
Date: Mon, 18 Aug 2025 22:40:16 -0400
Message-ID: <20250819024020.291759-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819024020.291759-1-sashal@kernel.org>
References: <2025081840-stomp-enhance-b456@gregkh>
 <20250819024020.291759-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ec666c84deba56f714505b53556a97565f72db86 ]

Extract the logic to rename the current inode at process_recorded_refs()
into a helper function and use it, therefore removing duplicated logic
and making it easier for an upcoming patch by avoiding yet more duplicated
logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 005b0a0c24e1 ("btrfs: send: use fallocate for hole punching with send stream v2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 07738b368608..7c6b4963ded8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4166,6 +4166,19 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rename_current_inode(struct send_ctx *sctx,
+				struct fs_path *current_path,
+				struct fs_path *new_path)
+{
+	int ret;
+
+	ret = send_rename(sctx, current_path, new_path);
+	if (ret < 0)
+		return ret;
+
+	return fs_path_copy(current_path, new_path);
+}
+
 /*
  * This does all the move/link/unlink/rmdir magic.
  */
@@ -4451,13 +4464,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * it depending on the inode mode.
 		 */
 		if (is_orphan && can_rename) {
-			ret = send_rename(sctx, valid_path, cur->full_path);
+			ret = rename_current_inode(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
 			is_orphan = false;
-			ret = fs_path_copy(valid_path, cur->full_path);
-			if (ret < 0)
-				goto out;
 		} else if (can_rename) {
 			if (S_ISDIR(sctx->cur_inode_mode)) {
 				/*
@@ -4465,10 +4475,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * dirs, we always have one new and one deleted
 				 * ref. The deleted ref is ignored later.
 				 */
-				ret = send_rename(sctx, valid_path,
-						  cur->full_path);
-				if (!ret)
-					ret = fs_path_copy(valid_path,
+				ret = rename_current_inode(sctx, valid_path,
 							   cur->full_path);
 				if (ret < 0)
 					goto out;
-- 
2.50.1


