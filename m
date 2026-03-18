Return-Path: <stable+bounces-227006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNpKGZFqumnnWAIAu9opvQ
	(envelope-from <stable+bounces-227006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:04:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260E2B8A2C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 367263010BAB
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9539E180;
	Wed, 18 Mar 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b="saxSUnA7"
X-Original-To: stable@vger.kernel.org
Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601435D604
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824640; cv=none; b=G4nNY/CeKWsdwPKlCQMPnqlD+Xf7BaClKRk8Q1YwBh+8Vboq6ajPN9WceaELK9ywYR2uXgGl5AL7ZhGAaKgbjNju1UWdnJE/LEBP6uvSH11rSBD59NDlMlv9IcY+fvIQqD3KAN2df80R2EplbaXnfwjmqyIhFRRBXnhMYXvmCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824640; c=relaxed/simple;
	bh=W4+xe38yEjG9SWFKdDLcrWA/dwSTIcAsK1usgGIfwng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XngXAsOKrXAsyt9Z3c3udXsfU/7ht7SVH5OnfMth+TrUl+4bK2jztfovoV28dOBn6A/N0gUE6qJ9c4BFelHQY6lbIu2vYqXOLZ58z+OFvvJwpCCkWA1h9+TJXmiGXKDnnKYEflWyFoFEpCkytHeF2JtGV3vOO3ERri2Y9qN76ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b=saxSUnA7; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 42F5244B91;
	Wed, 18 Mar 2026 10:03:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ac2.se; s=default;
	t=1773824628; bh=W4+xe38yEjG9SWFKdDLcrWA/dwSTIcAsK1usgGIfwng=;
	h=From:To:Cc:Subject:Date:From;
	b=saxSUnA7NOxuA0Y1hV4hz12meNgXOYCb3gRNF0+5e5jRmj1u25yrCXceb2hgJvkQu
	 blE86CqK6yKk3YiRKtIbumy3XSLHbzHMJeaVi8CFFJTk4SgI8/AM9zaVwNYlCc53+J
	 9qkjOqpBxY44LkZGBGEGZDBI1VmsFRpek7V57hX4=
Received: from suiko.ac2.se (suiko.ac2.se [130.239.18.162])
	by mail.acc.umu.se (Postfix) with ESMTP id 706C844B90;
	Wed, 18 Mar 2026 10:03:46 +0100 (CET)
Received: by suiko.ac2.se (Postfix, from userid 24471)
	id 635ED42B4B; Wed, 18 Mar 2026 10:03:46 +0100 (CET)
From: Anton Lundin <glance@ac2.se>
To: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Anton Lundin <glance@ac2.se>,
	stable@vger.kernel.org
Subject: [PATCHv2] sign-file,extract-cert: use KBUILD_SIGN_PIN in provider mode
Date: Wed, 18 Mar 2026 10:02:09 +0100
Message-ID: <20260318090336.556068-1-glance@ac2.se>
X-Mailer: git-send-email 2.47.3
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
	DMARC_POLICY_ALLOW(-0.50)[ac2.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ac2.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227006-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glance@ac2.se,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ac2.se:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9260E2B8A2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds support for the documented KBUILD_SIGN_PIN functionality to
sign-file and extract-cert when built with USE_PKCS11_PROVIDER.

Signed-off-by: Anton Lundin <glance@ac2.se>
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Cc: stable@vger.kernel.org
---
 certs/extract-cert.c | 27 ++++++++++++++++++++++++++-
 scripts/sign-file.c  |  6 +++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

v2: Added the corresponding fix to extract-cert to

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 7d6d468ed612..30afdc296fff 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -25,6 +25,7 @@
 # define USE_PKCS11_PROVIDER
 # include <openssl/provider.h>
 # include <openssl/store.h>
+# include <openssl/ui.h>
 #else
 # if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
 #  define USE_PKCS11_ENGINE
@@ -62,18 +63,42 @@ static void write_cert(X509 *x509)
 		fprintf(stderr, "Extracted cert: %s\n", buf);
 }
 
+#ifdef USE_PKCS11_PROVIDER
+static int pem_pw_cb(char *buf, int len, int w, void *v)
+{
+	int pwlen;
+
+	if (!key_pass)
+		return -1;
+
+	pwlen = strlen(key_pass);
+	if (pwlen >= len)
+		return -1;
+
+	strcpy(buf, key_pass);
+
+	/* If it's wrong, don't keep trying it. */
+	key_pass = NULL;
+
+	return pwlen;
+}
+#endif
+
 static X509 *load_cert_pkcs11(const char *cert_src)
 {
 	X509 *cert = NULL;
 #ifdef USE_PKCS11_PROVIDER
 	OSSL_STORE_CTX *store;
+	UI_METHOD *ui_method = NULL;
 
 	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
 		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
 	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
 		ERR(1, "OSSL_PROVIDER_try_load(default)");
 
-	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
+	if (key_pass)
+		ui_method = UI_UTIL_wrap_read_pem_callback(pem_pw_cb, 0);
+	store = OSSL_STORE_open(cert_src, ui_method, NULL, NULL, NULL);
 	ERR(!store, "OSSL_STORE_open");
 
 	while (!OSSL_STORE_eof(store)) {
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 73fbefd2e540..9ac89fea9d73 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -32,6 +32,7 @@
 # define USE_PKCS11_PROVIDER
 # include <openssl/provider.h>
 # include <openssl/store.h>
+# include <openssl/ui.h>
 #else
 # if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
 #  define USE_PKCS11_ENGINE
@@ -90,13 +91,16 @@ static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
 	EVP_PKEY *private_key = NULL;
 #ifdef USE_PKCS11_PROVIDER
 	OSSL_STORE_CTX *store;
+	UI_METHOD *ui_method = NULL;
 
 	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
 		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
 	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
 		ERR(1, "OSSL_PROVIDER_try_load(default)");
 
-	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	if (key_pass)
+		ui_method = UI_UTIL_wrap_read_pem_callback(pem_pw_cb, 0);
+	store = OSSL_STORE_open(private_key_name, ui_method, NULL, NULL, NULL);
 	ERR(!store, "OSSL_STORE_open");
 
 	while (!OSSL_STORE_eof(store)) {
-- 
2.47.3


