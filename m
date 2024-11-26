Return-Path: <stable+bounces-95499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A689D9258
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EF7B235FE
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E51898FC;
	Tue, 26 Nov 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TpSQIx+6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA26187876
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605728; cv=none; b=byiE9amjUMNOdTym0TVdlhXzF+23w9tqmoXtrXdVk/b7WWo0IUh+Bbbyglk9nyZtdTQHK6yrXFCfcB7lCfzkncOfmPd0xKK4FIeszi4nvnf9Hx220qQO74QllVjGxO2P7Ot882/IPQbkyWWOUSugVPS2Q3a2O3vEmHMKmYbgRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605728; c=relaxed/simple;
	bh=8ISEFZV7qdxwgd7R/ssIm3B3IHCC2H20PeHk0Kv9Zpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlKbREg41GfNoC2iveJpR193IKkPxmD4SGksr56NwDJ16YcLa2Vms9I8cy4JGaF0D/0/LexdElCtXch5SI9HXU05+OMYRByeDCBG3r2bw1Kse3j/gpxN6UNqJCRJ2vuz8V09yiFNeBUc3qGfmYg0KHOKvEYxOmhVQPqOx4K+Prg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TpSQIx+6; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-53ded167ae3so216275e87.0
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605724; x=1733210524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFxfLdwsehlRdjsVPtAEiiuSIn8Ld0Wm92KEYSAw+TY=;
        b=TpSQIx+6HBnw3DVPPs/OMFENdz/cvSZtfFRQuxGuOzJiPiZQQDpbTvjSVjkzKZ8HzY
         2l3AQHuZBiMXHbhNUYSBKxg17VjdyncK/3dGfq+BcXDhkxcMMeZnV0M7bcRfhIyN7qb+
         kkPCAA8lX0SeaEg5ChwlNnO3e2v6TTwH6OFRTcA58FBiVQ1mxy+avpk04/qQAU2uo770
         T8aHx0Akn0FPStoE2eqLXFesUuP3kebTbeCfvA9q+Y2uFOSTdKfXnIvCRof9DjtDJqfh
         JG7/5DNYybKJELWRMZ58MjyYrQXFkdUQCbGUmNeZPkreR3yuoCrxze8rtr1jjsErBxyT
         dbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605724; x=1733210524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFxfLdwsehlRdjsVPtAEiiuSIn8Ld0Wm92KEYSAw+TY=;
        b=tP/rX7bA/SGs6pGRPWk715JsKbFlcWf/hEcG07nICAdEBIRPFwsI5Quzg+HgTjmUHA
         OEJG7yW1fhTa/YzRvL2Ph4kYrPLbJLh5m9zKN0MSe0kwkokh6iXSgeL7dy5jmEldckB7
         7rRMWwwqvqSmre5AUdZU8qiUEVN8MrvtceGGCqRmowtdwEYLEZknmvgjiQrE+bKm7Pf0
         CxPQtczPqT69++A/3HrHAY711W4h8u5e2hJivPvaktr2m+O9DbRoAlJuGUnAOwxGOES3
         DeiG00wsGD4OoUufLGnugcGVbAlVcpHRvO9JbhEh69Lv/Omi08xsCEoohCl25/tgj2kw
         MNzQ==
X-Gm-Message-State: AOJu0Yz8rkq0xwdbpgX3Il1tyL1coyK3EcwZ1KvnR6hZkVCnaOqrqoum
	t3yJsg4ypFeQ1aDCudEsM+RQMVpQqO3qM6pSDb/FYhrsa2eyUSb+s0fzSc0LUV0gtNoJ8Yr1ZbR
	ZoQHcRCorHWI=
X-Gm-Gg: ASbGncstcbA133/KJyONgB1UpJOCy45tMwxeaqt2qSUb48IlJO/37Zeox1d7qGy4lZE
	/YM3UwAT41zc4oMUlecvZYa3BS+0qDcw4GOo+Y8d5Y9mbCHRFPdUkmbdxMngz2Glb958+wAsavU
	J411URI+U4I12Damu6BEtWbJHrK+I/r00AHt5o0L7bnbWxdgLeplshpQdq8PSrI+YfuMEtl5sX7
	SbV2HEjCBZWkv+PnXuixSzJ3tgLxiAmfgEIdBcPe1M+07NVOZw=
X-Google-Smtp-Source: AGHT+IEsH8qxReU4l1JrQP/zDKg47YgehY7gya0uJ/bZ9aoQCMQoMjFNa+MAKU8hpRvYs0F1vxaVBw==
X-Received: by 2002:a05:6512:2356:b0:53d:dbc4:8318 with SMTP id 2adb3069b0e04-53ddbc48400mr5375760e87.4.1732605724215;
        Mon, 25 Nov 2024 23:22:04 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de53c05csm7674722b3a.98.2024.11.25.23.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:22:03 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH stable 6.6 3/8] selftests/bpf: Factor out get_xlated_program() helper
