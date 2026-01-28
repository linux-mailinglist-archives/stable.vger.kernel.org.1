Return-Path: <stable+bounces-212412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KUcOhY5eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:28:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57078A5AA5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D686A314F4C4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFB27BF79;
	Wed, 28 Jan 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4m8hJIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A992E2DF4;
	Wed, 28 Jan 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615431; cv=none; b=QOFW2jHqVKFa9rDnC6qEJg4kUj1u8X4JP6ATZi/YbeBH8Uwusr6PNLAdjePYTpevkeMAE7gOps3SVtDligts88+ypDSyGC13qnlLSHAL1RgLqn2PQIabGe7qjyZcjQzyqgEJwJ5Ryjkt5sH3OtGGHeqoiOqUYfpJKq0buaFWeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615431; c=relaxed/simple;
	bh=7dOKrgXDPkz6zD4XhW1zoZ8jysE6/gL5zhv7aFNOs9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLWHIFdDgiXLYvxEC8cH1iUEfoGnyWvqkvcS/T3UeqmjYV5zdz666RtglNNyHQWHLWxLhJoY4t2nzpuDa7MJR+S9D5EyDGYXKUuUOQ7CM3me82NtxNHR3MUNU69hOGH9tTDfpNAuAjPNq4B6ZosxrWs5Fbfl/s46Tft900Tluyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4m8hJIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BEDC4CEF1;
	Wed, 28 Jan 2026 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615431;
	bh=7dOKrgXDPkz6zD4XhW1zoZ8jysE6/gL5zhv7aFNOs9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4m8hJIN90M5Bwitkq1A3+SnuA6QUChE43j0wzpqt1OtQpdOVcgGQ4FfcXaBuLUMs
	 tCfNRCC+1c/52XqERBUO7fjQgAUhF+quykoDyRM4YyYlnKf3uL2EhvJyixNAjKlZVZ
	 799OhU5wUwGvBFUaZGevbDRAFIgyoeEahL2S2/2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.12 149/169] selftests/bpf: Check for timeout in perf_link test
Date: Wed, 28 Jan 2026 16:23:52 +0100
Message-ID: <20260128145339.367289379@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212412-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 57078A5AA5
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihor Solodrai <ihor.solodrai@pm.me>

commit e6c209da7e0e9aaf955a7b59e91ed78c2b6c96fb upstream.

Recently perf_link test started unreliably failing on libbpf CI:
  * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
  * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
  * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251

Part of the test is running a dummy loop for a while and then checking
for a counter incremented by the test program.

Instead of waiting for an arbitrary number of loop iterations once,
check for the test counter in a loop and use get_time_ns() helper to
enforce a 100ms timeout.

v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/prog_tests/perf_link.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -4,8 +4,12 @@
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
+#include "testing_helpers.h"
 #include "test_perf_link.skel.h"
 
+#define BURN_TIMEOUT_MS 100
+#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
+
 static void burn_cpu(void)
 {
 	volatile int j = 0;
@@ -32,6 +36,7 @@ void serial_test_perf_link(void)
 	int run_cnt_before, run_cnt_after;
 	struct bpf_link_info info;
 	__u32 info_len = sizeof(info);
+	__u64 timeout_time_ns;
 
 	/* create perf event */
 	memset(&attr, 0, sizeof(attr));
@@ -63,8 +68,14 @@ void serial_test_perf_link(void)
 	ASSERT_GT(info.prog_id, 0, "link_prog_id");
 
 	/* ensure we get at least one perf_event prog execution */
-	burn_cpu();
-	ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
+	while (true) {
+		burn_cpu();
+		if (skel->bss->run_cnt > 0)
+			break;
+	        if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
+			break;
+	}
 
 	/* perf_event is still active, but we close link and BPF program
 	 * shouldn't be executed anymore



