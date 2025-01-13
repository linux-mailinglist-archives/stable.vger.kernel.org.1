Return-Path: <stable+bounces-108494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59799A0C031
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88443A70B5
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716A1FBEAD;
	Mon, 13 Jan 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxi21eIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380E1FC0F4;
	Mon, 13 Jan 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793325; cv=none; b=dyxDn7bhxT9qyy77OD71BFJ56aWMLArdkEP/K2I251SpqBCg1+Iu/5iQATE2vnokPQL0UmmUlEFODB45XMrHcWXH60yKSUK4xI+1kXoF81p5ciY37ogg2dwHbOLmAcGAs9FXW9W7dh2KWzkgX3xoi2XTlHNaT4qnCE+WItrNymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793325; c=relaxed/simple;
	bh=BE+Y0XSeW8eoYlbqAzwQnaajnEIJVDMT7DuCgIXfWHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3HJzN9cREa2WrARHKcZyd6W61BckSac0ffMO0PJiRYFWF6YohfArHQRbJHfRHzMOauexODCeKKyBtxoEt2IvZxEHHlltco78OFSt2l0irVsJhNkS8kkJllhe6pUHh/Les/nNFnQ1tmwoIv1XxLk6OsoT5p7ovWDgIiTr8d06XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxi21eIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC8DC4CED6;
	Mon, 13 Jan 2025 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793325;
	bh=BE+Y0XSeW8eoYlbqAzwQnaajnEIJVDMT7DuCgIXfWHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yxi21eIWhZhuF2n/fNVmsvGVikEqtRje+UAT1m/cLCfiaOvxKR2IH0uvh+Eblp0DY
	 owHRxOS4Z9eNHbxaEfqRLvgG9mO5U4qmjwKfZDBlLcQW4LBBf5UyiNyKlBe491YMlV
	 DQoR6KU57hP1tNOpKhRr4XCz/v5rOBSyFZpk1SA1w6Xu2k3uEW9gSGFBcF1jTQHihq
	 ullndUzwM8M96cB0gP7LFbIf4zESEw/HYcpAssk2spSVYbkk8mCeHFfO2yVYyLcbko
	 SFYox8YKz08Xj1ClJjX4IpXu05JScYUTzizIiDwGOB2MHXPjeq/5mcfjVbzeFgcteg
	 wAO/G8L9V//ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 05/10] cachefiles: Parse the "secctx" immediately
Date: Mon, 13 Jan 2025 13:35:06 -0500
Message-Id: <20250113183511.1783990-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
Content-Transfer-Encoding: 8bit

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
index 89b11336a836..1806bff8e59b 100644
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
index 111ad6ecd4ba..4421a12960a6 100644
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
index fe777164f1d8..fc6611886b3b 100644
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


