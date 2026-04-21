Return-Path: <stable+bounces-240241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMsOAv7m52lbCgIAu9opvQ
	(envelope-from <stable+bounces-240241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737543FA03
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38B6E301AFF7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD73DE42A;
	Tue, 21 Apr 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdIg9yJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8B3DE424;
	Tue, 21 Apr 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805596; cv=none; b=d4eu/dJQKVyNAH+jYYJyUXRADxwGSJDeYfMPawGN34wuLb+z5JyYbp7vf3n/Jjs1+Frn9B4kj7eTkWr2BCY6GPeSmwjLyiBBbmrt13GJjBFxTBWGeIhHBRGW9rPfh4xfr1F/TYXRuqqKkkIJOlNullqSGCNV8TPJKNSOwV/a19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805596; c=relaxed/simple;
	bh=gFhyDxaqLkbicx4vkrclZA247U28bwQ2jYvWEsQS62k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/cIQ6mq3OzJzbYlm+O/J0CL7sgnFChzWkyDNJ7MuHv4zcYrQx5bXQ9P8hEzowgMrs/hnnTgX3JcoOZaKiq0yanjMGgbagtAiFdMAbMLnyvUzp9alG9yLXmA/peQ7kNJA4YJRCh29VNNUj3G843bJ/jK65uDot0OiD2qbwgqVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdIg9yJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E0C2BCB4;
	Tue, 21 Apr 2026 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805596;
	bh=gFhyDxaqLkbicx4vkrclZA247U28bwQ2jYvWEsQS62k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdIg9yJsxSlF1bZTqz8Rnvh0QXThrKqjn2I5cCEsGTWw7Y1g321f6nBc6CMqNPlNJ
	 3dNWC6EUZwQGk6WpnpbFwI1G6zE51pIHAGdPo5BkSNskeapZUH1RB+0mu+XA+qpK56
	 2SRV0h0ygrENZpjQJRvIi6SO1G589wRph4bp9UZBpYXZArPPcLRWoBL2r1sUn5aGVm
	 pWUqKwBOP/745QaWNXb2ac5bFx6DfUIykwxhCA8exlu1Rzil3VZs2zgeV7jf1hzLEJ
	 3OsADt4Vg0yMLSvw1fnNRJwjrwCV+QaegkDLf5ezb1U4Oj0aHf8sysFeQJjyWJaLdr
	 mevjHn9YvU1cw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.18 5/8] lib/crypto: tests: Add a .kunitconfig file
Date: Tue, 21 Apr 2026 14:05:51 -0700
Message-ID: <20260421210554.36096-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421210554.36096-1-ebiggers@kernel.org>
References: <20260421210554.36096-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240241-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2737543FA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 20d6f07004d639967dcb00994d56ce6d16118e9e upstream.

Add a .kunitconfig file to the lib/crypto/ directory so that the crypto
library tests can be run more easily using kunit.py.  Example with UML:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crypto

Example with QEMU:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crypto --arch=arm64 --make_options LLVM=1

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260301040140.490310-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/.kunitconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 lib/crypto/.kunitconfig

diff --git a/lib/crypto/.kunitconfig b/lib/crypto/.kunitconfig
new file mode 100644
index 0000000000000..e38ccb5a4327e
--- /dev/null
+++ b/lib/crypto/.kunitconfig
@@ -0,0 +1,23 @@
+CONFIG_KUNIT=y
+
+# These kconfig options select all the CONFIG_CRYPTO_LIB_* symbols that have a
+# corresponding KUnit test.  Those symbols cannot be directly enabled here,
+# since they are hidden symbols.
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_NET=y
+CONFIG_NETDEVICES=y
+CONFIG_WIREGUARD=y
+
+CONFIG_CRYPTO_LIB_BLAKE2S_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_CURVE25519_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_MD5_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_POLY1305_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_SHA1_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_SHA256_KUNIT_TEST=y
+CONFIG_CRYPTO_LIB_SHA512_KUNIT_TEST=y
-- 
2.53.0


