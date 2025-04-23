Return-Path: <stable+bounces-135234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300CA97E65
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD27C7A6846
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49067265619;
	Wed, 23 Apr 2025 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KW1tDa4I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1655EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387680; cv=none; b=seyRFCf7iLyfAIe8csXumZgpt21+JRm8/K0ov1U6WYtZe4rtCliUkP8YStOjlRSEvZlQfTZDN6CZYqqyluEGcSEnOZ5NCTM7bHRUSbAol1alkenuupw/gs0hA7+hBoeEoS/AFXvpTDi5Y2LAcbW/kTUcFzmaqT5P9G7y82kuPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387680; c=relaxed/simple;
	bh=Q/0wL0uH9SCD0N+teGB8RBsruv6SvBDjGovMvGGdwAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2GJkLVl+fpyutItH4StWtXgnG033JA/+Zq4mezBKgRD/qq4+tiXwwUI8CDVL1bVvPAW2eHCNRuZqnw3JHaNfs6aK+vs31ra+Fl+QBstUA7XFi8kgVAAXMwTMzE6/EBCE9OwYaSdCE5b1r0X8Ov9FXA2utxW2wL6JBD3Rlp0Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KW1tDa4I; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so9846874a12.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387676; x=1745992476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLro4aTCxgEkjN7C/JuBszwRDlQq6OrD04ukYZrDOyg=;
        b=KW1tDa4IoHT4TXO2rm8z68zY0HPUcV5Wi0OIkUeOA7d1luQbSCAKCHgZ9ngrKh3HE0
         RzSAQgBx2tRi1GPBb+h2b9vap0u67auVWLmti4JWNJrOo1KZEE/Zxk2grigNNnUkAzFt
         VYEZXs7N/7WQMU9d89JjD4LRiE9nrcv/VykyVBB0ga2dSHM8zXe1Jq+l9mJtvEYc1aHs
         g90tUBVyvA4MQi2IB78bcn8l+3d6RY7m2TvB2fM0FLENfkWUQMqriUzUpyP1dpVm4lUA
         1ac/WnHgte1TSe403LXcahMT/5bZplsFJTyaFo6DzTJfnzgBTnswQQUoaZaqLP/CLxyJ
         KgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387676; x=1745992476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLro4aTCxgEkjN7C/JuBszwRDlQq6OrD04ukYZrDOyg=;
        b=JbBkJE+SwY4SYcJBf4Km7HUkCZUTlJDIAD0A4x4LS6EgPLKtrjX7GsJ/hz0Iq+dp1h
         ma1XodifB/I5A/ECvN4o9U3jNBsAfj3SbA1YUnHyJe5Yk8zCGIHGWL7PCk4+9KMsoiZ7
         z/2GA64nCBI7SPL8ISSiHge2NKFNAgvIpFvkELWWOZLQObnS457qBSZ3U8smzmBWUwhh
         AtNWsKFHHsizT2b2veXBB4Klmmh53CtnhFTYB4eTubQCghxgJsLpo3y+0/+JnzPcDRTT
         FBw9Ad7gcvE0f3uPnMYtHCrcxdKbljlRS+O1Ktd4bD8BhTYqtZiFAHg8dwXYGhgBIvz7
         Gt8A==
X-Gm-Message-State: AOJu0Yy56/c3bif79SLMEvpCrlMC3ndlW/LiLnwJnFot7mU4NBUOL9Iy
	UZb4EuAU80vKOPiaG6iTDGjLCTMG7/9X+Ye1LvM4dhqbiFKvP/304+duBRye0FUbJqAXQKXQ6Oh
	qbzK1XA==
X-Gm-Gg: ASbGncv3iyO+lZY2wJ2BU/fnBLyup7PySrgTIIK8ub06KAJP5icz7m3XAZ+QEnRF2Hj
	N1Lx0NionHk1ulkccGacao86zbdeXMsXs3EpMvcr2kXipQTUr0/q47il0GHylY4y9UxeXwZe95f
	VgeSaMIm7F6pAZ5975z+3b4A2tUr9LNbkxb8P9vvVl/K7u+u9l5aVwa541mTKRhtJNpIH706ZbS
	COzlC5A/FuIZfYSIfyZZ5r6ogqfKZ3LZVPdAxrKH4CQGBs2MF48MznK5OPhqVKxgm5EVgAlYawQ
	4PL2XduTg985uFYUo9yXNBLjkyekAl1SGljNVVSnSJw9d6bsaHCafZrogaqzM3IE8lHDjA==
X-Google-Smtp-Source: AGHT+IE33a7ZYiqYiw+AqIzRTMgueFD7kByItwko4uPwZThrCCZyZb/Cf3mYJQIt2HYGiC2eKMBIHg==
X-Received: by 2002:a17:907:743:b0:aca:cac7:28e2 with SMTP id a640c23a62f3a-acb74d8310bmr1673092166b.40.1745387675994;
        Tue, 22 Apr 2025 22:54:35 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaeab50sm9632380b3a.166.2025.04.22.22.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:35 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 8/8] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
Date: Wed, 23 Apr 2025 13:53:29 +0800
Message-ID: <20250423055334.52791-9-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
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


