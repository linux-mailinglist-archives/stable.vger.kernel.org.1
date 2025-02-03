Return-Path: <stable+bounces-112010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE0A25878
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5151636EB
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277822036FD;
	Mon,  3 Feb 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hglon55v"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B5202C43;
	Mon,  3 Feb 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583272; cv=none; b=Ymbq2qzw1ZsPF4FREGMW329ZcFwXW1QVU9bytA8B4jsh0weqrTHKEVgIY+Z5PX1vPmfuXI9WYEL9tmelyxU2xiJ8cjYsmG7t3gRO1EcJjMqmNFPul80fgub12Qnn5IEMWlUCOvczAfQbTbE8JyrT3fCyo15D+Vn2F7L6xA2MVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583272; c=relaxed/simple;
	bh=9UvIGGD/jqqbe+DZrf2fVRPgQKDmnE3Wxm6sJHjgxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0sTnOxvxLtxCZOgDWBGkGgj6HTRe/shlsqJSrsrn8VCQdRiPhKOwQWHdXOnHM+e0YkcTj2fwuXM5TJ6mRBOYtY7Jtn0cSLyEKE7h/siW4n+xuF+oMmhoQV5rO/qiMHUETIjtXt6EzaqGr/GLivVJPy2spI3dUzNTq7zXgLyMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hglon55v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BA6A205490F;
	Mon,  3 Feb 2025 03:47:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BA6A205490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738583265;
	bh=GhqWLe0XM7FRu82St3cvIHyrsf62zaHk0HvKjWJ+gHU=;
	h=From:To:Cc:Subject:Date:From;
	b=Hglon55vlI0pU/3vD9QRXL9khphoVCtwVz91oeMlH1Vsp6xhub02TKB6iQuVNSdtA
	 uYqmAvUsitxrNvURFdgu3CW97xZGro8xIZDunIUIP24Z0DXzrT2QNySogFlatIumpH
	 p0sozNy+AbmoFGfQ3Hx2uVMDIXGQi5p4S7RIpOnA=
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
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH v3] sched/topology: Enable topology_span_sane check only for debug builds
Date: Mon,  3 Feb 2025 11:47:38 +0000
Message-ID: <20250203114738.3109-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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
---

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
index c49aea8c1025..b030c1a2121f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 {
 	int i = cpu + 1;
 
+	/* Skip the topology sanity check for non-debug, as it is a time-consuming operatin */
+	if (!sched_debug()) {
+		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
+			     __func__);
+		return true;
+	}
+
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;

base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e
-- 
2.43.0


