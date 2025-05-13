Return-Path: <stable+bounces-144103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B0AB4B8A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE4188920B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209CC1DF98F;
	Tue, 13 May 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q1sLerr3"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F0A93D
	for <stable@vger.kernel.org>; Tue, 13 May 2025 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747115919; cv=none; b=MHyfdDK1J4/wzB4Tyk9q07az7sFDASc4DB3xifLYXhFrONJraOKM3CeDToJ+Zk+UXYJcPGMAQtWcZ6Bn2ADKvqT1daNj4vcHIcq8xNowLqJluScyJAonaT9Mv7AEm+59I2NywoLB474MRgUx3weCSOh7B+0czqKP97OxuSWg/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747115919; c=relaxed/simple;
	bh=CtJB2nNL7iJE9vB7/Ewn1WU9w2tzhNnrULQN5bRBz9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYukzP+BjHUQVyQLOSPYd3vPGlgpxK3XYAdeSYQsg+20gUhr7xTAIEktlUBI24EYvikkpRSFD4NGh+QWYyjU3COrk1/Vtd4F5kWP0lr3O/o8Qk4/VmlfxbcSEJzrmgnsolH+cbcRSj/YlN09osu7rXIOaq4sS1O5grUySEUXCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q1sLerr3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747115913; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GreWYfLjYNSiWzOVK8iv7aQesrNJekpykc7rQaH+GCI=;
	b=Q1sLerr392u7n4D9JxSIh0mkow5aeDwZ+UPUUug/3yd84nhUV5tC+IjSmA37pdsFeZPdGoV5/zSVHmFouociKcVSBGPjwO88mOd07MU3vRobPzdk81kLYWnPSKwpsnSniFp2b7FPEArwHzFnN+z79SRGo3BX0XqEmUbmwp6KwVo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WaULH8N_1747115911 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 13:58:32 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Sri Jayaramappa <sjayaram@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] selftests/mm: compaction_test: support platform with huge mount of memory
Date: Tue, 13 May 2025 13:58:31 +0800
Message-Id: <20250513055831.93239-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2025051243-poster-expiring-81bc@gregkh>
References: <2025051243-poster-expiring-81bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ab00ddd802f80e31fc9639c652d736fe3913feae upstream.

When running mm selftest to verify mm patches, 'compaction_test' case
failed on an x86 server with 1TB memory.  And the root cause is that it
has too much free memory than what the test supports.

The test case tries to allocate 100000 huge pages, which is about 200 GB
for that x86 server, and when it succeeds, it expects it's large than 1/3
of 80% of the free memory in system.  This logic only works for platform
with 750 GB ( 200 / (1/3) / 80% ) or less free memory, and may raise false
alarm for others.

Fix it by changing the fixed page number to self-adjustable number
according to the real number of free memory.

Link: https://lkml.kernel.org/r/20250423103645.2758-1-feng.tang@linux.alibaba.com
Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
Acked-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/selftests/vm/compaction_test.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 309b3750e57e..38fec412206b 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -89,6 +89,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 	int compaction_index = 0;
 	char initial_nr_hugepages[20] = {0};
 	char nr_hugepages[20] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -119,11 +121,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
-	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+	/*
+	 * Request huge pages for about half of the free memory. The Kernel
+	 * will allocate as much as it can, and we expect it will get at least 1/3
+	 */
+	nr_hugepages_ul = mem_free / hugepage_size / 2;
+	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
+		 "%lu", nr_hugepages_ul);
+
+	slen = strlen(target_nr_hugepages);
+	if (write(fd, target_nr_hugepages, slen) != slen) {
+		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
+			       nr_hugepages_ul, strerror(errno));
 		goto close_fd;
 	}
 
-- 
2.39.5 (Apple Git-154)


