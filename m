Return-Path: <stable+bounces-111953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF19A24CFD
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A801681AB
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F051D63D2;
	Sun,  2 Feb 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="PN3mnr/T"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97121DB943
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482657; cv=none; b=R//QpEKjVXTkrETzXyzaRvWc6jWsp0+wK8gTv3LG9U3ZbV0On4h4+moLE0BOrJXB2/LsxwljgTx+vdLUWdRO6y5hzd4O8u5t9BtS5Vo4RRLLIBv91y2yP+Rwhm+Yxe/PvG80LYfIZiVekp9VojA0QnN1/t0ltsWG7cxLTw4jcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482657; c=relaxed/simple;
	bh=Wt9pUzg6U+FNdrm1QfxI36mH26Q8U2BFaUxwgTPu0LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQdMiAIcEn9YVLPsE3YGnXdn8IRFkYW9iVCzoEVZY8KcwuFtkng63d+zlVev0AMCyEVkp6/F6jAISHOrb2+fVXq0AKHQcHuVR28We7z12HxlqMLw1mNj/MvYEHXLUdabphItGGlXEyytwdQtrXUSYcGGoKHQt5QXFGs1O317ZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=PN3mnr/T; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id C92891C2441
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 10:50:53 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482653; x=1739346654; bh=Wt9pUzg6U+FNdrm1QfxI36mH26Q
	8U2BFaUxwgTPu0LE=; b=PN3mnr/TbbmsiNoXBQ13IL2uaAaCu4bZPOUGV6/3kqe
	XAl4bHQBzHWE7fcgnlH98uJYPI9V4LMVl1qrbWJh9VfAw+nZ2XrU3Ru5oizaQaSj
	Ue4Xd8LihrEK+EugvVsyEwiCnWhEhYa0lkSwfnqGlALCh7bj++lmG3+5v3MsFxeo
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W4S1C5xqjWVm for <stable@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:53 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id B7A831C244F;
	Sun,  2 Feb 2025 10:50:24 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 14/16] rcu: Export rcu_request_urgent_qs_task()
Date: Sun,  2 Feb 2025 07:46:51 +0000
Message-ID: <20250202074709.932174-15-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

commit 43a89baecfe200cb4530f42b9fcf904925d6d14a upstream.

If a CPU is executing a long series of non-sleeping system calls,
RCU grace periods can be delayed for on the order of a couple hundred
milliseconds.  This is normally not a problem, but if each system call
does a call_rcu(), those callbacks can stack up.  RCU will eventually
notice this callback storm, but use of rcu_request_urgent_qs_task()
allows the code invoking call_rcu() to give RCU a heads up.

This function is not for general use, not yet, anyway.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230706033447.54696-11-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 include/linux/rcutiny.h | 2 ++
 include/linux/rcutree.h | 1 +
 kernel/rcu/rcu.h        | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 768196a5f39d..68ebe147e45d 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -138,6 +138,8 @@ static inline int rcu_needs_cpu(void)
 	return 0;
 }
 
+static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
+
 /*
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 5efb51486e8a..8d0cecced199 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -21,6 +21,7 @@ void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
+void rcu_request_urgent_qs_task(struct task_struct *t);
 
 /*
  * Note a virtualization-based context switch.  This is simply a
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index af6a06b86298..edff841a1a69 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -452,7 +452,8 @@ static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
-static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
+static inline void rcu_async_hurry(void) { }
+static inline void rcu_async_relax(void) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
@@ -464,7 +465,6 @@ void show_rcu_tasks_gp_kthreads(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
-void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #define RCU_SCHEDULER_INACTIVE	0
-- 
2.43.0


