Return-Path: <stable+bounces-141414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388FAAB33A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297D016984C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217422A4CB;
	Tue,  6 May 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyFmGbu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592628137B;
	Mon,  5 May 2025 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486212; cv=none; b=UprO3Ay0M6mD06ljGUjStAXZwWItcY0O/V4DX3VmEbBKDdAkK1/CqcNNAQy1YMk0/n5hqUQ1kpn0/zcUBKD38hfZ0ak2hCXl9DHe6CtQoTbo/LYLVcCqmi1O7a0RclhLLGFmJtCi18jqO34NzYADskO9AygrEulSEcXBun5R4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486212; c=relaxed/simple;
	bh=6RLmdhexPakcH2SycFVi5S8OZcX659nMSVKrz0xcr9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZtJVAUjym/GH95cxfHYTazNsYwI3YKGvsEhIzpd/E3qNorWfgWQECtb/gCAK5UtNJPq3H2p/YREdN4xORwETx4yZEbpQJNDbPMnocDOShr5/VLjGKWybgmnuSdyot8VRbjUR+Hyk2E9BTMm1NbqGEVhAzZxCo5DtxwpWtE8MkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyFmGbu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DCC4CEE4;
	Mon,  5 May 2025 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486212;
	bh=6RLmdhexPakcH2SycFVi5S8OZcX659nMSVKrz0xcr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyFmGbu42FUivSx+B1Uxn1nTRYFTP2ecKNKwT+YnrO4TaXXu08Mwot1ItFBHe68dP
	 H4DMYNJd9LBGUIefH4pvTj6CAw2+qlcHm4hoEDWy7XBA8rkrJWEx8GK5j3adUM89GU
	 c1oR7NzuW45xJvdr0RhZ560Tim9f6AmosUoSpQ/BFOgaylp4I4RTV/T8OZRMeMe9tr
	 UXwIKEGA4xBAp8ZTrVLxP3FUA/blXmTICWb+Cunpwv23zJlZaXNwhtmLkHTRljTP/V
	 cA+3U+MCSYWbyAIKBY1BFXPMT2dvv4GrGHM6SfyvFwaUkMsSoWuuEzzzSM6ILEK31V
	 fxu4/6Ca43rIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 210/294] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Mon,  5 May 2025 18:55:10 -0400
Message-Id: <20250505225634.2688578-210-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 400188ae361a9d9a72a47a6cedaf2d2efcc84aa8 ]

kernfs_notify_workfn() dereferences kernfs_node::name and passes it
later to fsnotify(). If the node is renamed then the previously observed
name pointer becomes invalid.

Acquire kernfs_root::kernfs_rwsem to block renames of the node.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-2-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 332d08d2fe0d5..501502cd5194e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -926,6 +926,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 
 	down_read(&root->kernfs_supers_rwsem);
+	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -962,6 +963,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
+	up_read(&root->kernfs_rwsem);
 	up_read(&root->kernfs_supers_rwsem);
 	kernfs_put(kn);
 	goto repeat;
-- 
2.39.5


