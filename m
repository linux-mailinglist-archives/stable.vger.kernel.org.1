Return-Path: <stable+bounces-150016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0DEACB4EA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A047ABC4E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DCD227B81;
	Mon,  2 Jun 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCCkEVR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7640226D1F;
	Mon,  2 Jun 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875767; cv=none; b=OEpnYjjCOL8P42vShss118M1U+buOcXVtOabSy0nHScvd7DNQKcVOsnhOSIC1Iz/90YOQZgm7qdBTBw+NL/fiyjc+liUknmL3QRRV5xWNTGXqzWl3v2mpsGVKlJmSs19iXQoD9x6E8Ya1ojK9PcxBzHWp1SUtWsScKAUXUiXQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875767; c=relaxed/simple;
	bh=NTc9U1pyUKnQ3k/rJS6HoDaYfMXxZIQ5YeLUCHMsJJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiU84XjbSUGy1a4qYfgx8ubCtC+n2LCeHBafFvH5VEgj1ZAEOXwdsomxLtNXQ97WhSoVz/FDEyu1UGUgBu5odJSVMNc7ZwerHIpTcupgBLVEB1W7IHzK8PZidKkesTx+li2ZmT8J3LKIeCpNqWf3GkFz/U3uiZgVDnZsY0kER3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCCkEVR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD3C4CEEB;
	Mon,  2 Jun 2025 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875767;
	bh=NTc9U1pyUKnQ3k/rJS6HoDaYfMXxZIQ5YeLUCHMsJJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCCkEVR1teMCWUkAb/A0HkE3LF9RBGP+CdSron2n4+mVIHX+VzNUBho1UiZuK973o
	 2ChuXERDAXobHWmPAyWSP+cXrnyqjYpijdtgFqFJOVr9b0ehdXGr7oaNggmNOuu6Yy
	 MgZkKVL8vJgRAYdg7x/Nd2mrU/SWQvfTs0TKgQ1c=
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
Subject: [PATCH 5.10 238/270] sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
Date: Mon,  2 Jun 2025 15:48:43 +0200
Message-ID: <20250602134317.043802454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index adc16643779fb..45d17501a6ed0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1571,6 +1571,9 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+
 	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
@@ -1586,9 +1589,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.39.5




