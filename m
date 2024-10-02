Return-Path: <stable+bounces-79624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE1698D96A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A781C2324B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AB1D0F63;
	Wed,  2 Oct 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMl3mz2v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811A1D07B8;
	Wed,  2 Oct 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877986; cv=none; b=p43XQoCyrs331AfPMQAGOccZjuXsV0GaxGchE5gQrzKArGw2YV7JLeZdxVD/injZJV+cuTXkKHwpp2/3yZ3d5K8twteYbDgQZP0Hq4H7lWYJKQ+KAs2XyHQX7o5Ux03pLXCQDHJrXwN/DlBo05B8/pizPI0OSJGwA/zjWli8Z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877986; c=relaxed/simple;
	bh=hY0xU5VvKB775OrroF81ajWImWGy//vxrYi52IZlrc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdkEXhpX4cRDgzzneJsRBYk0RYZoNKNX+m8UA+8XIDun4qptEyeNs3FtGNHnNXzv5IhHZoC3UMvmSfe12uHH4W3vHkK7oj5bEKvosuXu2tNKichL27jgRXWgyRlKgemN2+AsXP0fNofK5UtLNVyILLIpO9pBHqwrhnH7qBH/Vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMl3mz2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9782BC4CEC2;
	Wed,  2 Oct 2024 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877986;
	bh=hY0xU5VvKB775OrroF81ajWImWGy//vxrYi52IZlrc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMl3mz2vy5BEFRl+GLn8ahpKeTEZy96Iu47s6LMWkd87/vKEG3E26KVQV4U4q/Lcb
	 yqkFCPS9u+Mt7o2xVRvAR0PlMz9pZWlf3Sp64OBPc3rqi7+JBjpFh29GNDF0E9LT3b
	 0aJga/Rhacw2Oq7Hykej94XfzlqwgnqdbV4CthbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 262/634] selftests/bpf: Support checks against a regular expression
Date: Wed,  2 Oct 2024 14:56:02 +0200
Message-ID: <20241002125821.442987094@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cupertino Miranda <cupertino.miranda@oracle.com>

[ Upstream commit f06ae6194f278444201e0b041a00192d794f83b6 ]

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect do substring matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240617141458.471620-2-cupertino.miranda@oracle.com
Stable-dep-of: f00bb757ed63 ("selftests/bpf: fix to avoid __msg tag de-duplication by clang")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 115 ++++++++++++++-----
 2 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e1..c0280bd2f340d 100644
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
index 524c38e9cde48..f14e10b0de96e 100644
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
@@ -46,10 +49,16 @@ enum mode {
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
@@ -89,6 +98,16 @@ void test_loader_fini(struct test_loader *tester)
 
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
@@ -100,18 +119,38 @@ static void free_test_spec(struct test_spec *spec)
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
+
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
 
+	subspec->expect_msg_cnt += 1;
 	return 0;
 }
 
@@ -233,13 +272,25 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -337,16 +388,13 @@ static int parse_test_spec(struct test_loader *tester,
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
 
@@ -402,27 +450,40 @@ static void validate_case(struct test_loader *tester,
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
-
-		expect_msg = subspec->expect_msgs[i];
+		struct expect_msg *msg = &subspec->expect_msgs[i];
+
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
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+			for (j = 0; j <= i; j++) {
+				msg = &subspec->expect_msgs[j];
+				fprintf(stderr, "%s %s: '%s'\n",
+					j < i ? "MATCHED " : "EXPECTED",
+					msg->substr ? "SUBSTR" : " REGEX",
+					msg->substr ?: msg->regex_str);
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.43.0




