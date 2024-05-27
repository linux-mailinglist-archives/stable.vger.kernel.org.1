Return-Path: <stable+bounces-46293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C28CFF91
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBADB220F9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57815DBD1;
	Mon, 27 May 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9VnWGgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A01581E2;
	Mon, 27 May 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811636; cv=none; b=Vouy6UgmRii9ZLZ7zYoDCi3hczwlChdUUBRj+4sO8yTnPT/+OaMMy/auZBrS12x52mJK0kq9hTkag3dgz1T6Xauj1f/Wd3yGmagvNHY44GpOpE7fNR8LD1+b7D7qopfwecKKUncNJZrwnCuN2etEu5Rrp5Md1m1+0bWxb5OsspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811636; c=relaxed/simple;
	bh=Ookat3BufN/8SoLPN/8zjg5igMrsT1mPcTpK30q2+rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpwi/fbCa4O5wECNjYarBmHpw6YyqYlqTBggc6bhuDdTSAm74NLNpia36pVB6UiLPXsxYssV9X1dqLMy5DsYwQ69E1BWr0PiYBcQNPpshyjgFViLT3pqF92OYSbRAdI+X5ou27YgQ5nsf2vc2FrGO4TQVsG6eGmuY+Ryohz/TTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9VnWGgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7117C2BBFC;
	Mon, 27 May 2024 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811635;
	bh=Ookat3BufN/8SoLPN/8zjg5igMrsT1mPcTpK30q2+rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9VnWGgWWTY8G+2PkawIPuyuu2UyVWibAFyKgnv8bCkkMIGA8kQ8d+xMDKmmXqZqM
	 82td5g7I5/mf2EdLaOuUZxoN4O0LkZDrjmiEaJrsf9msf/wXAII/ssfsyRRidDpqt1
	 OIImIVeDlb5hOhsJeKMO5q/1MV9j8x1MFauUK5ihbSC7dLyhUy6HGUZBR6NirDjrVF
	 MpE+rSWLy68Ai3D7bzRu2+HWVQsUAXxfUoSR+YG3LDz+T/Q5HbL97In0d+Xgc0v2Ic
	 HmAq89JU7UD4NCfT8TLFImTXVfpJeG1jjasueLkcs0iyMupZ1+Tv9IQjWf0D8CT8jx
	 y2wm5BaqWFHSw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	stable@vger.kernel.org
Subject: [PATCH V7 2/9] sched/core: Add clearing of ->dl_server in put_prev_task_balance()
Date: Mon, 27 May 2024 14:06:48 +0200
Message-ID: <d184d554434bedbad0581cb34656582d78655150.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Paths using put_prev_task_balance() need to do a pick shortly
after. Make sure they also clear the ->dl_server on prev as a
part of that.

Cc: stable@vger.kernel.org
Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..08c409457152 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6006,6 +6006,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -6049,14 +6057,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
-- 
2.45.1


