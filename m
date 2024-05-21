Return-Path: <stable+bounces-45474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF358CA810
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967AD1C20E1B
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E915433DF;
	Tue, 21 May 2024 06:38:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020341C63
	for <stable@vger.kernel.org>; Tue, 21 May 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273499; cv=none; b=V3HLfjlSnnIN6byMw9dQIqgabpMNBkB+RnoSmo5ud5cq9UFhTeMLy82orm14i2ECKMbdIt29SV82yVduCspGcVyBxpOkpCn1TXFGhxHsh37d+INNtI1zRof8lWtDH1L2lDUDnMKq5R+5q4SUYnVVYgbBjPzRcnv5XMKvDd/pKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273499; c=relaxed/simple;
	bh=alWOOUxGUCfc+wy8hS4Mnj6SBCPhQ93kcvqQWKWbBL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cg3gv5uWuwmPLFF1LIBQIEmcWNPJmfVE30+laeHUwyB8cEim6JugLV2o6iTUZYEA85QbCXIt02ULHgbpIH1vIvjaFXG9IfH8G69qyCi8/DxJ4pjjx0oPS7AsuL8QUDih7PTvDzAeRO63NpOfX+6mnf0GPqtl46Nqv3AMCWVy+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CFDEFEC;
	Mon, 20 May 2024 23:38:33 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D55C13F641;
	Mon, 20 May 2024 23:38:07 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: dev.jain@arm.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/3] selftests/mm: compaction_test: Fix bogus test success on Aarch64
Date: Tue, 21 May 2024 12:07:53 +0530
Message-Id: <20240521063755.666388-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521063755.666388-1-dev.jain@arm.com>
References: <20240521063755.666388-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if at runtime we are not able to allocate a huge page, the
test will trivially pass on Aarch64 due to no exception being raised on
division by zero while computing compaction_index. Fix that by checking
for nr_hugepages == 0. Anyways, in general, avoid a division by zero by
exiting the program beforehand. While at it, fix a typo.

Changes in v2:
- Combine with this series, handle unsigned long number of hugepages

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

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
-- 
2.34.1


