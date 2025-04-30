Return-Path: <stable+bounces-139113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60770AA4519
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1B91C0273B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0401E9B03;
	Wed, 30 Apr 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVjFQlbw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF81EF09C
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001230; cv=none; b=JUMT7nFFAU0UiYt8VgQwemHkpWjzOyDZeY8hiaTL0yxj+e4pld8wNp+3xNKX58oiCzy47D/4RsJy3Rfp9p+QU6+0HKi8haKtEWh1tAzF4gvEXxUtq3FaBXt/Xyy1mrHGAFyF4VeCcwOmtvEft24GU27ofjkYis8R0Hf2k9XTPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001230; c=relaxed/simple;
	bh=x/1/wwDeK9aMIY2Z6rZDgNhhsBDjaajZVPyLCXf9MAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvWBcm/2SjwXf7hpte2TyxQQUvA3PPXpoWWLRyU4joyBscAO2wnLI5CvjcNsJ2X9VhC6hmrgCxAjO14SFiAujPDU59Db/xZeDm5KhH0dneCqXsfVJsgFQfLD2hLpJC7ZSwsJjr+VAGWalGVyAXmTHBKN501Su/skIZUc60LKq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DVjFQlbw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39d83782ef6so469833f8f.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001227; x=1746606027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxnXAPMMu2L8Z0EYHZYOhKGuk5P0dV4UaLVJpWA0lNc=;
        b=DVjFQlbwUVkg16DdjZ0QdXGgW3TmGSdElRrjprf2F0SAX3WPhRzp7QRpgWa7NVv2hT
         qT3UwtXiAThEVoS5Ba9lhS/d5je1VfBWWf59vy31TH9ArIgb/ZfLjTfuO4/Bcej5AHUs
         HuDNTTk9KjxWB2chi5J1l7xKOS+hbWndZKHWbdWDnUYAQ8CF+3uYvNkUARcHt8zfFCge
         mMiMelYUbSRwZSIkG7G+ob/cOQiSk61d2jXEPxjGVMVOA6VOGaRPL27MLGGF4fB9SB9j
         nUCKE6r70TOfD5HxsguKj7Zbh8lqGrih7DQ46X36lQCUXLf2/uzC4vLIMVyGHxJ3EWnX
         5Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001227; x=1746606027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxnXAPMMu2L8Z0EYHZYOhKGuk5P0dV4UaLVJpWA0lNc=;
        b=hD0eOu7uVerPmEAkspLp6cJBtqkp5+zEAvp0nbEGO0/R7XeKC06ozbvpaE/snkKg0N
         Pyoh749ono587oSNbO45+mFlSRyJFvWxAt0e8rNbd3S44SuwvsqxIbgzk6ut0N8ZlSoT
         b7ciWoI6F0lzD1crhSfd0xsmIvKZTWMADJ8nSJ37bmK8WDy8gFkBa5w1SDyi3vznnGpu
         kLu8J4vhAeEG0lZQ+y/aex68+IPipjyrtGrJgjFTLPwakhVzWJsEykRj/wOAI7IQxw1T
         go0mkm+YXtq5+DwoEcMiEX0WRj39rqe7F7ZFV7I3b07vy1TsL6hw0R9eUb0zxAxQQrjz
         j0aw==
X-Gm-Message-State: AOJu0YwpmlGAhDZGsvw1dYe+mHaQh+xrgOoFfIOnyPW3eVesaOqerule
	0x0tN6wxWN1gJMpZRKRFKpGvhwaV/q1wIVySdPftPATJXzA/6rA9/F9MNNaZrQZSYMw3kBdVnGh
	c4k5jYA==
X-Gm-Gg: ASbGncvEONkDj5K8mjtLjUHuGgY1jGFzBM3jY/MkDR5H+p1Yv7Y6qoW65DZMcXqA1H4
	8Av8KURSFAm/qofskzRBaf2rX6Y5/aQoDScFiaTUJfUKvQwlwvNegQ/pgmTpUBpI7t9/zxBS1Uq
	HAxBgaAJPKpVwhfLXzNThtep93b7lE+d4ieBnc1IxlFODqKzuugFF/RRTcB/Arf6u8f6kTRXq5F
	PYj0m+vXJ4JWmdXLRFPAaxzEeyxPL6p0hK0QcfXv5PKgIteyEq6ctPGCNPkOfQJLvTZ0kQMlwGM
	0LhbPuoFNqW1Y2D1/ps6CuFRdzfs0/8C8Y1B4A478SMtRI11g6rC0w==
