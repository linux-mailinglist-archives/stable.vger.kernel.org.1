Return-Path: <stable+bounces-121662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3CA58BA8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 06:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DF7188CE12
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44D1C57B2;
	Mon, 10 Mar 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FAr5PqtI"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E01170826;
	Mon, 10 Mar 2025 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584329; cv=none; b=fsGM1SruGxYcxuzjM5Jso5ERMyo31TMP3GjVWT/oO7dCF9v3F/iyFLvDZcMaaMxIjRFKXgYCO/cfJjZo3mXcGDxTEu8HCgewI7T/tfmakDl7CGgLhuAkJm1/UEnTb2g0qEe95yqRcrxe/FX9xMUzy7DYLQqAl1UmI2FfoGGSjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584329; c=relaxed/simple;
	bh=UQ6fZ6xghkU5QPnmySKM6lbnO7WA0QxzyR8cuols5P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThkqEPOh/lBOosSbdLE4lN9LCLHEp/dx8/2HO7hVTEM+K9TrFaSf9i6CWZ6V8nNHAhygiIW66PR6uFV+IWrAavJZhNJSI/73bplMzAhgUlJXcthzhdm8x1Hr/t0ZTblRDI7FEubhA9JXt7f2PR9LZwMQHjgWvZqaz+YxG392nLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FAr5PqtI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A50021104A4;
	Sun,  9 Mar 2025 22:25:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A50021104A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741584321;
	bh=nmD9a42GaaiuB3Gy6x1cilqEA4DsGMKK9oZhlim+gG4=;
	h=From:To:Cc:Subject:Date:From;
	b=FAr5PqtIrbIkhKOGNJ+p5qcU4CfnJLwh2PrpGVdEX4QcsdVukMUGZIrST4amVOEpm
	 jJBpja0MT9V+Mkp0cskEO+FOqDWLfHnFtmvFAG0JlMpkPd8fNc8fuq6j0nw1RDPf9D
	 /9WLg1T0gxSf6qfg00712Bpj7UeF6NPWDjQp/XGs=
From: Naman Jain <namjain@linux.microsoft.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	srivatsa@csail.mit.edu,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v5] sched/topology: Enable topology_span_sane check only for debug builds
Date: Mon, 10 Mar 2025 10:55:09 +0530
Message-Id: <20250310052509.1416-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

On a x86 system under test with 1780 CPUs, topology_span_sane() takes
around 8 seconds cumulatively for all the iterations. It is an expensive
operation which does the sanity of non-NUMA topology masks.

CPU topology is not something which changes very frequently hence make
this check optional for the systems where the topology is trusted and
need faster bootup.

Restrict this to sched_verbose kernel cmdline option so that this penalty
can be avoided for the systems who want to avoid it.

Cc: stable@vger.kernel.org
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changes since v4:
https://lore.kernel.org/all/20250306055354.52915-1-namjain@linux.microsoft.com/
	- Rephrased print statement and moved it to sched_domain_debug.
	  (addressing Valentin's comments)
Changes since v3:
https://lore.kernel.org/all/20250203114738.3109-1-namjain@linux.microsoft.com/
	- Minor typo correction in comment
	- Added Tested-by tag from Prateek for x86	
Changes since v2:
https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
	- Use sched_debug() instead of using sched_debug_verbose
	  variable directly (addressing Prateek's comment)

Changes since v1:
https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
	- Use kernel cmdline param instead of compile time flag.

Adding a link to the other patch which is under review.
https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
Above patch tries to optimize the topology sanity check, whereas this
patch makes it optional. We believe both patches can coexist, as even
with optimization, there will still be some performance overhead for
this check.

---
 kernel/sched/topology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..d7254c47af45 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -132,8 +132,11 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 {
 	int level = 0;
 
-	if (!sched_debug_verbose)
+	if (!sched_debug_verbose) {
+		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
+			     __func__);
 		return;
+	}
 
 	if (!sd) {
 		printk(KERN_DEBUG "CPU%d attaching NULL sched-domain.\n", cpu);
@@ -2359,6 +2362,10 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 {
 	int i = cpu + 1;
 
+	/* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
+	if (!sched_debug())
+		return true;
+
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;

base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
-- 
2.34.1


