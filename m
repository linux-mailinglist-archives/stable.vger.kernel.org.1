Return-Path: <stable+bounces-132276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09274A8624B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425E68A6FAF
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248D20E03C;
	Fri, 11 Apr 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LSftiyYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2B126C13
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386506; cv=none; b=arFkJfXt5+JdncZX1Ke9cKL2DH72N4dEFml5oP0W/3llAaWa9XSRvs6waeFF3q7bEoWChAn3HpOGVqUSqf029fhPTTnM4uCT7OHxKECO96ovHtq7RhMYGZf8uMkj6Uk5DdmO/4Jaq6WKyn9lZ0ClahAMLurb5remz1dXMm15OgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386506; c=relaxed/simple;
	bh=djb8YAzfiPjgdXMX2duxYPXhxZHjj5t0sxCKKmKbqTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DV/0990HMyS4p2UNSCQ7+O+HJeCz9oc2JjFqZyQ1EqNWH5S5y5YS3mgIhPDv2y1knSMFP8BTmFI+W+em/jP7HL1cGTEHsxGKTnwSLCDjGICSp6zGAqFqnu59l3nvnRBhW0AUtR07OpsiLGTEDxYu8sOYN3E9Hg+Qv43MYj+BUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=LSftiyYp; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1744386505; x=1775922505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Boa7HasX643xuHx6SQAC1Y+vDhAKy4vjytnJi7TM80U=;
  b=LSftiyYpKOxfIFWnVp4KNODHFLJ7TCQeXpNixNsVji12aUInXMf4JAbx
   qZtEKkFgjPsmgFC3B6p/qBcuftqE5noBqJAAFYxDCp9LHcDvHZn+mNG5P
   zQVQFjKEjSXX9qKdIMu8k9nhLn8FO5H2opm9muiRpJarTYaWY0mmPqtIT
   8=;
X-IronPort-AV: E=Sophos;i="6.15,205,1739836800"; 
   d="scan'208";a="82918999"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:48:21 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:59055]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.69:2525] with esmtp (Farcaster)
 id 01a5845a-d395-4ab4-883a-a0b7f43ba48a; Fri, 11 Apr 2025 15:48:20 +0000 (UTC)
X-Farcaster-Flow-ID: 01a5845a-d395-4ab4-883a-a0b7f43ba48a
Received: from EX19D023EUB003.ant.amazon.com (10.252.51.5) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 15:48:19 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D023EUB003.ant.amazon.com (10.252.51.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Fri, 11 Apr 2025 15:48:17 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: Oleg Nesterov <oleg@redhat.com>, Dylan Hatch <dylanbhatch@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, David Sauerwein
	<dssauerw@amazon.de>
Subject: [PATCH 5.10.y] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Fri, 11 Apr 2025 15:47:58 +0000
Message-ID: <20250411154758.57959-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D023EUB003.ant.amazon.com (10.252.51.5)

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 7601df8031fd67310af891897ef6cc0df4209305 ]

lock_task_sighand() can trigger a hard lockup.  If NR_CPUS threads call
do_task_stat() at the same time and the process has NR_THREADS, it will
spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change do_task_stat() to use sig->stats_lock to gather the statistics
outside of ->siglock protected section, in the likely case this code will
run lockless.

Link: https://lkml.kernel.org/r/20240123153357.GA21857@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: David Sauerwein <dssauerw@amazon.de>
---
 fs/proc/array.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 18a4588c35be..8fba6d39e776 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -443,12 +443,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	int permitted;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0;
-	u64 cutime, cstime, utime, stime;
-	u64 cgtime, gtime;
+	unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
+	u64 cutime, cstime, cgtime, utime, stime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -476,12 +476,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = utime = stime = 0;
-	cgtime = gtime = 0;
+	utime = stime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -492,37 +489,48 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
+		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
+
+		sid = task_session_nr_ns(task, ns);
+		ppid = task_tgid_nr_ns(task->real_parent, ns);
+		pgid = task_pgrp_nr_ns(task, ns);
+
+		unlock_task_sighand(task, &flags);
+	}
+
+	if (permitted && (!whole || num_threads < 2))
+		wchan = get_wchan(task);
+
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
 		cmin_flt = sig->cmin_flt;
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
 		cstime = sig->cstime;
 		cgtime = sig->cgtime;
-		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
 			struct task_struct *t = task;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
 			do {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
 			} while_each_thread(task, t);
+			rcu_read_unlock();
 
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
 			thread_group_cputime_adjusted(task, &utime, &stime);
-			gtime += sig->gtime;
 		}
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
-		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
-		pgid = task_pgrp_nr_ns(task, ns);
-
-		unlock_task_sighand(task, &flags);
-	}
-
-	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
-- 
2.47.1


