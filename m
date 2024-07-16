Return-Path: <stable+bounces-60003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D3932CF1
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60CD1C22187
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EF19DF73;
	Tue, 16 Jul 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBUeX8/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C91DDCE;
	Tue, 16 Jul 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145561; cv=none; b=KleC8XeX+hHbOrpu2y81cw9emF64c2nbqxwlReUfx3PEOZYbLKC0IIqPFkagM83tgYjgXd8k2EaR/WelCH/rwoa62OVryQ8Kcb0fCReiC60wU4X9BQmFakFRqjv4K/zC5BU/15aX25UIBlCQH4blW60q34qPfgo6+4lSXllqVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145561; c=relaxed/simple;
	bh=60rFwg3EZt4Vryy7HgXAOEV4lq+Xpvw4T3I/df8L7oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLUT1Xt2yV9THZvDhV6pXCxf4NJfwjGSCd6WE46bl9szXI26IjoGV+q7Nn7rO72GCyH0IsSW1oyJm6X4RCjuP8Z6zfpPX9ke0es1Vj2EO/1hCwWkGD+TL5OwxjhaT0qfHOVP/xPoD+6LMfZyvbX6LIKQKOfNOYO6PcPjKjrkXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBUeX8/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E1AC4AF0E;
	Tue, 16 Jul 2024 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145561;
	bh=60rFwg3EZt4Vryy7HgXAOEV4lq+Xpvw4T3I/df8L7oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBUeX8/D3lUUGkhJU4Y5896ZZCoktNQpUaxLtWM7F/iwyWwglwF2bg1uAs0UskM9K
	 Dxyg5SduHUtbQESTlhDyGL7RIIZ2QbBwTm3ciW+s32aEmpDevzfj79uBcFhcfA9EQZ
	 /v+QaSgwIfmHbpzWZkQ4ft3zhLUrxiapm+wuOjsU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/121] cachefiles: cyclic allocation of msg_id to avoid reuse
Date: Tue, 16 Jul 2024 17:31:12 +0200
Message-ID: <20240716152751.715781068@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 19f4f399091478c95947f6bd7ad61622300c30d9 ]

Reusing the msg_id after a maliciously completed reopen request may cause
a read request to remain unprocessed and result in a hung, as shown below:

       t1       |      t2       |      t3
-------------------------------------------------
cachefiles_ondemand_select_req
 cachefiles_ondemand_object_is_close(A)
 cachefiles_ondemand_set_object_reopening(A)
 queue_work(fscache_object_wq, &info->work)
                ondemand_object_worker
                 cachefiles_ondemand_init_object(A)
                  cachefiles_ondemand_send_req(OPEN)
                    // get msg_id 6
                    wait_for_completion(&req_A->done)
cachefiles_ondemand_daemon_read
 // read msg_id 6 req_A
 cachefiles_ondemand_get_fd
 copy_to_user
                                // Malicious completion msg_id 6
                                copen 6,-1
                                cachefiles_ondemand_copen
                                 complete(&req_A->done)
                                 // will not set the object to close
                                 // because ondemand_id && fd is valid.

                // ondemand_object_worker() is done
                // but the object is still reopening.

                                // new open req_B
                                cachefiles_ondemand_init_object(B)
                                 cachefiles_ondemand_send_req(OPEN)
                                 // reuse msg_id 6
process_open_req
 copen 6,A.size
 // The expected failed copen was executed successfully

Expect copen to fail, and when it does, it closes fd, which sets the
object to close, and then close triggers reopen again. However, due to
msg_id reuse resulting in a successful copen, the anonymous fd is not
closed until the daemon exits. Therefore read requests waiting for reopen
to complete may trigger hung task.

To avoid this issue, allocate the msg_id cyclically to avoid reusing the
msg_id for a very short duration of time.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-9-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 94f59123726ca..111ad6ecd4baf 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -129,6 +129,7 @@ struct cachefiles_cache {
 	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
+	u32				msg_id_next;
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1f6561814e702..51173ab6dbd84 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -505,20 +505,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		smp_mb();
 
 		if (opcode == CACHEFILES_OP_CLOSE &&
-			!cachefiles_ondemand_object_is_open(object)) {
+		    !cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
 		}
 
-		xas.xa_index = 0;
+		/*
+		 * Cyclically find a free xas to avoid msg_id reuse that would
+		 * cause the daemon to successfully copen a stale msg_id.
+		 */
+		xas.xa_index = cache->msg_id_next;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART) {
+			xas.xa_index = 0;
+			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
+		}
 		if (xas.xa_node == XAS_RESTART)
 			xas_set_err(&xas, -EBUSY);
+
 		xas_store(&xas, req);
-		xas_clear_mark(&xas, XA_FREE_MARK);
-		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		if (xas_valid(&xas)) {
+			cache->msg_id_next = xas.xa_index + 1;
+			xas_clear_mark(&xas, XA_FREE_MARK);
+			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		}
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-- 
2.43.0




