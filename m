Return-Path: <stable+bounces-75498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227299735C8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36230B2D6C0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD317A589;
	Tue, 10 Sep 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2fB+BD8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235018C324;
	Tue, 10 Sep 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964910; cv=none; b=ULhxvgXUJoVJQ0seqmqf9SbLJhEd0rxx97UGjdnh9gysAX2+D5GCebiRfHTRkY5fcR3GeCaqElruHuVIa0uqrjFp1coGp8bV0J6B34ArSum5YmpMrHSRO7f5ZsV1omB+K/8lS1WN0dKnEd++L/7LljcT2BjMAm79owSq4C8acLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964910; c=relaxed/simple;
	bh=u+ZZsCYjbnev4FrP/fkpBsCw75orOCOG8cJ1LzJEUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHnPHJUfTZ3vHYWIJ9OElDHaCrEWHDEqDzKmdKpN63ZXOGRKGcxuDNg6Ivv9mzNEUYwZF9S0NAb/jWRQH+Rl0pTqIVQoRXGS+mBIiXN1lBpNb6anTEK6LBklLHKG3A3VH6WfK75Z6B3SQZ7xXzW/6dOI2JqFHSUKV7kQ/o+73vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fB+BD8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12D7C4CEC3;
	Tue, 10 Sep 2024 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964910;
	bh=u+ZZsCYjbnev4FrP/fkpBsCw75orOCOG8cJ1LzJEUXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2fB+BD8HhEBD1psHDde3o7AjPsS4881gROamRa/EnLOHMtdHIAr4wCakN3sr/5hfK
	 bpV0kq2zKNWNbQt1vk/iPcIJwvVHeubQHyifUnh9CQ8tQKa5MPrPnixeeJ6dzUIbcX
	 hcSRZlsHhay1YwVSmKR01WruYI49Y8xTApP9yhMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 073/186] nilfs2: fix missing cleanup on rollforward recovery error
Date: Tue, 10 Sep 2024 11:32:48 +0200
Message-ID: <20240910092557.533639494@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 5787fcaab9eb5930f5378d6a1dd03d916d146622 upstream.

In an error injection test of a routine for mount-time recovery, KASAN
found a use-after-free bug.

It turned out that if data recovery was performed using partial logs
created by dsync writes, but an error occurred before starting the log
writer to create a recovered checkpoint, the inodes whose data had been
recovered were left in the ns_dirty_files list of the nilfs object and
were not freed.

Fix this issue by cleaning up inodes that have read the recovery data if
the recovery routine fails midway before the log writer starts.

Link: https://lkml.kernel.org/r/20240810065242.3701-1-konishi.ryusuke@gmail.com
Fixes: 0f3e1c7f23f8 ("nilfs2: recovery functions")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/recovery.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -709,6 +709,33 @@ static void nilfs_finish_roll_forward(st
 }
 
 /**
+ * nilfs_abort_roll_forward - cleaning up after a failed rollforward recovery
+ * @nilfs: nilfs object
+ */
+static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
+{
+	struct nilfs_inode_info *ii, *n;
+	LIST_HEAD(head);
+
+	/* Abandon inodes that have read recovery data */
+	spin_lock(&nilfs->ns_inode_lock);
+	list_splice_init(&nilfs->ns_dirty_files, &head);
+	spin_unlock(&nilfs->ns_inode_lock);
+	if (list_empty(&head))
+		return;
+
+	set_nilfs_purging(nilfs);
+	list_for_each_entry_safe(ii, n, &head, i_dirty) {
+		spin_lock(&nilfs->ns_inode_lock);
+		list_del_init(&ii->i_dirty);
+		spin_unlock(&nilfs->ns_inode_lock);
+
+		iput(&ii->vfs_inode);
+	}
+	clear_nilfs_purging(nilfs);
+}
+
+/**
  * nilfs_salvage_orphan_logs - salvage logs written after the latest checkpoint
  * @nilfs: nilfs object
  * @sb: super block instance
@@ -766,15 +793,19 @@ int nilfs_salvage_orphan_logs(struct the
 		if (unlikely(err)) {
 			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
-			goto failed;
+			goto put_root;
 		}
 
 		nilfs_finish_roll_forward(nilfs, ri);
 	}
 
- failed:
+put_root:
 	nilfs_put_root(root);
 	return err;
+
+failed:
+	nilfs_abort_roll_forward(nilfs);
+	goto put_root;
 }
 
 /**



