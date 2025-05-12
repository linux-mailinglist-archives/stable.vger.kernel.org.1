Return-Path: <stable+bounces-143163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61697AB3306
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D617117B8E2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B525B673;
	Mon, 12 May 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGq9krTb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AD25B668
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041660; cv=none; b=f7g+xxYlGT98FEqKWWIbLuix9iwi7kSwXAOtjxk0cM+4ea4AaqRqdbo6NlN5QCL0uy84L8ExO8Mz+ziChAJlw+JfXul68p4G51+PPQl8rroCdEdUkk9ZOjNViYK1n00zJqCEx2f1ISADVRwkLAmXs3woj9qWu3gcZGInt5TrIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041660; c=relaxed/simple;
	bh=mOw0jZOGydFhgxezAPWDsaRPndhNfwBs4+3zouem9J4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bGrdgh/w9qixIv6fSIgfoVuU1xAxC7E8vjiklfRW8nBpwo1S7e0PUyeewdF1xg8N1gAO+QltoUuQ7OKsYircsZmDCujlGrnVSdpJmaYS0y/7pex4+dFteMBtO3rQcgFi0oITec3SEKDS21OStcrJiZI6EqBj9VLmI0/q32n/02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGq9krTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C5FC4CEE7;
	Mon, 12 May 2025 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041659;
	bh=mOw0jZOGydFhgxezAPWDsaRPndhNfwBs4+3zouem9J4=;
	h=Subject:To:Cc:From:Date:From;
	b=CGq9krTb6NLmVFYVaE8+267Cu9cKEeux2nF11QFUbu1GU4JmSdYjNMxt3nu4/cszz
	 IOCxS9gNPpngD9t4sLLTm1ztOi0KTxG4qEMLNp9kkRHK2Beypu+GjtTXzMCGatuoeP
	 OZEWAL7lwuXeQTUpmnOvx5ayEyC6M4JdIwgXP1oc=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: support platform with huge" failed to apply to 5.15-stable tree
To: feng.tang@linux.alibaba.com,akpm@linux-foundation.org,baolin.wang@inux.alibaba.com,baolin.wang@linux.alibaba.com,dev.jain@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:20:44 +0200
Message-ID: <2025051244-backwater-computer-184f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ab00ddd802f80e31fc9639c652d736fe3913feae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051244-backwater-computer-184f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


