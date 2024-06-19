Return-Path: <stable+bounces-54518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3190EE9D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B9C2864E6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FF14A62A;
	Wed, 19 Jun 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fd6fdu+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7771422B8;
	Wed, 19 Jun 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803816; cv=none; b=DPTZUAJPJnIuYuGmdTrWFo7m3EAseXUjlQP/YwGr+wmvnBaEBbkAr0DgSbd2QJVZg9rXnGttrfoIOIWLdvMLccF4Y7IYKHfYa5MSa0Nyxu/+flCzYgHajgfjf0Zt1nNLK3BOpuRfJxDhXbHbJjoWL045f/SNUIoN5a3c45ib/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803816; c=relaxed/simple;
	bh=wrf27eKRl1XyH6njOwS2yF5DO9VsSXzBzw5sXeC72is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhYaGSFI/8crkI8Cw1CuYV3nGEY4S/fAxgqKkGC568D7EDT1/e5sQpm0B6eckiXqpfpyxLWLMCb5scGtECpoZPENnY+Xb/S+S68ZzOw9nvhg3vNZpo0/bP8jmgZUR7alhr0GELi18RUNKXegvmwDK+38i4cGZnJWS7so078xFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fd6fdu+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11061C2BBFC;
	Wed, 19 Jun 2024 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803816;
	bh=wrf27eKRl1XyH6njOwS2yF5DO9VsSXzBzw5sXeC72is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fd6fdu+rRys4SBNZ1ccm+SxqkzZFB8n86dryovNmcz4wEWs+/z5lpUoIpLZMAcEV6
	 faGqUsvmrmz5ZBh86iwh7U89q7/AZc+p/nLl2y2HJkEduSByjF5/eg+0w5ajCieWPb
	 t3WZFquywkx4sUWEwoUZbbiUnyA++u368ulTJWA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/217] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
Date: Wed, 19 Jun 2024 14:55:57 +0200
Message-ID: <20240619125601.087169557@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 3e6d704f02aa4c50c7bc5fe91a4401df249a137b ]

The err_put_fd label is only used once, so remove it to make the code
more readable. In addition, the logic for deleting error request and
CLOSE request is merged to simplify the code.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240522114308.2402121-6-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 4b4391e77a6b ("cachefiles: defer exposing anon_fd until after copy_to_user() succeeds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 45 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index fd73811c7ce4f..99b4bffad4a4f 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -337,7 +337,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
-	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
@@ -372,49 +371,37 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
-	id = xas.xa_index;
-
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
 		if (ret) {
 			cachefiles_ondemand_set_object_close(req->object);
-			goto error;
+			goto out;
 		}
 	}
 
-	msg->msg_id = id;
+	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
-		goto err_put_fd;
-	}
-
-	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	/* CLOSE request has no reply */
-	if (msg->opcode == CACHEFILES_OP_CLOSE) {
-		xa_erase(&cache->reqs, id);
-		complete(&req->done);
+		if (msg->opcode == CACHEFILES_OP_OPEN)
+			close_fd(((struct cachefiles_open *)msg->data)->fd);
 	}
-
-	cachefiles_req_put(req);
-	return n;
-
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
-error:
+out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	xas_reset(&xas);
-	xas_lock(&xas);
-	if (xas_load(&xas) == req) {
-		req->error = ret;
-		complete(&req->done);
-		xas_store(&xas, NULL);
+	/* Remove error request and CLOSE request has no reply */
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			req->error = ret;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+		xas_unlock(&xas);
 	}
-	xas_unlock(&xas);
 	cachefiles_req_put(req);
-	return ret;
+	return ret ? ret : n;
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
-- 
2.43.0




