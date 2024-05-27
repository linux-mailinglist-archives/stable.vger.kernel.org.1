Return-Path: <stable+bounces-46294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884548CFF93
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4801F21ADC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18E15E5AB;
	Mon, 27 May 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co8LEJEC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D515E5A7;
	Mon, 27 May 2024 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811642; cv=none; b=k5TsEj0jwjxpkK+KDic/tIuZb7VUlpzZF5jHi/T8zbK7mUlcgznrHFsGqZvH6RvcxyaXKWNjB2U/OAtvshfJuzzxj08nwJM5x4wpb0rKDLhM9FhBO6PADTUEVfETT3a7w+ktmP5z4UAfnIF+Devw/g7024TnKndV7QQizbkK3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811642; c=relaxed/simple;
	bh=Q6HzBW3LSaYAiupiLhOT8oiqFvjivNTjzbPPDIc2uag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgjF6yUmTZXJK8BIhdTOg4TvZSSDB2+hc2NTGAgdBXnNtETaRJ49Iwndd7DG+SyDAKIDDLtOhak3OgJwHeghLpc4wxM948TYZbo9pioKpTXVbgZxEaKcpG3mpekF2LPo6lYyGBv7pF9lgdDCENSc4aYIIb/o56mNJFCiLkX68Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co8LEJEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74073C32781;
	Mon, 27 May 2024 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811641;
	bh=Q6HzBW3LSaYAiupiLhOT8oiqFvjivNTjzbPPDIc2uag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Co8LEJEC5qMAS74RlTJm3Yh8502ch8clR/rtF3N1j6+Iyfo3a22VBtL2dObBypVhO
	 iIYNu/iJpmzvMuGytXdALpMTIwYFJtlMjCXNqISEAOCYzUUCrx++iFB/xVq5OJh3Q/
	 EHEpyBUoY9eLa58JZfMrGMC6yhN+rdHEi8QcDEys+S+pHZOW9cgmfKL9m/CFccgItR
	 PESfW6ZfI/Zw6eY2Pn2mHj2kYtwwxb/7vw1NUYn94ST99X+J4tzJw8GpEF40WfC8tF
	 LjP4IgdjTUGGrm2PyRSdzVIwDYFqaeXkUx3BgJq4IcF5uRNfwjoFBgW68+hR+802fV
	 Xzgo4CjhgQSOg==
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
Subject: [PATCH V7 3/9] sched/core: Clear prev->dl_server in CFS pick fast path
Date: Mon, 27 May 2024 14:06:49 +0200
Message-ID: <7f7381ccba09efcb4a1c1ff808ed58385eccc222.1716811044.git.bristot@kernel.org>
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

From: Youssef Esmat <youssefesmat@google.com>

In case the previous pick was a DL server pick, ->dl_server might be
set. Clear it in the fast path as well.

Cc: stable@vger.kernel.org
Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Youssef Esmat <youssefesmat@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 08c409457152..6d01863f93ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6044,6 +6044,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
 		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
-- 
2.45.1


