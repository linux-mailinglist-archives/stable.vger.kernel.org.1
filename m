Return-Path: <stable+bounces-236154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMVzG3cQ3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E13EE2B1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E323052EBF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA023DC4DC;
	Mon, 13 Apr 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceWTSMTo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE183D8129
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095166; cv=none; b=YtvWx62c/2n9XqMfFXgyEsT05WLPotACfgD1oXcIfrmk4Dwyq2nVSYjDVaJUX/oQoFQyJap2Gte1MeiKr8JxpTifO0umkHFt1BNC74hbg6QoN9QPNWjBbUjklbIqxQG366Z5afriIJxYNieiQ6rsZ9gzazESXwtvJcd7D8ibC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095166; c=relaxed/simple;
	bh=RPMP5nN3XQcJ4Sp8oYrKvpa28GuzhchqiWFFEbEuP28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVijfI4hD0ohQrC6M8bfdmmUg0ijBpeiY35O5RLFuYDtKcL/XsrcDKaznkNgspPqMVGA9uG4thlg8yh7xZU54MGEcfdJlCKbM4jq8r4SYlcvAWp1elitJ/W9pj2X0wLJWoX7ARGkmT7AkLf8G80Zbp6lU5v/OG9UnCun4aABr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceWTSMTo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1910772a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095164; x=1776699964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk406e4B6yaA1AYsopBQuAcW9y1VonUX3B3BnIn8G5g=;
        b=ceWTSMToBgebIGAeejWWcD3kTohblOkjh7e9mIfyke0gklHQfpe0jC9P0U04sLVxTQ
         ngz31dBiIVfZb+upipe+BFgYlQv397uukorXXh3PY6BPUFIOG5hXE+DCOu+bv4P9gKTz
         1pb8dbFBifdqgdF06gPpunqFBviwykdZPfrUQSpa3ufJCOPNeecNP0v5C3HHF/+v7Qgw
         wStPJOXG/JHG6DKPvQVyU4I5f/h6dt6lnlxZYgk5RzRi9VyUwEN9ufF4I2kB961iWLY+
         cC+eu4kA8AF1LXBWjsANFTPlx38UVUJB7nqaiC7Zl9OSbhq51CfCDEIreSsXsL7Sw8B1
         PW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095164; x=1776699964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gk406e4B6yaA1AYsopBQuAcW9y1VonUX3B3BnIn8G5g=;
        b=MCigzltXXqv6ieO3NVspgpCp30eqr7pF+lLsaeN2gV6SfZA68F3K0xUO9Am3aDvIgy
         GClgVKRgxB5JxSAxFY92Pa61PnIFa5ZAuVIFTgjxcVyUyLq7jCP10DrhuHEcAsZ+9Jwl
         jqVWsDOQhUq8QU868DEEOtk7l1V9aHPaUse4he72av2A1c8ViutmkyXXSpVJydzvKDvA
         TeB0hSDSktUEjxiQa5cHSTKPRpFZ2fm5AngmC7HYNbCBKj9l6jWk2YsOyub2Gq/QA8Do
         rI783Kmc1Tcd2ossVhptPsqb+KoSCfQ9ZhP7fZBPPPs4qiG8p1GyA4P7xfLSWoTCPlHJ
         Lw6A==
X-Forwarded-Encrypted: i=1; AFNElJ8Ld4sPuGh8LWSSRH5gny+cjFBRlDPII5VIQTtmoCbPVHIm9hO9zXO8XXbJLb29O7Vk+cTkkug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqcBRou1OjanlaCo2lBNO+ieS/AtILiKKJcOFXCVXQvdvhZnr
	dobiNnJaxtuE6EdKVmluzQnDi8rxbI6pDL9tawqWEzdpZXfLxxd390oy
X-Gm-Gg: AeBDietoAg6gWtq/LUMIT9YqO58ifjlaq2VjUhMo3YXTYG6NCx11YWv0+rsQoMCofLB
	QmE/qIREVSkAI8pK3+8DOuFsWxA9ZYV/LvLthOnpvJFU3m0P/pk8W55Bp/d8Ci3IsR3QItAumRe
	1GF5cbpfIFK7pOaiFJQ0lNF3D0p55QMhXP5E6Jbh0TltiY6jJBh3KlcEnotpyQ9o1WPVFOVUry0
	9cEBLaKupLL3xoNPPrswTYvpNdccsdaWSwKE1Bkamuy/BkHPoII95aUf17UWLcgrSW3cq38R7H4
	0EgcspvezXFh7D8kKImMBav1w6o8d6ivhrv+Jru/YqhK5sQ/RDOV3p1y1Y8fIOiCczh2Ig9BEet
	Ig566SzvHDEwNWq/btb9iqDVcgPmfbQlRK9ClUkVkkuvf7SuZ+8WJtYYE4bAzHFWkWbIO1egTXW
	vBESD4L0tK+UwI7mAIHUr8vonlv6mjsfWc
