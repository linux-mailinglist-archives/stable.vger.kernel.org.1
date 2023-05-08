Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC86FAB7F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjEHLOE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjEHLOB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7B35B0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C9862BC1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC297C433EF;
        Mon,  8 May 2023 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544434;
        bh=8L17YB0cC2N/BVvnhsFJ2duIe5kL8IcfTOzPwWmjbis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Al1w2ruEuY91FY146Vffip81nKC1OgseLfi9R3egCmfO/J/pTLNO42nOU5OZ4ISsS
         pbheJQDR+o2xxPHETR8j+YOtAB07PZ1PlC7or16aBQrhq9zZrSSowSN9AyXq03IVb8
         y5cBwZqf/0XxiNlqOhmmVG1KQZ50jHFazkp3Nx38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 408/694] selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
Date:   Mon,  8 May 2023 11:44:03 +0200
Message-Id: <20230508094446.465295868@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Song Liu <song@kernel.org>

[ Upstream commit de6d014a09bf12a9a8959d60c0a1d4a41d394a89 ]

Currently, perf_event sample period in perf_event_stackmap is set too low
that the test fails randomly. Fix this by using the max sample frequency,
from read_perf_max_sample_freq().

Move read_perf_max_sample_freq() to testing_helpers.c. Replace the CHECK()
with if-printf, as CHECK is not available in testing_helpers.c.

Fixes: 1da4864c2b20 ("selftests/bpf: Add callchain_stackid")
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230412210423.900851-2-song@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bpf/prog_tests/perf_event_stackmap.c      |  3 ++-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 15 --------------
 tools/testing/selftests/bpf/testing_helpers.c | 20 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
index 33144c9432aeb..f4aad35afae16 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
@@ -63,7 +63,8 @@ void test_perf_event_stackmap(void)
 			PERF_SAMPLE_BRANCH_NO_FLAGS |
 			PERF_SAMPLE_BRANCH_NO_CYCLES |
 			PERF_SAMPLE_BRANCH_CALL_STACK,
-		.sample_period = 5000,
+		.freq = 1,
+		.sample_freq = read_perf_max_sample_freq(),
 		.size = sizeof(struct perf_event_attr),
 	};
 	struct perf_event_stackmap *skel;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index f4ea1a215ce4d..704f7f6c3704a 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -2,21 +2,6 @@
 #include <test_progs.h>
 #include "test_stacktrace_build_id.skel.h"
 
-static __u64 read_perf_max_sample_freq(void)
-{
-	__u64 sample_freq = 5000; /* fallback to 5000 on error */
-	FILE *f;
-	__u32 duration = 0;
-
-	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
-	if (f == NULL)
-		return sample_freq;
-	CHECK(fscanf(f, "%llu", &sample_freq) != 1, "Get max sample rate",
-		  "return default value: 5000,err %d\n", -errno);
-	fclose(f);
-	return sample_freq;
-}
-
 void test_stacktrace_build_id_nmi(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 6c44153755e66..3fe98ffed38a6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -229,3 +229,23 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 
 	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
 }
+
+__u64 read_perf_max_sample_freq(void)
+{
+	__u64 sample_freq = 5000; /* fallback to 5000 on error */
+	FILE *f;
+
+	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
+	if (f == NULL) {
+		printf("Failed to open /proc/sys/kernel/perf_event_max_sample_rate: err %d\n"
+		       "return default value: 5000\n", -errno);
+		return sample_freq;
+	}
+	if (fscanf(f, "%llu", &sample_freq) != 1) {
+		printf("Failed to parse /proc/sys/kernel/perf_event_max_sample_rate: err %d\n"
+		       "return default value: 5000\n", -errno);
+	}
+
+	fclose(f);
+	return sample_freq;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 6ec00bf79cb55..eb8790f928e4c 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -20,3 +20,5 @@ struct test_filter_set;
 int parse_test_list(const char *s,
 		    struct test_filter_set *test_set,
 		    bool is_glob_pattern);
+
+__u64 read_perf_max_sample_freq(void);
-- 
2.39.2



