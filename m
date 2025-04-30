Return-Path: <stable+bounces-139117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B19AA451E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26685982B5B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB41EF09C;
	Wed, 30 Apr 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y8fYRpNk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C61C5489
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001245; cv=none; b=dMbIQHSPPU9THpwwFmBOQlZ40qut/2VjFYCnNzutrtWHkUIuDPs2CF9WSqeU/bm9Xza112tSzToBCPrZZftwtnycyWsTD6EAqyH4Y3/6ZFzoibc6bEmZ9TgfV0ug+xrpRJ6Q8t6FfR3EvZzuqm0UWszrA/NB66fVHbZK8DIYdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001245; c=relaxed/simple;
	bh=Q/0wL0uH9SCD0N+teGB8RBsruv6SvBDjGovMvGGdwAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvW6aSfH35FlKKxnxdDT3AXR2hz5xuwQ9mrc45b94114v4lBatndXazFtX5BVwgtXQlO8CWZNr262gOXVsm8adMEA7cJ9RPMyKLQs1c+nTpGADP5FYT/mV9G5cKDLb4WgcbD4HY1EumD+M5qjTW7/NmHZtT/KUktENfKbwvGWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y8fYRpNk; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso8119394f8f.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001240; x=1746606040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLro4aTCxgEkjN7C/JuBszwRDlQq6OrD04ukYZrDOyg=;
        b=Y8fYRpNknRo/yWijIe76gVH+Lnr16udrg+P29EDXjR9NVOWhxBkRyZaBBlDaqWBLiW
         EWngvvLUob+fj4Rc27mlByh3z6/k7wy6naSk6OLc7+MnxpEdUCuYBiSsRb2KBbJ9VkM8
         0UuQjELlsuyGQlAOTuGqtjYmMsMJj9ic3ZXfx2NwTdNhpffkAYYcOkN76J8npeNU/cnt
         ZrjySxvoWqhp8/yvCBh2aJhlcyDSPTI91wxQnFdwbruLmeMm2gbzR8viFRlixEC1VaHx
         gl+w+/iQiImIqXKe3kntfeBtaADSmWkcqqKATS+d/ioWgNQwqwKYtNr1B5CQbCCzbXeR
         z1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001240; x=1746606040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLro4aTCxgEkjN7C/JuBszwRDlQq6OrD04ukYZrDOyg=;
        b=VKTdgdFwachkzqO38/DpBueLr8CTwSttFSsT4i7W9At5SzHAC+OF2YFlovljVTVmVm
         V87ITMltwzEsj4A1Rd6YcieZGeJRPeFNAnKD+Cw+Wd+6GxPYu+ZPLWwF69jGriQmxHON
         zwDawaiZXWM+IeOZKJZv9Pq9DTEy5Y/gjciJQQ/ebvwU9dajKq7uzxkkslpelDg1j+NE
         /qXm/AFO049BHpPAYNW+DCsSOvyNvBhp/5A7n9Wqv4SBgUu+tieBzStGMxnASbfp982m
         mcsB2gzoRFtqWJXpODrRIIWGwuNzsCBngcF4CJSfiV4NB41SULdpV6Lh6tsCU+mVLRJJ
         LtZA==
X-Gm-Message-State: AOJu0YzvHdaf5bp0PoksOQlU9H0kUaPNMnjgL6hFTyNLPiJwBuQ0BxLP
	NPpGDjI63DSUltfbhKmLAT5oG1oNCEOnn7E/p6M/9jV0L6qhLIAdxcs4KEgBrs1lunEB/dyKR1H
	cWY/gHg==
X-Gm-Gg: ASbGncteq2YyDFzSesTP7mWPoA10DODdfWTkiDOavExnK3BUJjgpibf/ELE+v4OsQVT
	edcKn2gEn5s0d0+JHfMWF8SXvWKko5R3YLjtJnIX1/gV3WfjoMLEU4lmsrfhIpprwTaDmffDE1q
	lfmzyi92ku8rVOCh+5gs5K0T3GSWo/06GeyoHmaOBwPx15XlsU8m9F/fHMgrK1w3cLFmox4R5Tc
	6Dx0/7tYkyERu/72i6/crxecR8eceSrqpxnJLoTumH7+HqPdNBU50zE4tgES4KuqRQv4p3iFrhJ
	TsqHh1jcyJOJacAGM0unUDZ1IoHOPCssO0ncqkLd8tIUyLqP1xufKQ==
X-Google-Smtp-Source: AGHT+IF3bBCie4dgYuWu18yNrvPraoGcDGLPutjgVzyc6m6mzGx+TuGk70O+r8XF+pX177wasas7fg==
X-Received: by 2002:a5d:5f4c:0:b0:39f:fcb:3bf6 with SMTP id ffacd0b85a97d-3a08f75265amr1777481f8f.2.1746001240224;
        Wed, 30 Apr 2025 01:20:40 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74039a3107bsm1090842b3a.92.2025.04.30.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:39 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 10/10] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
Date: Wed, 30 Apr 2025 16:19:52 +0800
Message-ID: <20250430081955.49927-11-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 04789af756a4a43e72986185f66f148e65b32fed upstream.

Extend changes_pkt_data tests with test cases freplacing the main
program that does not have subprograms. Try four combinations when
both main program and replacement do and do not change packet data.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241212070711.427443-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 55 +++++++++++++++----
 .../selftests/bpf/progs/changes_pkt_data.c    | 27 ++++++---
 .../bpf/progs/changes_pkt_data_freplace.c     |  6 +-
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
index c0c7202f6c5c..7526de379081 100644
--- a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
@@ -10,10 +10,14 @@ static void print_verifier_log(const char *log)
 		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
 }
 
