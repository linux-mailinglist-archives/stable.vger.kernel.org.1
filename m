Return-Path: <stable+bounces-196799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B906FC8275D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5BEC4E24D4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAFE2EA168;
	Mon, 24 Nov 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHXqkXrZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79D2E2840
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017960; cv=none; b=gmi4q3eEkxvldVpqCcojT+MVAjETNGW4JvhcEJMHNq0vJXYqTojdlaV4KlWAuqhWyUBBIwF82/UWeoD1iOTEHFrpb5OxGtC2Eg+EGroS5HDxcflUIKi9xy3msT6X/davWBpWdAQiJ3Tm7yE2r5uVdd02+uMoXU5U2T2PPivZBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017960; c=relaxed/simple;
	bh=RNJVZtLuB6fBQQX3bg+HvE5t6eC0q9iMziGBjtzsGTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RINesUn8tQBdCqhHsVgSZ7sleRP7pVpo50JV1Fkrb3gmyzM5Af8bkX7CmVOS6OnplzRwnUEj9YNCWzZHV/YGw0OCVBkndZNKjbnpUFniRxR+gm0R8D77VPbslZZ5N0bqSvisdd4X08/iBwG4UzYsx96HAFB2C5izgz90PATZzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHXqkXrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F42C16AAE;
	Mon, 24 Nov 2025 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764017960;
	bh=RNJVZtLuB6fBQQX3bg+HvE5t6eC0q9iMziGBjtzsGTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHXqkXrZkiqK8ed1w2eIvO7ERCIRAM5PSCZcEzaPYfiEdUMnFn8bSmpC23+9VNDk9
	 +YXZplWQmhZqI1yf7MwGB+XHyf6ceDZXWQ/XHv7rH14V4itOB8qoB9snO70jvDLIqr
	 Dve+7P865K2/Baxv+j2MILIUVPStnG1bIxh4l2EwN3WNzT58jDiJAwUWMJBPVJzNFv
	 HUfhtY97BOQs0JYOFdYUDkyVym6DS5BBs5VRlf3i2EmmOTBVEj0tTbF1Ez5cYzyZ45
	 36Zv8ez0h7w0wDqleXZy7VmB+QWibgs2kMl3ri5K4By/K/ATLcyU8pcSOJg+IwJabC
	 65k/h4cj3r+mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+355158e7e301548a1424@syzkaller.appspotmail.com,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mptcp: fix race condition in mptcp_schedule_work()
Date: Mon, 24 Nov 2025 15:59:17 -0500
Message-ID: <20251124205917.27437-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124205917.27437-1-sashal@kernel.org>
References: <2025112402-confiding-slideshow-217f@gregkh>
 <20251124205917.27437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 035bca3f017ee9dea3a5a756e77a6f7138cc6eea ]

syzbot reported use-after-free in mptcp_schedule_work() [1]

Issue here is that mptcp_schedule_work() schedules a work,
then gets a refcount on sk->sk_refcnt if the work was scheduled.
This refcount will be released by mptcp_worker().

[A] if (schedule_work(...)) {
[B]     sock_hold(sk);
        return true;
    }

Problem is that mptcp_worker() can run immediately and complete before [B]

We need instead :

    sock_hold(sk);
    if (schedule_work(...))
        return true;
    sock_put(sk);

[1]
refcount_t: addition on 0; use-after-free.
 WARNING: CPU: 1 PID: 29 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
  __refcount_inc include/linux/refcount.h:366 [inline]
  refcount_inc include/linux/refcount.h:383 [inline]
  sock_hold include/net/sock.h:816 [inline]
  mptcp_schedule_work+0x164/0x1a0 net/mptcp/protocol.c:943
  mptcp_tout_timer+0x21/0xa0 net/mptcp/protocol.c:2316
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x22f/0x710 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  run_ktimerd+0xcf/0x190 kernel/softirq.c:1138
  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Cc: stable@vger.kernel.org
Fixes: 3b1d6210a957 ("mptcp: implement and use MPTCP-level retransmission")
Reported-by: syzbot+355158e7e301548a1424@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6915b46f.050a0220.3565dc.0028.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251113103924.3737425-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 591882cf86453..e40cd7f61106a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -716,14 +716,19 @@ static void mptcp_reset_timer(struct sock *sk)
 
 bool mptcp_schedule_work(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) != TCP_CLOSE &&
-	    schedule_work(&mptcp_sk(sk)->work)) {
-		/* each subflow already holds a reference to the sk, and the
-		 * workqueue is invoked by a subflow, so sk can't go away here.
-		 */
-		sock_hold(sk);
+	if (inet_sk_state_load(sk) == TCP_CLOSE)
+		return false;
+
+	/* Get a reference on this socket, mptcp_worker() will release it.
+	 * As mptcp_worker() might complete before us, we can not avoid
+	 * a sock_hold()/sock_put() if schedule_work() returns false.
+	 */
+	sock_hold(sk);
+
+	if (schedule_work(&mptcp_sk(sk)->work))
 		return true;
-	}
+
+	sock_put(sk);
 	return false;
 }
 
-- 
2.51.0


