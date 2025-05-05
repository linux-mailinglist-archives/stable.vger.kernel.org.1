Return-Path: <stable+bounces-140880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E14AAAF72
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1484A65F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2A3C1961;
	Mon,  5 May 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmVOZK1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DC2F10DB;
	Mon,  5 May 2025 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486707; cv=none; b=LwEwFy3jXgA94Hx27B72BKjnai2YwHVrnn50ynEyc9Bzk00XKzj+CBkN+XsokqV2EIXAfF7KpCgIkPt3U6a2GQpf66pMMt0bzqKbEnvBs2yTwwJsChKbaA1HPWiwYq/I+Z2BELrDSlGzFQu4gtdAg9YFLsEEJ0D0xP/o4+QXpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486707; c=relaxed/simple;
	bh=a6613h/Uw1nhotCwcomUHMU3wWD/6zR8K5kZvjxCPDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1EL5zznp0ZExC96MF+nz2X+Mh7pCYHKOGmwCEQnIpeKJLW71r+aSvE+Lfr9s1gPWykyWZeY5udhHO1EJAuq8AEL1FGQ2FhwF4qRsEOOI8j5gLH4BG8P0QSHQZdldYdKuOboqFVqO709x9jEdJ8MMK6ES3vXVMkpc1s1asRyCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmVOZK1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872FC4CEEF;
	Mon,  5 May 2025 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486706;
	bh=a6613h/Uw1nhotCwcomUHMU3wWD/6zR8K5kZvjxCPDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmVOZK1Si9oiEhrU1T0jWrAxTQdBEg79QYc2YomdqYkTMR6AFgixFrjYGaPUdZmVm
	 fO+JlxDqJyG0H3IiGYcYtpAU6zI8cXjYBc7U/KqGzTAu7dzyu/4AugjIbWo72cGMWO
	 ldyXuqCiNTbcPGwIZgq61+B8JJ4pFI5wwwgg5y40JeqNoqo535fBL95Goh6n3EFIRv
	 NjCC9+foX5+cxKl73zBTiK3bbisTy3k3i0WcGP7Bj93HPxg/iNKbxXyinW6ktl3OSo
	 z8M1zKPfsTt1/ad3F13gZMLkFX7wpxnT2defdEkD+WxlFoWz/rgR/HtHbstqqLvKXH
	 hFUb/M3gUegGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 163/212] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Mon,  5 May 2025 19:05:35 -0400
Message-Id: <20250505230624.2692522-163-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 9aab10a0249eab4ec77c6a5e4f66442610c12a09 ]

The readdir operation iterates over all entries and invokes dir_emit()
for every entry passing kernfs_node::name as argument.
Since the name argument can change, and become invalid, the
kernfs_root::kernfs_rwsem lock should not be dropped to prevent renames
during the operation.

The lock drop around dir_emit() has been initially introduced in commit
   1e5289c97bba2 ("sysfs: Cache the last sysfs_dirent to improve readdir scalability v2")

to avoid holding a global lock during a page fault. The lock drop is
wrong since the support of renames and not a big burden since the lock
is no longer global.

Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
userpace buffer.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-5-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 2c74b24fc22aa..6ddab75a68dd2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1846,10 +1846,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
-- 
2.39.5


