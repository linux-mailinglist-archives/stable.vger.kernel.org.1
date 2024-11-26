Return-Path: <stable+bounces-95504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353109D925E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6ABB2404D
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DF1917EB;
	Tue, 26 Nov 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KFOxbVbD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC571539A
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605752; cv=none; b=BovSj1bSfeJC4r9ac1f/UxhFeBOHS8wiN8JhlZVOUx945TgdryuokcCNHUACW9uwW879EZcmg6NOQkYe/dU94+sdv1kU9NmOswsJsGJQf9LX9W0By2EFirx91H0yXPdrFleJ9XZpNWSaQTDu8S7SIMV+gGqgTF3dVOlrvunbag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605752; c=relaxed/simple;
	bh=1zGK4bbXx0krUVnifbJtLxgoOZspVLHqZhbLfIkFcpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRGhoL4l0U1uFIXFmPycJOVGQgvUW7o1q9DwEBzz0J2/JjT/fh//jmER78Sh0RNHjrH4egQRXuTogBclIBMrTOIIxGXaaa+adtlKFSngmVkgJ2o2kO2MHDBNd7IOEbKX7CkQbmSbaY/uOBvdeifoe+rt3FKSisO73+6hvAG7Ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KFOxbVbD; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso620372e87.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605749; x=1733210549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsIS9KYNPOJweNdOlOP4WfVSwYJxYyODJDlJVHabq1Q=;
        b=KFOxbVbDQbT/fEUmZFxfAosubv/qR2E/F0DeWglJrZC+bCmYlFQV625qMnG+qS69Mm
         jEEdd5zRz2dgRV2fiiS0NvHHRHRhWg0jYQ3EF8vFWdUO3Be3PLSqI1x4YcPzGQwTu7HL
         Cq7voDJWInvU3js6fdRnuoeWuutnp0GbNzcLRRkWDNeg7nsSHrXDp2kIL9pUy5T+3OC2
         0CdH/s90RFcr7svwQih7qvD/MEPd3iZHTvM52lWY8QkrkPJxk94wJFOp6J7bWW4VArLB
         sLX0qgdJf6q097NyFAZwtAHER+zE8QgNEruk8F55JRkXLrDPThK7jmT2UnmWAUrFzPab
         oOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605749; x=1733210549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsIS9KYNPOJweNdOlOP4WfVSwYJxYyODJDlJVHabq1Q=;
        b=kRI40+03i4igvT9txu7WiOFybGfvhf9/Z59j2wOSoMPyzOEnbuw+USLnaT1HxO7ytd
         lG+7KHr24QYMk0l/77ifiLbY/FYT9Kxw1pDnP1Z8q+oirdm0AW5A6mXunN/hp8GSM+Cr
         LEjIDK/u/9vENdyKK7V5or+P2L6djCit5SpqHdQrAsYgXHL7g1vNWbef7BEilSJql2Jz
         itB9d7xQ4v76VJezSOCVUHR1SjiJa2Ro3I63E/0uXd1OwuX8V5cBD87tQugSb4sEy9e5
         roBgO4n06As9sBaN+TrCH6Sv8Z4n82ArNTuewmFXYXOlgizmH9JCdXCMAHdlqFRuqiSH
         nBpg==
X-Gm-Message-State: AOJu0Yw2GJJT5yu+/QqRNPsEaNsRAYUqdu4aDte2RtX8Csymrbz2bIOy
	Suk8NEh7Snp8FzIDgmZYd/oc3UvTjnziDWqyLclC4EBl34FBBoEMkTdVvVm4Urko61DSE81bpwJ
	YKiqLtfj/CgQ=
X-Gm-Gg: ASbGncuU7OhGehAzHyg/dEXtOLVbqLWayCRD3gxaOZPjGNXM++DxszrbH2q6jY1nD4H
	feFsquyrknxcGQ0iGxoUB7RW5qKOnjEfejgznYbB+tr5mmaGDTYxpalK7ttJMZO9OVgfPZXtnGB
	dOIxWIAB5AL2UE32OxYLqrmRHLSO+PMcddcHiuF6VxWkVD088DWbLpw3xgt4A/proaBQw3KU5RO
	l5jmuj/3ME8wdxbwQmcrHJBNOGbtgvzhwAi2UAZxkL5uZknT9A=
X-Google-Smtp-Source: AGHT+IGkEtoX2/ykNd4qM44I8cWr1fn+Yo2IdHKv/ruEHa4NFdq9aRPY1SR2EUWc0FAJa4licF81EA==
X-Received: by 2002:a05:6512:3195:b0:53d:ed21:eeaf with SMTP id 2adb3069b0e04-53ded21ef8bmr259575e87.44.1732605748634;
        Mon, 25 Nov 2024 23:22:28 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22a3fsm77315745ad.262.2024.11.25.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:22:28 -0800 (PST)
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
Subject: [PATCH stable 6.6 8/8] selftests/bpf: allow checking xlated programs in verifier_* tests
Date: Tue, 26 Nov 2024 15:21:30 +0800
Message-ID: <20241126072137.823699-9-shung-hsi.yu@suse.com>
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

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 9c9f7339131030949a8ef111080427ff1a8085b5 ]

Add a macro __xlated("...") for use with test_loader tests.

When such annotations are present for the test case:
- bpf_prog_get_info_by_fd() is used to get BPF program after all
  rewrites are applied by verifier.
