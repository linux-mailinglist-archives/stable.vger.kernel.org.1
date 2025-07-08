Return-Path: <stable+bounces-160670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7BAFD13B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20131C220E0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56F8F5B;
	Tue,  8 Jul 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urcrjXey"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF511BEF7E;
	Tue,  8 Jul 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992347; cv=none; b=jj6HVpoStJqdMFzbuxeZlqXLb5yUsSjlM44B0ML7kIwXeka+FWNne9LVuit0atVUSRvJwurcBciEzBJw79WORSgzowcaVbrhzjmL/EO0X/2RW3SvqPzSCKpfPYDtogXECSkYP/zuf1pILIFiUjsoDckxu+NLT1uFOHnFTxtpBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992347; c=relaxed/simple;
	bh=JocXkFPIbdrwnF3IXZG1uHddCfqcBXS3sFdkN5nnhq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrmTMwbCwNxJkFhNTZ9BP1+xQl9YMjWfbcT/szpVZY1UD6Sz/6mNAbQErkrPEWdWM7EfhZdzDE+ez+ej9MpMCehMKGRDp9CewVa6ho3dyrMQXYqghzH8ifuiHK5UDe+FELRSbvy8lXJiUac0Uv0HOD7XkR9gKD4rN/49TLRFzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urcrjXey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DFDC4CEED;
	Tue,  8 Jul 2025 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992347;
	bh=JocXkFPIbdrwnF3IXZG1uHddCfqcBXS3sFdkN5nnhq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urcrjXeyGBzyxv1tEiKeRdZVn9l+5/BXtoCBhIs2Ljwab/zZvHwoez1i/lJEPci1p
	 0MlNEasfawsT31/dey5WSJYfRH7oUnDxcURl9PCQfK02S5t6ii/Z6v3vVsXgXxoztz
	 PGdIHmL1q4mlw66v9nsf7mwuvAOumGxxoP9De9ZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lion Ackermann <nnamrec@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/132] net/sched: Always pass notifications when child class becomes empty
Date: Tue,  8 Jul 2025 18:22:52 +0200
Message-ID: <20250708162232.442499499@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lion Ackermann <nnamrec@gmail.com>

[ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]

Certain classful qdiscs may invoke their classes' dequeue handler on an
enqueue operation. This may unexpectedly empty the child qdisc and thus
make an in-flight class passive via qlen_notify(). Most qdiscs do not
expect such behaviour at this point in time and may re-activate the
class eventually anyways which will lead to a use-after-free.

The referenced fix commit attempted to fix this behavior for the HFSC
case by moving the backlog accounting around, though this turned out to
be incomplete since the parent's parent may run into the issue too.
The following reproducer demonstrates this use-after-free:

    tc qdisc add dev lo root handle 1: drr
    tc filter add dev lo parent 1: basic classid 1:1
    tc class add dev lo parent 1: classid 1:1 drr
    tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
    tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
    tc qdisc add dev lo parent 2:1 handle 3: netem
    tc qdisc add dev lo parent 3:1 handle 4: blackhole

    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
    tc class delete dev lo classid 1:1
    echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888

Since backlog accounting issues leading to a use-after-frees on stale
class pointers is a recurring pattern at this point, this patch takes
a different approach. Instead of trying to fix the accounting, the patch
ensures that qdisc_tree_reduce_backlog always calls qlen_notify when
the child qdisc is empty. This solves the problem because deletion of
qdiscs always involves a call to qdisc_reset() and / or
qdisc_purge_queue() which ultimately resets its qlen to 0 thus causing
the following qdisc_tree_reduce_backlog() to report to the parent. Note
that this may call qlen_notify on passive classes multiple times. This
is not a problem after the recent patch series that made all the
classful qdiscs qlen_notify() handlers idempotent.

Fixes: 3f981138109f ("sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()")
Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index df89790c459ad..282423106f15d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -779,15 +779,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 {
-	bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
 	const struct Qdisc_class_ops *cops;
 	unsigned long cl;
 	u32 parentid;
 	bool notify;
 	int drops;
 
-	if (n == 0 && len == 0)
-		return;
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
@@ -796,17 +793,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 
 		if (sch->flags & TCQ_F_NOPARENT)
 			break;
-		/* Notify parent qdisc only if child qdisc becomes empty.
-		 *
-		 * If child was empty even before update then backlog
-		 * counter is screwed and we skip notification because
-		 * parent class is already passive.
-		 *
-		 * If the original child was offloaded then it is allowed
-		 * to be seem as empty, so the parent is notified anyway.
-		 */
-		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
-						       !qdisc_is_offloaded);
+		/* Notify parent qdisc only if child qdisc becomes empty. */
+		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
@@ -815,6 +803,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		}
 		cops = sch->ops->cl_ops;
 		if (notify && cops->qlen_notify) {
+			/* Note that qlen_notify must be idempotent as it may get called
+			 * multiple times.
+			 */
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}
-- 
2.39.5




