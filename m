Return-Path: <stable+bounces-54935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F82913B58
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658311C20CAC
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D01993AD;
	Sun, 23 Jun 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtzVYNh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1B199398;
	Sun, 23 Jun 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150326; cv=none; b=lzWFqGMlns1McM92Y4eNo1T3nciKaiv28au74BLFlLox8WL0G1/wG/5muCFgmKfVVS/EyU8OCPS2Rmr7tfRxKVqL9Qpy2xd03/EX4TLUHil5ABOlofoUjLc9hBcQeyCPu6WgmN6dKMscT8bLq7ETCC3oQ15Whp78jpJOczOq7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150326; c=relaxed/simple;
	bh=JXifNuJFZLxzMxs/tL65AKn/n+CiUJ4hs5hZuDPTYHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux+ChiVNbw06SIOjvyBtG3b0t2xHhmDNTgEwiTnSXF24DFIoZc0yqKM8BDgbTg6RROEG0zxuvx0MHl/ihS1roRaLEP3WiHncfao3O1zHFNn+bY4+SvlNKgGq9ajrR1akf9nWhjhRaEQ0jnKj1F8xoM3wu5GthA6YfYhM8Lip92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtzVYNh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F18AC4AF09;
	Sun, 23 Jun 2024 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150326;
	bh=JXifNuJFZLxzMxs/tL65AKn/n+CiUJ4hs5hZuDPTYHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtzVYNh17m1YxWlu3cO80yExJPRUc7Rxs1nhzgN6Xmhugs1zihirFShoLcm61dCCU
	 dHpMuR8huEnJTdZ1XQTQK3nthMbx47zma12E9qu8NBIq2WuOsYU86r7j8bRO++Fj6Y
	 InoR8tDXmRkJVuuK+EFyVc09QPTxJi5RWqxwFdjfOnsHK+rVMVrYy447B4uHKpcMp+
	 UkYXhPatm05B4XW3IUVIPZgDTXQ2euOBbBg/tH51zMjvuCTL8wxXhbOS4wI3RlqwyW
	 VrO+lbC630QgK+/aJdM0O5BAkLjtQmhps2wfUL/QijCK9vNEFP8fvj97b8coDgzLnB
	 /rAs3vIu5hn8g==
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
Subject: [PATCH AUTOSEL 6.1 05/12] cachefiles: Set object to close if ondemand_id < 0 in copen
Date: Sun, 23 Jun 2024 09:45:08 -0400
Message-ID: <20240623134518.809802-5-sashal@kernel.org>
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
index b8e9cdc93643e..0862d69d64759 100644
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


