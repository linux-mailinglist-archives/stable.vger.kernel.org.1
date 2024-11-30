Return-Path: <stable+bounces-95878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C09DF265
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060F8281489
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC51A7264;
	Sat, 30 Nov 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlMvQHA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDB1A7261
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989121; cv=none; b=r8Gsc047KsvNcArzhzurP5depVDLg2plJl88FbqCUlB4SLKacePR3t5vegAcypeR8irVvD+Y18vYNegpfS/Ww1Gol7KSdqRe9gCEBM7HD9dKVMIHirWCEVabbHZHhQyOnnYJsWGHyZN7P5G5CusuVdkV/tMs6J5tENVdfc7i91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989121; c=relaxed/simple;
	bh=YjjI5D79z0Y4xKmTpk/zrX3+FMgMu+UI7ZG0S0j4YvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rj6hqgb7up03cR4KsoebPlYF8p7NqFaf07b8KNnl/BYTwTa5X3MkcfSD/9KB8U9hD3YcR7jMP2RDBxMGHBXZr/uSNqL+g27U2TNFaR7pz+gjSn6tA4VkBOJIAFwPhbdDhr1wcQ5wxjta2eNq4BHc7g2goUULixH0ubcjTqfyg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlMvQHA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2EDC4CECC;
	Sat, 30 Nov 2024 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732989121;
	bh=YjjI5D79z0Y4xKmTpk/zrX3+FMgMu+UI7ZG0S0j4YvA=;
	h=From:To:Cc:Subject:Date:From;
	b=UlMvQHA+bMmihEs7JLYphH08sFafyXg2/UQBFPBpTOX5xsshAVNrzziqHpSjsugj3
	 sq1rBy3f+66sgocthTp8k7VtPVfupvXFHPhxWls2cY0TT2nl99jB4g7MT4qzV+KFki
	 3eAHZPKnDyS1hBTKgGyfgW4ANravullb4usG6XERPOBILLL0gE4m7XwaEUyX37QvzR
	 zIriygiYsx/x9aoFam3iqbzJhkkNwsxGRSf1ZvRUvL2lI43gJxj4KWfVqXCV+HjEyD
	 /xYQ6UWDp+IYBXLXPXdZsvEwDVUJS16V0M4JTjN5v1pdpah0z46P7Eq+WPbsWyHaOP
	 Q5BhChO5P4TWw==
From: Jakub Kicinski <kuba@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11/6.12] net_sched: sch_fq: don't follow the fast path if Tx is behind now
Date: Sat, 30 Nov 2024 09:51:48 -0800
Message-ID: <20241130175148.63765-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 122aba8c80618eca904490b1733af27fb8f07528 ]

Recent kernels cause a lot of TCP retransmissions

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
[  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
                                                      ^^^^

Replacing the qdisc with pfifo makes retransmissions go away.

It appears that a flow may have a delayed packet with a very near
Tx time. Later, we may get busy processing Rx and the target Tx time
will pass, but we won't service Tx since the CPU is busy with Rx.
If Rx sees an ACK and we try to push more data for the delayed flow
we may fastpath the skb, not realizing that there are already "ready
to send" packets for this flow sitting in the qdisc.

Don't trust the fastpath if we are "behind" according to the projected
Tx time for next flow waiting in the Qdisc. Because we consider anything
within the offload window to be okay for fastpath we must consider
the entire offload window as "now".

Qdisc config:

qdisc fq 8001: dev eth0 parent 1234:1 limit 10000p flow_limit 100p \
  buckets 32768 orphan_mask 1023 bands 3 \
  priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 \
  weights 589824 196608 65536 quantum 3028b initial_quantum 15140b \
  low_rate_threshold 550Kbit \
  refill_delay 40ms timer_slack 10us horizon 10s horizon_drop

For iperf this change seems to do fine, the reordering is gone.
The fastpath still gets used most of the time:

  gc 0 highprio 0 fastpath 142614 throttled 418309 latency 19.1us
   xx_behind 2731

where "xx_behind" counts how many times we hit the new "return false".

CC: stable@vger.kernel.org
Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qdisc")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241124022148.3126719-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[stable: drop the offload horizon, it's not supported / 0]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Per Fixes tag 6.7+, so the two non-longterm branches.
---
 net/sched/sch_fq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 19a49af5a9e5..afefe124d903 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -331,6 +331,12 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
 		 */
 		if (q->internal.qlen >= 8)
 			return false;
+
+		/* Ordering invariants fall apart if some delayed flows
+		 * are ready but we haven't serviced them, yet.
+		 */
+		if (q->time_next_delayed_flow <= now)
+			return false;
 	}
 
 	sk = skb->sk;
-- 
2.47.0


