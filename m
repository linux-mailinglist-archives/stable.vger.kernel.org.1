Return-Path: <stable+bounces-186499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6ABE987A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2F01563CC2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A732332903;
	Fri, 17 Oct 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7HelXhX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7C3370E2;
	Fri, 17 Oct 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713415; cv=none; b=nRxcGhBynbSjRxOe+dilk0C3cENtX9wUZ+RxRkdDn78RfINIGk8WQbRii0u3E6Cci82U6wpHXadl1a+M0+k8dcRKj/7I5uRIw9me06k2GRhSpxOXLM/m4DcMgtEwW39wyIOqzqwEURpdmHfVFkU/pzNCPa5yjNSxjGe4LufwEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713415; c=relaxed/simple;
	bh=NMOxBXNpV79OA/b5c/49CCEb0girFwchHcVsMNtMuDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0gzlwhivxDWe8C9L1xIxwLzJKpfsrbP3jWxBs2F5IJl0MtstJ0WR+jsLcFoKrjYrHPZfnMVmNA1WY1iwzk9sbKr06QaAMjg3F15v0KN5VQHG5j2v+/HjDywtMu/4dBk0zeCM1k+zxuCbtlfiQ6MZiaYVyIAc64yW5dEEu+xXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7HelXhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F22C4CEFE;
	Fri, 17 Oct 2025 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713414;
	bh=NMOxBXNpV79OA/b5c/49CCEb0girFwchHcVsMNtMuDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7HelXhXphlwKiZcoGI68UcKSoyql0cu5C80e0BBL2WkXD5VQgkZZJoKqofm9NH4Z
	 42dl/THrEAa2/+l38e62y4aUCQbrXUo45D2f5CIo4awFjl8H8sSsLt1Y4KnwW4zmPj
	 bEAK7P3gWpRur04GoE1SSgutvSV6rLTebMKFv3oo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lance Yang <lance.yang@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 156/168] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Fri, 17 Oct 2025 16:53:55 +0200
Message-ID: <20251017145134.792833722@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Yang <lance.yang@linux.dev>

commit 0389c305ef56cbadca4cbef44affc0ec3213ed30 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/vm/madv_populate.c |    9 ++-
 tools/testing/selftests/vm/soft-dirty.c    |    5 +
 tools/testing/selftests/vm/vm_util.c       |   77 +++++++++++++++++++++++++++++
 tools/testing/selftests/vm/vm_util.h       |    2 
 4 files changed, 90 insertions(+), 3 deletions(-)

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
@@ -124,3 +160,44 @@ bool check_huge_shmem(void *addr, int nr
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



