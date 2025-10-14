Return-Path: <stable+bounces-185573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD3BD758F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 06:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101393B17AA
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8830CDB5;
	Tue, 14 Oct 2025 04:59:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61C30CDAE
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417990; cv=none; b=mbppgdphxRQlNVAUI5i82kHqkFK/DI89xQDITwOL9UZj5QVYWjO7mtK1xG1UWuR7WdJ2wBiZjeheFAwVvB1ONVUemdtOw72Mi5znNh9RwoOYugo16IDJw4YEZYmbFGWcxXBgumrOQkG4dYh5aDRmOETX9QcIbFp454EHCY2X57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417990; c=relaxed/simple;
	bh=XrXf8F/xtbgKNN/s4AA2++vwld5mD4/9QMIYMN9HtiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCXwFjwM07AhP0VTnZ2Q6jSjXPyDsGdEJ693sg6uFe+nGdRJOzKs7nSQUtNdX62AICe00W6MFUKxY/F+K8agofTqzMSGXA0GdH6enTiLqdojup8Exk2vMapGc/nzdkzZOUFvuAHTuY1stknGlTYICVkB6YrJeU2U/YWs9jSdLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b631b435d59so3130347a12.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 21:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417986; x=1761022786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7IUlAhB88E0TndW9aY0W3O4BbLrJPatp6viH0im4zM=;
        b=FwGU1/XLBiO0dlJaEx9zOsCTqQ8OuA44qFdWBpE2KUZDItrwXk9EuM2G9Fpx9d7CvK
         aAh3LJLFeJ6uqQ2acMd/vd8ztG8093PmiYVF1hMZsuZRMKGIPqCg6Gt/15PlJ0lfEEcn
         0ib04GcdRo3RrWi0hRf2/w52VrNY3pnOLNx3NsXm+f8CvFttL83YTyOh5lI13DotLO+/
         ygEqxblXEIRmS77JqkR/x4yXoIeRsUpBaVn3Ws2CQ7Je3+jD3zedGzTDWlRBqTtvqU7/
         gvY6I6c644RV311ipSg94SXjo2R4SQn0u7+q5bKiVNyPmIhtywHnVYiw87du4tsVNq3d
         dMrQ==
X-Gm-Message-State: AOJu0YxHYFeLEU+iAMdEW4SitxVwPdEmy0tigzdvjikoUMwr/XZwdlyL
	aJ/CV06baspDDsJDrObDQ7lidLzDyshsE2UJ+WRUA8Iu/w0BYVFwsEYpfiLK9Ftm
X-Gm-Gg: ASbGncu01aOzk5mIMFeS2E/8ZuzTbQlmiI+2XTeumNic7TE8a6I6VPKiAKp0UC/DG5h
	JZ5ZmWGW3HHLvc4rDn+DaOKgNINJdLs8Cs1XNYDGbkDuDlEW3GbO2TkPrDSVuqGMshnk9demvSa
	2dIAGIe3sZIC8rn/u5YAu+y61FK478y2uMTFlQ9h34PHmpG/1p35IkdVZiTNwUrOurO9hPbfTts
	e07O+DsOze//M2ZArxAoZguxHXcuCEP2sjWdtnH+Ug4+sCO17LpbqEj/TGIvd99B8vDmZgWW5+w
	R7zmQZv7atgbCsr34gqumNN1GpdY11130+E73zVD/7cFqo4B3y5mLOajvd+r6tJV6xNVJec5nIo
	wZ20GuDIIrO5J8ZvszgWEgAMEJOOVXj69TX5nRujy
X-Google-Smtp-Source: AGHT+IFjFdZHGXT/x9wuBsdsKcMSUOCZEq1MwGHaq7Dd+Jdf9jADzgCkgSMal9VmF64Wpt1ilzESQw==
X-Received: by 2002:a17:902:da8e:b0:26a:589b:cf11 with SMTP id d9443c01a7336-29027402d24mr340881805ad.43.1760417986016;
        Mon, 13 Oct 2025 21:59:46 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a11:3:200::202c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e39727sm149783765ad.51.2025.10.13.21.59.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 21:59:45 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Tue, 14 Oct 2025 12:59:31 +0800
