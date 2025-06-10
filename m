Return-Path: <stable+bounces-152309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B7AD3B99
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85113AA076
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12B20766C;
	Tue, 10 Jun 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa1zbdeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC91E5205
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566760; cv=none; b=nhWitBQSkHBMqYZ6M2RIz6+GjRwGLfXbLDTgAOb0efP55/qeMxLDjhwMDV0M3Nrn8V5C5ZZpS43XeKtFSoZ+x1itM6lZzihashTNOObcvGnPFQr3BVzjiS39ZKpJFwvstcPn7nkYs2p3TevYgZkzrg1vB/M57G5TeurKzUyz7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566760; c=relaxed/simple;
	bh=Jbd+EOwYOZnEjRavkoiI0Tj+Sq8vW86nyg5BQCGaF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlwDgsMv38xPnFhIJXRNmowfANn+r+v2j+ByeIIHmbqIuiGLqOTcg/++kJl4T5BNbg8fg+COQIoSy0dx2mbWBlfrhiHm1QdG8FKh2WJD83bLEVaxRe2dx1Ojq4hG5LqAWUkRXmBNSvmePS+dDiiZvpoyBiD/uUtux9FEgtLX1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa1zbdeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC3BC4CEED;
	Tue, 10 Jun 2025 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566760;
	bh=Jbd+EOwYOZnEjRavkoiI0Tj+Sq8vW86nyg5BQCGaF5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fa1zbdeh1SQ8WPSxqwVlKv3G8ALnyymMN/Bb45CauttBqvHjEnc44BMdxSZsdRcPt
	 ZHirjth3tM7eWs57wKGIhnw+U+0R77Zo//sbDy68ECz0yvsn4qm7EzlYD4gNj3dM48
	 +dsnIPkh10vjrjb62VO4pVcwkC0VmzVSZHFXmKaQela53dZeYlAYuMsEcFAbzFWLyu
	 FdHeg3NGNb9E/063o4Cx9IsCN+RaP+lswHwR7ZEstqRhHu9GqFIBVO551nCKeY0D7o
	 SuRb69Uq6WwS/KxV7YKAvlSVihnBC95PeH0eujUSBhqvRruudG4IqWPa6kWsa1iEXP
	 vGgbgVOQwj0qA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hao Luo <haoluo@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH stable linux-5.10.y v1 8/8] bpf/selftests: Test PTR_TO_RDONLY_MEM
Date: Tue, 10 Jun 2025 14:44:03 +0000
Message-ID: <20250610144407.95865-9-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610144407.95865-1-puranjay@kernel.org>
References: <20250610144407.95865-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Luo <haoluo@google.com>

commit 9497c458c10b049438ef6e6ddda898edbc3ec6a8 upstream.

This test verifies that a ksym of non-struct can not be directly
updated.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
[Changed ASSERT_ERR_PTR() to CHECK()]
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/bpf/20211217003152.48334-10-haoluo@google.com
Cc: stable@vger.kernel.org # 5.10.x
---
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index b58b775d19f3..97f38d4f6a26 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -6,6 +6,7 @@
 #include <bpf/btf.h>
 #include "test_ksyms_btf.skel.h"
 #include "test_ksyms_btf_null_check.skel.h"
+#include "test_ksyms_btf_write_check.skel.h"
 
 static int duration;
 
@@ -81,6 +82,16 @@ static void test_null_check(void)
 	test_ksyms_btf_null_check__destroy(skel);
 }
 
+static void test_write_check(void)
+{
+	struct test_ksyms_btf_write_check *skel;
+
+	skel = test_ksyms_btf_write_check__open_and_load();
+	CHECK(skel, "skel_open", "unexpected load of a prog writing to ksym memory\n");
+
+	test_ksyms_btf_write_check__destroy(skel);
+}
+
 void test_ksyms_btf(void)
 {
 	int percpu_datasec;
@@ -106,4 +117,7 @@ void test_ksyms_btf(void)
 
 	if (test__start_subtest("null_check"))
 		test_null_check();
+
+	if (test__start_subtest("write_check"))
+		test_write_check();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
new file mode 100644
index 000000000000..2180c41cd890
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+extern const int bpf_prog_active __ksym; /* int type global var. */
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	int *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* Kernel memory obtained from bpf_{per,this}_cpu_ptr
+		 * is read-only, should _not_ pass verification.
+		 */
+		/* WRITE_ONCE */
+		*(volatile int *)active = -1;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


