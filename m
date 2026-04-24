Return-Path: <stable+bounces-240928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEt1Bepz62kQNAAAu9opvQ
	(envelope-from <stable+bounces-240928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47D45F8E0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E03853009018
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8483C061E;
	Fri, 24 Apr 2026 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0/yuoEWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F53537DF;
	Fri, 24 Apr 2026 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038202; cv=none; b=DZYHAswyVV/1MAOsosKNvHmPYGlU2/cHl1+jALdH2L5oLMBkV3enA2l3ye9pMDxaccisGRyJAcTYUWa2lPc98/QeAubska36mtN8XXPwXcB6mCkgAEgpOnaGMXHw0eb+4PYmANtOYXn/Fj3gUBy/RHZWnecxrIH+QLu8N3vcWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038202; c=relaxed/simple;
	bh=cgSVu78WW5hVXtuMsoj9/caHwPgAbcdvQc22um+ywEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViKY0V7zifuSpW/4Ox3IDCAtBpv4kjo9vddveE5K1t68mp3OqzX1RUINfF5PnXHlksfSfFh/rBF7Pbr7iC6MarVLtZ4KYqCBFH6orSs966oKUvtneAUNs9IuwRxV4MxJXukk4KOFTD1a8m5Yc/VLl09ONOmlWJxQc+q4/WYM69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0/yuoEWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36606C19425;
	Fri, 24 Apr 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038202;
	bh=cgSVu78WW5hVXtuMsoj9/caHwPgAbcdvQc22um+ywEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0/yuoEWyDPYBZ3dCgxgwvrZRYgSZUh3W6u6R3/N8g84lNYIvgB7d+6yE3RtBkpdb7
	 6Xn/V7qiF+zOuPdsAyr7XXCL4hGUTKcn04r7Nmywur0sr5A6Tv8S7/7AEMbqLAN7zk
	 yYH6dsE3QDWfqaCMnW0gdxFfFahVFQhsG4LFF708=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"linux-crypto@vger.kernel.org, kunit-dev@googlegroups.com, Eric Biggers" <ebiggers@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 22/55] lib/crypto: tests: Introduce CRYPTO_LIB_ENABLE_ALL_FOR_KUNIT
Date: Fri, 24 Apr 2026 15:31:01 +0200
Message-ID: <20260424132434.687431117@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7D47D45F8E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240928-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit ed1767442d919f57aaf83d69c33853da2644d902 upstream.

For kunit.py to run all the crypto library tests when passed the
--alltests option, tools/testing/kunit/configs/all_tests.config needs to
enable options that satisfy the test dependencies.

This is the same as what lib/crypto/.kunitconfig already does.
However, the strategy that lib/crypto/.kunitconfig currently uses to
select all the hidden library options isn't going to scale up well when
it needs to be repeated in two places.

Instead let's go ahead and introduce an option
CRYPTO_LIB_ENABLE_ALL_FOR_KUNIT that depends on KUNIT and selects all
the crypto library options that have corresponding KUnit tests.

Update lib/crypto/.kunitconfig to use this option.

Link: https://lore.kernel.org/r/20260314035927.51351-2-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crypto/.kunitconfig  |   14 +-------------
 lib/crypto/tests/Kconfig |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 13 deletions(-)

--- a/lib/crypto/.kunitconfig
+++ b/lib/crypto/.kunitconfig
@@ -1,18 +1,6 @@
 CONFIG_KUNIT=y
 
-# These kconfig options select all the CONFIG_CRYPTO_LIB_* symbols that have a
-# corresponding KUnit test.  Those symbols cannot be directly enabled here,
-# since they are hidden symbols.
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-CONFIG_INET=y
-CONFIG_IPV6=y
-CONFIG_NET=y
-CONFIG_NETDEVICES=y
-CONFIG_WIREGUARD=y
+CONFIG_CRYPTO_LIB_ENABLE_ALL_FOR_KUNIT=y
 
 CONFIG_CRYPTO_LIB_BLAKE2S_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_CURVE25519_KUNIT_TEST=y
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -66,6 +66,24 @@ config CRYPTO_LIB_SHA512_KUNIT_TEST
 	  KUnit tests for the SHA-384 and SHA-512 cryptographic hash functions
 	  and their corresponding HMACs.
 
+config CRYPTO_LIB_ENABLE_ALL_FOR_KUNIT
+	tristate "Enable all crypto library code for KUnit tests"
+	depends on KUNIT
+	select CRYPTO_LIB_CURVE25519
+	select CRYPTO_LIB_MD5
+	select CRYPTO_LIB_POLY1305
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
+	help
+	  Enable all the crypto library code that has KUnit tests.
+
+	  Enable this only if you'd like to test all the crypto library code,
+	  even code that wouldn't otherwise need to be built.
+
+	  You'll still need to enable the tests themselves, either individually
+	  or using KUNIT_ALL_TESTS.
+
 config CRYPTO_LIB_BENCHMARK_VISIBLE
 	bool
 



