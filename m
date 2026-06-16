Return-Path: <stable+bounces-265322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mClJGMaGMWrGlgUAu9opvQ
	(envelope-from <stable+bounces-265322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65769317B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="QU/n0yyC";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265322-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265322-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A968D30160EE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C30478E55;
	Tue, 16 Jun 2026 17:23:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED153466B5E;
	Tue, 16 Jun 2026 17:23:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630617; cv=none; b=sSXwlkubQXIfzm1Yx1OiUtIGohFPPa2jMAUoIdCK4mAh6ph3AShXKD1/Ytv5WuY6J5jqLqhxVcPbzd+KGYe7qwsitftNTCem4y3M38l8hBL1YaNE1Dvqzv4MK3digNh2xdMHmbPr1TqYIcsuMkth1l+78njrKnfQZRqM+b+1SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630617; c=relaxed/simple;
	bh=4cnazfqNhKjM94GBIlyWguL9Txt+RO9XSxxANmPHljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzITgGUWfXg/D2+nRVf/Rj6p7nu5QUGfOEAIdJefeIXDMBpq/xpf6/Twvj7avT5PVYGyC2MoGB/dIl0h8OG64QbXCIq+PlvM19QW9GBUKqdxzJsd74q/p3btkwbWvRKlWM5nOJdFqmG2Pv7zMt23b2yWtMt8jbCfQv1h4i8OIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QU/n0yyC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27C81F000E9;
	Tue, 16 Jun 2026 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630615;
	bh=7JgI+olPypq571Zv1NfiMV9Vz+Wf+m8+AN6y3ULDVsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QU/n0yyCeIVTWXTzHTmFmHUK/X0T6/vtlh6AGq3Poza+HzFj0QG/YkheaiyXAIsA0
	 PDvIUzOXqZojW3rmH1MzSDCml3NwewmELeGgodIDgWqMV6zS5aFbn1Fked1/GK4wfA
	 K51hyaNacBryoZ4g0P5Lb0YQa7mMj5qzb6PU4hVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/522] Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test"
Date: Tue, 16 Jun 2026 20:23:29 +0530
Message-ID: <20260616145128.695638326@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265322-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD65769317B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

This reverts commit 4d8fb7ed7a55 ("selftests/bpf: Add a cgroup prog
bpf_get_ns_current_pid_tgid() test").

That commit should have never been backported to 6.1 because it
introduces a test for a feature that isn't supported:
bpf_get_ns_current_pid_tgid() cannot be called from cgroup BPF programs
in 6.1.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 73 -------------------
 .../bpf/progs/test_ns_current_pid_tgid.c      |  7 --
 2 files changed, 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 2c57ceede095eb..a84c41862ff8c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -12,7 +12,6 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <fcntl.h>
-#include "network_helpers.h"
 
 #define STACK_SIZE (1024 * 1024)
 static char child_stack[STACK_SIZE];
@@ -75,50 +74,6 @@ static int test_current_pid_tgid_tp(void *args)
 	return ret;
 }
 
-static int test_current_pid_tgid_cgrp(void *args)
-{
-	struct test_ns_current_pid_tgid__bss *bss;
-	struct test_ns_current_pid_tgid *skel;
-	int server_fd = -1, ret = -1, err;
-	int cgroup_fd = *(int *)args;
-	pid_t tgid, pid;
-
-	skel = test_ns_current_pid_tgid__open();
-	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
-		return ret;
-
-	bpf_program__set_autoload(skel->progs.cgroup_bind4, true);
-
-	err = test_ns_current_pid_tgid__load(skel);
-	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
-		goto cleanup;
-
-	bss = skel->bss;
-	if (get_pid_tgid(&pid, &tgid, bss))
-		goto cleanup;
-
-	skel->links.cgroup_bind4 = bpf_program__attach_cgroup(
-		skel->progs.cgroup_bind4, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.cgroup_bind4, "bpf_program__attach_cgroup"))
-		goto cleanup;
-
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_server"))
-		goto cleanup;
-
-	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
-		goto cleanup;
-	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
-		goto cleanup;
-	ret = 0;
-
-cleanup:
-	if (server_fd >= 0)
-		close(server_fd);
-	test_ns_current_pid_tgid__destroy(skel);
-	return ret;
-}
-
 static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 {
 	int wstatus;
@@ -140,25 +95,6 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-static void test_in_netns(int (*fn)(void *), void *arg)
-{
-	struct nstoken *nstoken = NULL;
-
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto cleanup;
-
-	test_ns_current_pid_tgid_new_ns(fn, arg);
-
-cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
-}
-
 /* TODO: use a different tracepoint */
 void serial_test_ns_current_pid_tgid(void)
 {
@@ -166,13 +102,4 @@ void serial_test_ns_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
-	if (test__start_subtest("new_ns_cgrp")) {
-		int cgroup_fd = -1;
-
-		cgroup_fd = test__join_cgroup("/sock_addr");
-		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
-			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
-			close(cgroup_fd);
-		}
-	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index d0010e698f6688..aa3ec7ca16d9b6 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -28,11 +28,4 @@ int tp_handler(const void *ctx)
 	return 0;
 }
 
-SEC("?cgroup/bind4")
-int cgroup_bind4(struct bpf_sock_addr *ctx)
-{
-	get_pid_tgid();
-	return 1;
-}
-
 char _license[] SEC("license") = "GPL";
-- 
2.53.0




