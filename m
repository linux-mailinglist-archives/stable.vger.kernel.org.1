Return-Path: <stable+bounces-54921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07924913B34
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DFFB21C15
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981119146E;
	Sun, 23 Jun 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Dl5SFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450A190684;
	Sun, 23 Jun 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150300; cv=none; b=ML1SypvkQvh4YaeAfw46IkIgHcBcKVr08rpEOr2Mbhx2TFFN82VU+fQbe0NfSaSRn+GI+9v0/iP3xckAABoMZdK26gZvX636a1aBnx5+stzLwM35bZsRkDUZZcGkUDII0U9JmCV1G9A5g/9xPipJGxxThzaBHK+mgv987/CnxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150300; c=relaxed/simple;
	bh=2dMvc69zDQ6giKu4nIZpePNxADLoHCon0Vcf5Hbapu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx7faQoJTPX8ZezYJigtLrpAZp89huGc55QXvVWo/ourgrFr1vxGSv6Se92+5MIIZRQTguhZZXT9ylJDaXiWo7Pw9JTTjuSQNpl0LptosR3LIctMl+s/1IMKALJ0oopAT32bAlMnOrKpQSY+/p354PMe87RRJtPRDmSLUQIS+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Dl5SFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314BEC4AF0B;
	Sun, 23 Jun 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150300;
	bh=2dMvc69zDQ6giKu4nIZpePNxADLoHCon0Vcf5Hbapu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5Dl5SFPLXx52TBZPmtjA9WkNYI0sy5iZnFvxhcIFCwdBjitwmJqflvxIGKa51GxF
	 4TepQatmYhmRwBAJ4ik4abtkWEMFIfHhNuD5YNkXVLw2EwDgcHS2xUROhyTPPMY1tJ
	 Sch+ctm3PW++2HT8eqYDuXqolM/WmV/ritbZllg3VZTkoWSXypihdSpsnnoeHPn363
	 GmBEH7pRZfk9uAuTg2uERTCux8pMpIA5FELB3FYVdzWaXIAQ7R6VftEHEXC/oCGERn
	 wUr3N5aVu1yTgJw/E7kOeTKc2duffAWjkMlNlkZbNN1o+cFLDRnwygMipBsb04dVfW
	 KvYDynVBba2ZQ==
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
Subject: [PATCH AUTOSEL 6.6 07/16] cachefiles: make on-demand read killable
Date: Sun, 23 Jun 2024 09:44:36 -0400
Message-ID: <20240623134448.809470-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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
index 0862d69d64759..9513efaeb7ab6 100644
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


