Return-Path: <stable+bounces-219842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE2YO0yeoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:26:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC291AE4E5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9D87303D886
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558944D024;
	Thu, 26 Feb 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/nAv674"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6044B687;
	Thu, 26 Feb 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133625; cv=none; b=dhKmHMokg5UNSEzcTn2tSZJFSMBZ6WPD1uj3Gppgqk/I2nO3uRxaeU7cphvncdXaYSgAdGebIbi/j5wSd2DX8zXk2+80QjqIfOI/C3DaoJur/PBX7b7D4giYJFtpQAqKT6n7f6qAU3mWr5ifhs1aYuD95mAmgqLNIK4VZk48+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133625; c=relaxed/simple;
	bh=8UyDlmzdL0eewNEbx4lzAEUxHzJ8czj4cIo2S6TSjqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3LEJpj4RZ1jLYvzY0wz+rRkMZcdrSyyAQnCdO/IAeTUUaBrW5WnotGrix5ZP6EXPzXV0+6kagdB84ZIGWZK2Afaq6UJixm8SeoMiXwT27UivA4WFEeAWYa5m5xYBYB34dQE58cJebfU9UttkKF5EsWSvYc24C3Qsp+E0zosuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/nAv674; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122CDC116C6;
	Thu, 26 Feb 2026 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772133625;
	bh=8UyDlmzdL0eewNEbx4lzAEUxHzJ8czj4cIo2S6TSjqM=;
	h=From:To:Cc:Subject:Date:From;
	b=G/nAv674EeIiDW3pRhx/3VL+daUELNY5kXBhZJvPKwYQvNmNckb9YVwxny4ODSsNy
	 ntLtIkOZxJSQG2OSq7mq4suUwqFvZ6YnQ5r5yAf+TvqVG+Lbh6Wgxs1uCkXjPRAObf
	 A9OyZedyk3CeqtZl+v5rK9YPTKPXJ6HTu25zKoxkeMoVZGxyI78P/8pntLRAUfOK10
	 Ej7E4RLsHxSmzW97l1FMJkg0q4F68epK6i8SsNix2p6hvoLX8Z09cwROIIdEqS6TX+
	 uj10CXYhzYabAzMYYBBvXDzEzcFOdDqVOtSq/TkBXJ2V2bMrrFsROppo1aStxPRjOU
	 2MRXTMOWxCQuQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <raemoar63@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	stable@vger.kernel.org
Subject: [PATCH] lib/crypto: tests: Depend on library options rather than selecting them
Date: Thu, 26 Feb 2026 11:17:49 -0800
Message-ID: <20260226191749.39397-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,googlegroups.com,linux.dev,google.com,gmail.com,linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219842-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 5EC291AE4E5
X-Rspamd-Action: no action

The convention for KUnit tests is to have the test kconfig options
visible only when the code they depend on is already enabled.  This way
only the tests that are relevant to the particular kernel build can be
enabled, either manually or via KUNIT_ALL_TESTS.

Update lib/crypto/tests/Kconfig to follow that convention, i.e. depend
on the corresponding library options rather than selecting them.  This
fixes an issue where enabling KUNIT_ALL_TESTS enabled non-test code.

This does mean that it becomes more difficult to enable *all* the crypto
library tests (which is what I do as a maintainer of the code), since
doing so will now require enabling other options that select the
libraries.  Regardless, we should follow the standard KUnit convention.

Note: currently most of the crypto library options are selected by
visible options in crypto/Kconfig, which can be used to enable them
without too much trouble.  If in the future we end up with more cases
like CRYPTO_LIB_CURVE25519 which is selected only by WIREGUARD (thus
making CRYPTO_LIB_CURVE25519_KUNIT_TEST effectively depend on WIREGUARD
after this commit), we could consider adding a new kconfig option that
enables all the library code specifically for testing.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/r/CAMuHMdVFRQZXCKJBOBDJtpENvpVO39AxGMUFWVQdM6xKTpnYYw@mail.gmail.com
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
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch applies to v7.0-rc1 and is targeting libcrypto-fixes

 lib/crypto/tests/Kconfig | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/lib/crypto/tests/Kconfig b/lib/crypto/tests/Kconfig
index 4970463ea0aaa..0de289b429a95 100644
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -1,120 +1,109 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 config CRYPTO_LIB_BLAKE2B_KUNIT_TEST
 	tristate "KUnit tests for BLAKE2b" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_BLAKE2B
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_BLAKE2B
 	help
 	  KUnit tests for the BLAKE2b cryptographic hash function.
 
 config CRYPTO_LIB_BLAKE2S_KUNIT_TEST
 	tristate "KUnit tests for BLAKE2s" if !KUNIT_ALL_TESTS
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
 
 # Option is named *_SHA256_KUNIT_TEST, though both SHA-224 and SHA-256 tests are
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
 
 # Option is named *_SHA512_KUNIT_TEST, though both SHA-384 and SHA-512 tests are
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
 	  SHAKE256.
 

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.53.0


