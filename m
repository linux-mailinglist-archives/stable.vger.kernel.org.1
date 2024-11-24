Return-Path: <stable+bounces-94693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2D9D6C7B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 03:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52BAB21438
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A76EEA8;
	Sun, 24 Nov 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN7gSIXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01D646;
	Sun, 24 Nov 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732414912; cv=none; b=jWNOUSq/0lDko/HwZC9aODz7gl/m/tjuEIGDmoYOm+rb/CYTaxjVd3M9+de2V1dTWEv7ov+MrseUOT8TV5Xr4Wp7jB0HzjEGNrX/OSRQPzl/JOJsyMJmN5nFoHkjTkZz9Xpc4PJ3aOOCnrK0BdlM2jap1M2lk1O1ihWIHQw9y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732414912; c=relaxed/simple;
	bh=SKZUE0cCNrR3sYXzvMSRSV03xJOyooSZpAcGkiFGBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPNLYROzzKtO8ntW+60k3pvOmHKQH0GP8ep64JSYS5E5XSCvwKLjp9gzYrBb98APOaKbSrbWYsTRBkmMhCd7ZAPbd9rDN+kKUWv82LKCp1E2yhN5+/r/tOfCDCM0ylmep7jWu92+l5613cZakMWpc4NP79OM4OAJJ+Z8YBRBP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN7gSIXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8E8C4CECD;
	Sun, 24 Nov 2024 02:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732414911;
	bh=SKZUE0cCNrR3sYXzvMSRSV03xJOyooSZpAcGkiFGBYg=;
	h=From:To:Cc:Subject:Date:From;
	b=VN7gSIXB+lCrG8d4GZbg9W3rl3ZLh3WBHvthw3gm+kbSwtK/6C9CPKcUja4vDjD2u
	 mGl7sTAwi6rb71KPNyspkJel1SUj15kO/EZTwJ+NztkYSTX3F2gmQ9CHSCxzDpBAUw
	 oClQXxyLSDv4W9WMuPoWrYfrWWCUgx+cgBHV/g04K79Pmgp/frMWlCudtCbslHGEgB
	 wo8yORBy48MWjuYC/0UAULF3PJduDECLr44rQ7Xj2DkTLHnMBzmXiw98Qv4hKLpkOV
	 1hXK49JvSM6ZSbwsNOJKqxyXycOO+rWdvPJvYxCnl2vDnKsSfKs6y4GADC+HDxNBUt
	 KzUVNBgwqfDqw==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net v2] net_sched: sch_fq: don't follow the fast path if Tx is behind now
Date: Sat, 23 Nov 2024 18:21:48 -0800
Message-ID: <20241124022148.3126719-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2:
 - use Eric's condition (fix offload, don't care about throttled)
 - throttled -> delayed
 - explicitly CC stable, it won't build on 6.12 because of the offload
   horizon, so make sure they don't just drop this
v1: https://lore.kernel.org/20241122162108.2697803-1-kuba@kernel.org

CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/sch_fq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index a97638bef6da..a5e87f9ea986 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -332,6 +332,12 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
 		 */
 		if (q->internal.qlen >= 8)
 			return false;
+
+		/* Ordering invariants fall apart if some delayed flows
+		 * are ready but we haven't serviced them, yet.
+		 */
+		if (q->time_next_delayed_flow <= now + q->offload_horizon)
+			return false;
 	}
 
 	sk = skb->sk;
-- 
2.47.0


