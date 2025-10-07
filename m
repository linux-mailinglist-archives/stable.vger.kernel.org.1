Return-Path: <stable+bounces-183527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866DBC1041
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F49B4F4761
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E42D94A3;
	Tue,  7 Oct 2025 10:29:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DB2D8DB5;
	Tue,  7 Oct 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832996; cv=none; b=V5EHKh7HSGDvc3lUvGYfs/Af2af9VET1ACr2S/dKDBT5pv7RZ2r9qiSl/6og/NiL2s5i8jQ8yTXgdhD5rkPDkf3IYH+ZoLqKbbJGCdKSqXqY4u+FL9NVAFudOdAE61I3y0nPcbhXox8AN8aOrpFeoSvsVdn5YLs5zAnJEYVCv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832996; c=relaxed/simple;
	bh=K9EgXTNWeloymlhQlMOub+ZTfTH5VQt0HXIU7kjBHCM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=C8W7S8BSx1Pt76ZLO1TtDIstLGFD1HbPV2SONIqT2XqmsYYYCd1HRj2PG+x3X1u94qrenNMLCxP2y79y0EV5/yEiKOxw+nvXOdJIXidXJqgcrNCSPJqs9jIiOwGKxMMfgOfrNMqlLE0or54RLozhSboPPZv9KmIUFX5mv61BNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cgsp222dYz5PM34;
	Tue, 07 Oct 2025 18:29:46 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 597ATXmE018488;
	Tue, 7 Oct 2025 18:29:33 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 7 Oct 2025 18:29:35 +0800 (CST)
Date: Tue, 7 Oct 2025 18:29:35 +0800 (CST)
X-Zmail-TransId: 2afb68e4eb8f049-615f1
X-Mailer: Zmail v1.0
Message-ID: <20251007182935207jm31wCIgLpZg5XbXQY64S@zte.com.cn>
In-Reply-To: <20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn>
References: 20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <tujinjiang@huawei.com>, <shr@devkernel.io>
Cc: <akpm@linux-foundation.org>, <david@redhat.com>, <tujinjiang@huawei.com>,
        <shr@devkernel.io>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMi8yXSBzZWxmdGVzdHM6IHVwZGF0ZSBrc20gaW5oZXJpdGF0aW9uIHRlc3RzIGZvciBwcmN0bCBmb3JrL2V4ZWM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 597ATXmE018488
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Oct 2025 18:29:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68E4EB9A.000/4cgsp222dYz5PM34

From: xu xin <xu.xin16@zte.com.cn>

To reproduce the issue mentioned by [1], this add a setting of pages_to_scan
and sleep_millisecs at the start of test_prctl_fork_exec(). The main change
is just raise the scanning frequency of ksmd.

[1] https://lore.kernel.org/all/202510012256278259zrhgATlLA2C510DMD3qI@zte.com.cn/

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 .../selftests/mm/ksm_functional_tests.c       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index ac136f04b8d6..95afa5cfc062 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -38,6 +38,8 @@ enum ksm_merge_mode {
 };

 static int mem_fd;
+static int pages_to_scan_fd;
+static int sleep_millisecs_fd;
 static int pagemap_fd;
 static size_t pagesize;

@@ -493,6 +495,46 @@ static void test_prctl_fork(void)
 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
 }

+static int start_ksmd_and_set_frequency(char *pages_to_scan, char *sleep_ms)
+{
+	int ksm_fd;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		return -errno;
+
+	if (write(ksm_fd, "1", 1) != 1)
+		return -errno;
+
+	if (write(pages_to_scan_fd, pages_to_scan, strlen(pages_to_scan)) <= 0)
+		return -errno;
+
+	if (write(sleep_millisecs_fd, sleep_ms, strlen(sleep_ms)) <= 0)
+		return -errno;
+
+	return 0;
+}
+
+static int stop_ksmd_and_restore_frequency(void)
+{
+	int ksm_fd;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		return -errno;
+
+	if (write(ksm_fd, "2", 1) != 1)
+		return -errno;
+
+	if (write(pages_to_scan_fd, "100", 3) <= 0)
+		return -errno;
+
+	if (write(sleep_millisecs_fd, "20", 2) <= 0)
+		return -errno;
+
+	return 0;
+}
+
 static void test_prctl_fork_exec(void)
 {
 	int ret, status;
@@ -500,6 +542,9 @@ static void test_prctl_fork_exec(void)

 	ksft_print_msg("[RUN] %s\n", __func__);

+	if (start_ksmd_and_set_frequency("2000", "0"))
+		ksft_test_result_fail("set ksmd's scanning frequency failed\n");
+
 	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
 	if (ret < 0 && errno == EINVAL) {
 		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
@@ -542,6 +587,11 @@ static void test_prctl_fork_exec(void)
 		return;
 	}

+	if (stop_ksmd_and_restore_frequency()) {
+		ksft_test_result_fail("restore ksmd frequency failed\n");
+		return;
+	}
+
 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
 }

@@ -656,6 +706,13 @@ static void init_global_file_handles(void)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
 	if (ksm_get_self_merging_pages() < 0)
 		ksft_exit_skip("accessing \"/proc/self/ksm_merging_pages\") failed\n");
+
+	pages_to_scan_fd = open("/sys/kernel/mm/ksm/pages_to_scan", O_RDWR);
+	if (pages_to_scan_fd < 0)
+		ksft_exit_fail_msg("opening /sys/kernel/mm/ksm/pages_to_scan failed\n");
+	sleep_millisecs_fd = open("/sys/kernel/mm/ksm/sleep_millisecs", O_RDWR);
+	if (sleep_millisecs_fd < 0)
+		ksft_exit_fail_msg("opening /sys/kernel/mm/ksm/sleep_millisecs failed\n");
 }

 int main(int argc, char **argv)
-- 
2.25.1

