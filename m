Return-Path: <stable+bounces-150535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87258ACB872
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E494810E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E783225792;
	Mon,  2 Jun 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZt+znib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF598225776;
	Mon,  2 Jun 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877427; cv=none; b=mwM821eF167PIQVEO+02wnyVKYum3xuB+8c9e/T6MT6Lj+Ebr4x3Y/L1iXt/XzrS0kDrJGFKd/DC9SFmjz+f3pk7+DY45vvQ28BAXJjJShc8vpk5KiVPqnyA6X3k4l5maAnLBqzE93kHEvtToJKRgiZ2K8YFcL3DJeVbBlo73LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877427; c=relaxed/simple;
	bh=D8AZY29T13VlZ1JlTg0SRdQhCjIQY6ceHXERDZNreeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUw3RbK6aoJsPiJ1+EXjiRyAIKF+9DrsdyX7X4ZJAud3GDUEsMeCBC4Ldxv+0vD5DDGrerB5GeGvNkzMD4aLdxzfi9s0V/x3A2Ud8BjCA5tCeDpbgwqn0jXOxfWxjPzVtyCFTp+qJSM3CBOzcxYYgJFGtZHYiiCZceKy/DumlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZt+znib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E22C4CEEB;
	Mon,  2 Jun 2025 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877427;
	bh=D8AZY29T13VlZ1JlTg0SRdQhCjIQY6ceHXERDZNreeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZt+znib5ir8lCwdyBadp/OAO+L7h6JrYirwRPvTlwaKwYBQ/dBBbN9+DGPVnFeDN
	 L85/TyysegAH7ZtT+INCwIfZVQkynlDqSTCV1gWeXd/c1gx2FrEh6ZA2lfYW0VyB1l
	 VQeyGgSzSoSkTtmf9DoG1LBwibMdy8YCC3x3wnG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingi Cho <mincho@theori.io>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 244/325] sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
Date: Mon,  2 Jun 2025 15:48:40 +0200
Message-ID: <20250602134329.698616972@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 3f981138109f63232a5fb7165938d4c945cc1b9d ]

When enqueuing the first packet to an HFSC class, hfsc_enqueue() calls the
child qdisc's peek() operation before incrementing sch->q.qlen and
sch->qstats.backlog. If the child qdisc uses qdisc_peek_dequeued(), this may
trigger an immediate dequeue and potential packet drop. In such cases,
qdisc_tree_reduce_backlog() is called, but the HFSC qdisc's qlen and backlog
have not yet been updated, leading to inconsistent queue accounting. This
can leave an empty HFSC class in the active list, causing further
consequences like use-after-free.

This patch fixes the bug by moving the increment of sch->q.qlen and
sch->qstats.backlog before the call to the child qdisc's peek() operation.
This ensures that queue length and backlog are always accurate when packet
drops or dequeues are triggered during the peek.

Fixes: 12d0ad3be9c3 ("net/sched/sch_hfsc.c: handle corner cases where head may change invalidating calculated deadline")
Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250518222038.58538-2-xiyou.wangcong@gmail.com
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_hfsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index fc1370c293730..ec6ee45100132 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1568,6 +1568,9 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+
 	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
@@ -1583,9 +1586,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.39.5




