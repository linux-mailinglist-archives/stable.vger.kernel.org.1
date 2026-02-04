Return-Path: <stable+bounces-214296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEh5KEhug2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:05:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BDFE9DAA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA8A3186BA1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD42D8798;
	Wed,  4 Feb 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGGz4D+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D432D0292;
	Wed,  4 Feb 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219215; cv=none; b=OJ3frkuEIN+i3Lk7Vdayw9RX/oSwd0//gMu+bFZvHV+f8U6SIC+QQuD60xvGRveNLNH8LBgdGnPOJv6FRyK8hGH6aiUs65baUoJaMl38ceIz9tao42Odt+2g46kUqOHD8C2qDMAgMkDXrHgNUVoiswQpXX99VZbfUWkiNAtVZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219215; c=relaxed/simple;
	bh=nhDeAablNrNmp4Ccg5ElZmtYxFSe4A2c7F3LRHGcyWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyaRl/m3O7DGoOCi6xGq5a96drNopBzhgsepIH1TDwdpKs46YvidYrpFHdMmFQKbwUDSBixLJcS4SgdYhRkR+ieCnadFCOxcQ0Phkd81mKrhbMlUuGPoDDrMOftxNUkYUILIi9bIvQgC5N1qm3gHmmkehCt5yZtVANOcoers1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGGz4D+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A41C4CEF7;
	Wed,  4 Feb 2026 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219215;
	bh=nhDeAablNrNmp4Ccg5ElZmtYxFSe4A2c7F3LRHGcyWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGGz4D+bVRHMSniJnozHmsJkTG6eJKgFN44df5cBUotvky1pFFubAMDy7VSpE28Mg
	 zUjOWtJYrQgYcnd+SyWJ7JTwwCvi+ah6GesaWYvOm8wJFbdYoNTbkWY6s/NNjA4T29
	 +sQU7XYmUQLfSe3UXOrzTjsdB8vU8aDS8P9yUy+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 057/122] sched/deadline: Document dl_server
Date: Wed,  4 Feb 2026 15:40:39 +0100
Message-ID: <20260204143853.906101912@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214296-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F0BDFE9DAA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 2614069c5912e9d6f1f57c262face1b368fb8c93 ]

