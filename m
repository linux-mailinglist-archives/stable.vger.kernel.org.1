Return-Path: <stable+bounces-109766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD457A183D0
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4EA16C471
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69751F55F7;
	Tue, 21 Jan 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVvcUzsL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316F1F7071;
	Tue, 21 Jan 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482376; cv=none; b=vCTsydu93N4VRJYO9rwsT+xa1gPs+OnPpVJI46Qik85Oy8suSaiG/ENiQUuKCrMfg4+j76iD0AKn7Fb0gKgAWfVyYZv3fLnt8IafgQbqKiwwJ/RBZ/ZTRsCzhxHu2EHRfoU4S6HMLOgWGsNvR6veT7PluUqn6Whh/Mc4y3OPnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482376; c=relaxed/simple;
	bh=YDPWKXu6piHgKTp4Rl+1OUnHF9jtJekDjuNJwa8sJ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C78kBOjDBf4LEPPLbHVbwXag6j8fQPWhK1/t9aAaRA+1uVjbIu0v1mVOcp3+RzAI27kv1y7A3u9snVif0hbrb7hmVWDCto+9WUTnxujMlL4aGBsE463gfABrw9g7EgytulfQ+mfgqrne25OpB27WDL79yjLzxSDhUKfn2IBFDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVvcUzsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E43C4CEE0;
	Tue, 21 Jan 2025 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482376;
	bh=YDPWKXu6piHgKTp4Rl+1OUnHF9jtJekDjuNJwa8sJ2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVvcUzsLHMvCRb0lxonkvS3+0w91MhRXXDDql2U9JzhiwvnaK+QYsQabtzZfUqUfZ
	 aYz5i7iPcaTZeDVYGOyQEDc55kPayn6+1b5NZcbs2SlNFEY779F+MDQKdT++iO5eNl
	 O1y3vduRE8rXyZPOaJPurA5YY1GuKv/Urhni71/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 055/122] cachefiles: Parse the "secctx" immediately
Date: Tue, 21 Jan 2025 18:51:43 +0100
Message-ID: <20250121174535.110466886@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit e5a8b6446c0d370716f193771ccacf3260a57534 ]

Instead of storing an opaque string, call security_secctx_to_secid()
right in the "secctx" command handler and store only the numeric
"secid".  This eliminates an unnecessary string allocation and allows
the daemon to receive errors when writing the "secctx" command instead
of postponing the error to the "bind" command handler.  For example,
if the kernel was built without `CONFIG_SECURITY`, "bind" will return
`EOPNOTSUPP`, but the daemon doesn't know why.  With this patch, the
"secctx" will instead return `EOPNOTSUPP` which is the right context
for this error.

This patch adds a boolean flag `have_secid` because I'm not sure if we
can safely assume that zero is the special secid value for "not set".
This appears to be true for SELinux, Smack and AppArmor, but since
this attribute is not documented, I'm unable to derive a stable
guarantee for that.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241209141554.638708-1-max.kellermann@ionos.com/
Link: https://lore.kernel.org/r/20241213135013.2964079-6-dhowells@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/daemon.c   | 14 +++++++-------
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a8369..1806bff8e59bc 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -576,7 +577,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 {
-	char *secctx;
+	int err;
 
 	_enter(",%s", args);
 
@@ -585,16 +586,16 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 		return -EINVAL;
 	}
 
-	if (cache->secctx) {
+	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
 		return -EINVAL;
 	}
 
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
+	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
+	if (err)
+		return err;
 
-	cache->secctx = secctx;
+	cache->have_secid = true;
 	return 0;
 }
 
@@ -820,7 +821,6 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
-	kfree(cache->secctx);
 	kfree(cache->tag);
 
 	_leave("");
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7b99bd98de75b..38c236e38cef8 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -122,7 +122,6 @@ struct cachefiles_cache {
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
 #define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
@@ -130,6 +129,8 @@ struct cachefiles_cache {
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 	u32				msg_id_next;
+	u32				secid;		/* LSM security id */
+	bool				have_secid;	/* whether "secid" was set */
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d89..fc6611886b3b5 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -18,7 +18,7 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 	struct cred *new;
 	int ret;
 
-	_enter("{%s}", cache->secctx);
+	_enter("{%u}", cache->have_secid ? cache->secid : 0);
 
 	new = prepare_kernel_cred(current);
 	if (!new) {
@@ -26,8 +26,8 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 		goto error;
 	}
 
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
+	if (cache->have_secid) {
+		ret = set_security_override(new, cache->secid);
 		if (ret < 0) {
 			put_cred(new);
 			pr_err("Security denies permission to nominate security context: error %d\n",
-- 
2.39.5




