Return-Path: <stable+bounces-95774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B149DBF64
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45890B21B73
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218E1547FD;
	Fri, 29 Nov 2024 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gUt3hjfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E59184F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732860547; cv=none; b=pKSftIRjLES+aYOHvrP0i0MwtF2kDHRgJttdv8n2QL51ZjjEQyqyPs06lHaXZmL1NPjNQx4olsMB/beE2fYJxBhLuWaTLg7SX3JpCJknNwk/7Ma8ZVhNYB8/xfc+HlIh7jxXx5yoiUNLkD6suU8bClLAdgC4FPQ5bhwuebxBUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732860547; c=relaxed/simple;
	bh=PNkiP0VK7Ip++Vg9Ydroq2C86VTtZfj2BrYnEML7Pq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkIhNgpr7yfoWoJW9hP2EEL3jaTWtzzJ1fcrP8wmWxdeXHvse4/3HMnBqygr7hWB4p3OsICFMCYfk0pTr9e14hHpWj8mFnC8cLw80XAKa/KVoElYZ2UFcDNkPiGa20UBR8rtDH5Vppj2q7x7vgf/VIRTJWE6m2cferz4N5XQW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gUt3hjfE; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732860547; x=1764396547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GB4xfh4ocN/L0oK7f1pFAys1btC1Smq3yi13CQOq8yc=;
  b=gUt3hjfEf0x3oQjwtviMtCNHb/hab2L//tWAWGDZTdHwK7AmGE3vNwBA
   LZXgV/imq1G1+TileIV4ah95/6INaYbOofvu8gw6+jZqlWkT+V8wqCex+
   6PoC6cqHphbh5VtSIhgWBLQL0s2UQ8lIL4eYUw7nKbVIaxgIdIeeOLuxM
   U=;
X-IronPort-AV: E=Sophos;i="6.12,194,1728950400"; 
   d="scan'208";a="779519657"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:09:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 3aa0b829-55aa-4374-bdc4-5e98d2c076b1; Fri, 29 Nov 2024 06:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: 3aa0b829-55aa-4374-bdc4-5e98d2c076b1
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 06:08:59 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 06:08:59 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id DA611406F5;
	Fri, 29 Nov 2024 06:08:58 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 95B4F224B1; Fri, 29 Nov 2024 06:08:58 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>, "Dongli
 Zhang" <dongli.zhang@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
	"Hagar Hemdan" <hagarhem@amazon.com>
Subject: [PATCH 6.6] perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
Date: Fri, 29 Nov 2024 06:08:55 +0000
Message-ID: <20241129060856.26060-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 556a7c039a52c21da33eaae9269984a1ef59189b ]

The below error is observed on Ice Lake VM.

$ perf stat
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (slots).
/bin/dmesg | grep -i perf may provide additional information.

In a virtualization env, the Topdown metrics and the slots event haven't
been supported yet. The guest CPUID doesn't enumerate them. However, the
current kernel unconditionally exposes the slots event and the Topdown
metrics events to sysfs, which misleads the perf tool and triggers the
error.

Hide the perf-metrics topdown events and the slots event if the
perf-metrics feature is not enumerated.

The big core of a hybrid platform can also supports the perf-metrics
feature. Fix the hybrid platform as well.

Closes: https://lore.kernel.org/lkml/CAM9d7cj8z+ryyzUHR+P1Dcpot2jjW+Qcc4CPQpfafTXN=LEU0Q@mail.gmail.com/
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Link: https://lkml.kernel.org/r/20240708193336.1192217-2-kan.liang@linux.intel.com
[ Minor changes to make it work on 6.6 ]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 arch/x86/events/intel/core.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 27968d10dd0b..3bc31cd20c81 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5409,8 +5409,22 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return attr->mode;
 }
 
+static umode_t
+td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	/*
+	 * Hide the perf metrics topdown events
+	 * if the feature is not enumerated.
+	 */
+	if (x86_pmu.num_topdown_events)
+		return x86_pmu.intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
+	.is_visible = td_is_visible,
 };
 
 static struct attribute_group group_events_mem = {
@@ -5587,9 +5601,27 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 	return (cpu >= 0) && (pmu->cpu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
+static umode_t hybrid_td_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	if (!is_attr_for_this_pmu(kobj, attr))
+		return 0;
+
+
+	/* Only the big core supports perf metrics */
+	if (pmu->cpu_type == hybrid_big)
+		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group hybrid_group_events_td  = {
 	.name		= "events",
-	.is_visible	= hybrid_events_is_visible,
+	.is_visible	= hybrid_td_is_visible,
 };
 
 static struct attribute_group hybrid_group_events_mem = {
-- 
2.40.1


