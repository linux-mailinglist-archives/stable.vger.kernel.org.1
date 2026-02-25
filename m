Return-Path: <stable+bounces-219142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBQ0DaVknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2201910D9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56061307E24D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC45299924;
	Wed, 25 Feb 2026 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K4797zhX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889529992A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988117; cv=none; b=YKqJPg+8aUAV/LmN8osaeiGqEpg595pvJZ8iyUI5Pa/taDNMSeZS2Itqc9nLOhTNymO/zXmhYL2PpADBOOXRMQS0tSoRSxPuouNmjeVFREWM5H1N3jlIrhbPUPCLkzmt3civ6LR/EuENNOYSlrpRAxXr2LvFA2UaTal/54I752E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988117; c=relaxed/simple;
	bh=rl3F5TweBMa0bJkI66yEAb/YLqGROhuqWpDlDCTQOA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNfAt2fevJVSR9pwSyfYneEXIvoidOGRhlhrcvjRP35F9c53+JpAhWcZ+8aL8OcjbNmCSzrsjueJjgy6+berevZ6PZ4IcrnWRuXf4Ap2EHZoMBXbyE1Yqkfn/4O041E+mr6sY/jDSPE2UlgQdoW+AtP701fgalG6S+5cpbqrnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K4797zhX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so36070015e9.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988114; x=1772592914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+MHyYP5xHCsKGxo/vC4lXzTj3T3qjDxCGJqFoJg55I=;
        b=K4797zhXON4fccWUNgbCBGAKaiILIr57yNTORuwp1r+k86WHFUzUv0NXUgLvunqfdn
         HXu+IYSJkbM9n2mJZYDyJqvMefOB5TCxrzT6bXscWFR/RClcv8mMGk2cPP6MEf1TaCFB
         OkssA6gSMOaVjZi9kOou0WUaqa/usydXbC9NL4CiOJbqb2BtXplWIU8ba5Wh/925ZNxS
         HVMR4IhPzXgHHB9uQ0X65GxdETijTf4el1j/2Vxrfikv84g3XGYz8xkYKNrhvgzo7AAo
         Wc9rpyMskVIWh2X3Q/XdI85qwAspMKLBdydrFqcXYkuX6bGQsm05NOQ6RA5LPiC/FI8j
         2taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988114; x=1772592914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+MHyYP5xHCsKGxo/vC4lXzTj3T3qjDxCGJqFoJg55I=;
        b=rvATOTZLQOIIf7JISZ1IGKzAWOkOj01kzShmXmQ4Kwe+4Lthgz3DgiqzAjSm6kAL4m
         FBci3t5tbr+DysUgM/FEdXeo0aNTvs7vBdf3w5YgvC2e52qWwjENa02dA51l5rNSt97V
         HAgLtV2RBzLQTfgjA9SDRUrvXQkgGYMggnixfewicQtIigt6h52sDaxeYaAllo1rFF8S
         Bd6GZ1hM75SPL3qzEFFn6+t+bFj9mNfxMD2cWsNSlf1PbmIM7/zSzTQ6jG9+anER9qAD
         7UtveOkULJdWPX1T1kdf/rVNGkH3yv85NGyixEU2ktE40+A9G+ZLJmEkkPU6m8UaNCAo
         D0bA==
X-Gm-Message-State: AOJu0YyY6OlO+QX4dv5jq1JbPQ3Ek6S/vEBSR5R6zlWf8qDYy43BdH3w
	z95fLYS8F+/ElSwg2sVUtEuRHGRqjP6WqTa0arDYSz3ctiCvXUpUDwmILfVRKRxil1erC9Y9BP4
	y6vUy
X-Gm-Gg: ATEYQzz3gOqXZxeWboG7/VuK+yrWZFjYIvCpHU9RHwMUXHN25GtME+a2cFLBEHw2c/X
	UmBNJ4yRn04+38OdkdB+4rURFRtq1sRiuPiLmV3ieLOgPGqYKfLLuLEZi9R2A6UC5PQy3ueapp3
	SC2kAbCBPaDI+f1ihnq8s9FC0nlG0TQ44AIxxZuyNLLZ7aqNAL2R+ETd5x+FAJngXA46Lv7WFg4
	JTCr+7mgwKgrkVXGNUShtTTWYfNwg1+1ajnrGF5XAAjBm1cwVQIpASmT6Wf+BwoP6Rntu6bMxFM
	5wKzGxo+f8/Yg1/go9eaNBEGrz0N/d/eh9p0c2TyracT/u0lIFQHGv+wc7px/EuLfqbZ9I0laiG
	zXSRB4BwLURWW5Xrbxgmwkgs6u+buqSfmJzHsSU1dCnCUXOqEtAxVd3ABj8Xf+7JknFFDS9CqCU
	YQYMDCIFrFvthI7mZFC+O7QJyghw==
X-Received: by 2002:a05:600c:3b0a:b0:480:4ae2:def1 with SMTP id 5b1f17b1804b1-483a95be7c9mr284285825e9.13.1771988114294;
        Tue, 24 Feb 2026 18:55:14 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm116924455ad.91.2026.02.24.18.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:13 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 03/11] selftests/bpf: netns_new() and netns_free() helpers.
