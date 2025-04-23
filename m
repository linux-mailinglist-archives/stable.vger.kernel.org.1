Return-Path: <stable+bounces-135231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A36A97E62
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B0B189F068
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07526658F;
	Wed, 23 Apr 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q9C2UXIZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6DEAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387663; cv=none; b=IPKsW0UM4uKpupPLNqp7u0JdfUGv62Jmj1Biz3J9mPk1Sxet0Q9NVgnrjglF/aQmtKU3alafhtn6gIcnKx/kbAYlCDkv1191vnMDHcgSgV1/fWV2H6q6zh5W87K/zFOfAewQFW5dIMNqR7G4wEwvZpidMe5A4B7PWqqfy5h9RME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387663; c=relaxed/simple;
	bh=x/1/wwDeK9aMIY2Z6rZDgNhhsBDjaajZVPyLCXf9MAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPuboZt7SrqNVMUMyAudwF5xvB75wyl22FMpXGavObPOxOyShM+OPACFgmV/cvX6GXu4vhnK4NVC+yWKBg3n4/YDzyDec44yeUQ8Jx0gY1mq/kLk1lOJkRDPhTAh1EztF1U3KO3ZRhGUV9C8tc6p1oR0Ds/dLbn2buztWYvkXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q9C2UXIZ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so741790666b.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387659; x=1745992459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxnXAPMMu2L8Z0EYHZYOhKGuk5P0dV4UaLVJpWA0lNc=;
        b=Q9C2UXIZzlr9U8Ou6zDcNc7F5a1NIkZ4rJ4aVJXzauQ1rbLxNITT+JLLXM+kd21k9m
         y54VtZRJVJtPxn1n4VsMF+3ZyKq1TTB845eWwCzAJCV2opL5+9IbknmXzMX9Rqj1uPty
         05TrYj3zB/fVGgIdGp+1d8Q3B2K0ZQKpq5qT3ZZHxzCE5got02t5o5YwNcA0zQVcR1Va
         8DdQK7rtGzr9wQ/HH/knAN70zLq09raNZugLjV9aE/r9WW54oOrvlYRQ6aAGbbhHnKlt
         cvVx1X1aPeDEdsD3/JLeK/1OPSU+56oFy1P1xZZeBFbh7W3PzJ9tvyUHfZbm5QDfOntb
         aZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387659; x=1745992459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxnXAPMMu2L8Z0EYHZYOhKGuk5P0dV4UaLVJpWA0lNc=;
        b=dXSCRVWGItmtQS9PvOCOl8T5apZ5qm7CsLPGh2d156gudxxainCq2IdDHI0URPFGGT
         BfKg/mcGbDhMwaRc0c8muPwOhscvQWkW+dX4ON9Z/iltWazy6nwi/5sfKjiyoKioGfki
         DG18nr1o+nRFqg743kZw4eY5zM2EG52oddmmHw3hRXP0QjBQ/3FERJwOPzloqsWuMVL3
         bI1teoT7y1sLlhZ3VTgRYEWLrotaHnWGk9k2NVexFKL+7RgatRGeNEyJNDkvQcPhSMRY
         7w6fFdSNqdipnXAnyNWXu84A4IOQ1A5CJ1WMTeuZYDH8SZEZcXs7/GPQufOmYpFgZHD8
         2BhA==
X-Gm-Message-State: AOJu0YyZf5l4HH1tmX4ajr/QgBUaVWuljBhY2ZIC4diWJbl6fKzl9JKA
	c2zksei4CEYR/UoOwHTgNiURLfjdISGi6cPZaTk6rKU0el84iIz3HwfYXGEL8REaSPOg0YRRDJO
	yjWgeJA==
X-Gm-Gg: ASbGncu4zJa2dQFg501p7MAH/4eZZ2uFdohrO3BUkkxMtssAWA3Ehw9yOfXUUZ/0TTy
	1OVur3WyZXz/TzyrfQuQO9g5Q0JC6kpsSph0Q8bcWqoSgMsM50Kud1s7W/mm73VK88+14e5Ge38
	2talSic+jdG/2DOPsEqtgI0gGRWMbf7J9R+8XDTeU6R86CpT1RPFXbDMW5C/07He2FTApPxD0OJ
	ww+F1/mM4NpTlnVLjxfm4IFHW9v0fptMSwLZ8gqfGjciMEUP7M2eH1NuLQPDyhac/BdIMKVcFbC
	l2c4oHMjd4euAMJjSPW/Arx8FwQbeRkCMpoxKZzoW3IsCzBwy885Wc/lYMmcabVBnsC2AQ==
X-Google-Smtp-Source: AGHT+IHWuRw5emHoh59oGEA3N9JAie3YTkX1uBTNzAyBU5FxOBIpD1aPv3ff1TE4Tu2BiK0laR2R4A==
X-Received: by 2002:a17:906:3896:b0:acb:b8bd:ddef with SMTP id a640c23a62f3a-acbb8bde151mr532482266b.36.1745387659068;
        Tue, 22 Apr 2025 22:54:19 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaeb7e8sm9996158b3a.179.2025.04.22.22.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:18 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 5/8] selftests/bpf: freplace tests for tracking of changes_packet_data
Date: Wed, 23 Apr 2025 13:53:26 +0800
Message-ID: <20250423055334.52791-6-shung-hsi.yu@suse.com>
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


