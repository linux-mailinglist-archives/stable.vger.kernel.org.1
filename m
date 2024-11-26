Return-Path: <stable+bounces-95498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A59D9257
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A90165B2A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FCF1917FB;
	Tue, 26 Nov 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LJpID+Q+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3918FDC5
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605724; cv=none; b=H6xNsVD92YnB6MlnSHKzkHejqQ30bHbeS8/C0Z/71iO9tVOy4Vn3NRY58MMLl3ksZ66E+GPL0ZmCnxpMM8ARUx4v4fRL9WuXOb5urvVuBo99glz06m8qBnCurfpJ6sGQEml9QYiKkbnIcNAcQ5Ki19Rcq+3EnnikQqNCtD5GYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605724; c=relaxed/simple;
	bh=78xbMOpWSBcesdeBM5sEKO3k1sOlaPIzSYkWRv+5Ekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUuq19aTvOf0DDAlusfiVcI5esp1yekqIcEGtxfPmmSZ45o12xUriIP1WQpxLu17GRFZ5tan6LDA/TDwROd2qhVOJtiqiBA8ogCNAqGTYlvD+HOKEt8INvyRjCMDJmzHl7mui/1TnEDSw7A2HE7s1O7d5+8uvNIwOSdm1PlFU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LJpID+Q+; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539e59dadebso5811489e87.0
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605720; x=1733210520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShS1E5scpSO+jPsu636PdHEpEV6SDQqlMWWvgBpsMKE=;
        b=LJpID+Q+wbywuGq738zxK026GKA/DjNEIeAYVopAEn24/XDluhV2qbPbFzXfMNf19u
         9b/fidli41+Dcy77rBmAcrjQLjK5pW060kQfhHrnY1UAE1CzX/MoSJ94O4at1WlXd31d
         yamEK4dS1uOosLnR9vLuExOHy/PJpkf1K1DduJNL4U+wL4V/zVNRzCXBEHtDQzugFvDx
         G/mxyqenQj1HcVzWdKaCND5MIJJ2TYaIyp6ixttV8UQcnh+EOQrsPu2ku7qEQy2w2mQA
         byjFyeU486FWgmnlmID6rqgFCawoNMzsBMUPArjJFvSJ0dNKGyQyRqEegnsUioXDnJ80
         eFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605720; x=1733210520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShS1E5scpSO+jPsu636PdHEpEV6SDQqlMWWvgBpsMKE=;
        b=ILhiZ3Wr9zPjhHysasS/1CDobiu9ogW+pYLK4ZkFVaLFOy0ZJu1ZapDefdYRGfcNBu
         UD07Zs9OMlFQqNPhH5rECnN4Geb4AhSrdL5dIWLoDTR+zWaESGgisfUQKeMlEfPyLvtE
         E63x2O/WqFE7K2IK7S8HEMPzeAECDiQOBiLbOpF3+J3Ldey5yTkAx4JN8BYY+jCThXQw
         XHuhpNjYQhmCzcnRmC4akFN9Ul5LI3yZc5Gqk+nAfnB0zOqoSLQb6wjnWlynZU5AZZaq
         8tzUTiccFkPkg6Nm+IaPzjkYNxCsnCTMvrr09ULLc8oVJmF3ZCqNyPyOwbqMfw3/xhh2
         EhZQ==
X-Gm-Message-State: AOJu0YyuQXTcMqYKT21ir+/97SxPQxUg+jEfsJ4TzMZDAeHeUxyRx/Ue
	xNf3U3qIX2hyaafdmdmiEzIL29J+6FJ9tCsYXwtZSAhm64WVgRiNFbM2ZkON7zNOJRQypALk6YT
	1ZAddgfF/PY4=
X-Gm-Gg: ASbGncuz6Y3ZIqmZGqCdM1RmfkCkS4Js+BGubRpzP2qrm+ed8I6/j4im3RN5xw74ap5
	eOWrY5pKn8FDIO8lD6A0Xf1w6DheFZrNr3Wzp6ldDEc2yLueurVd9P8kp9ogRpbOwUJEIFdOVIf
	nR4jYW/AMjur7K8+NN4wFgYzITHIyksuPtDz92UdGr8TuqSsgPNIYMxFYkC0FaTTmJ6U7pwPpbq
	VZbzAlHT8YC6o2IzM1+9ffSBakTgv/LRAUcW2B3MElewqXxZ+M=
