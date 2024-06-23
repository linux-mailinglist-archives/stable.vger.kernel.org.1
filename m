Return-Path: <stable+bounces-54934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCA913B56
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F24B2282E
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608851991D8;
	Sun, 23 Jun 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy4zAGhp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DC1991B2;
	Sun, 23 Jun 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150325; cv=none; b=iuu8PZ2zQoBkfylEGlkIH7V92J9wZPvjml1fFn9cniS+x9ZllIS9iBylOy8XCQiEdE+dsRHtO0Gq3nfoT4klWC/ymP4fIMZE37rTB495RQGWtHs4SXmhAyCpq4Yfmksp4NkqOe4b0KVaKJjO0PNa7lxkmIC/L+rrJuQ7TvXo+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150325; c=relaxed/simple;
	bh=r/b0ciWjzISWnepJ9kFySb3gDAWmKtarJfO9wtHGBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im838ECUrQ0ZACVosLpyy6SwuXqmKUWny6aftDg91hCOAsD5+0Q1JCSbP2iiSd2H8sgisXgT2CqtN6a7SWG/m26MfiYCg7ekJuVTlDKGHkFlAwq/xnnSmgT2wQVB1I7MV5spDwGaESOKY++BgyYJYGPxx7V73AGk+AcLBgXqlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy4zAGhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC3C2BD10;
	Sun, 23 Jun 2024 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150325;
	bh=r/b0ciWjzISWnepJ9kFySb3gDAWmKtarJfO9wtHGBrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hy4zAGhpt5Su+4Y282PhddevdrYYrSG2NbGED29jGGGN+mnpNDtC+s2qA9Xnx38bL
	 aecdMlu87sd9JV0GeFZl41rJF6bnCW9cUvCmT91W6t8TExyzLaCWIFEmhUVXd0IKAO
	 UJ7bQBqPee2v9aX17UVNJRn8uV69MEHHC2CFOLIi9Ep5FxB62GP7HUeZmc5QJ0TApP
	 rVylMi2joOOb3+45NQB+dIU0Wyogw8ry0lciFacWNW2cYghmhTup51fchw2WJtuFmK
	 9Ti9bEHp43CLOo9x61IvyJ7YawSt1CslYtSCU/EcfzA0U+AxtF5WRXtaEHJ1WVvWx6
	 7uWAAgev4xk1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 04/12] cachefiles: add consistency check for copen/cread
Date: Sun, 23 Jun 2024 09:45:07 -0400
Message-ID: <20240623134518.809802-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit a26dc49df37e996876f50a0210039b2d211fdd6f ]

This prevents malicious processes from completing random copen/cread
requests and crashing the system. Added checks are listed below:

  * Generic, copen can only complete open requests, and cread can only
    complete read requests.
  * For copen, ondemand_id must not be 0, because this indicates that the
    request has not been read by the daemon.
  * For cread, the object corresponding to fd and req should be the same.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240522114308.2402121-7-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4b39f0422e590..b8e9cdc93643e 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -97,12 +97,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 }
 
 static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
-					 unsigned long arg)
+					 unsigned long id)
 {
 	struct cachefiles_object *object = filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_req *req;
-	unsigned long id;
+	XA_STATE(xas, &cache->reqs, id);
 
 	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
 		return -EINVAL;
@@ -110,10 +110,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
 
-	id = arg;
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
+	    req->object != object) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
 	trace_cachefiles_ondemand_cread(object, id);
 	complete(&req->done);
@@ -142,6 +147,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	unsigned long id;
 	long size;
 	int ret;
+	XA_STATE(xas, &cache->reqs, 0);
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
@@ -165,9 +171,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	if (ret)
 		return ret;
 
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	xas.xa_index = id;
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
+	    !req->object->ondemand->ondemand_id) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
 	/* fail OPEN request if copen format is invalid */
 	ret = kstrtol(psize, 0, &size);
-- 
2.43.0


