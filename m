Return-Path: <stable+bounces-50445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E09065F9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7334DB247A8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810113CA80;
	Thu, 13 Jun 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j+hzzjDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DF13C9D8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265437; cv=none; b=VGt9ZQLaqoFdddJuD/rzfcn9TjUQLCFKMzKgdIJ3pbl3Ceog4ULlDGNjqeO2ujeGztqbJdBmH8teasDNl2fip+k75C9k/LTdpgWNjJ6HwKFKAKBE/TDVDS4C6wd78ifzK2oS6I7s4wlT/8JbSdP0fWC5yFkda5SEzmSoz53bXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265437; c=relaxed/simple;
	bh=O8yt9XBhCbhiCyds4/FQHb9pn8RTurUDRvkdg9ceqrs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D4Adz4M2mJnTni0TdY+n+bq/FB/83xy0/Yj9yVvxZ5waW6eR2c1pv2kuS96+E9Esr4cWln39/Xhy9q9yej+Xah4Y9PFuK4gLK2P14pPPs96wjbQzpK27RxKEcNSXlE1skNHF2nKIKmS1MHiNMBWSmBuTRqpNedJleqVOgdeaFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j+hzzjDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148B2C2BBFC;
	Thu, 13 Jun 2024 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265437;
	bh=O8yt9XBhCbhiCyds4/FQHb9pn8RTurUDRvkdg9ceqrs=;
	h=Subject:To:Cc:From:Date:From;
	b=j+hzzjDTIfcOIN8GGIAk23Os4mxsyh3K2LKOKmYU95FCC3L2a0SWHeE/dMkJkD/yv
	 m7uCcbJhopy4q2S2bUgFNJ6g3XzQtmzOPaqkh8MWqfk7+kPtkKNmNq6hDUY+gmSV51
	 ExgH6LvxOLjRK13SEtSVti2a+V5miLt7siep5ba8=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: fix bogus test success on" failed to apply to 6.6-stable tree
To: dev.jain@arm.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:57:14 +0200
Message-ID: <2024061314-unlit-filled-c396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d4202e66a4b1fe6968f17f9f09bbc30d08f028a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061314-unlit-filled-c396@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d4202e66a4b1 ("selftests/mm: compaction_test: fix bogus test success on Aarch64")
f3b7568c4942 ("selftests/mm: log a consistent test name for check_compaction")
9a21701edc41 ("selftests/mm: conform test to TAP format output")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4202e66a4b1fe6968f17f9f09bbc30d08f028a1 Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Tue, 21 May 2024 13:13:56 +0530
Subject: [PATCH] selftests/mm: compaction_test: fix bogus test success on
 Aarch64

Patch series "Fixes for compaction_test", v2.

The compaction_test memory selftest introduces fragmentation in memory
and then tries to allocate as many hugepages as possible. This series
addresses some problems.

On Aarch64, if nr_hugepages == 0, then the test trivially succeeds since
compaction_index becomes 0, which is less than 3, due to no division by
zero exception being raised. We fix that by checking for division by
zero.

Secondly, correctly set the number of hugepages to zero before trying
to set a large number of them.

Now, consider a situation in which, at the start of the test, a non-zero
number of hugepages have been already set (while running the entire
selftests/mm suite, or manually by the admin). The test operates on 80%
of memory to avoid OOM-killer invocation, and because some memory is
already blocked by hugepages, it would increase the chance of OOM-killing.
Also, since mem_free used in check_compaction() is the value before we
set nr_hugepages to zero, the chance that the compaction_index will
be small is very high if the preset nr_hugepages was high, leading to a
bogus test success.


This patch (of 3):

Currently, if at runtime we are not able to allocate a huge page, the test
will trivially pass on Aarch64 due to no exception being raised on
division by zero while computing compaction_index.  Fix that by checking
for nr_hugepages == 0.  Anyways, in general, avoid a division by zero by
exiting the program beforehand.  While at it, fix a typo, and handle the
case where the number of hugepages may overflow an integer.

Link: https://lkml.kernel.org/r/20240521074358.675031-1-dev.jain@arm.com
Link: https://lkml.kernel.org/r/20240521074358.675031-2-dev.jain@arm.com
Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 4f42eb7d7636..0b249a06a60b 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -82,12 +82,13 @@ int prereq(void)
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 {
+	unsigned long nr_hugepages_ul;
 	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[10] = {0};
-	char nr_hugepages[10] = {0};
+	char initial_nr_hugepages[20] = {0};
+	char nr_hugepages[20] = {0};
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -134,7 +135,12 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	/* We should have been able to request at least 1/3 rd of the memory in
 	   huge pages */
-	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
+	nr_hugepages_ul = strtoul(nr_hugepages, NULL, 10);
+	if (!nr_hugepages_ul) {
+		ksft_print_msg("ERROR: No memory is available as huge pages\n");
+		goto close_fd;
+	}
+	compaction_index = mem_free/(nr_hugepages_ul * hugepage_size);
 
 	lseek(fd, 0, SEEK_SET);
 
@@ -145,11 +151,11 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 		goto close_fd;
 	}
 
-	ksft_print_msg("Number of huge pages allocated = %d\n",
-		       atoi(nr_hugepages));
+	ksft_print_msg("Number of huge pages allocated = %lu\n",
+		       nr_hugepages_ul);
 
 	if (compaction_index > 3) {
-		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
+		ksft_print_msg("ERROR: Less than 1/%d of memory is available\n"
 			       "as huge pages\n", compaction_index);
 		goto close_fd;
 	}


