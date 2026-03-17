Return-Path: <stable+bounces-225844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPsJJIU9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6F2A90CB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F70A30B7014
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF137268C;
	Tue, 17 Mar 2026 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WESQmvcE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B6357A20
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747407; cv=none; b=B0Zz0N0gz8jmJdH+EcdVgCoQBafEjS8BvJCf90lx9FMzoAsB8OpSVlBRTerg7x5pnmJ9CXl/CKSH6Hnqzgj9eMANYO5u35ZPQSKnRRB2RLaw40/UPPFC4kNcdT15iXB0EwfOasZr1Vo6YBz8vC1azS/YdndDEHTtC0/Wh/ZXECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747407; c=relaxed/simple;
	bh=davyLUGINtIA8msP32vNRtqjuJiJ9vQ/zdG27iUUBq0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DP/hNlQEEBbhMg87xj4W/romPxx5adWXuEJTrffvRV/axnEuixkRVx8B9ignb9L53kh7obXAaMFvbB0fnLxPvm6B16qq0Csl008+YXLwBbM6ekDm7mNxIAEWpk3xkNHW7wRKIeVXXNLQ08dj5bR/FrpYCOesIRxzH7itXeB2Unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WESQmvcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5A1C2BC9E;
	Tue, 17 Mar 2026 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747406;
	bh=davyLUGINtIA8msP32vNRtqjuJiJ9vQ/zdG27iUUBq0=;
	h=Subject:To:Cc:From:Date:From;
	b=WESQmvcE9Bvft9Qrh8yow0A7O3Xod3Ygv88kMvGm9rfpEg8sVJw22ETI9INtUIJlo
	 GHJ+VPUghIHr2g2SLiQQQyQddsRGwC8/OYNb+03j+35877KxxnLzY+BMwM3fKLNrJq
	 xtLE7a7zbszXXoQfpB5rp2rIb7N4wB8uc10/PVVs=
Subject: FAILED: patch "[PATCH] lib/crypto: tests: Depend on library options rather than" failed to apply to 6.19-stable tree
To: ebiggers@kernel.org,ardb@kernel.org,david@davidgow.net,geert@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:36:43 +0100
Message-ID: <2026031743-wolf-improper-746a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-225844-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: EFD6F2A90CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4478e8eeb87120c11e90041864c2233238b2155a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031743-wolf-improper-746a@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4478e8eeb87120c11e90041864c2233238b2155a Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 26 Feb 2026 11:17:49 -0800
Subject: [PATCH] lib/crypto: tests: Depend on library options rather than
 selecting them

The convention for KUnit tests is to have the test kconfig options
visible only when the code they depend on is already enabled.  This way
only the tests that are relevant to the particular kernel build can be
enabled, either manually or via KUNIT_ALL_TESTS.

Update lib/crypto/tests/Kconfig to follow that convention, i.e. depend
on the corresponding library options rather than selecting them.  This
fixes an issue where enabling KUNIT_ALL_TESTS enabled non-test code.

This does mean that it becomes a bit more difficult to enable *all* the
crypto library tests (which is what I do as a maintainer of the code),
since doing so will now require enabling other options that select the
libraries.  Regardless, we should follow the standard KUnit convention.
I'll also add a .kunitconfig file that does enable all these options.

Note: currently most of the crypto library options are selected by
visible options in crypto/Kconfig, which can be used to enable them
without too much trouble.  If in the future we end up with more cases
like CRYPTO_LIB_CURVE25519 which is selected only by WIREGUARD (thus
making CRYPTO_LIB_CURVE25519_KUNIT_TEST effectively depend on WIREGUARD
after this commit), we could consider adding a new kconfig option that
enables all the library code specifically for testing.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/r/CAMuHMdULzMdxuTVfg8_4jdgzbzjfx-PHkcgbGSthcUx_sHRNMg@mail.gmail.com
Fixes: 4dcf6caddaa0 ("lib/crypto: tests: Add KUnit tests for SHA-224 and SHA-256")
Fixes: 571eaeddb67d ("lib/crypto: tests: Add KUnit tests for SHA-384 and SHA-512")
Fixes: 6dd4d9f7919e ("lib/crypto: tests: Add KUnit tests for Poly1305")
Fixes: 66b130607908 ("lib/crypto: tests: Add KUnit tests for SHA-1 and HMAC-SHA1")
Fixes: d6b6aac0cdb4 ("lib/crypto: tests: Add KUnit tests for MD5 and HMAC-MD5")
Fixes: afc4e4a5f122 ("lib/crypto: tests: Migrate Curve25519 self-test to KUnit")
Fixes: 6401fd334ddf ("lib/crypto: tests: Add KUnit tests for BLAKE2b")
Fixes: 15c64c47e484 ("lib/crypto: tests: Add SHA3 kunit tests")
Fixes: b3aed551b3fc ("lib/crypto: tests: Add KUnit tests for POLYVAL")
Fixes: ed894faccb8d ("lib/crypto: tests: Add KUnit tests for ML-DSA verification")
Fixes: 7246fe6cd644 ("lib/crypto: tests: Add KUnit tests for NH")
Cc: stable@vger.kernel.org
Reviewed-by: David Gow <david@davidgow.net>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260226191749.39397-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/tests/Kconfig b/lib/crypto/tests/Kconfig
index 4970463ea0aa..0de289b429a9 100644
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -2,10 +2,9 @@
 
 config CRYPTO_LIB_BLAKE2B_KUNIT_TEST
 	tristate "KUnit tests for BLAKE2b" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_BLAKE2B
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_BLAKE2B
 	help
 	  KUnit tests for the BLAKE2b cryptographic hash function.
 