X-Google-Smtp-Source: AGHT+IHVnzmyG1MExPdSkhvkJKuJqLS2wMKLW30Fe/iy2xnOBkdFE12bLSc4a7QS4fmdVPyux53xRw==
X-Received: by 2002:a5d:5f47:0:b0:3a0:8a19:db31 with SMTP id ffacd0b85a97d-3a08fb451b5mr1357078f8f.9.1746001226742;
        Wed, 30 Apr 2025 01:20:26 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4dc70efsm115940845ad.95.2025.04.30.01.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:26 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 06/10] selftests/bpf: freplace tests for tracking of changes_packet_data
Date: Wed, 30 Apr 2025 16:19:48 +0800
Message-ID: <20250430081955.49927-7-shung-hsi.yu@suse.com>
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

commit 89ff40890d8f12a7d7e93fb602cc27562f3834f0 upstream.

Try different combinations of global functions replacement:
- replace function that changes packet data with one that doesn't;
- replace function that changes packet data with one that does;
- replace function that doesn't change packet data with one that does;
- replace function that doesn't change packet data with one that doesn't;

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-7-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 76 +++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    | 26 +++++++
 .../bpf/progs/changes_pkt_data_freplace.c     | 18 +++++
 3 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
new file mode 100644
index 000000000000..c0c7202f6c5c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf/libbpf.h"
+#include "changes_pkt_data_freplace.skel.h"
+#include "changes_pkt_data.skel.h"
+#include <test_progs.h>
+
+static void print_verifier_log(const char *log)
+{
+	if (env.verbosity >= VERBOSE_VERY)
+		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
+}
+
+static void test_aux(const char *main_prog_name, const char *freplace_prog_name, bool expect_load)
+{
+	struct changes_pkt_data_freplace *freplace = NULL;
+	struct bpf_program *freplace_prog = NULL;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct changes_pkt_data *main = NULL;
+	char log[16*1024];
+	int err;
+
+	opts.kernel_log_buf = log;
+	opts.kernel_log_size = sizeof(log);
+	if (env.verbosity >= VERBOSE_SUPER)
+		opts.kernel_log_level = 1 | 2 | 4;
+	main = changes_pkt_data__open_opts(&opts);
+	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
+		goto out;
+	err = changes_pkt_data__load(main);
+	print_verifier_log(log);
+	if (!ASSERT_OK(err, "changes_pkt_data__load"))
+		goto out;
+	freplace = changes_pkt_data_freplace__open_opts(&opts);
+	if (!ASSERT_OK_PTR(freplace, "changes_pkt_data_freplace__open"))
+		goto out;
+	freplace_prog = bpf_object__find_program_by_name(freplace->obj, freplace_prog_name);
+	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
+		goto out;
+	bpf_program__set_autoload(freplace_prog, true);
+	bpf_program__set_autoattach(freplace_prog, true);
+	bpf_program__set_attach_target(freplace_prog,
+				       bpf_program__fd(main->progs.dummy),
+				       main_prog_name);
+	err = changes_pkt_data_freplace__load(freplace);
+	print_verifier_log(log);
+	if (expect_load) {
+		ASSERT_OK(err, "changes_pkt_data_freplace__load");
+	} else {
+		ASSERT_ERR(err, "changes_pkt_data_freplace__load");
+		ASSERT_HAS_SUBSTR(log, "Extension program changes packet data", "error log");
+	}
+
+out:
+	changes_pkt_data_freplace__destroy(freplace);
+	changes_pkt_data__destroy(main);
+}
+
+/* There are two global subprograms in both changes_pkt_data.skel.h:
+ * - one changes packet data;
+ * - another does not.
+ * It is ok to freplace subprograms that change packet data with those
+ * that either do or do not. It is only ok to freplace subprograms
+ * that do not change packet data with those that do not as well.
+ * The below tests check outcomes for each combination of such freplace.
+ */
+void test_changes_pkt_data_freplace(void)
+{
+	if (test__start_subtest("changes_with_changes"))
+		test_aux("changes_pkt_data", "changes_pkt_data", true);
+	if (test__start_subtest("changes_with_doesnt_change"))
+		test_aux("changes_pkt_data", "does_not_change_pkt_data", true);
+	if (test__start_subtest("doesnt_change_with_changes"))
+		test_aux("does_not_change_pkt_data", "changes_pkt_data", false);
+	if (test__start_subtest("doesnt_change_with_doesnt_change"))
+		test_aux("does_not_change_pkt_data", "does_not_change_pkt_data", true);
+}
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
new file mode 100644
index 000000000000..f87da8e9d6b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__noinline
+long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline __weak
+long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return 0;
+}
+
+SEC("tc")
+int dummy(struct __sk_buff *sk)
+{
+	changes_pkt_data(sk, 0);
+	does_not_change_pkt_data(sk, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
new file mode 100644
index 000000000000..0e525beb8603
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("?freplace")
+long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+SEC("?freplace")
+long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