-static void test_aux(const char *main_prog_name, const char *freplace_prog_name, bool expect_load)
+static void test_aux(const char *main_prog_name,
+		     const char *to_be_replaced,
+		     const char *replacement,
+		     bool expect_load)
 {
 	struct changes_pkt_data_freplace *freplace = NULL;
 	struct bpf_program *freplace_prog = NULL;
+	struct bpf_program *main_prog = NULL;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct changes_pkt_data *main = NULL;
 	char log[16*1024];
@@ -26,6 +30,10 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
 	main = changes_pkt_data__open_opts(&opts);
 	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
 		goto out;
+	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
+	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
+		goto out;
+	bpf_program__set_autoload(main_prog, true);
 	err = changes_pkt_data__load(main);
 	print_verifier_log(log);
 	if (!ASSERT_OK(err, "changes_pkt_data__load"))
@@ -33,14 +41,14 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
 	freplace = changes_pkt_data_freplace__open_opts(&opts);
 	if (!ASSERT_OK_PTR(freplace, "changes_pkt_data_freplace__open"))
 		goto out;
-	freplace_prog = bpf_object__find_program_by_name(freplace->obj, freplace_prog_name);
+	freplace_prog = bpf_object__find_program_by_name(freplace->obj, replacement);
 	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
 		goto out;
 	bpf_program__set_autoload(freplace_prog, true);
 	bpf_program__set_autoattach(freplace_prog, true);
 	bpf_program__set_attach_target(freplace_prog,
-				       bpf_program__fd(main->progs.dummy),
-				       main_prog_name);
+				       bpf_program__fd(main_prog),
+				       to_be_replaced);
 	err = changes_pkt_data_freplace__load(freplace);
 	print_verifier_log(log);
 	if (expect_load) {
@@ -62,15 +70,38 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
  * that either do or do not. It is only ok to freplace subprograms
  * that do not change packet data with those that do not as well.
  * The below tests check outcomes for each combination of such freplace.
+ * Also test a case when main subprogram itself is replaced and is a single
+ * subprogram in a program.
  */
 void test_changes_pkt_data_freplace(void)
 {
-	if (test__start_subtest("changes_with_changes"))
-		test_aux("changes_pkt_data", "changes_pkt_data", true);
-	if (test__start_subtest("changes_with_doesnt_change"))
-		test_aux("changes_pkt_data", "does_not_change_pkt_data", true);
-	if (test__start_subtest("doesnt_change_with_changes"))
-		test_aux("does_not_change_pkt_data", "changes_pkt_data", false);
-	if (test__start_subtest("doesnt_change_with_doesnt_change"))
-		test_aux("does_not_change_pkt_data", "does_not_change_pkt_data", true);
+	struct {
+		const char *main;
+		const char *to_be_replaced;
+		bool changes;
+	} mains[] = {
+		{ "main_with_subprogs",   "changes_pkt_data",         true },
+		{ "main_with_subprogs",   "does_not_change_pkt_data", false },
+		{ "main_changes",         "main_changes",             true },
+		{ "main_does_not_change", "main_does_not_change",     false },
+	};
+	struct {
+		const char *func;
+		bool changes;
+	} replacements[] = {
+		{ "changes_pkt_data",         true },
+		{ "does_not_change_pkt_data", false }
+	};
+	char buf[64];
+
+	for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
+		for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
+			snprintf(buf, sizeof(buf), "%s_with_%s",
+				 mains[i].to_be_replaced, replacements[j].func);
+			if (!test__start_subtest(buf))
+				continue;
+			test_aux(mains[i].main, mains[i].to_be_replaced, replacements[j].func,
+				 mains[i].changes || !replacements[j].changes);
+		}
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
index f87da8e9d6b3..43cada48b28a 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
@@ -4,22 +4,35 @@
 #include <bpf/bpf_helpers.h>
 
 __noinline
-long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+long changes_pkt_data(struct __sk_buff *sk)
 {
-	return bpf_skb_pull_data(sk, len);
+	return bpf_skb_pull_data(sk, 0);
 }
 
 __noinline __weak
-long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+long does_not_change_pkt_data(struct __sk_buff *sk)
 {
 	return 0;
 }
 
-SEC("tc")
-int dummy(struct __sk_buff *sk)
+SEC("?tc")
+int main_with_subprogs(struct __sk_buff *sk)
+{
+	changes_pkt_data(sk);
+	does_not_change_pkt_data(sk);
+	return 0;
+}
+
+SEC("?tc")
+int main_changes(struct __sk_buff *sk)
+{
+	bpf_skb_pull_data(sk, 0);
+	return 0;
+}
+
+SEC("?tc")
+int main_does_not_change(struct __sk_buff *sk)
 {
-	changes_pkt_data(sk, 0);
-	does_not_change_pkt_data(sk, 0);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
index 0e525beb8603..f9a622705f1b 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
@@ -4,13 +4,13 @@
 #include <bpf/bpf_helpers.h>
 
 SEC("?freplace")
-long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+long changes_pkt_data(struct __sk_buff *sk)
 {
-	return bpf_skb_pull_data(sk, len);
+	return bpf_skb_pull_data(sk, 0);
 }
 
 SEC("?freplace")
-long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+long does_not_change_pkt_data(struct __sk_buff *sk)
 {
 	return 0;
 }
-- 
2.49.0


