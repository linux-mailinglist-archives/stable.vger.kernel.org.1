Return-Path: <stable+bounces-270813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gf/bC0WURmrwYwsAu9opvQ
	(envelope-from <stable+bounces-270813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:39:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED16FA552
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YsGMPqIm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270813-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270813-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9231D3059C4A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402063403EF;
	Thu,  2 Jul 2026 16:31:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C67330B29;
	Thu,  2 Jul 2026 16:31:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009916; cv=none; b=f7sld1LfVeMcHPwGVE7Rbr0SQiTez8pHsZFfEr4LCCTzVTr3/wnhipTpQ1cKeyPqkVoiGkniV+nkGKHmqgSpgQVHdLNrUs2kFmaFCR8bFwHZjSvyFwRs8Z73VEL+K082DWjshWu0zfPuPwKTuTEHmg3KY6XqN7a1rEGyqHcmYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009916; c=relaxed/simple;
	bh=wk848r46DIJ8YXjKTLfRixnoTpSAFGmQ3fJlyEKkUYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC5VHU99gjgEwgp7x6NKs9I61plTLBCQH/JzBXrRSerUMLt80M5AHRenghXJ87hYdafDLbEgAVKYQOgzcMVWiFx19procwaIUu2023duazvY2dnR5Xpu2dxHnV0n+KzTIcjgQYJL8lCoGaBvpKOrY3p43d/ngeP1pkqJPqSfs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YsGMPqIm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F841F000E9;
	Thu,  2 Jul 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009914;
	bh=YPPknz2Rd9jvtPtj3V3CZWUzv8nGsCV3A3Zxf/gR5UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YsGMPqImGp2hEVYft54DIvmnUjxwxrl5ZQnEcU2G+PNSsKvV7xfVQV8IVcjfjpl6l
	 2r0JutWCm+PaNbkt+7JwGdwYtrChJO8Y25yEj0bSn+o91h+bHZG+x97iMkGAnI7IDv
	 GKOsnPvQLjXgTQrnj0opSLH841UtrmMB/Qc6LLXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/129] selftests/bpf: Move get_time_ns to testing_helpers.h
Date: Thu,  2 Jul 2026 18:18:52 +0200
Message-ID: <20260702155112.436376777@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270813-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jolsa@kernel.org,m:ast@kernel.org,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6ED16FA552

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 3830d04a7401f277185e4439eb259c1b13e76788 upstream.

We'd like to have single copy of get_time_ns used b bench and test_progs,
but we can't just include bench.h, because of conflicting 'struct env'
objects.

Moving get_time_ns to testing_helpers.h which is being included by both
bench and test_progs objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230809083440.3209381-19-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: e6c209da7e0e ("selftests/bpf: Check for timeout in perf_link test")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bench.h                    |  9 ---------
 .../selftests/bpf/prog_tests/kprobe_multi_test.c       |  8 --------
 tools/testing/selftests/bpf/testing_helpers.h          | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 66959387148375..2c94c57885af85 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -79,15 +79,6 @@ void grace_period_latency_basic_stats(struct bench_res res[], int res_cnt,
 void grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt,
 				    struct basic_stats *gp_stat);
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-
-	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static inline void atomic_inc(long *value)
 {
 	(void)__atomic_add_fetch(value, 1, __ATOMIC_RELAXED);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 0d82e28aed1ac0..8086e28346466f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -304,14 +304,6 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static size_t symbol_hash(const void *key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index f72fb24f8e90fb..ba4f205e7bc757 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <time.h>
 
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
@@ -30,4 +31,13 @@ int load_bpf_testmod(bool verbose);
 void unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 
+static inline __u64 get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+
+	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.53.0




