Return-Path: <stable+bounces-140174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B5AAA5E4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEF43A5CD7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1910318A34;
	Mon,  5 May 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/42sIhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C9318A2B;
	Mon,  5 May 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484272; cv=none; b=R966kdCkZdN6z/whTFqHZB8eH9r0Rj4vV9uoJw11Ud48fwE/hpGIsCnUUp23Dp/sniFyMrMyAX0WLe7XtDNzuK7vatuoYnLocorTb2WBWD69/v6QA806kARCrpQ26xr/ryRNVFOrhqxaOnmnoegG4f4WPNDQZ5+G24Zr23pXo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484272; c=relaxed/simple;
	bh=0HowdxVneWlmuUt/Ri7ssXNL86GZJ/vpP0ibY5TqlxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC/WQWOqqJH6lITUip6qi76ia+flUJbIPUQ2DgDwQGQ96vbn0UU530FvShxGBTfCQeDDbrNFYrOeJeipyWtEmzzowbDsWNh0fzAv+2JobNaKEyw8xW+R/LdZU3+K6pyrPTogpiPi7TEa2wTARnRXy4biXfP1EjERP2xhqlVcQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/42sIhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83E8C4CEEF;
	Mon,  5 May 2025 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484272;
	bh=0HowdxVneWlmuUt/Ri7ssXNL86GZJ/vpP0ibY5TqlxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/42sIhETERFMJvU2RY5wjkA7flfaova/GphzztBq6c3Un3RzZweUeCdf/Tyt2O4C
	 Fo7V4W/2oN2GsI3mC9MTtq/szxu9EYfR3eIkipLo/KHwZ8NBJLiZPGm1S+TYbBJywi
	 svEv23aNAvJTVAfx1zeT6eoRHXpdGo6Eoi+K6jBHYI/YpWEgD3TveHwu6jYpY1PSGA
	 OXD3y6Ypojh6F0LPVbcyH1bdND2prGlFRV0I42xA3m2dVl3C/mm6AXw5b0hT3+zPll
	 7t4QpYDpt5lus5FkVElcp/mOmkHp6WLSIEipNIQRHG3It3081nbuJHsD1AIz8Wv0Sz
	 FZ9QO3bOVQJHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 427/642] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Mon,  5 May 2025 18:10:43 -0400
Message-Id: <20250505221419.2672473-427-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 0eb320617d7b1..c4ffa8dc89ebc 100644
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


