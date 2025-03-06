Return-Path: <stable+bounces-121173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE112A54274
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F1A3ADD28
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 05:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D381990AB;
	Thu,  6 Mar 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p5RYhwuJ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC538DFC;
	Thu,  6 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240448; cv=none; b=FJ9eBSd8aQRiX1wx5PPmzEUM92SPiBuDeqVhv3ej5uW+DUbnXbit+54h59Y37JyGDxP7Eef4lO7k72DPuyZARuAye+VTM5EvZT9otxWjYXd5Ci3thCYVVogjwHaNnixvw9lTRiRZmngYtLj4lSsYM6ymVx4gSKiTXqK8VJt6wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240448; c=relaxed/simple;
	bh=RtNMk6CkpnYVHyGLgMRy2qu0U5YISKGT4Rp6VgakTZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TO77oSJMeXcQPHv9ivVrWK5r3PzE205Gy71eWWhxc412TEas4Ry5Z7Nclwdlypi2lyBTlm+Hz9N/0ogjhXwaOhMeKAQmbYxCwn7/oVExxBpXL9uZ6GMFLALLrJ7EuzbC/C5PT6p9l585E4axLhQdNE+APR/S3HFVDwqJU9+8ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p5RYhwuJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5638721104B2;
	Wed,  5 Mar 2025 21:54:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5638721104B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741240446;
	bh=c9/w+F2JSYsBy5jmq+6LSxe4kArENwUiG/f1/vGprkM=;
	h=From:To:Cc:Subject:Date:From;
	b=p5RYhwuJChFPYPCnQZF/yhcB3lk2e9E9+wmdObF7RQjpYQkxdlYJ2Coe9YAN1bqc9
	 hV31S+cwIiG1W9Z7LWljOosQeR6FpH0zxxtpiVtPYhyeSXXhz76Qf6vnFyLsjdqhw+
	 ohwCiWM/4dNyNO4mxoFfTupnSdPuCg3Sbvhrdu94=
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
Subject: [PATCH v4] sched/topology: Enable topology_span_sane check only for debug builds
Date: Thu,  6 Mar 2025 11:23:54 +0530
Message-Id: <20250306055354.52915-1-namjain@linux.microsoft.com>
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
 kernel/sched/topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..666f0a18cc6c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 {
 	int i = cpu + 1;
 
+	/* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
+	if (!sched_debug()) {
+		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
+			     __func__);
+		return true;
+	}
+
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
-- 
2.34.1


