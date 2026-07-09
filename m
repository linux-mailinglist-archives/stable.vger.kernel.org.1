Return-Path: <stable+bounces-272786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8C+QL+MHT2p/ZQIAu9opvQ
	(envelope-from <stable+bounces-272786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 04:30:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0F72BF2D
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 04:30:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WbnAqlDQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272786-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272786-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75613036424
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304533F5BD;
	Thu,  9 Jul 2026 02:30:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCA1A9F83;
	Thu,  9 Jul 2026 02:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564213; cv=none; b=oT2iXsz5bSDp28Ci1bv6kXIw6j4Iq8pfnKAjUclpdkCx14pdY1eAPgFRBjB1ffYBZf9Bh9e55A7Q0nJR6033WnGdL16vvDAu3Q1wVQZVP9CcCn2tORJnKijuFdqyKFDklkP5ANUPlvH4LYkYWcJ9iz2lUM09SR8cjvlqHLE3lo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564213; c=relaxed/simple;
	bh=5s3+b0OPj0QT8LLuYKahd5FUmo2fDiDuNCUZMKplh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxU7bgwqiJvPn5NOKwKwaEWh4LbBMnGkOmL4a82Pad2mrZVFXGfHQmCCdf+YKuhU6ttaTMiIe+ddVwEC+asB7BYAEBiCVaITmZdc0Da0AnoAOIvUTRj9C6jZpv9YMOO0nEPVbqEzFUz6uHyCAZvU0XLHJk4rsgYW/J0NYlErC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbnAqlDQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343F01F000E9;
	Thu,  9 Jul 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783564211;
	bh=4JCf6/UCFQuTBqxcZ0SaqkiNjUZ2DK9Onba0ROtqu/Y=;
	h=From:To:Cc:Subject:Date;
	b=WbnAqlDQuANiwAouiUHwXF8oVxnznnINRTDbCR0wLDk8O2I5ikYCp78mnDLFjFSs1
	 V+HFUXe1qMphqKfxbSCTmUGkISDMYW2t7uNDT8EgeUehn1icuyHDfIkDYXdzaaHlI8
	 ZSiXnKWjtyFz5wczqtqIllqdPGkmyE0GWbFTprL8hSlSkZxRWtVQDG0hEOyOoH/9vf
	 L8q44p/jBDCKWFzvlsFwJWBv8jMqaCxxqUr1QK2N8M0PSChcB9vfQALwwkDnQeNNGz
	 mfJpt4ngQ82po8UlPB9dOzwGknnRSa8l0/yZdCucuk2QIRHdn4bUmUvcDbg3Y2YzWV
	 OM7NkNiLNLt6w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: aes - Fix conditions for selecting MAC dependencies
Date: Wed,  8 Jul 2026 22:29:54 -0400
Message-ID: <20260709022954.45113-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272786-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63D0F72BF2D

Starting in commit 7137cbf2b5c9 ("crypto: aes - Add cmac, xcbc, and
cbcmac algorithms using library"), the aes module (CRYPTO_AES) supports
CBC based MACs using the corresponding library functions.

To avoid including unneeded functionality, that support honors the
existing CRYPTO_CMAC, CRYPTO_XCBC, and CRYPTO_CCM kconfig options.  The
dependencies are selected if at least one of those is enabled.

However, the select statements don't correctly handle the case where
CRYPTO_AES=y and (for example) CRYPTO_CMAC=m.  In that case the
dependencies get selected at level 'm', due to how the kconfig language
works.  That causes a linker error.

Fix this by changing the selection conditions to use '!= n'.

A similar issue also exists for CRYPTO_LIB_AES's conditional selection
of CRYPTO_LIB_UTILS.  The same '!= n' would work, but instead just make
CRYPTO_LIB_AES always select CRYPTO_LIB_UTILS.  CRYPTO_LIB_UTILS is
lightweight, and it's needed by most AES modes and many other things.

Fixes: 7137cbf2b5c9 ("crypto: aes - Add cmac, xcbc, and cbcmac algorithms using library")
Fixes: 309a7e514da7 ("lib/crypto: aes: Add support for CBC-based MACs")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

I'm planning to take this patch through libcrypto-fixes.

 crypto/Kconfig     | 4 ++--
 lib/crypto/Kconfig | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index f1e372195273..b61401bd3ef6 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -358,8 +358,8 @@ config CRYPTO_AES
 	tristate "AES (Advanced Encryption Standard)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
-	select CRYPTO_LIB_AES_CBC_MACS if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
-	select CRYPTO_HASH if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
+	select CRYPTO_LIB_AES_CBC_MACS if CRYPTO_CMAC != n || CRYPTO_XCBC != n || CRYPTO_CCM != n
+	select CRYPTO_HASH if CRYPTO_CMAC != n || CRYPTO_XCBC != n || CRYPTO_CCM != n
 	help
 	  AES cipher algorithms (Rijndael)(FIPS-197, ISO/IEC 18033-3)
 
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 591c1c2a7fb3..83d4c95e079e 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -8,8 +8,7 @@ config CRYPTO_LIB_UTILS
 
 config CRYPTO_LIB_AES
 	tristate
-	# Select dependencies of modes that are part of libaes.
-	select CRYPTO_LIB_UTILS if CRYPTO_LIB_AES_CBC_MACS
+	select CRYPTO_LIB_UTILS
 
 config CRYPTO_LIB_AES_ARCH
 	bool

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0


