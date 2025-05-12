Return-Path: <stable+bounces-143165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800BAB330D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E53BCFCF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7925D542;
	Mon, 12 May 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1SrQBVB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8625B67B
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041666; cv=none; b=LpykkYmdbmqtxMCwuf7LCCvSpkxSeoG52mZjBhJShzms7QjjRHlymFxtMJLmDlB3Cq3vGCUk0LlIQ2lW1h3Cct2zEnXdwxX1RZDFTxkRwPw/O364SCKc1uQqDEkk8531eUWFstFP0Xgk5AB2sjPO9JvmcYOe2GiB9OxOAS5WldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041666; c=relaxed/simple;
	bh=VbUZXaQJmIZfY3JD/a2Ib3hZHLikO+fYLXHvJU7KLAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NP4nh6oK+saACUQIZTfkQmLUgXGoVUnnqgwcxIVy7iYY2jI2Mz8GnmtCyWPLT44GWyvE23Z5OkuwsBPl6AX1QkNuF/FwkluJva7n2vx97lxz4ZXzZYNzBDT7uAxUWdRqzvgXqgoP7NXpSJQBTwKeHb1JEZXhLghIBE72xIeM4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1SrQBVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7655FC4CEE7;
	Mon, 12 May 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041665;
	bh=VbUZXaQJmIZfY3JD/a2Ib3hZHLikO+fYLXHvJU7KLAg=;
	h=Subject:To:Cc:From:Date:From;
	b=E1SrQBVBJK8XAzB0sqyDxghPdIk7tbxv4j74hXOk8D66ZKB3pWCUr1VQPAPEyVn6T
	 8LOIssaBXbbb/XbmbPTGU0u20edZXZtspX1N4NVsplaMe6le2QCRDY+3OdpuL0zgNo
	 t1hqX1wvMaYmGFiBtO/+wtnWhIbSA78Zw6E+5um0=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: support platform with huge" failed to apply to 5.4-stable tree
To: feng.tang@linux.alibaba.com,akpm@linux-foundation.org,baolin.wang@inux.alibaba.com,baolin.wang@linux.alibaba.com,dev.jain@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:20:46 +0200
Message-ID: <2025051246-book-chase-1d4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ab00ddd802f80e31fc9639c652d736fe3913feae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051246-book-chase-1d4c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab00ddd802f80e31fc9639c652d736fe3913feae Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@linux.alibaba.com>
Date: Wed, 23 Apr 2025 18:36:45 +0800
Subject: [PATCH] selftests/mm: compaction_test: support platform with huge
 mount of memory

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
Tested-by: Baolin Wang <baolin.wang@inux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 2c3a0eb6b22d..9bc4591c7b16 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -90,6 +90,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	int compaction_index = 0;
 	char nr_hugepages[20] = {0};
 	char init_nr_hugepages[24] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
 		 "%lu", initial_nr_hugepages);
@@ -106,11 +108,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 		goto out;
 	}
 
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
 


