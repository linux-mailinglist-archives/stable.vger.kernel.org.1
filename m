Return-Path: <stable+bounces-15753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0931683B5FC
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B61F22C84
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EA196;
	Thu, 25 Jan 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8bHi1Tj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6980A
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141798; cv=none; b=MXlITzLczS9CmwUsCFJ6C889CCFHVw/o9MLBK1waHciy99LttjU/vUSy1WR1eOTqscc5m/HjmGzcFGb602dmkSewt6I+mCdDmncscGFCbf+ygZl89fO9vCrGoDl025apO6GhXp6LhaWV81ujHxeA7/J64g9zqhjaZqLN/GyJ4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141798; c=relaxed/simple;
	bh=9ICLx2yXRVQijV/8NPNMmVWZpcJQkPPmoU5XL+skyh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwOhZ7n49iVaxN7KweyCbyv6GgotkqCnN6IE95+WUpXFsYodSzQJf0D2bmVT7xYvCv/DvUlCSvIwE/EdUu6G/1pU92cWRUb5RHis8K/3Dhck7vquDFveN4+vZ/7sZcck4BmUYH6oFYQq9TwAsbE9l9+9rCpblFcLVv45064CTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8bHi1Tj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7af5f618so7036979e87.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141795; x=1706746595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwFnjdSiHZnhckiC1EM2tuGSlPkRL2vHshBKfd9OuSo=;
        b=P8bHi1Tjz9MCtMy9hd8X0DrqGEKUnt8tWJpbZHD/zepgJHPlCsVsoSDohhaK/8C8ly
         zyMXtiBXunwv4FBMwkc64e3/JL58mEV0Y5EWZMNTi24raE2aFpHfzflrKWLMLQ140fSn
         qp2bp2ky9K8XwtTWNz5qoaps47p3rSvY4EupFju3h/lwzgEOjsNWqMQ9UOf0TNwUoflZ
         D48DLM+6L7DjK2Ew24XAr80P7/2AtNXtCfaJOU3k1/nwQoAxQubkV3eE77+f0C2NQTDk
         Q7a8UHwK5CLJjJGBkXgwS3AIuV8NFvmyUukBZob8Kgn8ejPKt0xOo0K3HLn5F8Nfqzvx
         8t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141795; x=1706746595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwFnjdSiHZnhckiC1EM2tuGSlPkRL2vHshBKfd9OuSo=;
        b=fv0t7DHFHWPYwlvM1PEIeqWxdqL+uaWgY0mFaO+WOy0edHEMJKKN0ZS1WrzcKh/qqQ
         d2DNZxwjO7QswLUUyKD5z8Zl1qsjYBTFcaoDTYNIXm980CjJ+e2Z8KK9o2bndBKwnLKt
         abFVDOQ19xqA3TGu9q/d+RQZsi6KV2U5aYAbQ12q/Rr9CPemrGXHtGBZEDt+1TeykagI
         SmRCVuPssLflBNWOg5JqvkwrPW5Mog+nFH4XJCuwXD+hpNUYrh4K/IBzDvjLfddmhUsq
         Zxka4olaWZSZbG0JRlTdv+aVWBKCdU4qjYRS3JJFvdSjIwOPZwiLUdiWQd1hRtVIKzyR
         59DA==
X-Gm-Message-State: AOJu0Yx9HUQASLqXTNT5NTt0U19ep0T/Wac6I/9pz9YNPhnLq2wALvXZ
	32UUp8gkqXuO8hEn5DVWS6EjT5WspNggbxNbJxdPvig1grK+vXUZQe+xD/cV
X-Google-Smtp-Source: AGHT+IHonDC/gif4oyJkQF861UMDEEd81SnZFHDOQRHTkxryRyP3UUjbYpKMD+2OuFnmwhd4B6HURQ==
X-Received: by 2002:ac2:51a5:0:b0:50e:dc84:114 with SMTP id f5-20020ac251a5000000b0050edc840114mr28241lfk.45.1706141794640;
        Wed, 24 Jan 2024 16:16:34 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:34 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 13/17] selftests/bpf: tests for iterating callbacks
Date: Thu, 25 Jan 2024 02:15:50 +0200
Message-ID: <20240125001554.25287-14-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 958465e217db ]

A set of test cases to check behavior of callback handling logic,
check if verifier catches the following situations:
- program not safe on second callback iteration;
- program not safe on zero callback iterations;
- infinite loop inside a callback.

Verify that callback logic works for bpf_loop, bpf_for_each_map_elem,
bpf_user_ringbuf_drain, bpf_find_vma.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-8-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 147 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e3e68c97b40c..e51d11c36a21 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
 #include "verifier_int_ptr.skel.h"
+#include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
@@ -138,6 +139,7 @@ void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_acces
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
+void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
new file mode 100644
index 000000000000..fa9429f77a81
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 8);
+} ringbuf SEC(".maps");
+
+struct vm_area_struct;
+struct bpf_map;
+
+struct buf_context {
+	char *buf;
+};
+
+struct num_context {
+	__u64 i;
+};
+
+__u8 choice_arr[2] = { 0, 1 };
+
+static int unsafe_on_2nd_iter_cb(__u32 idx, struct buf_context *ctx)
+{
+	if (idx == 0) {
+		ctx->buf = (char *)(0xDEAD);
+		return 0;
+	}
+
+	if (bpf_probe_read_user(ctx->buf, 8, (void *)(0xBADC0FFEE)))
+		return 1;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R1 type=scalar expected=fp")
+int unsafe_on_2nd_iter(void *unused)
+{
+	char buf[4];
+	struct buf_context loop_ctx = { .buf = buf };
+
+	bpf_loop(100, unsafe_on_2nd_iter_cb, &loop_ctx, 0);
+	return 0;
+}
+
+static int unsafe_on_zero_iter_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i = 0;
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_on_zero_iter(void *unused)
+{
+	struct num_context loop_ctx = { .i = 32 };
+
+	bpf_loop(100, unsafe_on_zero_iter_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static int loop_detection_cb(__u32 idx, struct num_context *ctx)
+{
+	for (;;) {}
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("infinite loop detected")
+int loop_detection(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_loop(100, loop_detection_cb, &loop_ctx, 0);
+	return 0;
+}
+
+static __always_inline __u64 oob_state_machine(struct num_context *ctx)
+{
+	switch (ctx->i) {
+	case 0:
+		ctx->i = 1;
+		break;
+	case 1:
+		ctx->i = 32;
+		break;
+	}
+	return 0;
+}
+
+static __u64 for_each_map_elem_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_for_each_map_elem(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_for_each_map_elem(&map, for_each_map_elem_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static __u64 ringbuf_drain_cb(struct bpf_dynptr *dynptr, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_ringbuf_drain(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_user_ringbuf_drain(&ringbuf, ringbuf_drain_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static __u64 find_vma_cb(struct task_struct *task, struct vm_area_struct *vma, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_find_vma(void *unused)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_find_vma(task, 0, find_vma_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


