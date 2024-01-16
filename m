Return-Path: <stable+bounces-11151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8BC82E5C9
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD091C226A9
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B236321B6;
	Tue, 16 Jan 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZY23/xR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6789321AE;
	Tue, 16 Jan 2024 00:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634CDC433F1;
	Tue, 16 Jan 2024 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364727;
	bh=oUxM+L9QRSeLHu85ntXBvYiWdvw6hv9Hpkn+f+LuMjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZY23/xRCOrMuZl6lbNN7mbj2z4E6IzMDS21h43QQ3ilNTmPTCHXDJxC52ToLvxFN
	 AlpujI5xI4W50IHjUHfxoWCN3jIdfMgUycWoao9yhEIGKDk3Y26oFuu4ZOV+5cBEOh
	 m3NhxLBdxvuG0Y7d7MO7JYrpAyt+/Hg/AS4LmpRZsGBdmuBzD22VqYrJFNyWdfXlBE
	 i+EbkQnfXbpdK2OgArQTpyFF8bfGXfSgDMngraUcKbxrozjXfI6RcDpISqHzoqkNTW
	 bfvH6d6ubeNDRdFtjcew9/incS2WbVDfJNcEwSs+obDvpU9KXSn3YVutP5xPwgqNuU
	 r/hB+oWITgOyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 05/14] jfs: fix uaf in jfs_evict_inode
Date: Mon, 15 Jan 2024 19:24:47 -0500
Message-ID: <20240116002512.215607-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002512.215607-1-sashal@kernel.org>
References: <20240116002512.215607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit e0e1958f4c365e380b17ccb35617345b31ef7bf3 ]

When the execution of diMount(ipimap) fails, the object ipimap that has been
released may be accessed in diFreeSpecial(). Asynchronous ipimap release occurs
when rcu_core() calls jfs_free_node().

Therefore, when diMount(ipimap) fails, sbi->ipimap should not be initialized as
ipimap.

Reported-and-tested-by: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_mount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 48d1f70f786c..21d8d4a5c67a 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -172,15 +172,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
-- 
2.43.0