@@ -14,71 +13,64 @@ config CRYPTO_LIB_BLAKE2S_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	# No need to select CRYPTO_LIB_BLAKE2S here, as that option doesn't
+	# No need to depend on CRYPTO_LIB_BLAKE2S here, as that option doesn't
 	# exist; the BLAKE2s code is always built-in for the /dev/random driver.
 	help
 	  KUnit tests for the BLAKE2s cryptographic hash function.
 
 config CRYPTO_LIB_CURVE25519_KUNIT_TEST
 	tristate "KUnit tests for Curve25519" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_CURVE25519
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_CURVE25519
 	help
 	  KUnit tests for the Curve25519 Diffie-Hellman function.
 
 config CRYPTO_LIB_MD5_KUNIT_TEST
 	tristate "KUnit tests for MD5" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_MD5
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_MD5
 	help
 	  KUnit tests for the MD5 cryptographic hash function and its
 	  corresponding HMAC.
 
 config CRYPTO_LIB_MLDSA_KUNIT_TEST
 	tristate "KUnit tests for ML-DSA" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_MLDSA
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_MLDSA
 	help
 	  KUnit tests for the ML-DSA digital signature algorithm.
 
 config CRYPTO_LIB_NH_KUNIT_TEST
 	tristate "KUnit tests for NH" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_NH
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
-	select CRYPTO_LIB_NH
 	help
 	  KUnit tests for the NH almost-universal hash function.
 
 config CRYPTO_LIB_POLY1305_KUNIT_TEST
 	tristate "KUnit tests for Poly1305" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_POLY1305
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_POLY1305
 	help
 	  KUnit tests for the Poly1305 library functions.
 
 config CRYPTO_LIB_POLYVAL_KUNIT_TEST
 	tristate "KUnit tests for POLYVAL" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_POLYVAL
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_POLYVAL
 	help
 	  KUnit tests for the POLYVAL library functions.
 
 config CRYPTO_LIB_SHA1_KUNIT_TEST
 	tristate "KUnit tests for SHA-1" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_SHA1
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_SHA1
 	help
 	  KUnit tests for the SHA-1 cryptographic hash function and its
 	  corresponding HMAC.
@@ -87,10 +79,9 @@ config CRYPTO_LIB_SHA1_KUNIT_TEST
 # included, for consistency with the naming used elsewhere (e.g. CRYPTO_SHA256).
 config CRYPTO_LIB_SHA256_KUNIT_TEST
 	tristate "KUnit tests for SHA-224 and SHA-256" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_SHA256
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_SHA256
 	help
 	  KUnit tests for the SHA-224 and SHA-256 cryptographic hash functions
 	  and their corresponding HMACs.
@@ -99,20 +90,18 @@ config CRYPTO_LIB_SHA256_KUNIT_TEST
 # included, for consistency with the naming used elsewhere (e.g. CRYPTO_SHA512).
 config CRYPTO_LIB_SHA512_KUNIT_TEST
 	tristate "KUnit tests for SHA-384 and SHA-512" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_SHA512
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_SHA512
 	help
 	  KUnit tests for the SHA-384 and SHA-512 cryptographic hash functions
 	  and their corresponding HMACs.
 
 config CRYPTO_LIB_SHA3_KUNIT_TEST
 	tristate "KUnit tests for SHA-3" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_SHA3
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_SHA3
 	help
 	  KUnit tests for the SHA3 cryptographic hash and XOF functions,
 	  including SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128 and


