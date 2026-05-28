Return-Path: <stable+bounces-255768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHkBIuGnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C25F9377
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B42F33A397C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF732F39B4;
	Thu, 28 May 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgoxLKah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02862E7379;
	Thu, 28 May 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999827; cv=none; b=PLIVUFpkhaM3qyiljx/zIfQ1ZpLWA2s2NIF5EKc0mpSzs1JzH6iu4E1j+os7LpQ5+j9etk+GQFgWRrsGpGgxYTEbGEvaWgP3GRqHDcI5Lsi+9bAM5t5BXAq7iKiPWfJj3Piwagz2pu0s+4WSKQdFPAZfu9W6cID/g7X4EutuQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999827; c=relaxed/simple;
	bh=Mgt3Rl9L6figr+WTLBlodB2HuE2RDQBoqg0HIL3JtNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7nAh7ujijhVpB604HuL1/f4krNYV62t6x84N8BulP+WQGYKaYv+GLdXkXApINL6mykDa8isFRGbpsOgW45fhKRty9IcHYa47tDBS3uoCsTXioRjSq/H/nmDEwf/W3G4U1j24kU67NdRQDq3qcMDck1lUoKG/++VVjnsWSDUzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgoxLKah; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE1B1F000E9;
	Thu, 28 May 2026 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999825;
	bh=8/jVc271gvL12bQMEzL989rKzSy2WnFcMGGyx+QcFsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SgoxLKahU71wfpji6cSvQGG1zNiBxGwR9RvvU8FuayCfRKtv+Z2DKW6RsVT1T6JKh
	 tQomdd7r44aKxeS3V4pTOreDcpW4+IeBZTeUfAdVvjQOvBleMSG9e1z0edpvxr9qyL
	 rCJ9uUzUuVhJ6vaB7VTGHWCspo2F3TwwuMdiSDt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Kaiser <martin@kaiser.cx>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 206/377] test_kprobes: clear kprobes between test runs
Date: Thu, 28 May 2026 21:47:24 +0200
Message-ID: <20260528194644.368850722@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255768-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,rp.kp:url,rp4.kp:url,martin-riscv-1:email,kaiser.cx:email,rp2.kp:url,rp3.kp:url]
X-Rspamd-Queue-Id: E92C25F9377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 lib/tests/test_kprobes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
index b7582010125c3..06e729e4de051 100644
--- a/lib/tests/test_kprobes.c
+++ b/lib/tests/test_kprobes.c
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




