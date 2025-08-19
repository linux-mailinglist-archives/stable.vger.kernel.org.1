Return-Path: <stable+bounces-171720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5129B2B6E1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F064525F8D
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DB288500;
	Tue, 19 Aug 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZEirs9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061821EB1AA
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569768; cv=none; b=B9xVbGVNLQ325gzV59LC9U4EKBDivOOOzVhtm+WZdDkSPm3PmXsGX7BYISdbdgEUGVKBOc7s9urZOlHqFhy12HAbn9/ES2dotOmuZqaECB8hMx7Z8Ud/wmvuQ20N9DKy3Od1EpPHfAqMqmXNkONbrQxACtIpkRDHhL+sixk4mQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569768; c=relaxed/simple;
	bh=ScmyXUZf3Mw1Mdd9flLhi5bfVw8KPQ2xfiu+EYGkcZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1cJ5ObkhuuygobNMg9St5HTK5Cxi8KEGEFuJtgAUUJ7/FS0oMG4FgdOPImN0Ifw7nsgnbAiTAjkkuqnHTQ4XMaXspCjPBwlcXvfotJ0d+ZWC9hNW6MyrlYh7lyQoq0Z+htzRSksfX9d3s9oVFjmnhYXaiplLcnHkENpELP16b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZEirs9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EFFC4CEEB;
	Tue, 19 Aug 2025 02:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569767;
	bh=ScmyXUZf3Mw1Mdd9flLhi5bfVw8KPQ2xfiu+EYGkcZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZEirs9fjUwxKb84DtTukdKj8IFUyDQJvk0yvt8wICsM23dbxdbb23qpznnDWxXOo
	 M4Q8Mk0zOL049pY9WWKD4Et6EasYsIApdzx3QDCwPPrnmeQ0Z8GXQhLjZtMh0PuCPH
	 iGG9AqwJ1EEJpiMVqDR4zBFStd0p1+A7K/XNsGDAfBvr9YE0pZGtRSOVKNI8hKx7z1
	 Knp0KZ664HzMjr/7jh7e1D6UnjrokGBx9ipazgUzykLaeC1GT1I86QLgCEQnJ9IhBR
	 0LQOOH0rWfrZe18JDuhNVAtJ0d/NkAKGPbQ2/oSnfY5Lt3vfc2Paa5inwnrS8Bpdqu
	 LkmvTAnLg1xkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] btrfs: send: add and use helper to rename current inode when processing refs
Date: Mon, 18 Aug 2025 22:15:57 -0400
Message-ID: <20250819021601.274993-3-sashal@kernel.org>
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
index deecd92cc512..3a960ac1f3c3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4165,6 +4165,19 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
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
@@ -4450,13 +4463,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
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
@@ -4464,10 +4474,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
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


