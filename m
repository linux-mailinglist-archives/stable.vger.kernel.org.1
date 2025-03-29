Return-Path: <stable+bounces-127010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671FA757CF
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C84188E856
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBE1DE891;
	Sat, 29 Mar 2025 20:07:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E671DED47;
	Sat, 29 Mar 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278846; cv=none; b=GPOK8b011qTlEGkGat4JQIeGM+iXjuWBe66vng3RIISXeuZqmCJ/DeOFr2fvEEdOfCHWgrIKcNUM3XeiukL8xFNA4/EHwCDuo5h67dfPTGc7ZcCZOp9sXBGY81P877qGS9AwCNxsg73LMXNHz9Fgk63Obz+VMi077q36cZWSu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278846; c=relaxed/simple;
	bh=JFrqu1Yd0mWyoCeub8YGs8zqUy2Uhdwz48LorZUX3Vw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=f71XmhGdS3cY3cEGLzUiCnDM9Z6DsAj7QQxA0pRNrfp32ToaBDjzhFdmR/I71WrVxTZSBd9rmq//NRTFP/p5aFbRIisCxxV5Cx9TzrmvBFGjmAXeMXDUTdzsRAq4jTx67Ye61VGp00Xe/x7rk943R2VR65QhPUKUqNo1KGwKzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.153.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 29 Mar
 2025 23:07:10 +0300
Message-ID: <db05804f-9094-4ed9-b32e-06d72e612647@omp.ru>
Date: Sat, 29 Mar 2025 23:07:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH RESEND#2 5.10.y] KEYS: asymmetric: properly validate hash_algo
 and encoding
To: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Stefan Berger <stefanb@linux.ibm.com>, Tianjia Zhang
	<tianjia.zhang@linux.alibaba.com>, Eric Biggers <ebiggers@google.com>, Vitaly
 Chikunov <vt@altlinux.org>, Jarkko Sakkinen <jarkko@kernel.org>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/29/2025 19:54:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 192222 [Mar 29 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.136 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	213.87.153.136:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.136
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/29/2025 19:55:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/29/2025 7:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 590bfb57b2328951d5833979e7ca1d5fde2e609a ]

It is insecure to allow arbitrary hash algorithms and signature
encodings to be used with arbitrary signature algorithms.  Notably,
ECDSA, ECRDSA, and SM2 all sign/verify raw hash values and don't
disambiguate between different hash algorithms like RSA PKCS#1 v1.5
padding does.  Therefore, they need to be restricted to certain sets of
hash algorithms (ideally just one, but in practice small sets are used).
Additionally, the encoding is an integral part of modern signature
algorithms, and is not supposed to vary.

Therefore, tighten the checks of hash_algo and encoding done by
software_key_determine_akcipher().

Also rearrange the parameters to software_key_determine_akcipher() to
put the public_key first, as this is the most important parameter and it
often determines everything else.

[s.shtylyov@omp.ru: removed the ECDSA related code.]

Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
Cc: stable@vger.kernel.org
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
Re-sending with LKML added and testers moved from the To: to Cc:...
Re-sending again with the correct stable ML address...

 crypto/asymmetric_keys/public_key.c |   92 ++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 34 deletions(-)

Index: linux-stable/crypto/asymmetric_keys/public_key.c
===================================================================
--- linux-stable.orig/crypto/asymmetric_keys/public_key.c
+++ linux-stable/crypto/asymmetric_keys/public_key.c
@@ -59,38 +59,65 @@ static void public_key_destroy(void *pay
 }
 
 /*
- * Determine the crypto algorithm name.
+ * Given a public_key, and an encoding and hash_algo to be used for signing
+ * and/or verification with that key, determine the name of the corresponding
+ * akcipher algorithm.  Also check that encoding and hash_algo are allowed.
  */
-static
-int software_key_determine_akcipher(const char *encoding,
-				    const char *hash_algo,
-				    const struct public_key *pkey,
-				    char alg_name[CRYPTO_MAX_ALG_NAME])
+static int
+software_key_determine_akcipher(const struct public_key *pkey,
+				const char *encoding, const char *hash_algo,
+				char alg_name[CRYPTO_MAX_ALG_NAME])
 {
 	int n;
 
-	if (strcmp(encoding, "pkcs1") == 0) {
-		/* The data wangled by the RSA algorithm is typically padded
-		 * and encoded in some manner, such as EMSA-PKCS1-1_5 [RFC3447
-		 * sec 8.2].
+	if (!encoding)
+		return -EINVAL;
+
+	if (strcmp(pkey->pkey_algo, "rsa") == 0) {
+		/*
+		 * RSA signatures usually use EMSA-PKCS1-1_5 [RFC3447 sec 8.2].
 		 */
+		if (strcmp(encoding, "pkcs1") == 0) {
+			if (!hash_algo)
+				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+					     "pkcs1pad(%s)",
+					     pkey->pkey_algo);
+			else
+				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+					     "pkcs1pad(%s,%s)",
+					     pkey->pkey_algo, hash_algo);
+			return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
+		}
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
+		/*
+		 * Raw RSA cannot differentiate between different hash
+		 * algorithms.
+		 */
+		if (hash_algo)
+			return -EINVAL;
+	} else if (strcmp(pkey->pkey_algo, "sm2") == 0) {
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
 		if (!hash_algo)
-			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
-				     "pkcs1pad(%s)",
-				     pkey->pkey_algo);
-		else
-			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
-				     "pkcs1pad(%s,%s)",
-				     pkey->pkey_algo, hash_algo);
-		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
-	}
-
-	if (strcmp(encoding, "raw") == 0) {
-		strcpy(alg_name, pkey->pkey_algo);
-		return 0;
+			return -EINVAL;
+		if (strcmp(hash_algo, "sm3") != 0)
+			return -EINVAL;
+	} else if (strcmp(pkey->pkey_algo, "ecrdsa") == 0) {
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
+		if (!hash_algo)
+			return -EINVAL;
+		if (strcmp(hash_algo, "streebog256") != 0 &&
+		    strcmp(hash_algo, "streebog512") != 0)
+			return -EINVAL;
+	} else {
+		/* Unknown public key algorithm */
+		return -ENOPKG;
 	}
-
-	return -ENOPKG;
+	if (strscpy(alg_name, pkey->pkey_algo, CRYPTO_MAX_ALG_NAME) < 0)
+		return -EINVAL;
+	return 0;
 }
 
 static u8 *pkey_pack_u32(u8 *dst, u32 val)
@@ -111,9 +138,8 @@ static int software_key_query(const stru
 	u8 *key, *ptr;
 	int ret, len;
 
-	ret = software_key_determine_akcipher(params->encoding,
-					      params->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, params->encoding,
+					      params->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 
@@ -177,9 +203,8 @@ static int software_key_eds_op(struct ke
 
 	pr_devel("==>%s()\n", __func__);
 
-	ret = software_key_determine_akcipher(params->encoding,
-					      params->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, params->encoding,
+					      params->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 
@@ -328,9 +353,8 @@ int public_key_verify_signature(const st
 	BUG_ON(!sig);
 	BUG_ON(!sig->s);
 
-	ret = software_key_determine_akcipher(sig->encoding,
-					      sig->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, sig->encoding,
+					      sig->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 