X-Google-Smtp-Source: AGHT+IFG+OMDVWy5TKTDnKxFZOqBnhMjghjj1Lpj7rNyQlbMgo+rFOKTKdbozcO197EDVKGvNQVVcQ==
X-Received: by 2002:a05:6512:3e1f:b0:53d:d65e:772a with SMTP id 2adb3069b0e04-53dd65e77c3mr7461454e87.47.1732605719569;
        Mon, 25 Nov 2024 23:21:59 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02eb043sm11665268a91.11.2024.11.25.23.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:21:59 -0800 (PST)
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
Subject: [PATCH stable 6.6 2/8] selftests/bpf: Support checks against a regular expression
Date: Tue, 26 Nov 2024 15:21:24 +0800
Message-ID: <20241126072137.823699-3-shung-hsi.yu@suse.com>
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

From: Cupertino Miranda <cupertino.miranda@oracle.com>

[ Upstream commit f06ae6194f278444201e0b041a00192d794f83b6 ]

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect do substring matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240617141458.471620-2-cupertino.miranda@oracle.com
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 121 ++++++++++++++-----
 2 files changed, 99 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 799fff4995d8..c2a694449085 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index b4edd8454934..150aebd1802f 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -45,10 +48,16 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	const char *regex_str; /* regex-based match */
+	regex_t regex;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect_msgs;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -87,6 +96,16 @@ void test_loader_fini(struct test_loader *tester)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
+	/* Deallocate expect_msgs arrays. */
+	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
+		if (spec->priv.expect_msgs[i].regex_str)
+			regfree(&spec->priv.expect_msgs[i].regex);
+	for (i = 0; i < spec->unpriv.expect_msg_cnt; i++)
+		if (spec->unpriv.expect_msgs[i].regex_str)
+			regfree(&spec->unpriv.expect_msgs[i].regex);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
 	free(spec->priv.expect_msgs);
@@ -98,18 +117,38 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct test_subspec *subspec)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msgs,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
 	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	msg = &subspec->expect_msgs[subspec->expect_msg_cnt];
 
+	if (substr) {
+		msg->substr = substr;
+		msg->regex_str = NULL;
+	} else {
+		msg->regex_str = regex_str;
+		msg->substr = NULL;
+		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
+			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
+				   regex_str, error_msg);
+			return -EINVAL;
+		}
+	}
+
+	subspec->expect_msg_cnt += 1;
 	return 0;
 }
 
@@ -221,13 +260,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, NULL, &spec->priv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, NULL, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_msg(NULL, msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_msg(NULL, msg, &spec->unpriv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -316,16 +367,13 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 
 		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+			for (i = 0; i < spec->priv.expect_msg_cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs[i];
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
-				err = -ENOMEM;
-				goto cleanup;
+				err = push_msg(msg->substr, msg->regex_str, &spec->unpriv);
+				if (err)
+					goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
-			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
 
@@ -381,27 +429,40 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i, j, err;
+	char *match;
+	regmatch_t reg_match[1];
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
+		struct expect_msg *msg = &subspec->expect_msgs[i];
 
-		expect_msg = subspec->expect_msgs[i];
-
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
-		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
-			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
-			return;
+		if (msg->substr) {
+			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			if (match)
+				tester->next_match_pos = match - tester->log_buf + strlen(msg->substr);
+		} else {
+			err = regexec(&msg->regex,
+				      tester->log_buf + tester->next_match_pos, 1, reg_match, 0);
+			if (err == 0) {
+				match = tester->log_buf + tester->next_match_pos + reg_match[0].rm_so;
+				tester->next_match_pos += reg_match[0].rm_eo;
+			} else {
+				match = NULL;
+			}
 		}
 
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
+		if (!ASSERT_OK_PTR(match, "expect_msg")) {
+			if (env.verbosity == VERBOSE_NONE)
+				emit_verifier_log(tester->log_buf, true /*force*/);
+			for (j = 0; j <= i; j++) {
+				msg = &subspec->expect_msgs[j];
+				fprintf(stderr, "%s %s: '%s'\n",
+					j < i ? "MATCHED " : "EXPECTED",
+					msg->substr ? "SUBSTR" : " REGEX",
+					msg->substr ?: msg->regex_str);
+			}
+			return;
+		}
 	}
 }
 
-- 
2.47.0


