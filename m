Return-Path: <stable+bounces-3963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2B803FEF
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F67B20BB7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB69364A5;
	Mon,  4 Dec 2023 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR9nf3iM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C235F1A
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEA4C433C9;
	Mon,  4 Dec 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722200;
	bh=U+iK74xp5oPTmNBNFab4RWt4NmvEWLcTGvd+AOgvVN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hR9nf3iMQeLLXCSceIVbrEMvfxL2HnmDgxxDejSSNhaJXsyyxuKId2qhKpEhdR7Kq
	 x4J6Gl742A/4CocMqXITh2H9f6A83fc4eHPb8r+AsFg7KnJJoS39pX70jHxkguYY+o
	 4OaQbL/RM9+GFaNW7g5t7XNGIB7+A04V/+DLBQopx6ngb7iGB4bd3uFqs8fCIHeQIT
	 5Mhp0d8e+EdEvNP69tcstwCyTnEHlH5vQ9Xr1wUU2BkkEoeVCLBK7HNNPw7sIqIutF
	 ymTkaoWwSXaTxLB3TOM19ClgcBTAsPqo2IJYz5++fG1tXYLnCtsJzbtyEzGuKXE5qf
	 FPpvOAuaneBkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 07/10] debugfs: annotate debugfs handlers vs. removal with lockdep
Date: Mon,  4 Dec 2023 15:36:04 -0500
Message-ID: <20231204203616.2094529-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f4acfcd4deb158b96595250cc332901b282d15b0 ]

When you take a lock in a debugfs handler but also try
to remove the debugfs file under that lock, things can
deadlock since the removal has to wait for all users
to finish.

Add lockdep annotations in debugfs_file_get()/_put()
to catch such issues.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c     | 10 ++++++++++
 fs/debugfs/inode.c    | 12 ++++++++++++
 fs/debugfs/internal.h |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index df5c2162e7297..a1aea4d1637c7 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -108,6 +108,12 @@ int debugfs_file_get(struct dentry *dentry)
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
+#ifdef CONFIG_LOCKDEP
+		fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
+		lockdep_register_key(&fsd->key);
+		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
+				 &fsd->key, 0);
+#endif
 	}
 
 	/*
@@ -124,6 +130,8 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!refcount_inc_not_zero(&fsd->active_users))
 		return -EIO;
 
+	lock_map_acquire_read(&fsd->lockdep_map);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debugfs_file_get);
@@ -141,6 +149,8 @@ void debugfs_file_put(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = READ_ONCE(dentry->d_fsdata);
 
+	lock_map_release(&fsd->lockdep_map);
+
 	if (refcount_dec_and_test(&fsd->active_users))
 		complete(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 5290a721a703f..014ff204548d9 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -219,6 +219,14 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
+	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
+	if (fsd && fsd->real_fops) {
+#ifdef CONFIG_LOCKDEP
+		lockdep_unregister_key(&fsd->key);
+		kfree(fsd->lock_name);
+#endif
+	}
+
 	kfree(fsd);
 }
 
@@ -712,6 +720,10 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	fsd = READ_ONCE(dentry->d_fsdata);
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
+
+	lock_map_acquire(&fsd->lockdep_map);
+	lock_map_release(&fsd->lockdep_map);
+
 	if (!refcount_dec_and_test(&fsd->active_users))
 		wait_for_completion(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f7c489b5a368c..c7d61cfc97d26 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,6 +7,7 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
+#include <linux/lockdep.h>
 
 struct file_operations;
 
@@ -23,6 +24,11 @@ struct debugfs_fsdata {
 		struct {
 			refcount_t active_users;
 			struct completion active_users_drained;
+#ifdef CONFIG_LOCKDEP
+			struct lockdep_map lockdep_map;
+			struct lock_class_key key;
+			char *lock_name;
+#endif
 		};
 	};
 };
-- 
2.42.0


