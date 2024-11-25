Return-Path: <stable+bounces-95340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473C9D7B2F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FB2162D23
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328901E517;
	Mon, 25 Nov 2024 05:32:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36E249E5
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512777; cv=none; b=LBy0NnBNoDNTjM82yfo9InUwGELMxENc2v4b2GE7LtlzsczkCU/ztG6+QxiN4K13c2DHHk/ptg2V5aNoF8+M2sTifkxBBCoEgRSAnUkhRubjYYQU0iIaEtGPe28wN35JjXIiylHLSjDoUGql6WE216Ksjeyvzcs2xJpl3IBU4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512777; c=relaxed/simple;
	bh=R4Mte8cPEQI0N0a/LsCmFZNXqzi10GYS9mnOTdxmqDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0Kg9D0MWq7ks/Bzal6K66q9Yz1uikBpDO3DG30q2dJw1Ca/QNzI0Q3uC9PvCAglIXgZxtXxBmJgPWfXSs7PC79PrtQItpPMvCwlMU/jjy8tbnvdSI160Q2y//D4lp6bsedNpu2+FbKyicsFHYb8mPrEfyMSksM3KtucxXnIFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP46Wjg032442;
	Mon, 25 Nov 2024 05:32:45 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4336189me4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Nov 2024 05:32:45 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 24 Nov 2024 21:32:44 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 24 Nov 2024 21:32:43 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <oleg@redhat.com>
Subject: [PATCH 6.6] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Mon, 25 Nov 2024 13:33:07 +0800
Message-ID: <20241125053307.374219-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hd5We1Zet4SJ3_K6MYdTQi17GD1q7XkX
X-Proofpoint-GUID: hd5We1Zet4SJ3_K6MYdTQi17GD1q7XkX
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67440bfd cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=PtDNVHqPAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8
 a=qLP9lVyGxuQOJfS2YR4A:9 a=BpimnaHY1jUKGyF_4-AF:22 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_02,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411250045

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
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/proc/array.c | 57 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 37b8061d84bb..34a47fb0c57f 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -477,13 +477,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
 	int exit_code = task->exit_code;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -511,12 +511,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
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
@@ -527,26 +523,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
-		cmin_flt = sig->cmin_flt;
-		cmaj_flt = sig->cmaj_flt;
-		cutime = sig->cutime;
-		cstime = sig->cstime;
-		cgtime = sig->cgtime;
 		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
-			struct task_struct *t = task;
-			do {
-				min_flt += t->min_flt;
-				maj_flt += t->maj_flt;
-				gtime += task_gtime(t);
-			} while_each_thread(task, t);
-
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
-			gtime += sig->gtime;
-
 			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
 				exit_code = sig->group_exit_code;
 		}
@@ -561,6 +540,34 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
+		cmin_flt = sig->cmin_flt;
+		cmaj_flt = sig->cmaj_flt;
+		cutime = sig->cutime;
+		cstime = sig->cstime;
+		cgtime = sig->cgtime;
+
+		if (whole) {
+			struct task_struct *t;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
+			__for_each_thread(sig, t) {
+				min_flt += t->min_flt;
+				maj_flt += t->maj_flt;
+				gtime += task_gtime(t);
+			}
+			rcu_read_unlock();
+		}
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
 	} else {
-- 
2.43.0


