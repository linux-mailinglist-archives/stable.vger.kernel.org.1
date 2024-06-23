Return-Path: <stable+bounces-54900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C441913AF8
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70061F219AD
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3283183083;
	Sun, 23 Jun 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4gMYdb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB76183079;
	Sun, 23 Jun 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150257; cv=none; b=Jzunbi7mrQbUPw17keNzUa3a7S8swRzu5kfTMcn8w54L0cgKThcMpEzJr+b2sJ4q0DYEqOJoPHDUTmybF3Xu0bpYZ+CB7iEa3CV2Pt84fAn9VZF3jxoH1G02ZuuZmWsLY06bNTx3+rac0bq3arSbi/F838uwvLl9vWCU9EqJEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150257; c=relaxed/simple;
	bh=dKy6LkwywmysDJSaktBVDJEaAMupduauUN3rMr7hUeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMPyCzfhWQIyn1OU2grZy3zeUuWzuP6v6YQ/9tsD02ageXve3phCg/U1nSVRhhOslirU3fT4Zstl1WjtGd7JoQ4vHupvF8OQVUuj+a8IvIHDAUWt2vOOapQbr/XhBLUGI3xrdjUG+mqR+XBbT3erarQ9XxtgK31UhVqnYmwRb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4gMYdb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B113C32781;
	Sun, 23 Jun 2024 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150257;
	bh=dKy6LkwywmysDJSaktBVDJEaAMupduauUN3rMr7hUeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4gMYdb5Pucm/14851uV5EvIqyHicEgHTCAFexw3NPMHP7izK8mituDp0+gaMEYqi
	 WQwBPRdM+TXT7/eCI4Dl9dn5UuwbISCRQDhWEWcGbeFYaKiS+mVtx/QfLABPuCxAPL
	 BKASt1zo1XJJmQz8ENVqj8O7ORQW1YSe76FcdoNuiL8rpG9PX4kiGmVPfj9jigUfLy
	 PivhMm+EVmPcn85HeEC08G20GaNzWZpKXr69YBklb/weHtrIDLiKb0uZ60ubTcsVJn
	 /DWB9u/PC92ai41SR+EkwAPyO8Z4F9W9UUU9TdDiQCZXVaqxUN3EdnRBJ985ovUjYM
	 T9Ag1pHF5pfNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Hou Tao <houtao1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 07/21] cachefiles: make on-demand read killable
Date: Sun, 23 Jun 2024 09:43:40 -0400
Message-ID: <20240623134405.809025-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit bc9dde6155464e906e630a0a5c17a4cab241ffbb ]

Replacing wait_for_completion() with wait_for_completion_killable() in
cachefiles_ondemand_send_req() allows us to kill processes that might
trigger a hunk_task if the daemon is abnormal.

But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
is initiated from kworker context and the signal is prohibited in these
kworker.

Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
means that a process will complete the current request soon, so wait
again for the request to be completed.

In addition, add the cachefiles_ondemand_finish_req() helper function to
simplify the code.

Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240522114308.2402121-13-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 922cab1a314b2..58bd80956c5a6 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -380,6 +380,20 @@ static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xa
 	return NULL;
 }
 
+static inline bool cachefiles_ondemand_finish_req(struct cachefiles_req *req,
+						  struct xa_state *xas, int err)
+{
+	if (unlikely(!xas || !req))
+		return false;
+
+	if (xa_cmpxchg(xas->xa, xas->xa_index, req, NULL, 0) != req)
+		return false;
+
+	req->error = err;
+	complete(&req->done);
+	return true;
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -443,16 +457,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* Remove error request and CLOSE request has no reply */
-	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
-		xas_reset(&xas);
-		xas_lock(&xas);
-		if (xas_load(&xas) == req) {
-			req->error = ret;
-			complete(&req->done);
-			xas_store(&xas, NULL);
-		}
-		xas_unlock(&xas);
-	}
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE)
+		cachefiles_ondemand_finish_req(req, &xas, ret);
 	cachefiles_req_put(req);
 	return ret ? ret : n;
 }
@@ -544,8 +550,18 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 
 	wake_up_all(&cache->daemon_pollwq);
-	wait_for_completion(&req->done);
-	ret = req->error;
+wait:
+	ret = wait_for_completion_killable(&req->done);
+	if (!ret) {
+		ret = req->error;
+	} else {
+		ret = -EINTR;
+		if (!cachefiles_ondemand_finish_req(req, &xas, ret)) {
+			/* Someone will complete it soon. */
+			cpu_relax();
+			goto wait;
+		}
+	}
 	cachefiles_req_put(req);
 	return ret;
 out:
-- 
2.43.0


