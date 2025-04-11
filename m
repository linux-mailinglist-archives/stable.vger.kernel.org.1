Return-Path: <stable+bounces-132275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697EA86247
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F7D1B61519
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14620E33F;
	Fri, 11 Apr 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="i19cyPl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB821F2367
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386442; cv=none; b=JuUqQhWfHdRIEmcbu0THWPic0Vo4wyJjqT7Oq9mKwK5Lyyqfuww0QcGnxjPTIfbmhoH8qmfTBAw+2xOPYLBmY53dPOjt4rxf7ZwYVCYhB/fypH9LL4k2Q4H/4ktuVI1kzwS0YK+/JOLLMRs7+bFFOgnl86oWUc4AFG7KsRXPxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386442; c=relaxed/simple;
	bh=4oJYZ6jszem3aU50MgGgijL6yT/vG7LpPcT8uY/QThs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUJwm9IBrKRk+LE5VUrNLFl8s4GqdhI46tqjYbV0gLlyMfClZsVYqjryA1wRFeFFYGDSaZr34IluQhHNiSYXBKfQZ/wnGYtnNmBHo5AdIIOO75cOK1rVGmNQ98EwSHqAMvBp5fLB9wrXN4M+Cp+HpaHiNYOioZ+qbPYez7aYRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=i19cyPl4; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1744386441; x=1775922441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AlBj1fG/Q796nxWokK3npvRWCQm91EqpFopqnQvODPg=;
  b=i19cyPl4ODxFEjaNbBM511jsvAoUIX0ABu5tPkqBXbx1gUUV1QGnT2p+
   DoTRH57vEtEi1zO19X3GCJ3h8NBfD0LZvROEr9kRSt2j2cUZObengs1cm
   z3TaCKe8qij0bRQXmby2Cl6+giaVVBmTYENk2/X9R0jczJ02Lkwkt0LCv
   U=;
X-IronPort-AV: E=Sophos;i="6.15,205,1739836800"; 
   d="scan'208";a="815323595"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:47:15 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:38735]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.242:2525] with esmtp (Farcaster)
 id ec5d9933-12a8-48b3-b431-a4972d2e0b80; Fri, 11 Apr 2025 15:47:13 +0000 (UTC)
X-Farcaster-Flow-ID: ec5d9933-12a8-48b3-b431-a4972d2e0b80
Received: from EX19D023EUB003.ant.amazon.com (10.252.51.5) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 15:47:12 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D023EUB003.ant.amazon.com (10.252.51.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Fri, 11 Apr 2025 15:47:10 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: Oleg Nesterov <oleg@redhat.com>, Dylan Hatch <dylanbhatch@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, David Sauerwein
	<dssauerw@amazon.de>
Subject: [PATCH 5.15.y] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Fri, 11 Apr 2025 15:47:01 +0000
Message-ID: <20250411154701.57102-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
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
 fs/proc/array.c | 53 +++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index c925287a4dc4..2cb01aaa6718 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -462,12 +462,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
@@ -495,12 +495,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = 0;
-	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -511,36 +507,45 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
+		wchan = !task_is_running(task);
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
-
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
-			gtime += sig->gtime;
+			rcu_read_unlock();
 		}
-
-		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
-		pgid = task_pgrp_nr_ns(task, ns);
-
-		unlock_task_sighand(task, &flags);
-	}
-
-	if (permitted && (!whole || num_threads < 2))
-		wchan = !task_is_running(task);
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
-- 
2.47.1


