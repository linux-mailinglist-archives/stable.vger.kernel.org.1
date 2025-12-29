Return-Path: <stable+bounces-204149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC9CE8501
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CC73019B7B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD521A444;
	Mon, 29 Dec 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjyljROA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEFD531
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767050155; cv=none; b=EAHaabHn641xiTwF6E51IfERhqj37LOYpacFaVs54VOdxD2hJ0VBT33pnFCs/okoUXvqBI30g13phO39wSw09T+PK/KPT0lDKc6/LFjCmEzNJCoRY6s9PRbrcCXlp9O4sH7Md3LPPXD5osEjo6umodyFHcy9nvXGnfwrUTreMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767050155; c=relaxed/simple;
	bh=Ie7eZNzHJMPyfOsrONd4LiNT5OGAiznUY0VR87phfJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiRRB6hIG87rhYSck7iUWzcpEH62n45aXCdO6D5nOgeetig52QExTW2Eam3izrzntXx4ozT1mgjW4rgUkM9W7vL06wZ3MZHekPeKr2+gAVgjEazJ+z7Uc0aLWG1Ra/5L8rCalpojiq4xDakoNkvd+dXGfCJF+n/IQRDcbmyBqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjyljROA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE78C4CEF7;
	Mon, 29 Dec 2025 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767050154;
	bh=Ie7eZNzHJMPyfOsrONd4LiNT5OGAiznUY0VR87phfJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjyljROAmmfHKvuhtloYUEIQAaLrhhXzHBEMUw8ZSawVUZyY58lvxBgeN0vpTS0Q/
	 uCx+CgSUT/2+CSo96bcQvTJjgD/F/UebMH6WPgfHl6jJxDZ6/0CBB5axZq4llfZTin
	 1Uofr8ZlZSV8n/AQ0nL9YBBVG0ncZgZ0unI7qayOz2H5u6Pf/0W93bUcvDWVpVUSKT
	 rCB7bxPqHk/l4WxRmvfMojtYcuNAkAiM/CV1GdQ88kjXeIc751Hx5z4tm5J3rfb+n/
	 IkmBLMMlDayKaZXjP7rD6slmCrljAkmYe8lXtvwRmCGQYNDlfr8uAgPisRZJuwN2KB
	 se8n1rWYr4pXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gfs2: fix freeze error handling
Date: Mon, 29 Dec 2025 18:15:51 -0500
Message-ID: <20251229231551.1812844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122907-recount-stoning-1de1@gregkh>
References: <2025122907-recount-stoning-1de1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

[ Upstream commit 4cfc7d5a4a01d2133b278cdbb1371fba1b419174 ]

After commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"),
the freeze error handling is broken because gfs2_do_thaw()
overwrites the 'error' variable, causing incorrect processing
of the original freeze error.

Fix this by calling gfs2_do_thaw() when gfs2_lock_fs_check_clean()
fails but ignoring its return value to preserve the original
freeze error for proper reporting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b77b4a4815a9 ("gfs2: Rework freeze / thaw logic")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[ gfs2_do_thaw() only takes one param ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 49684bc82dc1..d43cac46e1dd 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -776,9 +776,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 		if (!error)
 			break;  /* success */
 
-		error = gfs2_do_thaw(sdp);
-		if (error)
-			goto out;
+		(void)gfs2_do_thaw(sdp);
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
-- 
2.51.0


