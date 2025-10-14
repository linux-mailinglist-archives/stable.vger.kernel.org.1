Return-Path: <stable+bounces-185567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7ABD720A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 04:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D75F94E0681
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432A304BBD;
	Tue, 14 Oct 2025 02:52:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A911259CBC
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410362; cv=none; b=qS7qJRFTi1YGSf0eCwhpb6zUWTt9jOWMl7P39ZKd3vBEbBRsM29Vcx3OOxNABGJsR46C9CGfOXeMEiSSU/g9R9yYLaRjTehSPRhxgvhdyM3tOaqWIFl+KtTXFUrGD0ZFfvQZ22PPpHZh5p4JBHsOJYq+yKYEgNNl2YJaO9rpaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410362; c=relaxed/simple;
	bh=UC16EbPigLMsglPShN2aU4x4dx4S/ea9ol+vIvxK6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMh2qDkSagqQq3oO+0CFGKB5KozFclaWRK2N97txyt9sZlBH3OBufzDeqH8z5n05FclPEiYYnd2Xf4siDEVK0Mxicnzs/uVV9zRa3cYUSZGPuUQCM1BhMQYlqFbVca+RmKkUSJqXC6KEOMCgB61wHS3xNcvHTSr869E4r3mDehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-279e2554b6fso35551325ad.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410359; x=1761015159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3iEGPjTEMq28H494G3le/PpjY1d/gXwokrnXwTr0EA=;
        b=uPKF0pOAyvQDjgHi6P6rlqXBji7rK7aRLr1r+U74OLOeS8bnvaLvt5+rmu0Sh+g+A3
         MUzyHtstKrMp9bxFswb/iEjyn4mkwFLYfRA7j+KL2aiw02SRqAgUuM4wI3vYaE11yQp9
         C0kI+6ZIhULYS+EhQEoohdKD2rYSKnc8lQIQfpkvJH+tjSpi/l7Q4p992qUyQEmSvWgx
         IRoSRY2BjXWnjKQf6KVccbfonhNbobjylpKmnob06L4ARMsh7W6hnOJVoo3TWJdr/lx9
         ZyFacgZzwtvx3ggWY4y6wY34mcgiqkvomcHwTZ1XcYiF1CDfW96b/wlCUiRjiAiOYOEX
         0Slg==
X-Gm-Message-State: AOJu0YwH0oLLbfoEuW9za3sWoF98p7pU46bi7kt5UNbtk6UrDVJIuGZm
	7e/hIKI6vydrtrB41Kp65Fa3T3n6pquEV7o5yDI15rGsB8h16Rkrz1fpC3H0CEcs
X-Gm-Gg: ASbGnctBoKvG9Wr111CAOAzNkHUlIZpTEKS8UlYKFR1jaurMYtHgDms9UdNj7Mx7ADZ
	2H+TjYFglX5ylsH7Ry+nvgk4s93JrLS0+8gCPDDln/ZpjQkyrSAW3la2VYcdJ9ubLYgr2J6sjjA
	ELpunx1NjuhdyErWd6vvK3AuTYREiLG5fGzVOkN5S3SPN3WWf56Dl+8Yb5q9zbhxGdMFiGKlI6L
	IFMEIoR0/5gNKn70kNahAM8+QogzGPLZJp9wFfEe3jMgXskWJA3I6M512ZLC3WeO498V+ScyB1T
	v5qIirPH4XgvCrY1epA3ULiAorx2orlSr2CainvnvliV+vd2BIGEgXmmWpJGtoAJe46S8adDNlO
	CeGAJSUIFAMAo2imp/iF6VGJCGnOB3gJgbydWX/9FLswCAQcrKuZP
X-Google-Smtp-Source: AGHT+IFJaPeb2N4JPYVpNkhASYoC4H+gIGNfYkAiyOPGfA7gyXdUEpvFwcG64zzIIMcO+f5GlwBDFA==
X-Received: by 2002:a17:903:8c8:b0:264:a34c:c7f with SMTP id d9443c01a7336-290273568famr335713285ad.7.1760410359395;
        Mon, 13 Oct 2025 19:52:39 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a11:3:200::202c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f4ae6csm147933885ad.108.2025.10.13.19.52.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 19:52:38 -0700 (PDT)
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
Subject: [PATCH 6.6.y 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Tue, 14 Oct 2025 10:52:26 +0800
Message-ID: <20251014025226.35257-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025101329-unplanted-language-2cc7@gregkh>
References: <2025101329-unplanted-language-2cc7@gregkh>
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
 tools/testing/selftests/mm/madv_populate.c | 21 +-----
 tools/testing/selftests/mm/soft-dirty.c    |  5 +-
 tools/testing/selftests/mm/vm_util.c       | 77 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 17bcb07f19f3..7278623acf8c 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,23 +264,6 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
 	int nr_tests = 16;
@@ -288,7 +271,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7dbfa53d93a0..7095b95d19ae 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -193,8 +193,11 @@ int main(int argc, char **argv)
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
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 558c9cd8901c..b2af70d75711 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -97,6 +97,42 @@ uint64_t read_pmd_pagesize(void)
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
@@ -269,3 +305,44 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
 
 	return ret;
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
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 0c603bec5e20..9816d6e9bce6 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -51,6 +51,7 @@ int uffd_register(int uffd, void *addr, uint64_t len,
 int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
+bool softdirty_supported(void);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.49.0