Message-ID: <20251014045931.86386-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025101330-hemstitch-crimson-1681@gregkh>
References: <2025101330-hemstitch-crimson-1681@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The madv_populate and soft-dirty kselftests currently fail on systems
where CONFIG_MEM_SOFT_DIRTY is disabled.

Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
tests are properly skipped when the feature is not enabled.

Link: https://lkml.kernel.org/r/20250917133137.62802-1-lance.yang@linux.dev
Fixes: 9f3265db6ae8 ("selftests: vm: add test for Soft-Dirty PTE bit")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0389c305ef56cbadca4cbef44affc0ec3213ed30)
---
 tools/testing/selftests/vm/madv_populate.c |  9 ++-
 tools/testing/selftests/vm/soft-dirty.c    |  5 +-
 tools/testing/selftests/vm/vm_util.c       | 77 ++++++++++++++++++++++
 tools/testing/selftests/vm/vm_util.h       |  2 +
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
index 715a42e8e2cd..f37bda59c18c 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -274,12 +274,16 @@ static void test_softdirty(void)
 
 int main(int argc, char **argv)
 {
+	int nr_tests = 16;
 	int err;
 
 	pagesize = getpagesize();
 
+	if (softdirty_supported())
+		nr_tests += 5;
+
 	ksft_print_header();
-	ksft_set_plan(21);
+	ksft_set_plan(nr_tests);
 
 	sense_support();
 	test_prot_read();
@@ -287,7 +291,8 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	test_softdirty();
+	if (softdirty_supported())
+		test_softdirty();
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
index 21d8830c5f24..615ab2d204ef 100644
--- a/tools/testing/selftests/vm/soft-dirty.c
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -190,8 +190,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index f11f8adda521..fc5743bc1283 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -72,6 +72,42 @@ uint64_t read_pmd_pagesize(void)
 	return strtoul(buf, NULL, 10);
 }
 
+char *__get_smap_entry(void *addr, const char *pattern, char *buf, size_t len)
+{
+	int ret;
+	FILE *fp;
+	char *entry = NULL;
+	char addr_pattern[MAX_LINE_LENGTH];
+
+	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
+		       (unsigned long)addr);
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
+
+	fp = fopen(SMAP_FILE_PATH, "r");
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__,
+				   SMAP_FILE_PATH);
+
+	if (!check_for_pattern(fp, addr_pattern, buf, len))
+		goto err_out;
+
+	/* Fetch the pattern in the same block */
+	if (!check_for_pattern(fp, pattern, buf, len))
+		goto err_out;
+
+	/* Trim trailing newline */
+	entry = strchr(buf, '\n');
+	if (entry)
+		*entry = '\0';
+
+	entry = buf + strlen(pattern);
+
+err_out:
+	fclose(fp);
+	return entry;
+}
+
 bool __check_huge(void *addr, char *pattern, int nr_hpages,
 		  uint64_t hpage_size)
 {
@@ -124,3 +160,44 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
 {
 	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
 }
+
+static bool check_vmflag(void *addr, const char *flag)
+{
+	char buffer[MAX_LINE_LENGTH];
+	const char *flags;
+	size_t flaglen;
+
+	flags = __get_smap_entry(addr, "VmFlags:", buffer, sizeof(buffer));
+	if (!flags)
+		ksft_exit_fail_msg("%s: No VmFlags for %p\n", __func__, addr);
+
+	while (true) {
+		flags += strspn(flags, " ");
+
+		flaglen = strcspn(flags, " ");
+		if (!flaglen)
+			return false;
+
+		if (flaglen == strlen(flag) && !memcmp(flags, flag, flaglen))
+			return true;
+
+		flags += flaglen;
+	}
+}
+
+bool softdirty_supported(void)
+{
+	char *addr;
+	bool supported = false;
+	const size_t pagesize = getpagesize();
+
+	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	supported = check_vmflag(addr, "sd");
+	munmap(addr, pagesize);
+	return supported;
+}
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 5c35de454e08..470f85fe9594 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdint.h>
 #include <stdbool.h>
+#include <sys/mman.h>
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
@@ -10,3 +11,4 @@ uint64_t read_pmd_pagesize(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
+bool softdirty_supported(void);
-- 
2.49.0