X-Received: by 2002:a05:6a20:258a:b0:3a0:129a:974b with SMTP id adf61e73a8af0-3a0129a9aa3mr7223876637.48.1776095164257;
        Mon, 13 Apr 2026 08:46:04 -0700 (PDT)
Received: from ubuntu24.lan ([2602:ffe4:1:2113:9dfd:1ff:3726:3839])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c793488d824sm6318233a12.16.2026.04.13.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:46:03 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Yiyang Chen <cyyzero16@gmail.com>
Subject: [PATCH v3 2/2] selftests/acct: add taskstats TGID retention test
Date: Mon, 13 Apr 2026 23:45:45 +0800
Message-ID: <0d55354911c54cd1b9f10a09f6fd378af85c8d43.1776094300.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776094300.git.cyyzero16@gmail.com>
References: <cover.1776094300.git.cyyzero16@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,uni-hamburg.de,linux-foundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-236154-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E10E13EE2B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a kselftest for the taskstats TGID aggregation fix.

The test creates a worker thread, snapshots TGID taskstats while the
worker is still alive, lets the worker exit, and then verifies that the
TGID CPU total does not regress after the thread has been reaped.

The pass/fail check intentionally keys off ac_utime + ac_stime only,
which is the primary user-visible regression fixed by the taskstats
change and is less sensitive to scheduling noise than context-switch
counters.

Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>

diff --git a/tools/testing/selftests/acct/.gitignore b/tools/testing/selftests/acct/.gitignore
index 7e78aac19038..9e9c61c5bfd6 100644
--- a/tools/testing/selftests/acct/.gitignore
+++ b/tools/testing/selftests/acct/.gitignore
@@ -1,3 +1,4 @@
 acct_syscall
+taskstats_fill_stats_tgid
 config
-process_log
\ No newline at end of file
+process_log
diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..083cab5ddb72 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
+TEST_GEN_PROGS += taskstats_fill_stats_tgid
+
 CFLAGS += -Wall
+LDLIBS += -lpthread
 
