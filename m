Return-Path: <stable+bounces-171719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D891B2B6CF
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01EFC4E3449
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CD2D027E;
	Tue, 19 Aug 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzIuEE83"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4981EB1AA
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569767; cv=none; b=dKQy6A+NT1StRSjhviuDVsL/nA0U7rIA0XkZkdD1bJ8Et8TdA0F+Y7nvxVPEF5w9kuD6jBAmhCOvkBKJ3K8L6yTJc0gp4sGI7663WUOTjt65WEcNPo41uFCqSHr3Xz5/qqAByHDpDIbeeM3NHvPMYZXpIgWcK4CUdBhh8c++syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569767; c=relaxed/simple;
	bh=3GmCNkUZFx5Bk5/81fxkcNVTl2iAw5/yQ8+PKYIKYEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPftcyPlI4jPAxPdg46OSG/QsFjvlMZ1AMmvUcEzIbGRFl+JhSsSRyd/2hon6ZWeZTI+3NIU911Jw7/zxD/LOeov8a3tvydVyYXqpE3V3UXKe/2dQLxes8/JKaL2MtdcfBrUqB7j2FQCsDcg07tamagch0U15y4/VOU8MOrlFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzIuEE83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82AC113D0;
	Tue, 19 Aug 2025 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569766;
	bh=3GmCNkUZFx5Bk5/81fxkcNVTl2iAw5/yQ8+PKYIKYEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzIuEE83wOwQr9uRObK1L2/6MS3KdSTDqWEgSJ1mrEOXVF56GGk+1wVeKR++bkT0m
	 LRr7+V3jIJiuUFRAOqM3i70lwWUrBZAiV6mgQKJblZmUgqwTmzIJQvKNPnM4xeSdLN
	 3oE9DZM81vsP8fSQAjwb/Q0zvxHg7wGTx6vWHAJseI9ZhNt8aM5m85a53n2pVaK659
	 bFSzRqfNYHk/8HClQ6w150JklTqkt0Ym1fHJaO5rylq45XdavGJAmSB7Cbpsm0zPwv
	 RELv10lYrQfcXiwABXkSBUaG+WpGrmdt/7QHlZkZYLJEVueIaze+VUUWdeY/1fRmGa
	 Vi/I7aiulzDmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] btrfs: send: only use boolean variables at process_recorded_refs()
Date: Mon, 18 Aug 2025 22:15:56 -0400
Message-ID: <20250819021601.274993-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819021601.274993-1-sashal@kernel.org>
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9453fe329789073d9a971de01da5902c32c1a01a ]

We have several local variables at process_recorded_refs() that are used
as booleans, with some of them having a 'bool' type while two of them
having an 'int' type. Change this to make them all use the 'bool' type
which is more clear and to make everything more consistent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 005b0a0c24e1 ("btrfs: send: use fallocate for hole punching with send stream v2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 464c37c2b33d..deecd92cc512 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4179,9 +4179,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	u64 ow_inode = 0;
 	u64 ow_gen;
 	u64 ow_mode;
-	int did_overwrite = 0;
-	int is_orphan = 0;
 	u64 last_dir_ino_rm = 0;
+	bool did_overwrite = false;
+	bool is_orphan = false;
 	bool can_rename = true;
 	bool orphanized_dir = false;
 	bool orphanized_ancestor = false;
@@ -4223,14 +4223,14 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		if (ret < 0)
 			goto out;
 		if (ret)
-			did_overwrite = 1;
+			did_overwrite = true;
 	}
 	if (sctx->cur_inode_new || did_overwrite) {
 		ret = gen_unique_name(sctx, sctx->cur_ino,
 				sctx->cur_inode_gen, valid_path);
 		if (ret < 0)
 			goto out;
-		is_orphan = 1;
+		is_orphan = true;
 	} else {
 		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
 				valid_path);
@@ -4453,7 +4453,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 			ret = send_rename(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 0;
+			is_orphan = false;
 			ret = fs_path_copy(valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
@@ -4514,7 +4514,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					sctx->cur_inode_gen, valid_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 1;
+			is_orphan = true;
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
-- 
2.50.1