Date: Wed, 25 Feb 2026 10:54:41 +0800
Message-ID: <20260225025454.17398-4-shung-hsi.yu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-219142-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.907];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC2201910D9
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit 1e115a58be0ffca63727dc0495dae924a19f8cd4 upstream.

netns_new()/netns_free() create/delete network namespaces. They support the
option '-m' of test_progs to start/stop traffic monitor for the network
namespace being created for matched tests.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-4-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 46 ++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 tools/testing/selftests/bpf/test_progs.c      | 88 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  4 +
 4 files changed, 140 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0c09324bc111..3c5eab4fa93d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -410,6 +410,52 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int remove_netns(const char *name)
+{
+	char *cmd;
+	int r;
+
+	r = asprintf(&cmd, "ip netns del %s >/dev/null 2>&1", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd");
+		return -1;
+	}
+
+	r = system(cmd);
+	free(cmd);
+	return r;
+}
+
+int make_netns(const char *name)
+{
+	char *cmd;
+	int r;
+
+	r = asprintf(&cmd, "ip netns add %s", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd");
+		return -1;
+	}
+
+	r = system(cmd);
+	free(cmd);
+
+	if (r)
+		return r;
+
+	r = asprintf(&cmd, "ip -n %s link set lo up", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd for setting up lo");
+		remove_netns(name);
+		return -1;
+	}
+
+	r = system(cmd);
+	free(cmd);
+
+	return r;
+}
+
 struct nstoken {
 	int orig_netns_fd;
 };
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 3a046dc42c34..8f1f23e0a0d7 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -70,6 +70,8 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+int make_netns(const char *name);
+int remove_netns(const char *name);
 
 struct tmonitor_ctx;
 
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 2e2ee6a5a3ba..650bb694d84a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,8 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#include "network_helpers.h"
+
 #ifdef __GLIBC__
 #include <execinfo.h> /* backtrace */
 #endif
@@ -660,6 +662,92 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
 }
 
+struct netns_obj {
+	char *nsname;
+	struct tmonitor_ctx *tmon;
+	struct nstoken *nstoken;
+};
+
+/* Create a new network namespace with the given name.
+ *
+ * Create a new network namespace and set the network namespace of the
+ * current process to the new network namespace if the argument "open" is
+ * true. This function should be paired with netns_free() to release the
+ * resource and delete the network namespace.
+ *
+ * It also implements the functionality of the option "-m" by starting
+ * traffic monitor on the background to capture the packets in this network
+ * namespace if the current test or subtest matching the pattern.
+ *
+ * nsname: the name of the network namespace to create.
+ * open: open the network namespace if true.
+ *
+ * Return: the network namespace object on success, NULL on failure.
+ */
+struct netns_obj *netns_new(const char *nsname, bool open)
+{
+	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
+	const char *test_name, *subtest_name;
+	int r;
+
+	if (!netns_obj)
+		return NULL;
+	memset(netns_obj, 0, sizeof(*netns_obj));
+
+	netns_obj->nsname = strdup(nsname);
+	if (!netns_obj->nsname)
+		goto fail;
+
+	/* Create the network namespace */
+	r = make_netns(nsname);
+	if (r)
+		goto fail;
+
+	/* Start traffic monitor */
+	if (env.test->should_tmon ||
+	    (env.subtest_state && env.subtest_state->should_tmon)) {
+		test_name = env.test->test_name;
+		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
+		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);
+		if (!netns_obj->tmon) {
+			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
+			goto fail;
+		}
+	} else {
+		netns_obj->tmon = NULL;
+	}
+
+	if (open) {
+		netns_obj->nstoken = open_netns(nsname);
+		if (!netns_obj->nstoken)
+			goto fail;
+	}
+
+	return netns_obj;
+fail:
+	traffic_monitor_stop(netns_obj->tmon);
+	remove_netns(nsname);
+	free(netns_obj->nsname);
+	free(netns_obj);
+	return NULL;
+}
+
+/* Delete the network namespace.
+ *
+ * This function should be paired with netns_new() to delete the namespace
+ * created by netns_new().
+ */
+void netns_free(struct netns_obj *netns_obj)
+{
+	if (!netns_obj)
+		return;
+	traffic_monitor_stop(netns_obj->tmon);
+	close_netns(netns_obj->nstoken);
+	remove_netns(netns_obj->nsname);
+	free(netns_obj->nsname);
+	free(netns_obj);
+}
+
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name)				\
 	extern void test_##name(void) __weak;		\
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 479d29dda223..1a2d476e51b9 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -413,6 +413,10 @@ int write_sysctl(const char *sysctl, const char *value);
 int get_bpf_max_tramp_links_from(struct btf *btf);
 int get_bpf_max_tramp_links(void);
 
+struct netns_obj;
+struct netns_obj *netns_new(const char *name, bool open);
+void netns_free(struct netns_obj *netns);
+
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
 #elif defined(__s390x__)
-- 
2.53.0


