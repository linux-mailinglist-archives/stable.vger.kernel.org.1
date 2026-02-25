Return-Path: <stable+bounces-219141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCPcAKBknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E271910CB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA753076716
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F556298CC7;
	Wed, 25 Feb 2026 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DjsPI9q1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AA29992A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988114; cv=none; b=SNLlsDupdT0vJjlybK3LPvzypWXHIiQzqiyYfW5naDh7oaeXQBfBcv7IEfXuLe+WJAG8U2cFeUDQaJHcptLPqBMx00ccPFzegvvSp51ijZjYh58KMaL5a27isSDW+sSsMhoNGQxFS0o37ZSQMVE4Tz/WL/Ovz7FrKjt76XQhLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988114; c=relaxed/simple;
	bh=VZ5yVN0HuTcqdlvkzZ861Zurl/3yw2gfUFXvIZNdDcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubZbSINduInQH27P7dDG5MGbjl3kpTEqg+b8J2DtjRGSI0mfO+faeBgYZVWkD/9UU8d56yWXgwNqf9qvGFgZ9Jss/ZBO5qND/sU/XTzzogNhLs1Z5RgO/WjLdKwZS4UABNAMUpaQaWgdHOWwXEl6enFJp15GeEuGxsyiPmIzT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DjsPI9q1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483770e0b25so55207005e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988110; x=1772592910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moa2xZAi8Zgy2CaFMdQWFNPQvu4B3jfKoE7UmLhS6is=;
        b=DjsPI9q1hgk2BQKiC6Xws4naNxVW3hCxpT1DaKhy7jkYqvBLTHN9nBP1VFe37uRja9
         hjVqoyUed2bJ/SVTMGTpiRA8HUJ9xDm0BkhgDF/T8H1oenih3T43QCSP2yMNxsOjH9Nl
         syKki39Gtn+wctgEAxOiJJwPwgneov+vYM1DtdoI80YQEyPvagm9/Yh4pY24RsrqgUeE
         ELa6J+RxfNzywIrYbqY1AiHBLslKj4XxZB61Mq5z1Yzjoy4aoKcqaXpFU3YznK2LZAlC
         rbE73IvUII5ry4CBE1CE016qkmN5lW9ktRZD64SjuWOUlV/g6yJjr7/2UYAG+Tyxy7ln
         WxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988110; x=1772592910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moa2xZAi8Zgy2CaFMdQWFNPQvu4B3jfKoE7UmLhS6is=;
        b=okmYfmWQRWHSIl37mNzeOmyBElCFcDUToBESTiJDkcVJhmeBt0iYAIUjfq5XCh7zFH
         FYr5OZfpjoir67aEBuVWR6zm//9bI9BpuQa9H2jABpcG9AhNCTjYKqRNBvdqN7s83YXK
         AIapR0NgVTNdtXNnQWFLKjzWSnx2uSl2v4yveKoCgtTSPQivEqN1/3DSHFaJLoJebVOa
         ewjzmfM+j6gQ5lJhv57jlhiD8nWhvQu3cPoJf/c+bdI6HKnWk8uCfMwgtW5HwIbQDaMk
         kvClMXst4BLrljHG586vc5T1VP3lj8ONOjUi8MrMY/WFdvXHEXUVuXtyXh4TOWSNMgLx
         o/Zw==
X-Gm-Message-State: AOJu0YzQX5GyT8/yCCXlwb3yqD7vkKLb8Ai+zDnItKQEAGbMf1M791xD
	0I0sA6uBnxRy2+q8v+O/FxkkH2qhJ+H3axa1UgaxnqySwhQrxBh5WXfF9UXO3ZT6mZR44IaS9fm
	ISB8r
X-Gm-Gg: ATEYQzwrU15Xqwphy95bO0z109aV0WSTNJAzP7KFLP2pJQKKYkCYimeJc23B1CdXVtQ
	s6NfiP24/QXCfLygnHJcx2And8BdFj3Pne09856N0dlAbUZoWY7Vf46pdKRsT/YXqdaynKLv+k1
	cSZY2oeqSkpuiwu4Bm42e+8Ny9cKoZwBk69cocGTJGXGukf81bs8sGDbloPcgAHHIEK1InnX+ou
	NZs84ImAZnTD+ED5R+no59EKqRv9DzXbbAmq7kpRSgVxbWAJE6QPYN3uSVweZer6cVuhgzjATy8
	Cf04juwlkShHwpMxIlQST9lvDuf6mT8WIihteh4TloHEckCwtvWwM23qYmnbWoVenfuc43utZAX
	3WDWATyEgGkna5TYP/qXvcuyqMn2UX2DJnnJEV1SSSjuI1plLmP3eAESHgUpJL6B3RMxB6Gvo5L
	hTlRLDWsckqqlsNd2LlBtTj+aZBw==
X-Received: by 2002:a05:600c:314a:b0:47e:e20e:bbb4 with SMTP id 5b1f17b1804b1-483a9637a24mr208026765e9.26.1771988110476;
        Tue, 24 Feb 2026 18:55:10 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd695a8fsm15631226b3a.23.2026.02.24.18.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:10 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 02/11] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Wed, 25 Feb 2026 10:54:40 +0800
Message-ID: <20260225025454.17398-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,fomichev.me,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219141-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.916];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93E271910CB
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit f5281aacec856e7e0beb643d74122595fc1fb4be upstream.

