Return-Path: <stable+bounces-229129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICskNjJtwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE82F8999
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B447430382AC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F13282F35;
	Mon, 23 Mar 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uiILMgsb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375427FD6D;
	Mon, 23 Mar 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278152; cv=none; b=HliYDPpvDwQ22KIMJDVBcKsYWIgFMSTN/ANRkj6dKqHk00sUUjy3X34PVL59TcBnCSiy+N8wfjcGaDpyWtkBBHNsiBKu/2QLnIkkN3CaZgyJF5HtpD1Uj7tJjyqIrs0wstgnQhJCFXArgWHFyTIbqzFtI8PCkTxV/boNw5EXLgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278152; c=relaxed/simple;
	bh=QAbaoWNjg+GUBAWVNpI39vxdQ4J/7RJ1d/1OHGmsXbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGun6mZhYR/hhEjVKbTBR4BGvyfwqMomg7nvHSJrCGjX06rQ1q2jwNb3mZgIv9mlNrbDl7pffMLAzFbGbA5FQTpAgWOcvf/I/4su6nwau+7Bi3U/T9PE/pHBDWnVCxF9+W1xONfpdmQb3CfB7dgyc2eFTi8tS9GXXAbOeHomygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uiILMgsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA211C4CEF7;
	Mon, 23 Mar 2026 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278152;
	bh=QAbaoWNjg+GUBAWVNpI39vxdQ4J/7RJ1d/1OHGmsXbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uiILMgsbQEczBwfVvJ7YTqe20S5V0PZUmjIexY9iLAQRbfJIFpylDKgpTMfUZL5fS
	 edRoUWo8+icxuqWVqXXe6X9abYIWzcgf0rzClXq/vbg6462Pwe920p+NwI7us/9RiS
	 G+VnUNqNM6qL+RTHTX2YfXbxA57em+altQF0JSWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Badger <ebadger@purestorage.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 216/567] xprtrdma: Decrement re_receiving on the early exit paths
Date: Mon, 23 Mar 2026 14:42:16 +0100
Message-ID: <20260323134539.172119248@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229129-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DAFE82F8999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Badger <ebadger@purestorage.com>

[ Upstream commit 7b6275c80a0c81c5f8943272292dfe67730ce849 ]

In the event that rpcrdma_post_recvs() fails to create a work request
(due to memory allocation failure, say) or otherwise exits early, we
should decrement ep->re_receiving before returning. Otherwise we will
hang in rpcrdma_xprt_drain() as re_receiving will never reach zero and
the completion will never be triggered.

On a system with high memory pressure, this can appear as the following
hung task:

    INFO: task kworker/u385:17:8393 blocked for more than 122 seconds.
          Tainted: G S          E       6.19.0 #3
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/u385:17 state:D stack:0     pid:8393  tgid:8393  ppid:2      task_flags:0x4248060 flags:0x00080000
    Workqueue: xprtiod xprt_autoclose [sunrpc]
    Call Trace:
     <TASK>
     __schedule+0x48b/0x18b0
     ? ib_post_send_mad+0x247/0xae0 [ib_core]
     schedule+0x27/0xf0
     schedule_timeout+0x104/0x110
     __wait_for_common+0x98/0x180
     ? __pfx_schedule_timeout+0x10/0x10
     wait_for_completion+0x24/0x40
     rpcrdma_xprt_disconnect+0x444/0x460 [rpcrdma]
     xprt_rdma_close+0x12/0x40 [rpcrdma]
     xprt_autoclose+0x5f/0x120 [sunrpc]
     process_one_work+0x191/0x3e0
     worker_thread+0x2e3/0x420
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x10d/0x230
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x273/0x2b0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30

Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it is draining")
Signed-off-by: Eric Badger <ebadger@purestorage.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/verbs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index cb909329a5039..4132a505d742a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1362,7 +1362,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 		needed += RPCRDMA_MAX_RECV_BATCH;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
-		goto out;
+		goto out_dec;
 
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
@@ -1389,7 +1389,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 		++count;
 	}
 	if (!wr)
-		goto out;
+		goto out_dec;
 
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
@@ -1404,9 +1404,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 			--count;
 		}
 	}
+
+out_dec:
 	if (atomic_dec_return(&ep->re_receiving) > 0)
 		complete(&ep->re_done);
-
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count);
 	ep->re_receive_count += count;
-- 
2.51.0




