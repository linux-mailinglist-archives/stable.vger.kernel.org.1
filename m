Return-Path: <stable+bounces-11202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0282E648
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 02:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658B31C226DF
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22F61677;
	Tue, 16 Jan 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC2H/EY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD261671;
	Tue, 16 Jan 2024 00:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DC9C43399;
	Tue, 16 Jan 2024 00:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364911;
	bh=FMED2B9qb1JCH2ercG6WTSUNn5g0uZDvocMxdvgI/RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eC2H/EY4q4SXK+bekmqRGdpSlf5aCQkWRWgFn9/clkhPJi3zEK4T8+oYR016y0Q5L
	 GIVfY3v+KmyDZoemjXwJ+8B4Qmmo8ZkpS7V5Y2KNJgwqmuWTNuiFru/CsST1ozsfCw
	 7GKaOuTQxK1pl+ncHK6/0ccbqs9w3+s8dzWJS6etzZhrD63z5EKh3kJdjrsrhvLWDs
	 can4u+X0s0/V7XzA2VnIBuVjSpvPGrwyG8Y2kYFs1/gyC0rjqdK0Z61V8KQKj5snSv
	 UpnUMH2ypv/z3U20H3C85PL4rZ7G8TMpUG+/mzesIBqC22Qx6FFPrEFcxut8MoEFar
	 e62xZzQ0LBgRA==
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
Subject: [PATCH AUTOSEL 4.19 05/12] jfs: fix uaf in jfs_evict_inode
Date: Mon, 15 Jan 2024 19:27:58 -0500
Message-ID: <20240116002817.216837-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002817.216837-1-sashal@kernel.org>
References: <20240116002817.216837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index f1a705d15904..97d91c1686b8 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -184,15 +184,15 @@ int jfs_mount(struct super_block *sb)
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