Date: Tue, 26 Nov 2024 15:21:25 +0800
Message-ID: <20241126072137.823699-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit b4b7a4099b8ccea224577003fcf9d321bf0817b7 ]

Both test_verifier and test_progs use get_xlated_program(), so moving
the helper into testing_helpers.h to reuse it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20240105104819.3916743-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 44 -----------------
 tools/testing/selftests/bpf/test_verifier.c   | 47 +------------------
 tools/testing/selftests/bpf/testing_helpers.c | 42 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 +++
 4 files changed, 50 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 4951aa978f33..3b7c57fe55a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -626,50 +626,6 @@ static bool match_pattern(struct btf *btf, char *pattern, char *text, char *reg_
 	return false;
 }
 
-/* Request BPF program instructions after all rewrites are applied,
- * e.g. verifier.c:convert_ctx_access() is done.
- */
-static int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 xlated_prog_len;
-	__u32 buf_element_size = sizeof(struct bpf_insn);
-
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("bpf_prog_get_info_by_fd failed");
-		return -1;
-	}
-
-	xlated_prog_len = info.xlated_prog_len;
-	if (xlated_prog_len % buf_element_size) {
-		printf("Program length %d is not multiple of %d\n",
-		       xlated_prog_len, buf_element_size);
-		return -1;
-	}
-
-	*cnt = xlated_prog_len / buf_element_size;
-	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
-		perror("can't allocate xlated program buffer");
-		return -ENOMEM;
-	}
-
-	bzero(&info, sizeof(info));
-	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("second bpf_prog_get_info_by_fd failed");
-		goto out_free_buf;
-	}
-
-	return 0;
-
-out_free_buf:
-	free(*buf);
-	return -1;
-}
-
 static void print_insn(void *private_data, const char *fmt, ...)
 {
 	va_list args;
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 98107e0452d3..b92586efcb5e 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1341,48 +1341,6 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
-static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
-{
-	__u32 buf_element_size = sizeof(struct bpf_insn);
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 xlated_prog_len;
-	struct bpf_insn *buf;
-
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("bpf_prog_get_info_by_fd failed");
-		return NULL;
-	}
-
-	xlated_prog_len = info.xlated_prog_len;
-	if (xlated_prog_len % buf_element_size) {
-		printf("Program length %d is not multiple of %d\n",
-		       xlated_prog_len, buf_element_size);
-		return NULL;
-	}
-
-	*cnt = xlated_prog_len / buf_element_size;
-	buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
-		perror("can't allocate xlated program buffer");
-		return NULL;
-	}
-
-	bzero(&info, sizeof(info));
-	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)buf;
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("second bpf_prog_get_info_by_fd failed");
-		goto out_free_buf;
-	}
-
-	return buf;
-
-out_free_buf:
-	free(buf);
-	return NULL;
-}
-
 static bool is_null_insn(struct bpf_insn *insn)
 {
 	struct bpf_insn null_insn = {};
@@ -1505,7 +1463,7 @@ static void print_insn(struct bpf_insn *buf, int cnt)
 static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 {
 	struct bpf_insn *buf;
-	int cnt;
+	unsigned int cnt;
 	bool result = true;
 	bool check_expected = !is_null_insn(test->expected_insns);
 	bool check_unexpected = !is_null_insn(test->unexpected_insns);
@@ -1513,8 +1471,7 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 	if (!check_expected && !check_unexpected)
 		goto out;
 
-	buf = get_xlated_program(fd_prog, &cnt);
-	if (!buf) {
+	if (get_xlated_program(fd_prog, &buf, &cnt)) {
 		printf("FAIL: can't get xlated program\n");
 		result = false;
 		goto out;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 6acffe0426f0..622c2c4245e0 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -387,3 +387,45 @@ int kern_sync_rcu(void)
 {
 	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
 }
+
+int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
+{
+	__u32 buf_element_size = sizeof(struct bpf_insn);
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 xlated_prog_len;
+
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("bpf_prog_get_info_by_fd failed");
+		return -1;
+	}
+
+	xlated_prog_len = info.xlated_prog_len;
+	if (xlated_prog_len % buf_element_size) {
+		printf("Program length %u is not multiple of %u\n",
+		       xlated_prog_len, buf_element_size);
+		return -1;
+	}
+
+	*cnt = xlated_prog_len / buf_element_size;
+	*buf = calloc(*cnt, buf_element_size);
+	if (!buf) {
+		perror("can't allocate xlated program buffer");
+		return -ENOMEM;
+	}
+
+	bzero(&info, sizeof(info));
+	info.xlated_prog_len = xlated_prog_len;
+	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("second bpf_prog_get_info_by_fd failed");
+		goto out_free_buf;
+	}
+
+	return 0;
+
+out_free_buf:
+	free(*buf);
+	*buf = NULL;
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 5b7a55136741..a7b779191a97 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -43,4 +43,10 @@ static inline __u64 get_time_ns(void)
 	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
+struct bpf_insn;
+/* Request BPF program instructions after all rewrites are applied,
+ * e.g. verifier.c:convert_ctx_access() is done.
+ */
+int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.47.0


