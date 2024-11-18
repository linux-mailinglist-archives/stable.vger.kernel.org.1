Return-Path: <stable+bounces-93777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F849D0BF3
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D7C1F2134D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215F188906;
	Mon, 18 Nov 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KxOeHPNZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A71714A1;
	Mon, 18 Nov 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922784; cv=none; b=eQkoD02984FCwdTf5AMuKYFDGkKZp772/nsJVxBLFAdpsXtWyL5kAUar0Aq30jayc0WmFOcFlPmRueNBBkpS0hx2ALpGDC3Z+3U990tCNlo7m0lMD6tMYQTrbh5aaTY8nARaaCOL9erSITHTrVLXUJN5tvI4gwebsN/Uob2GkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922784; c=relaxed/simple;
	bh=jI2oUO+1tsMleG+aQ41cfYpVkgtPY3AKQrsU4Nb2XJw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=G1w3jh2GG1JjcT2uLsEBLQZ96f5XuehCL1+E4BaJueMNOPgG720OzagA7+HtLeC6RRlEls9m9W1Vgchg/95HYJqB9TtTd66JePEcYtYMNp859oCMqNknfimnrphq87JcXgQV69uVKHun0s8jJBfFGjYJTJ+Ei7lJzUB7n4vU88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KxOeHPNZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id F148820BEBD0;
	Mon, 18 Nov 2024 01:39:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F148820BEBD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731922783;
	bh=svmTY/2kdXFMsccrG2M7GQxcnbt1jxzePbgPFOpjeHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KxOeHPNZn72MXN/NANVCUXhUWZvH+PPSx/ueNHww+PzaTOo4VLQ/lJHziXXQ4J8bD
	 W2t7OdG3JG152gJqDQKInIhK0I+8NCL3WcK6TjzlWyrL99Egj9zhJZp6ldzcmbRr/i
	 Cm0DkWPkFozGTue4ma1C13bBsDl3dDj2Gj0HchRM=
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
Subject: [PATCH v2] sched/topology: Enable topology_span_sane check only for debug builds
Date: Mon, 18 Nov 2024 01:39:37 -0800
Message-Id: <1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com>
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

Restrict this to sched_verbose kernel cmdline option so that this penalty
can be avoided for the systems who wants to avoid it.

Cc: stable@vger.kernel.org
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]
	- Use kernel cmdline param instead of compile time flag.

 kernel/sched/topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..4ca63bff321d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2363,6 +2363,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 {
 	int i = cpu + 1;
 
+	/* Skip the topology sanity check for non-debug, as it is a time-consuming operatin */
+	if (!sched_debug_verbose) {
+		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
+			     __func__);
+		return true;
+	}
+
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
-- 
2.43.0


