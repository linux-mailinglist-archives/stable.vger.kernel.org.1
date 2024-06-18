Return-Path: <stable+bounces-53499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CBC90D20B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33522839B1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1131AB509;
	Tue, 18 Jun 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dt6iwGca"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7815B55B;
	Tue, 18 Jun 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716511; cv=none; b=Hi4ky0mt/UL/zTXibubd1ShkngLfutGMemebkMRoobE1XVQecShXTNVk15yc6QPSOJNbqrsxX+hn6V34z8kqZZtfiP5LniQBYKS0IOK0ATvh+IV2Wh7C+aS0Aw9lkT/ckyc3oiai+BqeuCJmAmT5yL7t9av1nfJoADjhl9I6bXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716511; c=relaxed/simple;
	bh=LOMOneXdhvUXH0PFN7144YI6DXHHkfE4131+1HRGbVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+mhxs7ih05JAoh0WlKW+IU0eSXByKrsdItyN4kD4PvmQEMonE9VBiUXUtaJnLBnG3IUNmu/pqLGHTqJRKqNIDV0cOLpuKq3hq7UOrU28W+OIYGo87HXHhgsYpFu0Lrj9QLaQTvsKwb469hPzOl/ixC+MPIHgfqgU+KBo+ExseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dt6iwGca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E94C3277B;
	Tue, 18 Jun 2024 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716511;
	bh=LOMOneXdhvUXH0PFN7144YI6DXHHkfE4131+1HRGbVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt6iwGcaFthAoD7B13YgBN0eJksOeacPFOBkNjQPq4SUNvDeP2yG8e6s92k6TLZ/G
	 oQ5vrM/yJBafPt6z+vIOgvrzckoUeSPrK8vtND5t/uS7EOFvL5OqIBHTQpC4pbNbY3
	 +VJ9E3PKnWfhVB5V8n3FBZx3QMw4f3cXtshpXwj8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bobrowski <repnop@google.com>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 669/770] fs/notify: constify path
Date: Tue, 18 Jun 2024 14:38:42 +0200
Message-ID: <20240618123433.106169953@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit d5bf88895f24686641c39420ee6df716dc1d95d8 ]

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c      | 2 +-
 fs/notify/fanotify/fanotify.h      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index cd7d09a569fff..a2a15bc4df280 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -18,7 +18,7 @@
 
 #include "fanotify.h"
 
-static bool fanotify_path_equal(struct path *p1, struct path *p2)
+static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
 {
 	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
 }
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 1d9f11255c64f..bf6d4d38afa04 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -458,7 +458,7 @@ static inline bool fanotify_event_has_path(struct fanotify_event *event)
 		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
 }
 
-static inline struct path *fanotify_event_path(struct fanotify_event *event)
+static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
 		return &FANOTIFY_PE(event)->path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 72dd446606a78..5302313f28bed 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -237,7 +237,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	return event;
 }
 
-static int create_fd(struct fsnotify_group *group, struct path *path,
+static int create_fd(struct fsnotify_group *group, const struct path *path,
 		     struct file **file)
 {
 	int client_fd;
@@ -607,7 +607,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  char __user *buf, size_t count)
 {
 	struct fanotify_event_metadata metadata;
-	struct path *path = fanotify_event_path(event);
+	const struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
@@ -1541,7 +1541,7 @@ static int fanotify_test_fid(struct dentry *dentry)
 }
 
 static int fanotify_events_supported(struct fsnotify_group *group,
-				     struct path *path, __u64 mask,
+				     const struct path *path, __u64 mask,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-- 
2.43.0