Add option '-m' to test_progs to accept names and patterns of test cases.
This option will be used later to enable traffic monitor that capture
network packets generated by test cases.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-3-thinker.li@gmail.com
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 92 +++++++++++++++++-------
 tools/testing/selftests/bpf/test_progs.h |  2 +
 2 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 74620ed3a166..2e2ee6a5a3ba 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -155,6 +155,7 @@ struct prog_test_def {
 	void (*run_serial_test)(void);
 	bool should_run;
 	bool need_cgroup_cleanup;
+	bool should_tmon;
 };
 
 /* Override C runtime library's usleep() implementation to ensure nanosleep()
@@ -192,39 +193,39 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
 	return num < sel->num_set_len && sel->num_set[num];
 }
 
+static bool match_subtest(struct test_filter_set *filter,
+			  const char *test_name,
+			  const char *subtest_name)
+{
+	int i, j;
+
+	for (i = 0; i < filter->cnt; i++) {
+		if (glob_match(test_name, filter->tests[i].name)) {
+			if (!filter->tests[i].subtest_cnt)
+				return true;
+
+			for (j = 0; j < filter->tests[i].subtest_cnt; j++) {
+				if (glob_match(subtest_name,
+					       filter->tests[i].subtests[j]))
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static bool should_run_subtest(struct test_selector *sel,
 			       struct test_selector *subtest_sel,
 			       int subtest_num,
 			       const char *test_name,
 			       const char *subtest_name)
 {
-	int i, j;
+	if (match_subtest(&sel->blacklist, test_name, subtest_name))
+		return false;
 
-	for (i = 0; i < sel->blacklist.cnt; i++) {
-		if (glob_match(test_name, sel->blacklist.tests[i].name)) {
-			if (!sel->blacklist.tests[i].subtest_cnt)
-				return false;
-
-			for (j = 0; j < sel->blacklist.tests[i].subtest_cnt; j++) {
-				if (glob_match(subtest_name,
-					       sel->blacklist.tests[i].subtests[j]))
-					return false;
-			}
-		}
-	}
-
-	for (i = 0; i < sel->whitelist.cnt; i++) {
-		if (glob_match(test_name, sel->whitelist.tests[i].name)) {
-			if (!sel->whitelist.tests[i].subtest_cnt)
-				return true;
-
-			for (j = 0; j < sel->whitelist.tests[i].subtest_cnt; j++) {
-				if (glob_match(subtest_name,
-					       sel->whitelist.tests[i].subtests[j]))
-					return true;
-			}
-		}
-	}
+	if (match_subtest(&sel->whitelist, test_name, subtest_name))
+		return true;
 
 	if (!sel->whitelist.cnt && !subtest_sel->num_set)
 		return true;
@@ -232,6 +233,19 @@ static bool should_run_subtest(struct test_selector *sel,
 	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[subtest_num];
 }
 
+static bool should_tmon(struct test_selector *sel, const char *name)
+{
+	int i;
+
+	for (i = 0; i < sel->whitelist.cnt; i++) {
+		if (glob_match(name, sel->whitelist.tests[i].name) &&
+		    !sel->whitelist.tests[i].subtest_cnt)
+			return true;
+	}
+
+	return false;
+}
+
 static char *test_result(bool failed, bool skipped)
 {
 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
@@ -488,6 +502,10 @@ bool test__start_subtest(const char *subtest_name)
 		return false;
 	}
 
+	subtest_state->should_tmon = match_subtest(&env.tmon_selector.whitelist,
+						   test->test_name,
+						   subtest_name);
+
 	env.subtest_state = subtest_state;
 	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
 
@@ -685,7 +703,8 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
 	ARG_NUM_WORKERS = 'j',
 	ARG_DEBUG = -1,
-	ARG_JSON_SUMMARY = 'J'
+	ARG_JSON_SUMMARY = 'J',
+	ARG_TRAFFIC_MONITOR = 'm',
 };
 
 static const struct argp_option opts[] = {
@@ -712,6 +731,10 @@ static const struct argp_option opts[] = {
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
 	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
+#ifdef TRAFFIC_MONITOR
+	{ "traffic-monitor", ARG_TRAFFIC_MONITOR, "NAMES", 0,
+	  "Monitor network traffic of tests with name matching the pattern (supports '*' wildcard)." },
+#endif
 	{},
 };
 
@@ -865,6 +888,18 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case ARGP_KEY_END:
 		break;
+#ifdef TRAFFIC_MONITOR
+	case ARG_TRAFFIC_MONITOR:
+		if (arg[0] == '@')
+			err = parse_test_list_file(arg + 1,
+						   &env->tmon_selector.whitelist,
+						   true);
+		else
+			err = parse_test_list(arg,
+					      &env->tmon_selector.whitelist,
+					      true);
+		break;
+#endif
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1695,6 +1730,8 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (test->should_run)
+			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
 	}
 
 	/* ignore workers if we are just listing */
@@ -1779,6 +1816,7 @@ int main(int argc, char **argv)
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
+	free_test_selector(&env.tmon_selector);
 	free_test_states();
 
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 2f9f6f250f17..479d29dda223 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -74,6 +74,7 @@ struct subtest_state {
 	int error_cnt;
 	bool skipped;
 	bool filtered;
+	bool should_tmon;
 
 	FILE *stdout;
 };
@@ -98,6 +99,7 @@ struct test_state {
 struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
+	struct test_selector tmon_selector;
 	bool verifier_stats;
 	bool debug;
 	enum verbosity verbosity;
-- 
2.53.0


