Return-Path: <stable+bounces-148099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61234AC808E
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB203BF4CA
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57D22D7A2;
	Thu, 29 May 2025 15:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7422D4E7;
	Thu, 29 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534076; cv=none; b=dL4DkXqkhuHZrgvFPNu9qSSnzPyvuuwMcKi+7gUHatLcImgkB9bvgWi5z7c8j1IUNFdAB8zcH+aUpSQLN3kith7auap61PvGrPFpjKixbpKKX4InlYNYCioouNozslpKIDtXbIStH9J24XE5cCZAEDeBij3WCM0fn/5S8P8Zuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534076; c=relaxed/simple;
	bh=K72By17qKFqnx6oumU+tCqeRFWBtx235RLyi4zzGe8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7C1Ra/vR2AnXIXnWGNAb/gpo2gSOE/e6qw8z/6arhO2ZKoVwmIn8WrwU/FabJQIK5cMereNjV0SGVOooJRY0tYxWpzTdFifDFu53vgsuthTJx/KTrSSmaff7fasTE6J3y8U8nc3tqHN8PCMSHfYTtPPh1bjkJn4WFBqfsQ9tcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7WCD53xvzYQv88;
	Thu, 29 May 2025 23:54:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C9A7B1A1592;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBX98EzgzhooMK5Ng--.57784S5;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH v1 3/4] selftests/mm: Extract read_sysfs and write_sysfs into vm_util
Date: Thu, 29 May 2025 15:56:49 +0000
Message-Id: <20250529155650.4017699-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529155650.4017699-1-pulehui@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX98EzgzhooMK5Ng--.57784S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13Zw18urW7Kr43tw1kZrb_yoWrCFyxp3
	WfJ34jgws7Kr13Jr15Aa4qgFyFkrs7JayUt397J34Ivr1UJrZ3WrWSka4jqrn8GrZY9rWf
	Aa4fJFZ3Cr1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Extract read_sysfs and write_sysfs into vm_util. Meanwhile, rename
the function in thuge-gen that has the same name as read_sysfs.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/mm/ksm_tests.c | 32 ++--------------------
 tools/testing/selftests/mm/thuge-gen.c |  6 ++--
 tools/testing/selftests/mm/vm_util.c   | 38 ++++++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h   |  2 ++
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index dcdd5bb20f3d..e80deac1436b 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -58,40 +58,12 @@ int debug;
 
 static int ksm_write_sysfs(const char *file_path, unsigned long val)
 {
-	FILE *f = fopen(file_path, "w");
-
-	if (!f) {
-		fprintf(stderr, "f %s\n", file_path);
-		perror("fopen");
-		return 1;
-	}
-	if (fprintf(f, "%lu", val) < 0) {
-		perror("fprintf");
-		fclose(f);
-		return 1;
-	}
-	fclose(f);
-
-	return 0;
+	return write_sysfs(file_path, val);
 }
 
 static int ksm_read_sysfs(const char *file_path, unsigned long *val)
 {
-	FILE *f = fopen(file_path, "r");
-
-	if (!f) {
-		fprintf(stderr, "f %s\n", file_path);
-		perror("fopen");
-		return 1;
-	}
-	if (fscanf(f, "%lu", val) != 1) {
-		perror("fscanf");
-		fclose(f);
-		return 1;
-	}
-	fclose(f);
-
-	return 0;
+	return read_sysfs(file_path, val);
 }
 
 static void ksm_print_sysfs(void)
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index a41bc1234b37..95b6f043a3cb 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -77,7 +77,7 @@ void show(unsigned long ps)
 	system(buf);
 }
 
-unsigned long read_sysfs(int warn, char *fmt, ...)
+unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
 {
 	char *line = NULL;
 	size_t linelen = 0;
@@ -106,7 +106,7 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
 
 unsigned long read_free(unsigned long ps)
 {
-	return read_sysfs(ps != getpagesize(),
+	return thuge_read_sysfs(ps != getpagesize(),
 			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
 			  ps >> 10);
 }
@@ -195,7 +195,7 @@ void find_pagesizes(void)
 	}
 	globfree(&g);
 
-	if (read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
+	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
 		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
 				   largest * NUM_PAGES);
 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 1357e2d6a7b6..d899c272e0ee 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -486,3 +486,41 @@ int close_procmap(struct procmap_fd *procmap)
 {
 	return close(procmap->fd);
 }
+
+int write_sysfs(const char *file_path, unsigned long val)
+{
+	FILE *f = fopen(file_path, "w");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_path);
+		perror("fopen");
+		return 1;
+	}
+	if (fprintf(f, "%lu", val) < 0) {
+		perror("fprintf");
+		fclose(f);
+		return 1;
+	}
+	fclose(f);
+
+	return 0;
+}
+
+int read_sysfs(const char *file_path, unsigned long *val)
+{
+	FILE *f = fopen(file_path, "r");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_path);
+		perror("fopen");
+		return 1;
+	}
+	if (fscanf(f, "%lu", val) != 1) {
+		perror("fscanf");
+		fclose(f);
+		return 1;
+	}
+	fclose(f);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9211ba640d9c..f84c7c4680ea 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -87,6 +87,8 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
+int write_sysfs(const char *file_path, unsigned long val);
+int read_sysfs(const char *file_path, unsigned long *val);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.34.1


