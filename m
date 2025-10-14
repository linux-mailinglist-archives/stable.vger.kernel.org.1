Return-Path: <stable+bounces-185565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8EBD7180
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 04:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2F18A6B71
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596A1F4E4F;
	Tue, 14 Oct 2025 02:34:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC81C862D
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409288; cv=none; b=fWlbMYmWa4AWeLnFUjM341YiGVUDXXKs4FbhojJv7QQ+wMpzt9XRPy8v0iSm5wes1+IwNLKMG/+I6vA05olhwLAVTcO+YMLt8finmgt1chvDtWwTp5WgotpO4T8Tef46PEwX8YEwLVZWNuRYzBcfG1uERmAaiTRS3y0tTcJFXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409288; c=relaxed/simple;
	bh=FBaR5plMALEkJWdbIpfcbTys5ckgMqepQG119/TWh4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdMEZ2zykIFMK3kFeJBVQBSknuu9kp2t+ILlGrVpzxI2lBvbLR4e4DsIF2t5wMqABMxG4QptnunH5hDlV+yuaXNziXG5FZuEEK0Id9+Xp1aSQRGVaX0kMe7JfTjdk4v1QZjytycOqgltb6BA5sMSH/BkBoEz7VjOB7jOEDvIMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3821061b3a.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409286; x=1761014086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZjisJgnzE8Y+BY1h4B2KaiB1xBx662MQM1196IO0b0=;
        b=JOrpwAJqIUhZAlF9SYGMIwMB8MQyhPReUvjt2s/yEfmjoLwKUciLE1S+JmuFwqLqtI
         51/AqEbVn3bq7voZjABWdVfDfM4LUNcHfrzJRCScjp5JWbEiNUwSvKiRYZK0BsRu7skx
         AZKpTUA5O6xzFX4Fuhmr0dI24HVWLnrC3lBNY99X8rn/xgnjOalwIj8o1xzInqTdXhxk
         66UGlXXPkaYQicWqvzDjR7dxial5+n1CF99zGzG6JjIkExguJwgXFlMnW8FmyHRPzvPP
         aCfWTkYtKG1dpW6OGbvhbp8bklaWOr05r7LAlGt5/ll8xHvjWWKj5s2FtCVUvAR6u1D+
         Xdxg==
X-Gm-Message-State: AOJu0YxgOvpdyqaFPfj8znbGwgub6pwxXKz/QkRJ7Y6luXEJhhPaN/Vz
	nUV4yjx2q4ZKK6T0a6rSJHWkCnVZZIY1z65FEUzC0BQjBuDkCLTzd4wCr+IM+nWw
X-Gm-Gg: ASbGncsJ8C5jQqRvexaYIFA6PPC/YjZ5gfNm6S6SWALHL2IVeJ6VKaJ2QU2NK8T7aZN
	VO/RTagz9rl1cmGv2pqeso5BidUl1ci986GD9mSkssaEhCQi5n4h6xBhBuRtb8ZaN+L+uYfbJ7Q
	3wU9e3IHmJqTgSed7spz1HcsWLXDapRDukeJpLC3EJICdOuaLHvRUEfDRiVfkiJ1MksGw2xeB6B
	tkE5JKKyxWxr1odcvtkEwNyGjy0rS+Uo5i99aTSFTDB7yn3vhVoSAQPe7QYuAbT2sPlM123SwI1
	OmH2xKsiixRZJ5QvSSFH2OP80SPQ9RTfGYcqABnlhTOqy9vqUdhagaHf+/Kd7wyZu02kPts5/TU
	EbvKsWlOW/Ny1CGJNWYyHBaOPmAqE/g==
X-Google-Smtp-Source: AGHT+IHAt1umQylxa4/Yajbo01iA4gOrM9C/4jJR27f0749sEEubSjiAiTZ3/Ohup96fdMKMZ2M4DQ==
X-Received: by 2002:a05:6a00:a0a:b0:77d:13e3:cd08 with SMTP id d2e1a72fcca58-793859f64aemr27785297b3a.5.1760409285802;
        Mon, 13 Oct 2025 19:34:45 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a11:3:200::202c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060c4esm13322561b3a.14.2025.10.13.19.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 19:34:45 -0700 (PDT)
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
Subject: [PATCH 6.12.y 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Tue, 14 Oct 2025 10:34:28 +0800
Message-ID: <20251014023428.26814-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025101329-cyclic-cylinder-9e6b@gregkh>
References: <2025101329-cyclic-cylinder-9e6b@gregkh>
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
index ef7d911da13e..16f5754b8b1f 100644
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
index bdfa5d085f00..7b91df12ce5b 100644
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
index d8d0cf04bb57..a4a2805d3d3e 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -193,6 +193,42 @@ unsigned long rss_anon(void)
 	return rss_anon;
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
@@ -384,3 +420,44 @@ unsigned long get_free_hugepages(void)
 	fclose(f);
 	return fhp;
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
index 2eaed8209925..823d07d84ad0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -53,6 +53,7 @@ int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 unsigned long get_free_hugepages(void);
+bool softdirty_supported(void);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.49.0


