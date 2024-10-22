Return-Path: <stable+bounces-87766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9D9AB59A
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020821F2386E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FB1C9B86;
	Tue, 22 Oct 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j6AG7kUY"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88861C7B98;
	Tue, 22 Oct 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619861; cv=none; b=GlHd2wlCpzA8bE/aiXSnkvW7ymMsNh7p+9IfbZUTMeoFgDGg8U/VwAOLPbFgr80rz4LiIKavz+dJ2wGpLUT55hTNk8sws9w+61DzWaM46Pe+4CLKmt8Jflg/TsKQgrHKZ8nesWtgay6tI1mAWrIpZMA3zuUBEgpGv9RdVvmu/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619861; c=relaxed/simple;
	bh=rXrvx1WPGPDwjcWKUH0FnLk6OcHtQYABwn43TN2DErA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ljdaoi6oVQOXw23Q+19klq20Re6a8kdQe5GzS4ucMAKbJM//LfBneKIaGKJJQG4jsXHrZPiLZX3qh/E8Yucg+aIgcZBwHHm5Is7ItTQYPbPOEqplbgjPXIscbICDW1CZ+ccMQ8z4DQbnf6JeInQZpCSyGuK5Emj1Kq1B+iSVYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j6AG7kUY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 34569210FBBD;
	Tue, 22 Oct 2024 10:57:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34569210FBBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729619859;
	bh=RaEgNvlyDPu6gmaxMsf39NwStpnU9QnZ5TzKi6GHQhI=;
	h=From:To:Cc:Subject:Date:From;
	b=j6AG7kUYzsTqBYEYEBuHZpf4FiDfLXW1MXluQctrJIcowSV4JowBqSYGDBTCmHir0
	 Z8fmYklWjXcKZEEkC1iCPIqCutf3LYkfz024UMo7+rOYxhbR7v55Eh+Esbj5fITyaA
	 igSiyIqZT3jpl2J7LIvRM99yFpdU1yXHQVeKRYRo=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	ssengar@microsoft.com,
	srivatsa@csail.mit.edu
Subject: [PATCH] sched/topology: Enable topology_span_sane check only for debug builds
Date: Tue, 22 Oct 2024 10:57:33 -0700
Message-Id: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On a x86 system under test with 1780 CPUs, topology_span_sane() takes
around 8 seconds cumulatively for all the iterations. It is an expensive
operation which does the sanity of non-NUMA topology masks.

CPU topology is not something which changes very frequently hence make
this check optional for the systems where the topology is trusted and
need faster bootup.

Restrict this to SCHED_DEBUG builds so that this penalty can be avoided
for the systems who wants to avoid it.

Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 kernel/sched/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..dacc8c6f978b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2354,6 +2354,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
 /*
  * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
  * any two given CPUs at this (non-NUMA) topology level.
@@ -2387,6 +2388,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 
 	return true;
 }
+#endif
 
 /*
  * Build sched domains for a given set of CPUs and attach the sched domains
@@ -2417,8 +2419,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		sd = NULL;
 		for_each_sd_topology(tl) {
 
+#ifdef CONFIG_SCHED_DEBUG
 			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
 				goto error;
+#endif
 
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
-- 
2.43.0


