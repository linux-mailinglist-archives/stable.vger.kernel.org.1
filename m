Return-Path: <stable+bounces-131315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D55A80952
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5351BA5CAF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75190278167;
	Tue,  8 Apr 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2rqkxjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343626AA9A;
	Tue,  8 Apr 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116064; cv=none; b=iGRtDxiXhIZ1R8IYdU3shnFIv8uJGQPpnfBIZiZsOmh6yGSvkU+eQpyd9CjohP219sPOQjGDOwFH3+h4YmKf29ZlZUtFlR6FIU3PU/lVOoQBIf+bpj4Ka5TlLjdDFnkPf/MxZXbpT/mQGv5GP33a4xTxzA4eeynG7PHE6PVdVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116064; c=relaxed/simple;
	bh=+inD9wnTbfhs/SFjtjcdhIxr9+JvjPxgWnNNJ2XcZ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGW0EGQmxKTsV/oWCNJHY8HsncTKX7I5R9+Ste/WIJYOt/lMz6/6WeFcb47rMJyM/1hvgNXX6jsBgH3dTZlZYYxKivkZTS5WkAHN4axB10nmDQNs9WbGwcxLL/e6vOHtcLhk/UfOFgbSGgn5Snfye47m/wHscFM04O3Nel7q07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2rqkxjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7773C4CEE5;
	Tue,  8 Apr 2025 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116064;
	bh=+inD9wnTbfhs/SFjtjcdhIxr9+JvjPxgWnNNJ2XcZ0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2rqkxjPFdDzSOtF3Ta/ZxEU3Y9uKrejGjTDOZZzjn4It9GHsqo8mFK+ml6hWleEP
	 pq5Op8BNvNSuuwxYyHQTIu27WqbU4z6v0w+CdEGHFtZuf1BhILc8IQoNosltq6NPH7
	 82naOgIVecDDCU0tWswzEhEo3H1NJrRzXO/DD+NY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com,
	Nishanth Devarajan <ndev2021@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 157/204] net_sched: skbprio: Remove overly strict queue assertions
Date: Tue,  8 Apr 2025 12:51:27 +0200
Message-ID: <20250408104824.920047161@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

[ Upstream commit ce8fe975fd99b49c29c42e50f2441ba53112b2e8 ]

In the current implementation, skbprio enqueue/dequeue contains an assertion
that fails under certain conditions when SKBPRIO is used as a child qdisc under
TBF with specific parameters. The failure occurs because TBF sometimes peeks at
packets in the child qdisc without actually dequeuing them when tokens are
unavailable.

This peek operation creates a discrepancy between the parent and child qdisc
queue length counters. When TBF later receives a high-priority packet,
SKBPRIO's queue length may show a different value than what's reflected in its
internal priority queue tracking, triggering the assertion.

The fix removes this overly strict assertions in SKBPRIO, they are not
necessary at all.

Reported-by: syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a3422a19b05ea96bee18
Fixes: aea5f654e6b7 ("net/sched: add skbprio scheduler")
Cc: Nishanth Devarajan <ndev2021@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/20250329222536.696204-2-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_skbprio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 5df2dacb7b1ab..05aa363a7fee9 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -121,8 +121,6 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Check to update highest and lowest priorities. */
 	if (skb_queue_empty(lp_qdisc)) {
 		if (q->lowest_prio == q->highest_prio) {
-			/* The incoming packet is the only packet in queue. */
-			BUG_ON(sch->q.qlen != 1);
 			q->lowest_prio = prio;
 			q->highest_prio = prio;
 		} else {
@@ -154,7 +152,6 @@ static struct sk_buff *skbprio_dequeue(struct Qdisc *sch)
 	/* Update highest priority field. */
 	if (skb_queue_empty(hpq)) {
 		if (q->lowest_prio == q->highest_prio) {
-			BUG_ON(sch->q.qlen);
 			q->highest_prio = 0;
 			q->lowest_prio = SKBPRIO_MAX_PRIORITY - 1;
 		} else {
-- 
2.39.5