- the program is disassembled and patterns specified in __xlated are
  searched for in the disassembly text.

__xlated matching follows the same mechanics as __msg:
each subsequent pattern is matched from the point where
previous pattern ended.

This allows to write tests like below, where the goal is to verify the
behavior of one of the of the transformations applied by verifier:

    SEC("raw_tp")
    __xlated("1: w0 = ")
    __xlated("2: r0 = &(void __percpu *)(r0)")
    __xlated("3: r0 = *(u32 *)(r0 +0)")
    __xlated("4: exit")
    __success __naked void simple(void)
    {
            asm volatile (
            "call %[bpf_get_smp_processor_id];"
            "exit;"
            :
            : __imm(bpf_get_smp_processor_id)
            : __clobber_all);
    }

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240722233844.1406874-9-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  5 ++
 tools/testing/selftests/bpf/test_loader.c    | 82 +++++++++++++++++++-
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c2a694449085..666750fb3aac 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -26,6 +26,9 @@
  *
  * __regex           Same as __msg, but using a regular expression.
  * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ * __xlated          Expect a line in a disassembly log after verifier applies rewrites.
+ *                   Multiple __xlated attributes could be specified.
+ * __xlated_unpriv   Same as __xlated but for unprivileged mode.
  *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
@@ -63,11 +66,13 @@
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
+#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
 #define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
+#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a66745e9cf8d..1355f8beec00 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -7,6 +7,7 @@
 #include <bpf/btf.h>
 
 #include "autoconf_helper.h"
+#include "disasm_helpers.h"
 #include "unpriv_helpers.h"
 #include "cap_helpers.h"
 
@@ -19,10 +20,12 @@
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
 #define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
+#define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
 #define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
+#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -63,6 +66,7 @@ struct test_subspec {
 	char *name;
 	bool expect_failure;
 	struct expected_msgs expect_msgs;
+	struct expected_msgs expect_xlated;
 	int retval;
 	bool execute;
 };
@@ -115,6 +119,8 @@ static void free_test_spec(struct test_spec *spec)
 	/* Deallocate expect_msgs arrays. */
 	free_msgs(&spec->priv.expect_msgs);
 	free_msgs(&spec->unpriv.expect_msgs);
+	free_msgs(&spec->priv.expect_xlated);
+	free_msgs(&spec->unpriv.expect_xlated);
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
@@ -287,6 +293,18 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX) - 1;
+			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX_UNPRIV) - 1;
+			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
 			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
 			err = parse_retval(val, &spec->priv.retval, "__retval");
@@ -381,6 +399,16 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 			}
 		}
+		if (spec->unpriv.expect_xlated.cnt == 0) {
+			for (i = 0; i < spec->priv.expect_xlated.cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_xlated.patterns[i];
+
+				err = push_msg(msg->substr, msg->regex_str,
+					       &spec->unpriv.expect_xlated);
+				if (err)
+					goto cleanup;
+			}
+		}
 	}
 
 	spec->valid = true;
@@ -428,7 +456,15 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
-static void validate_msgs(char *log_buf, struct expected_msgs *msgs)
+static void emit_xlated(const char *xlated, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "XLATED:\n=============\n%s=============\n", xlated);
+}
+
+static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
+			  void (*emit_fn)(const char *buf, bool force))
 {
 	regmatch_t reg_match[1];
 	const char *log = log_buf;
@@ -452,7 +488,7 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs)
 
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
 			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(log_buf, true /*force*/);
+				emit_fn(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
 				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
@@ -585,6 +621,37 @@ static bool should_do_test_run(struct test_spec *spec, struct test_subspec *subs
 	return true;
 }
 
+/* Get a disassembly of BPF program after verifier applies all rewrites */
+static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
+{
+	struct bpf_insn *insn_start = NULL, *insn, *insn_end;
+	__u32 insns_cnt = 0, i;
+	char buf[64];
+	FILE *out = NULL;
+	int err;
+
+	err = get_xlated_program(prog_fd, &insn_start, &insns_cnt);
+	if (!ASSERT_OK(err, "get_xlated_program"))
+		goto out;
+	out = fmemopen(text, text_sz, "w");
+	if (!ASSERT_OK_PTR(out, "open_memstream"))
+		goto out;
+	insn_end = insn_start + insns_cnt;
+	insn = insn_start;
+	while (insn < insn_end) {
+		i = insn - insn_start;
+		insn = disasm_insn(insn, buf, sizeof(buf));
+		fprintf(out, "%d: %s\n", i, buf);
+	}
+	fflush(out);
+
+out:
+	free(insn_start);
+	if (out)
+		fclose(out);
+	return err;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -667,7 +734,16 @@ void run_subtest(struct test_loader *tester,
 		}
 	}
 	emit_verifier_log(tester->log_buf, false /*force*/);
-	validate_msgs(tester->log_buf, &subspec->expect_msgs);
+	validate_msgs(tester->log_buf, &subspec->expect_msgs, emit_verifier_log);
+
+	if (subspec->expect_xlated.cnt) {
+		err = get_xlated_program_text(bpf_program__fd(tprog),
+					      tester->log_buf, tester->log_buf_sz);
+		if (err)
+			goto tobj_cleanup;
+		emit_xlated(tester->log_buf, false /*force*/);
+		validate_msgs(tester->log_buf, &subspec->expect_xlated, emit_xlated);
+	}
 
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
-- 
2.47.0


