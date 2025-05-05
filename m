Return-Path: <stable+bounces-141206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B7AAB641
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0449B7BD4B0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25A3F9429;
	Tue,  6 May 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB3eephT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6452D113E;
	Mon,  5 May 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485481; cv=none; b=ZFVuDEn2H4Hf96jegDcu34z7kNRVrHGwQ8o3N5r0l8nQFvij7OrPVBnmM+cBGnUuvuBZK1YEVgUOmzIvmLWhiWEXQIdutMTF9s+Sy4ovffu7OJCkcuPnBOyBBbN+VdgBKnEY9hcEUAgXHdyqRTjX4nvqm6KGjL9Hpg05V35zeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485481; c=relaxed/simple;
	bh=EYtw+AqDkKNk3Q+svkTmH4GW2t5HIn0ZPOM17SE5M+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dAvW52bpPylkcb3Z2z7NIrZtDp7p/idfTAKMOQY7V443etx9LimNO/aHGBt3n2RM/nNpKDul4pZLMY+jZ9mdHrJdU+4ufv6xnyf1fObUgSei+FBjt9AyXWRBx8Q8huSIuSXN9j5Vcr8KjtL+hTe+/cVZGzZxgOkzyo/YNqTNJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB3eephT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5589C4CEED;
	Mon,  5 May 2025 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485481;
	bh=EYtw+AqDkKNk3Q+svkTmH4GW2t5HIn0ZPOM17SE5M+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QB3eephTGMUruI0WwtSsGzDNodf7ljwwdQParJO2bx9efWlHumfzIYLTlt2q+NqFx
	 M+YbZf9CsQzmFv5z8S6lWg0jsOlVIyNeS8Nv3dT1DpMpkp6RjGTP6y6MQuyO938v2t
	 eioluhzi5GP3NFMezqrlq875tjsBmJFzRTyL6fYnZFg18S5LZdO+SZzsxRj6huJsiA
	 NmR//l53IH/pLnXehoNmusLn5ZLNxex9gly/KoyPR/UdOu81xqItm6qUyiVkuQMiHc
	 xnN/Rj5ojXfnkgHMAmTeb6zyQHRN26EYJC+z9LHkUiSOEgGe8PEw2O/Dm4pqJhkThH
	 De3a5eVrSAD3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 338/486] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Mon,  5 May 2025 18:36:54 -0400
Message-Id: <20250505223922.2682012-338-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 8502ef68459b9..165d8e37976ba 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,6 +911,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 
 	down_read(&root->kernfs_supers_rwsem);
+	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -947,6 +948,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
+	up_read(&root->kernfs_rwsem);
 	up_read(&root->kernfs_supers_rwsem);
 	kernfs_put(kn);
 	goto repeat;
-- 
2.39.5