Place the notes that resulted from going through the dl_server code in a
comment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Stable-dep-of: 115135422562 ("sched/deadline: Fix 'stuck' dl_server")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 194 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 465592fa530ef..6bfffb244162f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1573,6 +1573,200 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
+/*
+ * dl_server && dl_defer:
+ *
+ *                                        6
+ *                            +--------------------+
+ *                            v                    |
+ *     +-------------+  4   +-----------+  5     +------------------+
+ * +-> |   A:init    | <--- | D:running | -----> | E:replenish-wait |
+ * |   +-------------+      +-----------+        +------------------+
+ * |     |         |    1     ^    ^               |
+ * |     | 1       +----------+    | 3             |
+ * |     v                         |               |
+ * |   +--------------------------------+   2      |
+ * |   |                                | ----+    |
+ * | 8 |       B:zero_laxity-wait       |     |    |
+ * |   |                                | <---+    |
+ * |   +--------------------------------+          |
+ * |     |              ^     ^           2        |
+ * |     | 7            | 2   +--------------------+
+ * |     v              |
+ * |   +-------------+  |
+ * +-- | C:idle-wait | -+
+ *     +-------------+
+ *       ^ 7       |
+ *       +---------+
+ *
+ *
+ * [A] - init
+ *   dl_server_active = 0
+ *   dl_throttled = 0
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 0/1
+ *   dl_defer_idle = 0
+ *
+ * [B] - zero_laxity-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 1
+ *   dl_defer_running = 0
+ *   dl_defer_idle = 0
+ *
+ * [C] - idle-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 1
+ *   dl_defer_running = 0
+ *   dl_defer_idle = 1
+ *
+ * [D] - running
+ *   dl_server_active = 1
+ *   dl_throttled = 0
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 1
+ *   dl_defer_idle = 0
+ *
+ * [E] - replenish-wait
+ *   dl_server_active = 1
+ *   dl_throttled = 1
+ *   dl_defer_armed = 0
+ *   dl_defer_running = 1
+ *   dl_defer_idle = 0
+ *
+ *
+ * [1] A->B, A->D
+ * dl_server_start()
+ *   dl_server_active = 1;
+ *   enqueue_dl_entity()
+ *     update_dl_entity(WAKEUP)
+ *       if (!dl_defer_running)
+ *         dl_defer_armed = 1;
+ *         dl_throttled = 1;
+ *     if (dl_throttled && start_dl_timer())
+ *       return; // [B]
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // deplete server runtime from client-class
+ * [2] B->B, C->B, E->B
+ * dl_server_update()
+ *   update_curr_dl_se() // idle = false
+ *     if (dl_defer_idle)
+ *       dl_defer_idle = 0;
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       dl_defer_running = 0;
+ *       hrtimer_try_to_cancel();   // stop timer
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled = 1;
+ *         dl_defer_armed = 1;
+ *       start_dl_timer();        // restart timer
+ *       // [B]
+ *
+ * // timer actually fires means we have runtime
+ * [3] B->D
+ * dl_server_timer()
+ *   if (dl_defer_armed)
+ *     dl_defer_running = 1;
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       // fwd period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *       if (dl_defer_armed)
+ *         dl_defer_armed = 0;
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // schedule server
+ * [4] D->A
+ * pick_task_dl()
+ *   p = server_pick_task();
+ *   if (!p)
+ *     dl_server_stop()
+ *       dequeue_dl_entity();
+ *       hrtimer_try_to_cancel();
+ *       dl_defer_armed = 0;
+ *       dl_throttled = 0;
+ *       dl_server_active = 0;
+ *       // [A]
+ *   return p;
+ *
+ * // server running
+ * [5] D->E
+ * update_curr_dl_se()
+ *   if (dl_runtime_exceeded())
+ *     dl_throttled = 1;
+ *     dequeue_dl_entity();
+ *     start_dl_timer();
+ *     // [E]
+ *
+ * // server replenished
+ * [6] E->D
+ * dl_server_timer()
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       fwd-period
+ *       if (dl_throttled)
+ *         dl_throttled = 0;
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // deplete server runtime from idle
+ * [7] B->C, C->C
+ * dl_server_update_idle()
+ *   update_curr_dl_se() // idle = true
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       if (dl_defer_idle)
+ *         return;
+ *       dl_defer_running = 0;
+ *       hrtimer_try_to_cancel();
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled = 1;
+ *         dl_defer_armed = 1;
+ *       dl_defer_idle = 1;
+ *       start_dl_timer();        // restart timer
+ *       // [C]
+ *
+ * // stop idle server
+ * [8] C->A
+ * dl_server_timer()
+ *   if (dl_defer_idle)
+ *     dl_server_stop();
+ *     // [A]
+ *
+ *
+ * digraph dl_server {
+ *   "A:init" -> "B:zero_laxity-wait"             [label="1:dl_server_start"]
+ *   "A:init" -> "D:running"                      [label="1:dl_server_start"]
+ *   "B:zero_laxity-wait" -> "B:zero_laxity-wait" [label="2:dl_server_update"]
+ *   "B:zero_laxity-wait" -> "C:idle-wait"        [label="7:dl_server_update_idle"]
+ *   "B:zero_laxity-wait" -> "D:running"          [label="3:dl_server_timer"]
+ *   "C:idle-wait" -> "A:init"                    [label="8:dl_server_timer"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="2:dl_server_update"]
+ *   "C:idle-wait" -> "C:idle-wait"               [label="7:dl_server_update_idle"]
+ *   "D:running" -> "A:init"                      [label="4:pick_task_dl"]
+ *   "D:running" -> "E:replenish-wait"            [label="5:update_curr_dl_se"]
+ *   "E:replenish-wait" -> "B:zero_laxity-wait"   [label="2:dl_server_update"]
+ *   "E:replenish-wait" -> "D:running"            [label="6:dl_server_timer"]
+ * }
+ *
+ *
+ * Notes:
+ *
+ *  - When there are fair tasks running the most likely loop is [2]->[2].
+ *    the dl_server never actually runs, the timer never fires.
+ *
+ *  - When there is actual fair starvation; the timer fires and starts the
+ *    dl_server. This will then throttle and replenish like a normal DL
+ *    task. Notably it will not 'defer' again.
+ *
+ *  - When idle it will push the actication forward once, and then wait
+ *    for the timer to hit or a non-idle update to restart things.
+ */
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
-- 
2.51.0




