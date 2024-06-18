Return-Path: <stable+bounces-53369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102390D15B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D801F25658
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB531A00DC;
	Tue, 18 Jun 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3RQMWba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD91158A12;
	Tue, 18 Jun 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716121; cv=none; b=QiYX3thQjC+wNGcNhw6ej+KGFxIALnbCEUatQNC6GUlVhcC5+5LNCXEr/7mdWoruc+n3+jg7RCCmE27A9HMSsIMjODSztqGYLQnV8lBHXR4wnobc06np5HL5s/QQhvEKLKPILrnAzsc2We8Rp/gM/2KCVlnwPYmeJqkfYvaiyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716121; c=relaxed/simple;
	bh=eC4/4R3g9oUalFkICgubXedadzlCXNmhNEdBTty2s4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEpqGiOqpUdIgWLDMv0jtG1NefvRkLElBC8/AHMifVyr3g6QFi0QT9Oa9EROU5Qrjg7acBfRFymOYYohVQzQgCxDIwJT3Jcc0DSxUbYU8D37e/RW8f4UOzkWfXBWPZd5BFcYcH5ApK0LHBnqFY8HCwsrFiCjKFdV+K2VEOaGy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3RQMWba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70750C3277B;
	Tue, 18 Jun 2024 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716120;
	bh=eC4/4R3g9oUalFkICgubXedadzlCXNmhNEdBTty2s4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3RQMWbay2IuCjqSMj3xF7A4qkZfvzOXGP2IHCzqfCRTesI7vihtUeykNrb/3WD3M
	 ueLyUqcg2PaDJ5DDrZz9OdCiDhdKU/4xiVUFxJe2DTBsiATG+FmeT3WEggw3s2XZKZ
	 DVSCV4CtQ5veVLCoMyImTFWUfCfFwqRcZQvweuIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 539/770] fanotify: refine the validation checks on non-dir inode mask
Date: Tue, 18 Jun 2024 14:36:32 +0200
Message-ID: <20240618123428.116065280@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 8698e3bab4dd7968666e84e111d0bfd17c040e77 ]

Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
mask of non-dir") added restrictions about setting dirent events in the
mask of a non-dir inode mark, which does not make any sense.

For backward compatibility, these restictions were added only to new
(v5.17+) APIs.

It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
dir-only restriction of the new APIs as well.

Move the check of the dir-only flags for new APIs into the helper
fanotify_events_supported(), which is only called for FAN_MARK_ADD,
because there is no need to error on an attempt to remove the dir-only
flags from non-dir inode.

Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
Link: https://lore.kernel.org/r/20220627174719.2838175-1-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[ cel: adjusted to apply to v5.10.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 30 +++++++++++++++---------------
 include/linux/fanotify.h           |  4 ++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f4a5e9074dd42..990464e00aec7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1501,10 +1501,14 @@ static int fanotify_test_fid(struct dentry *dentry)
 	return 0;
 }
 
-static int fanotify_events_supported(struct path *path, __u64 mask,
+static int fanotify_events_supported(struct fsnotify_group *group,
+				     struct path *path, __u64 mask,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
+	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
+				 (mask & FAN_RENAME);
 
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
@@ -1532,6 +1536,15 @@ static int fanotify_events_supported(struct path *path, __u64 mask,
 	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
 		return -EINVAL;
 
+	/*
+	 * We shouldn't have allowed setting dirent events and the directory
+	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
+	 * but because we always allowed it, error only when using new APIs.
+	 */
+	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
+	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+		return -ENOTDIR;
+
 	return 0;
 }
 
@@ -1678,7 +1691,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask, flags);
+		ret = fanotify_events_supported(group, &path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
@@ -1701,19 +1714,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
-	/*
-	 * FAN_RENAME is not allowed on non-dir (for now).
-	 * We shouldn't have allowed setting any dirent events in mask of
-	 * non-dir, but because we always allowed it, error only if group
-	 * was initialized with the new flag FAN_REPORT_TARGET_FID.
-	 */
-	ret = -ENOTDIR;
-	if (inode && !S_ISDIR(inode->i_mode) &&
-	    ((mask & FAN_RENAME) ||
-	     ((mask & FANOTIFY_DIRENT_EVENTS) &&
-	      FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID))))
-		goto path_put_and_out;
-
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 81f45061c1b18..4f6cbe6c6e235 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -113,6 +113,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 					 FANOTIFY_PERM_EVENTS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
+/* Events and flags relevant only for directories */
+#define FANOTIFY_DIRONLY_EVENT_BITS	(FANOTIFY_DIRENT_EVENTS | \
+					 FAN_EVENT_ON_CHILD | FAN_ONDIR)
+
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
-- 
2.43.0




