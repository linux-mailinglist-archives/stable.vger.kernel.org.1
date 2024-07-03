Return-Path: <stable+bounces-57609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E549D925D36
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150D11C20AB0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C51741C0;
	Wed,  3 Jul 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0S7pAYAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBE173334;
	Wed,  3 Jul 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005397; cv=none; b=dzMftunNITiLkinwHTYjcDtj6q2yV5XsbiKyLsc8ZGsV51P+xKXvcC/VZX+DSq2R/VywQ2uSKDf2foGfmhnZptycy7Q/QKH9wGRTAv4xOr5sDddWl9FvYzkVPAiaiWbXskl2jXeLIEG6WNxl32UsU/I17oLa/fE3bH36mZmtCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005397; c=relaxed/simple;
	bh=jVWf1/sOmnbQ8ZWxfZ0GBVkmXmmpduzKVDyG56tnbGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeNBc0l39VB880rFgU57snKTHNbpotmCFbyoLUIiHM4ix0SCH3Gg0TRDI/6wbAFE1TW33Ph2KVvGEnkzBm2ZZ+ZZodErSSFA2S4qX8R1Bp6+lueU1fV7I9tgfe1HPPoZqa0gS5ZYsl/F8fIgS6IIzNrbkkpo0nDNG8FdmLa89ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0S7pAYAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A7FC2BD10;
	Wed,  3 Jul 2024 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005397;
	bh=jVWf1/sOmnbQ8ZWxfZ0GBVkmXmmpduzKVDyG56tnbGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0S7pAYATDypLCS4QglkIsBGgjXZqsW/j+X80lDCHtKVAX1/K+uVdRmzife2EvWT8w
	 g6hs79aNAWS6o42wjuO0WmLAirmAsmffri7ofHEaP3pm+1SysKRjvsBN7XImKhKYHu
	 aEYUkIdAfqkXGvuhhWl/mWcOteuQX/Yxf0fm2kVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/356] selftests/mm: log a consistent test name for check_compaction
Date: Wed,  3 Jul 2024 12:36:43 +0200
Message-ID: <20240703102915.636328702@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit f3b7568c49420d2dcd251032c9ca1e069ec8a6c9 ]

Every test result report in the compaction test prints a distinct log
messae, and some of the reports print a name that varies at runtime.  This
causes problems for automation since a lot of automation software uses the
printed string as the name of the test, if the name varies from run to run
and from pass to fail then the automation software can't identify that a
test changed result or that the same tests are being run.

Refactor the logging to use a consistent name when printing the result of
the test, printing the existing messages as diagnostic information instead
so they are still available for people trying to interpret the results.

Link: https://lkml.kernel.org/r/20240209-kselftest-mm-cleanup-v1-2-a3c0386496b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d4202e66a4b1 ("selftests/mm: compaction_test: fix bogus test success on Aarch64")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/compaction_test.c | 35 +++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index f81931c1f8386..6aa6460b854ea 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -95,14 +95,15 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_test_result_fail("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
-		return -1;
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		ret = -1;
+		goto out;
 	}
 
 	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		ksft_test_result_fail("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -110,8 +111,8 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_test_result_fail("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -120,16 +121,16 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_test_result_fail("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_test_result_fail("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -141,24 +142,26 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
-		ksft_test_result_fail("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
+	ksft_print_msg("Number of huge pages allocated = %d\n",
+		       atoi(nr_hugepages));
+
 	if (compaction_index > 3) {
 		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
 			       "as huge pages\n", compaction_index);
-		ksft_test_result_fail("No of huge pages allocated = %d\n", (atoi(nr_hugepages)));
 		goto close_fd;
 	}
 
-	ksft_test_result_pass("Memory compaction succeeded. No of huge pages allocated = %d\n",
-			      (atoi(nr_hugepages)));
 	ret = 0;
 
  close_fd:
 	close(fd);
+ out:
+	ksft_test_result(ret == 0, "check_compaction\n");
 	return ret;
 }
 
-- 
2.43.0




