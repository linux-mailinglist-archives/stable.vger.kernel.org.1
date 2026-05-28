Return-Path: <stable+bounces-256337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O+pM9+sGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:00:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3815FA085
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7AD3218B03
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC79318B9D;
	Thu, 28 May 2026 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZ5Kmoub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916C2F260C;
	Thu, 28 May 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001419; cv=none; b=TIf5H3Q49/7Y0gNi2TCmPoluuOMDFmbmNMTchgjih4Dm1O9u87MCiTUD1MHh2Y2b2NI92hj+jM4QZSSxRbMBpdDwXF92xIpLF1cKTo4ENah0gE6CNXt0iXmz7FP88pd+7YtuBDl6hj5rppo4/7L2jg8gnWQX78T7xQe6lMsWKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001419; c=relaxed/simple;
	bh=4Do3FCAs+NGpXzbIVdO9uOR1nXa1hfsWWaUSWxzhYFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhBPXWMHpzbTiQmfVloOZgknJbYQIzMISeBcrzT73mgJz5nyjbMkbVkhe99a0goTiZX6SCi14XE4pLoERD5tLyJgyuaN81rSAs+W/FgUdOGeJuuK5LeBTMoy67P6L5pCzEG0tdKOFYy+i4FFMLusnqcKH5MRtfy7m2/BP6n7/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZ5Kmoub; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D67F1F000E9;
	Thu, 28 May 2026 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001417;
	bh=9v7Cq4T8I1UFase3JjNjGMYmUfwnwjmOCkmbGVKjgqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ5Kmoub1dQKdNHzgqdAUr4XYd6UdlWfcDOSjtHeBqGWTpBU7cYMDjbM+fdhin+s/
	 V0EHDnP+SGqJyaA0vY7JyeQHaZfPHDTvjYsNkeG7xSb797OteNceSatjDGTMN2DZI0
	 yS8Ai69QuvcSi9qEwnfbV1PRnLhpJ6fU0c6EAs7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Kaiser <martin@kaiser.cx>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 121/186] test_kprobes: clear kprobes between test runs
Date: Thu, 28 May 2026 21:50:01 +0200
Message-ID: <20260528194932.210924020@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256337-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[martin-riscv-1:email,kaiser.cx:email,rp3.kp:url,rp4.kp:url,rp2.kp:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,rp.kp:url]
X-Rspamd-Queue-Id: 2F3815FA085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit ef5581bb30efb939cc2bf093475c6cc85258e5cd ]

Running the kprobes sanity tests twice makes all tests fail and
eventually crashes the kernel.

[root@martin-riscv-1 ~]# echo 1 > /sys/kernel/debug/kunit/kprobes_test/run
...
   # Totals: pass:5 fail:0 skip:0 total:5
   ok 1 kprobes_test
[root@martin-riscv-1 ~]# echo 1 > /sys/kernel/debug/kunit/kprobes_test/run
...
  # test_kprobe: EXPECTATION FAILED at lib/tests/test_kprobes.c:64
  Expected 0 == register_kprobe(&kp), but
      register_kprobe(&kp) == -22 (0xffffffffffffffea)
...
  Unable to handle kernel paging request ...

The testsuite defines several kprobes and kretprobes as static variables
that are preserved across test runs.

After register_kprobe and unregister_kprobe, a kprobe contains some
leftover data that must be cleared before the kprobe can be registered
again. The tests are setting symbol_name to define the probe location.
Address and flags must be cleared.

The existing code clears some of the probes between subsequent tests, but
not between two test runs. The leftover data from a previous test run
makes the registrations fail in the next run.

Move the cleanups for all kprobes into kprobes_test_init, this function
is called before each single test (including the first test of a test
run).

Link: https://lore.kernel.org/all/20260507134615.1010905-1-martin@kaiser.cx/

Fixes: e44e81c5b90f ("kprobes: convert tests to kunit")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_kprobes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
index 0648f7154f5c4..cd7a452ab3032 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -12,6 +12,12 @@
 
 #define div_factor 3
 
+#define KP_CLEAR(_kp) \
+do { \
+	(_kp).addr = NULL; \
+	(_kp).flags = 0; \
+} while (0)
+
 static u32 rand1, preh_val, posth_val;
 static u32 (*target)(u32 value);
 static u32 (*recursed_target)(u32 value);
@@ -125,10 +131,6 @@ static void test_kprobes(struct kunit *test)
 
 	current_test = test;
 
-	/* addr and flags should be cleard for reusing kprobe. */
-	kp.addr = NULL;
-	kp.flags = 0;
-
 	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
 	preh_val = 0;
 	posth_val = 0;
@@ -226,9 +228,6 @@ static void test_kretprobes(struct kunit *test)
 	struct kretprobe *rps[2] = {&rp, &rp2};
 
 	current_test = test;
-	/* addr and flags should be cleard for reusing kprobe. */
-	rp.kp.addr = NULL;
-	rp.kp.flags = 0;
 	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
 
 	krph_val = 0;
@@ -290,8 +289,6 @@ static void test_stacktrace_on_kretprobe(struct kunit *test)
 	unsigned long myretaddr = (unsigned long)__builtin_return_address(0);
 
 	current_test = test;
-	rp3.kp.addr = NULL;
-	rp3.kp.flags = 0;
 
 	/*
 	 * Run the stacktrace_driver() to record correct return address in
@@ -352,8 +349,6 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
 	struct kretprobe *rps[2] = {&rp3, &rp4};
 
 	current_test = test;
-	rp3.kp.addr = NULL;
-	rp3.kp.flags = 0;
 
 	//KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
 
@@ -367,6 +362,18 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
 
 static int kprobes_test_init(struct kunit *test)
 {
+	KP_CLEAR(kp);
+	KP_CLEAR(kp2);
+	KP_CLEAR(kp_missed);
+#ifdef CONFIG_KRETPROBES
+	KP_CLEAR(rp.kp);
+	KP_CLEAR(rp2.kp);
+#ifdef CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	KP_CLEAR(rp3.kp);
+	KP_CLEAR(rp4.kp);
+#endif
+#endif
+
 	target = kprobe_target;
 	target2 = kprobe_target2;
 	recursed_target = kprobe_recursed_target;
-- 
2.53.0




