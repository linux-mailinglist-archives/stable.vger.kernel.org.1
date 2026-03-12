Return-Path: <stable+bounces-224863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G1wG1HDsmmvPAAAu9opvQ
	(envelope-from <stable+bounces-224863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:44:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4289272D31
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7133150582
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E03C13F9;
	Thu, 12 Mar 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b="Pju2dU3R"
X-Original-To: stable@vger.kernel.org
Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4623B776A
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322874; cv=none; b=Y8CBajK7bGcE6EsYHKERFf0xGClY2wDM9RvHKvU5tjRqRMYRSX0ONjmK5QQJqIGzQaLTjb6MSV0X2vNJ+/ccB0IhnICY7pLYTi/xte2HCKAT1A8vMxIaVHodbxR+dEWi/AQbKsFaFeEXyLysN1NmE1Ibuzo4vyPJlaU3l7Wtnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322874; c=relaxed/simple;
	bh=Ndn3/sS9hKibGeS+MjXJBSXMdLr3jWey2xTeGHrf3r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m959hlYa/QkKLWs/EiNA0wmjQ5tHDHS6tSvdFNorZp8vTriRRUzsbHuSejd83FM5bse7VXeGkczz/zJogAIZaNhPFKth6EXUN+7QGRCUs2mpjHzVeo+y31asGceocwHu+1LCFg92F5/yVrupKQmFo2qv8lUFwzDlMQB+lyFEtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b=Pju2dU3R; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 38A2A44B91;
	Thu, 12 Mar 2026 14:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ac2.se; s=default;
	t=1773322331; bh=Ndn3/sS9hKibGeS+MjXJBSXMdLr3jWey2xTeGHrf3r8=;
	h=From:To:Cc:Subject:Date:From;
	b=Pju2dU3R0maVncdhRePZk0YFYYLTsykBczZb/vOfVPHxs94AbqTT0I21x2ZtCqY2h
	 ffopMO5bSQi/UPxit3oxN9fX1TLcWrURAFKVjNBa9yNNQI3U99+4oqeeiumR44hkuX
	 zqTikLrPe6lEUj/b0szHPfhLStwpn5JzjsIGsBkQ=
Received: from suiko.ac2.se (suiko.ac2.se [130.239.18.162])
	by mail.acc.umu.se (Postfix) with ESMTP id 99D0B44B90;
	Thu, 12 Mar 2026 14:32:10 +0100 (CET)
Received: by suiko.ac2.se (Postfix, from userid 24471)
	id 8E69442B4B; Thu, 12 Mar 2026 14:32:10 +0100 (CET)
From: Anton Lundin <glance@ac2.se>
To: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Anton Lundin <glance@ac2.se>,
	stable@vger.kernel.org
Subject: [PATCH] sign-file: use KBUILD_SIGN_PIN in provider mode
Date: Thu, 12 Mar 2026 14:31:39 +0100
Message-ID: <20260312133139.3168334-1-glance@ac2.se>
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
	R_DKIM_ALLOW(-0.20)[ac2.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224863-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glance@ac2.se,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ac2.se:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ac2.se:dkim,ac2.se:email,ac2.se:mid]
X-Rspamd-Queue-Id: E4289272D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds support for the documented KBUILD_SIGN_PIN functionality to
sign-file when built with USE_PKCS11_PROVIDER.

Signed-off-by: Anton Lundin <glance@ac2.se>
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Cc: stable@vger.kernel.org
---
 scripts/sign-file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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


