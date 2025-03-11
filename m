Return-Path: <stable+bounces-123458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68040A5C59F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CE0189B971
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1C25DCE5;
	Tue, 11 Mar 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JskdMdRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71225C715;
	Tue, 11 Mar 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706014; cv=none; b=sUVGOpdJUuwWPUp8BeO4Kv/pcxyAEeR2ekZ/uQf/gyw+lN8L8WDmQ05Iad/N7apLXGpsLwcAPZyHAGz9ax6DloD4/IKGHCXZNKdcWZ/BYU7ID2SMYU9zvaWkuJBxjw6Ass6ciOJ3n0WMV2jSZLOojZ/gQSbtOuuKUR24Z6JVmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706014; c=relaxed/simple;
	bh=CgURnV/FLYwqjzN/O63hIiDvSlllUrL0MZDL5gPQCi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5Dub8WiPgEgCTWZgYSvKTuM9rQ3Z7hV44Q6yx+eTDZA/4hQqjdgn+z+XIQVaPIeZcT1lrh5WtY1CyFnJFV2TToCPchie1kTB9Vvjl4LXw6XQMTUSXFvbMTlUXUMHyPHTBpzGZxfsarwt5hz5AALcRz0Vp5yWZKk8TgD5Vab39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JskdMdRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF87AC4CEE9;
	Tue, 11 Mar 2025 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706014;
	bh=CgURnV/FLYwqjzN/O63hIiDvSlllUrL0MZDL5gPQCi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JskdMdRq6VRpDNav5bYjZcd5Gnwn7GV8JSZQCb+Q0is2S5OsM4Wwa8+Ol4wrdBdtp
	 bRkn02k+SPrarD00E2JlGMcPDd7vUibfzwURPU01Xr7T+YdD7ougBRtrh6tXTzZ+g/
	 W1grE6XOudHd4ijRw45WzvAZEDYxa71S8ikBcnmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Galo <carlosgalo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 233/328] mm: update mark_victim tracepoints fields
Date: Tue, 11 Mar 2025 16:00:03 +0100
Message-ID: <20250311145724.174949087@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Galo <carlosgalo@google.com>

[ Upstream commit 72ba14deb40a9e9668ec5e66a341ed657e5215c2 ]

The current implementation of the mark_victim tracepoint provides only the
process ID (pid) of the victim process.  This limitation poses challenges
for userspace tools requiring real-time OOM analysis and intervention.
Although this information is available from the kernel logs, it’s not
the appropriate format to provide OOM notifications.  In Android, BPF
programs are used with the mark_victim trace events to notify userspace of
an OOM kill.  For consistency, update the trace event to include the same
information about the OOMed victim as the kernel logs.

- UID
   In Android each installed application has a unique UID. Including
   the `uid` assists in correlating OOM events with specific apps.

- Process Name (comm)
   Enables identification of the affected process.

- OOM Score
  Will allow userspace to get additional insight of the relative kill
  priority of the OOM victim. In Android, the oom_score_adj is used to
  categorize app state (foreground, background, etc.), which aids in
  analyzing user-perceptible impacts of OOM events [1].

- Total VM, RSS Stats, and pgtables
  Amount of memory used by the victim that will, potentially, be freed up
  by killing it.

[1] https://cs.android.com/android/platform/superproject/main/+/246dc8fc95b6d93afcba5c6d6c133307abb3ac2e:frameworks/base/services/core/java/com/android/server/am/ProcessList.java;l=188-283
Signed-off-by: Carlos Galo <carlosgalo@google.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/oom.h | 36 ++++++++++++++++++++++++++++++++----
 mm/oom_kill.c              |  6 +++++-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c361..b799f3bcba823 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -7,6 +7,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+#define PG_COUNT_TO_KB(x) ((x) << (PAGE_SHIFT - 10))
+
 TRACE_EVENT(oom_score_adj_update,
 
 	TP_PROTO(struct task_struct *task),
@@ -72,19 +74,45 @@ TRACE_EVENT(reclaim_retry_zone,
 );
 
 TRACE_EVENT(mark_victim,
-	TP_PROTO(int pid),
+	TP_PROTO(struct task_struct *task, uid_t uid),
 
-	TP_ARGS(pid),
+	TP_ARGS(task, uid),
 
 	TP_STRUCT__entry(
 		__field(int, pid)
+		__string(comm, task->comm)
+		__field(unsigned long, total_vm)
+		__field(unsigned long, anon_rss)
+		__field(unsigned long, file_rss)
+		__field(unsigned long, shmem_rss)
+		__field(uid_t, uid)
+		__field(unsigned long, pgtables)
+		__field(short, oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = pid;
+		__entry->pid = task->pid;
+		__assign_str(comm, task->comm);
+		__entry->total_vm = PG_COUNT_TO_KB(task->mm->total_vm);
+		__entry->anon_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_ANONPAGES));
+		__entry->file_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_FILEPAGES));
+		__entry->shmem_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_SHMEMPAGES));
+		__entry->uid = uid;
+		__entry->pgtables = mm_pgtables_bytes(task->mm) >> 10;
+		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d", __entry->pid)
+	TP_printk("pid=%d comm=%s total-vm=%lukB anon-rss=%lukB file-rss:%lukB shmem-rss:%lukB uid=%u pgtables=%lukB oom_score_adj=%hd",
+		__entry->pid,
+		__get_str(comm),
+		__entry->total_vm,
+		__entry->anon_rss,
+		__entry->file_rss,
+		__entry->shmem_rss,
+		__entry->uid,
+		__entry->pgtables,
+		__entry->oom_score_adj
+	)
 );
 
 TRACE_EVENT(wake_reaper,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ee927ffeb718d..42b546c7b74b5 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -42,6 +42,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/cred.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -721,6 +722,7 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
  */
 static void mark_oom_victim(struct task_struct *tsk)
 {
+	const struct cred *cred;
 	struct mm_struct *mm = tsk->mm;
 
 	WARN_ON(oom_killer_disabled);
@@ -742,7 +744,9 @@ static void mark_oom_victim(struct task_struct *tsk)
 	 */
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
-	trace_mark_victim(tsk->pid);
+	cred = get_task_cred(tsk);
+	trace_mark_victim(tsk, cred->uid.val);
+	put_cred(cred);
 }
 
 /**
-- 
2.39.5




