Return-Path: <stable+bounces-54899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E59913AF3
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FE3B211A7
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D859183065;
	Sun, 23 Jun 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRlNJywl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FC1822FC;
	Sun, 23 Jun 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150255; cv=none; b=gep32/vsEYZmu6p5AfJVj4SZf/rXB8Hp5UboX8Ghg7YBfDJUwY8zFiAavzt+xCI2UwB4Knlnqo6m0lhyvPFkCS/N2xgsrgJNYUb5Qz5hCYTg51AODOnMTJ7VsKQH7pF5V5OAGAlJM2P6ILkJqIz1cNngejXWYPmkRXhE7Ty0KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150255; c=relaxed/simple;
	bh=nOudGRl+mb68MsHONBxOVOD6JeJsjsiddcuRzbkffMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2zCSPjkdODKkFIJymon1zRtkUGrBupC9JbJqrEgLePk0YwYm1uNUjVnImQ3T6q2JXhc6C+QWefr8Gx88I1ynDzpzsufrwLgGgLqG6DTwZYNGNlm6fyrT677H+r3Q6SlCy8Gdmzzj17JsN6zfivrOLXZwUgNdon5k84D2OJzz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRlNJywl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91391C32781;
	Sun, 23 Jun 2024 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150255;
	bh=nOudGRl+mb68MsHONBxOVOD6JeJsjsiddcuRzbkffMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRlNJywlNyc327ArgeUDmku5Lya5Cq4gTSJii0CU+DVyuJs8aUFtn+askG/bM3fzP
	 HDcnQdM2XJXa9Sf8KwoHJPiI0Nt2O6fM1UNZWtItEHYrdbN79rjClicsBb8HbbEg/N
	 eSu9THhvVuvVfJ8ncbztUpCVXhBJ51ntn7tHdUFaym9beETMvwEJflgrw8dALPInli
	 rQHf6xloMThIpzQGovzk0nYEHoyl9Eyic8RDkW7Da79NYY1pWN++3SsxG2Z5OfHDrp
	 8fOCirps57YouxpHuzui+gcjk0AfIe9RYD6OaS0IP+pWX/bXkNx4GtSeCYdGBuTvUb
	 3vzmdM5gLzFAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zizhi Wo <wozizhi@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 06/21] cachefiles: Set object to close if ondemand_id < 0 in copen
Date: Sun, 23 Jun 2024 09:43:39 -0400
Message-ID: <20240623134405.809025-6-sashal@kernel.org>
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

From: Zizhi Wo <wozizhi@huawei.com>

[ Upstream commit 4f8703fb3482f92edcfd31661857b16fec89c2c0 ]

If copen is maliciously called in the user mode, it may delete the request
corresponding to the random id. And the request may have not been read yet.

Note that when the object is set to reopen, the open request will be done
with the still reopen state in above case. As a result, the request
corresponding to this object is always skipped in select_req function, so
the read request is never completed and blocks other process.

Fix this issue by simply set object to close if its id < 0 in copen.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240522114308.2402121-11-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 6f815e7c50867..922cab1a314b2 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -182,6 +182,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	xas_store(&xas, NULL);
 	xa_unlock(&cache->reqs);
 
+	info = req->object->ondemand;
 	/* fail OPEN request if copen format is invalid */
 	ret = kstrtol(psize, 0, &size);
 	if (ret) {
@@ -201,7 +202,6 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		goto out;
 	}
 
-	info = req->object->ondemand;
 	spin_lock(&info->lock);
 	/*
 	 * The anonymous fd was closed before copen ? Fail the request.
@@ -241,6 +241,11 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	wake_up_all(&cache->daemon_pollwq);
 
 out:
+	spin_lock(&info->lock);
+	/* Need to set object close to avoid reopen status continuing */
+	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED)
+		cachefiles_ondemand_set_object_close(req->object);
+	spin_unlock(&info->lock);
 	complete(&req->done);
 	return ret;
 }
-- 
2.43.0


