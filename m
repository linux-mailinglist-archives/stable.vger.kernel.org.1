Return-Path: <stable+bounces-245666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAwzJ/Q/A2ro2AEAu9opvQ
	(envelope-from <stable+bounces-245666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:57:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF25231B6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6421311568C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122543A7D82;
	Tue, 12 May 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hii+mpb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC53A599D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594584; cv=none; b=UIC9+uWe7yn0TolEN1uR+wUcHyw1uTmoZZ7Zx2gkleE1iXjpw4+DHbgZqMbk4Sz43ilpxAYM+++GJcvdoGtvcrF5m1t1l9UX1otXO2tFGXLtyB71nRRkrF19eWkb/c1G4A0UNPoQXz59rtwZSaSnUjOF8sIWXoDq8J0Ei+I5Ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594584; c=relaxed/simple;
	bh=UfWVhppF8FFovefg26z1N+jEE3li+sUfniu9oVUmYcY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GPq+FZVhGQXfHRz/Ncip6SDDhPgmwATTzFartkqMJP8mFySRMI+7ST5cScw6T43LO6VwmjKLnpNkTJb2ca7pKN5Gg/KJ+8mv8X5ZYfdl84XK6P+eJvXjupKIHmEFJrhZsz/Ru1R3mhNOtuXnuT7d99q6Y/XPUe4056Bj9bJiRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hii+mpb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F2C2BCB0;
	Tue, 12 May 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594583;
	bh=UfWVhppF8FFovefg26z1N+jEE3li+sUfniu9oVUmYcY=;
	h=Subject:To:Cc:From:Date:From;
	b=hii+mpb+z+hnSacsvB0p8n1FUnpzCv43U7LUW/RdFIxPuNjpbcCysXFopwGjhbKi3
	 KqQJfGryxuJ3HdSnmCy54EzmBZT9nd8N79axxZwbInLHWSDBZsEajMsrGBV9ob+1/Y
	 1dlQHHfEU4zev0lmZsWaM4IokWAy6i2BlrG7WqoY=
Subject: FAILED: patch "[PATCH] lib/crc: tests: Make crc_kunit test only the enabled CRC" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:01:34 +0200
Message-ID: <2026051234-enjoyer-prankster-e471@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DBF25231B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245666-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 85c9f3a2b805eb96d899da7bcc38a16459aa3c16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051234-enjoyer-prankster-e471@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85c9f3a2b805eb96d899da7bcc38a16459aa3c16 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 5 Mar 2026 19:35:55 -0800
Subject: [PATCH] lib/crc: tests: Make crc_kunit test only the enabled CRC
 variants

Like commit 4478e8eeb871 ("lib/crypto: tests: Depend on library options
rather than selecting them") did with the crypto library tests, make
crc_kunit depend on the code it tests rather than selecting it.  This
follows the standard convention for KUnit and fixes an issue where
enabling KUNIT_ALL_TESTS enabled non-test code.

crc_kunit does differ from the crypto library tests in that it
consolidates the tests for multiple CRC variants, with 5 kconfig
options, into one KUnit suite.  Since depending on *all* of these
kconfig options would greatly restrict the ability to enable crc_kunit,
instead just depend on *any* of these options.  Update crc_kunit
accordingly to test only the reachable code.

Alternatively we could split crc_kunit into 5 test suites.  But keeping
it as one is simpler for now.

Fixes: e47d9b1a76ed ("lib/crc_kunit.c: add KUnit test suite for CRC library functions")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260306033557.250499-2-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 70e7a6016de3..9ddfd1a29757 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -99,13 +99,8 @@ config CRC_OPTIMIZATIONS
 
 config CRC_KUNIT_TEST
 	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && (CRC7 || CRC16 || CRC_T10DIF || CRC32 || CRC64)
 	default KUNIT_ALL_TESTS
-	select CRC7
-	select CRC16
-	select CRC_T10DIF
-	select CRC32
-	select CRC64
 	help
 	  Unit tests for the CRC library functions.
 
diff --git a/lib/crc/tests/crc_kunit.c b/lib/crc/tests/crc_kunit.c
index 9a450e25ac81..9428cd913625 100644
--- a/lib/crc/tests/crc_kunit.c
+++ b/lib/crc/tests/crc_kunit.c
@@ -268,8 +268,7 @@ crc_benchmark(struct kunit *test,
 	}
 }
 
-/* crc7_be */
-
+#if IS_REACHABLE(CONFIG_CRC7)
 static u64 crc7_be_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	/*
@@ -294,9 +293,9 @@ static void crc7_be_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc7_be_wrapper);
 }
+#endif /* CONFIG_CRC7 */
 
-/* crc16 */
-
+#if IS_REACHABLE(CONFIG_CRC16)
 static u64 crc16_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc16(crc, p, len);
@@ -318,9 +317,9 @@ static void crc16_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc16_wrapper);
 }
+#endif /* CONFIG_CRC16 */
 
-/* crc_t10dif */
-
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 static u64 crc_t10dif_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc_t10dif_update(crc, p, len);
@@ -342,6 +341,9 @@ static void crc_t10dif_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc_t10dif_wrapper);
 }
+#endif /* CONFIG_CRC_T10DIF */
+
+#if IS_REACHABLE(CONFIG_CRC32)
 
 /* crc32_le */
 
@@ -414,6 +416,9 @@ static void crc32c_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc32c_wrapper);
 }
+#endif /* CONFIG_CRC32 */
+
+#if IS_REACHABLE(CONFIG_CRC64)
 
 /* crc64_be */
 
@@ -463,24 +468,35 @@ static void crc64_nvme_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc64_nvme_wrapper);
 }
+#endif /* CONFIG_CRC64 */
 
 static struct kunit_case crc_test_cases[] = {
+#if IS_REACHABLE(CONFIG_CRC7)
 	KUNIT_CASE(crc7_be_test),
 	KUNIT_CASE(crc7_be_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC16)
 	KUNIT_CASE(crc16_test),
 	KUNIT_CASE(crc16_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 	KUNIT_CASE(crc_t10dif_test),
 	KUNIT_CASE(crc_t10dif_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC32)
 	KUNIT_CASE(crc32_le_test),
 	KUNIT_CASE(crc32_le_benchmark),
 	KUNIT_CASE(crc32_be_test),
 	KUNIT_CASE(crc32_be_benchmark),
 	KUNIT_CASE(crc32c_test),
 	KUNIT_CASE(crc32c_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC64)
 	KUNIT_CASE(crc64_be_test),
 	KUNIT_CASE(crc64_be_benchmark),
 	KUNIT_CASE(crc64_nvme_test),
 	KUNIT_CASE(crc64_nvme_benchmark),
+#endif
 	{},
 };
 


