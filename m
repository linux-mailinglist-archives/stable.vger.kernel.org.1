Return-Path: <stable+bounces-171729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929DB2B720
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F271B66142
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039A18E3F;
	Tue, 19 Aug 2025 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM0PCv5x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1E25B663
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571223; cv=none; b=ihkFlqp6xgQtFiZ970ILqYlGONjl1h8G+e76e4Y1UohbDgEdJqEDbBoUe08hM2cmSD3x4rgEmzU+qCt0LSV8S7jng56HGO3r6Q+2KZHpr8WeNDv5Gfhep8/V+4Hlvr3PZ+ynTLj85dXXLhRtwLDNO2V4vGiWPnNWvKWLBluiMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571223; c=relaxed/simple;
	bh=nLrZ6rDiCJ/ZzVmVzjg/n1BCaN7yC2iZTicAmT1oJiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzvrsiYb0PWPcV1V8gobuHlZizLn1bDVbyxutCme1N7wEB4cpEQwoxbVw+vjGFrIwcW3e9d8LQyOk0AhHjnaK+a43A/LyDjwseHvZgucOK0AWlf3NS2uzrfHBi4wsu+6J/88Hbz4E2nL8O9d2QeMrymKV2zxfpk7lD0Eti2Rvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM0PCv5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94131C116B1;
	Tue, 19 Aug 2025 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571223;
	bh=nLrZ6rDiCJ/ZzVmVzjg/n1BCaN7yC2iZTicAmT1oJiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NM0PCv5xnj/TMYjlj1BJdockaVjo4XXXRm3GX/CntoTEJzT0NGNNVPZPxLnXhJzjG
	 bevM5hS6pFmPrU43zmjzbjqjC/CElOLYPZjYqq0++XsZhFX3YKA6vdKqlANM/D6zFj
	 r1fuBO4xpgMn42VvNE/XVDSYX1McuGexNHs/fgQCFdPMaTwagE7JIYmq+JNyVod2cf
	 CHpKgzwiGR4+OdDcKIPvuo03wMhj795MH3pB+3rtHfdAIN+m1bMSPjm/Q+rG+nMcQX
	 E5Nbvlf996WMIUE9+7eviP5khKzokPTJmcu1xqncd58zkDU1kIP+6FxQm7SdrcJgRM
	 9pt541xteAe/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] btrfs: send: only use boolean variables at process_recorded_refs()
Date: Mon, 18 Aug 2025 22:40:15 -0400
Message-ID: <20250819024020.291759-2-sashal@kernel.org>
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
index bb24c1a00f6e..07738b368608 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4180,9 +4180,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
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
@@ -4224,14 +4224,14 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
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
@@ -4454,7 +4454,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 			ret = send_rename(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 0;
+			is_orphan = false;
 			ret = fs_path_copy(valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
@@ -4515,7 +4515,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					sctx->cur_inode_gen, valid_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 1;
+			is_orphan = true;
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
-- 
2.50.1