-include ../lib.mk
\ No newline at end of file
+include ../lib.mk
diff --git a/tools/testing/selftests/acct/taskstats_fill_stats_tgid.c b/tools/testing/selftests/acct/taskstats_fill_stats_tgid.c
new file mode 100644
index 000000000000..d6cab4ae26f2
--- /dev/null
+++ b/tools/testing/selftests/acct/taskstats_fill_stats_tgid.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <linux/netlink.h>
+#include <linux/taskstats.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+
+#ifndef NLA_ALIGN
+#define NLA_ALIGNTO 4
+#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
+#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
+#endif
+
+#define BUSY_NS (200ULL * 1000 * 1000)
+
+struct worker_ctx {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	bool ready;
+	bool release;
+};
+
+static unsigned long busy_sink;
+
+static void *taskstats_nla_data(const struct nlattr *na)
+{
+	return (void *)((char *)na + NLA_HDRLEN);
+}
+
+static bool taskstats_nla_ok(const struct nlattr *na, int remaining)
+{
+	return remaining >= (int)sizeof(*na) &&
+	       na->nla_len >= sizeof(*na) &&
+	       na->nla_len <= remaining;
+}
+
+static struct nlattr *taskstats_nla_next(const struct nlattr *na, int *remaining)
+{
+	int aligned_len = NLA_ALIGN(na->nla_len);
+
+	*remaining -= aligned_len;
+	return (struct nlattr *)((char *)na + aligned_len);
+}
+
+static uint64_t timespec_diff_ns(const struct timespec *start,
+				 const struct timespec *end)
+{
+	return (uint64_t)(end->tv_sec - start->tv_sec) * 1000000000ULL +
+	       (uint64_t)(end->tv_nsec - start->tv_nsec);
+}
+
+static void burn_cpu_for_ns(uint64_t runtime_ns)
+{
+	struct timespec start, now;
+	unsigned long acc = 0;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &start)) {
+		perror("clock_gettime");
+		exit(EXIT_FAILURE);
+	}
+
+	do {
+		for (int i = 0; i < 100000; i++)
+			acc += i;
+		if (clock_gettime(CLOCK_MONOTONIC, &now)) {
+			perror("clock_gettime");
+			exit(EXIT_FAILURE);
+		}
+	} while (timespec_diff_ns(&start, &now) < runtime_ns);
+
+	busy_sink = acc;
+}
+
+static int netlink_open(void)
+{
+	struct sockaddr_nl addr = {
+		.nl_family = AF_NETLINK,
+		.nl_pid = getpid(),
+	};
+	int fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (fd < 0)
+		return -errno;
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		int err = -errno;
+
+		close(fd);
+		return err;
+	}
+
+	return fd;
+}
+
+static int send_request(int fd, void *buf, size_t len)
+{
+	struct sockaddr_nl addr = {
+		.nl_family = AF_NETLINK,
+	};
+
+	if (sendto(fd, buf, len, 0, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int get_family_id(int fd, const char *name)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct genlmsghdr genl;
+		char buf[256];
+	} req = { 0 };
+	char resp[8192];
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *genl;
+	struct nlattr *na;
+	int len;
+	int rem;
+	int ret;
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = GENL_ID_CTRL;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST;
+	req.nlh.nlmsg_seq = 1;
+	req.nlh.nlmsg_pid = getpid();
+
+	req.genl.cmd = CTRL_CMD_GETFAMILY;
+	req.genl.version = 1;
+
+	na = (struct nlattr *)((char *)&req + NLMSG_ALIGN(req.nlh.nlmsg_len));
+	na->nla_type = CTRL_ATTR_FAMILY_NAME;
+	na->nla_len = NLA_HDRLEN + strlen(name) + 1;
+	memcpy(taskstats_nla_data(na), name, strlen(name) + 1);
+	req.nlh.nlmsg_len = NLMSG_ALIGN(req.nlh.nlmsg_len) + NLA_ALIGN(na->nla_len);
+
+	ret = send_request(fd, &req, req.nlh.nlmsg_len);
+	if (ret)
+		return ret;
+
+	len = recv(fd, resp, sizeof(resp), 0);
+	if (len < 0)
+		return -errno;
+
+	for (nlh = (struct nlmsghdr *)resp; NLMSG_OK(nlh, len);
+	     nlh = NLMSG_NEXT(nlh, len)) {
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			struct nlmsgerr *err = NLMSG_DATA(nlh);
+
+			return err->error ? err->error : -ENOENT;
+		}
+
+		genl = (struct genlmsghdr *)NLMSG_DATA(nlh);
+		rem = nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
+		na = (struct nlattr *)((char *)genl + GENL_HDRLEN);
+		while (taskstats_nla_ok(na, rem)) {
+			if (na->nla_type == CTRL_ATTR_FAMILY_ID)
+				return *(uint16_t *)taskstats_nla_data(na);
+			na = taskstats_nla_next(na, &rem);
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int get_taskstats(int fd, int family_id, uint16_t attr_type, uint32_t id,
+			 struct taskstats *stats)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct genlmsghdr genl;
+		char buf[256];
+	} req = { 0 };
+	char resp[16384];
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *genl;
+	struct nlattr *na;
+	struct nlattr *nested;
+	int len;
+	int rem;
+	int nrem;
+	int ret;
+
+	memset(stats, 0, sizeof(*stats));
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = family_id;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST;
+	req.nlh.nlmsg_seq = 2;
+	req.nlh.nlmsg_pid = getpid();
+
+	req.genl.cmd = TASKSTATS_CMD_GET;
+	req.genl.version = 1;
+
+	na = (struct nlattr *)((char *)&req + NLMSG_ALIGN(req.nlh.nlmsg_len));
+	na->nla_type = attr_type;
+	na->nla_len = NLA_HDRLEN + sizeof(id);
+	memcpy(taskstats_nla_data(na), &id, sizeof(id));
+	req.nlh.nlmsg_len = NLMSG_ALIGN(req.nlh.nlmsg_len) + NLA_ALIGN(na->nla_len);
+
+	ret = send_request(fd, &req, req.nlh.nlmsg_len);
+	if (ret)
+		return ret;
+
+	len = recv(fd, resp, sizeof(resp), 0);
+	if (len < 0)
+		return -errno;
+
+	for (nlh = (struct nlmsghdr *)resp; NLMSG_OK(nlh, len);
+	     nlh = NLMSG_NEXT(nlh, len)) {
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			struct nlmsgerr *err = NLMSG_DATA(nlh);
+
+			return err->error ? err->error : -ENOENT;
+		}
+
+		genl = (struct genlmsghdr *)NLMSG_DATA(nlh);
+		rem = nlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
+		na = (struct nlattr *)((char *)genl + GENL_HDRLEN);
+		while (taskstats_nla_ok(na, rem)) {
+			if (na->nla_type == TASKSTATS_TYPE_AGGR_PID ||
+			    na->nla_type == TASKSTATS_TYPE_AGGR_TGID) {
+				nested = (struct nlattr *)taskstats_nla_data(na);
+				nrem = na->nla_len - NLA_HDRLEN;
+				while (taskstats_nla_ok(nested, nrem)) {
+					if (nested->nla_type == TASKSTATS_TYPE_STATS) {
+						memcpy(stats, taskstats_nla_data(nested),
+						       sizeof(*stats));
+						return 0;
+					}
+					nested = taskstats_nla_next(nested, &nrem);
+				}
+			}
+			na = taskstats_nla_next(na, &rem);
+		}
+	}
+
+	return -ENOENT;
+}
+
+static uint64_t cpu_total(const struct taskstats *stats)
+{
+	return (uint64_t)stats->ac_utime + (uint64_t)stats->ac_stime;
+}
+
+static void print_stats(const char *label, const struct taskstats *stats)
+{
+	ksft_print_msg("%s: cpu_total=%llu nvcsw=%llu nivcsw=%llu\n",
+		       label, (unsigned long long)cpu_total(stats),
+		       (unsigned long long)stats->nvcsw,
+		       (unsigned long long)stats->nivcsw);
+}
+
+static void *worker_thread(void *arg)
+{
+	struct worker_ctx *ctx = arg;
+
+	burn_cpu_for_ns(BUSY_NS);
+
+	pthread_mutex_lock(&ctx->lock);
+	ctx->ready = true;
+	pthread_cond_broadcast(&ctx->cond);
+	while (!ctx->release)
+		pthread_cond_wait(&ctx->cond, &ctx->lock);
+	pthread_mutex_unlock(&ctx->lock);
+
+	return NULL;
+}
+
+int main(void)
+{
+	struct worker_ctx ctx = {
+		.lock = PTHREAD_MUTEX_INITIALIZER,
+		.cond = PTHREAD_COND_INITIALIZER,
+	};
+	struct taskstats before, after;
+	pthread_t thread;
+	pid_t tgid = getpid();
+	int family_id;
+	int fd;
+	int ret;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (geteuid())
+		ksft_exit_skip("taskstats_fill_stats_tgid needs root\n");
+
+	fd = netlink_open();
+	if (fd < 0)
+		ksft_exit_skip("failed to open generic netlink socket: %s\n",
+			       strerror(-fd));
+
+	family_id = get_family_id(fd, TASKSTATS_GENL_NAME);
+	if (family_id < 0)
+		ksft_exit_skip("taskstats generic netlink family unavailable: %s\n",
+			       strerror(-family_id));
+
+	/* Create worker thread that burns 200ms of CPU */
+	if (pthread_create(&thread, NULL, worker_thread, &ctx) != 0)
+		ksft_exit_fail_msg("pthread_create failed: %s\n", strerror(errno));
+
+	/* Wait for worker to finish generating activity */
+	pthread_mutex_lock(&ctx.lock);
+	while (!ctx.ready)
+		pthread_cond_wait(&ctx.cond, &ctx.lock);
+	pthread_mutex_unlock(&ctx.lock);
+
+	/*
+	 * Snapshot A: TGID stats while worker is alive and sleeping.
+	 * Contains main thread + worker contributions.
+	 */
+	ret = get_taskstats(fd, family_id, TASKSTATS_CMD_ATTR_TGID, tgid, &before);
+	if (ret)
+		ksft_exit_fail_msg("TGID query before exit failed: %s\n",
+				   strerror(-ret));
+
+	/* Release worker so it can exit, then join (deterministic wait).
+	 *
+	 * Kernel exit path ordering guarantees:
+	 *   do_exit()
+	 *     taskstats_exit() -> fill_tgid_exit()  (accumulates worker into signal->stats)
+	 *     exit_notify()                         (releases the thread)
+	 *     do_task_dead() -> __schedule()        (wakes joiner)
+	 *
+	 * So pthread_join() returns only after fill_tgid_exit() has completed.
+	 */
+	pthread_mutex_lock(&ctx.lock);
+	ctx.release = true;
+	pthread_cond_broadcast(&ctx.cond);
+	pthread_mutex_unlock(&ctx.lock);
+
+	pthread_join(thread, NULL);
+
+	/*
+	 * Snapshot B: TGID stats after worker has exited.
+	 * fill_stats_for_tgid() does:
+	 *   memcpy(signal->stats)   <- includes fill_tgid_exit accumulation
+	 *   + scan live threads      <- only main thread now
+	 */
+	ret = get_taskstats(fd, family_id, TASKSTATS_CMD_ATTR_TGID, tgid, &after);
+	if (ret)
+		ksft_exit_fail_msg("TGID query after exit failed: %s\n",
+				   strerror(-ret));
+
+	print_stats("TGID before worker exit", &before);
+	print_stats("TGID after  worker exit", &after);
+
+	/*
+	 * The worker burned 200ms of CPU before the first snapshot.
+	 * If the kernel correctly retained its contribution via
+	 * fill_tgid_exit(), then the TGID CPU total after exit must be at
+	 * least as large as the TGID CPU total before exit.
+	 */
+	ksft_test_result(cpu_total(&after) >= cpu_total(&before),
+			 "TGID CPU stats should not regress after thread exit\n");
+
+	close(fd);
+	ksft_finished();
+	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
+}
-- 
2.43.0


