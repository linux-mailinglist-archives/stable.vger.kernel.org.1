Return-Path: <stable+bounces-7637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981D817561
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD221C227D1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5C3D54B;
	Mon, 18 Dec 2023 15:35:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891F42387
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b48f70766so725083a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913743; x=1703518543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54Cppsoa4UfkK6E0bEr7G5uU1aHVFg9YvJ5fEdP/6xQ=;
        b=mfw1Ankbh998QTGzuqYOGRBM9CpLxMHopF6YDEo48nAxBaMTQVvv3FoZHyq12o6TUP
         GQ2F4Ls7i8H/I8JRJ03EQ2aryEyel9Ygq0Lh5YF25Sg357m1PwivXIzTQeoWWMct2Jzd
         7A/A/k07GX6fTQeIJFmG84KJAk9MAHhFrGR0Qr5ejCMu9TIbJDobBhKA1LMD2D2owf4b
         kGfO14BHKeUlH91NyZi26e1lM/27rqQKABK/mqS76mLViy5EfbHxRu6T16t0f6QapZ3+
         qTsiZcCHVggJ7x0mtXdiwX939guqx6hsNfTlyoM4mmTCnfEgysXeOX5OnyvOcmJuFyWL
         30eg==
X-Gm-Message-State: AOJu0Yx5uk58VcokmZfCg9SRPIXYhbuSe3rrQiFxbC8qSHwUIkY3cXkS
	ff2OwJjYajXC/Qmy/ZHj1BVRj5jU8jM=
X-Google-Smtp-Source: AGHT+IHY9m1cYKc2a/1G37ULsTCcfaEndSpr+Y1MteLSps65+u6DtmSM+2xEBwOzWQrOy9J5Wf1elQ==
X-Received: by 2002:a17:90a:1c90:b0:28b:1848:aab1 with SMTP id t16-20020a17090a1c9000b0028b1848aab1mr2386468pjt.10.1702913742703;
        Mon, 18 Dec 2023 07:35:42 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:42 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 008/154] ksmbd: use oid registry functions to decode OIDs
Date: Tue, 19 Dec 2023 00:32:28 +0900
Message-Id: <20231218153454.8090-9-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 294277410cf3b46bee2b8282ab754e52975c0a70 ]

Use look_up_OID to decode OIDs rather than
implementing functions.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/asn1.c | 142 +++++++-----------------------------------------
 1 file changed, 19 insertions(+), 123 deletions(-)

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index b014f4638610..c03eba090368 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -21,101 +21,11 @@
 #include "ksmbd_spnego_negtokeninit.asn1.h"
 #include "ksmbd_spnego_negtokentarg.asn1.h"
 
-#define SPNEGO_OID_LEN 7
 #define NTLMSSP_OID_LEN  10
-#define KRB5_OID_LEN  7
-#define KRB5U2U_OID_LEN  8
-#define MSKRB5_OID_LEN  7
-static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
-static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10 };
-static unsigned long KRB5_OID[7] = { 1, 2, 840, 113554, 1, 2, 2 };
-static unsigned long KRB5U2U_OID[8] = { 1, 2, 840, 113554, 1, 2, 2, 3 };
-static unsigned long MSKRB5_OID[7] = { 1, 2, 840, 48018, 1, 2, 2 };
 
 static char NTLMSSP_OID_STR[NTLMSSP_OID_LEN] = { 0x2b, 0x06, 0x01, 0x04, 0x01,
 	0x82, 0x37, 0x02, 0x02, 0x0a };
 
-static bool
-asn1_subid_decode(const unsigned char **begin, const unsigned char *end,
-		  unsigned long *subid)
-{
-	const unsigned char *ptr = *begin;
-	unsigned char ch;
-
-	*subid = 0;
-
-	do {
-		if (ptr >= end)
-			return false;
-
-		ch = *ptr++;
-		*subid <<= 7;
-		*subid |= ch & 0x7F;
-	} while ((ch & 0x80) == 0x80);
-
-	*begin = ptr;
-	return true;
-}
-
-static bool asn1_oid_decode(const unsigned char *value, size_t vlen,
-			    unsigned long **oid, size_t *oidlen)
-{
-	const unsigned char *iptr = value, *end = value + vlen;
-	unsigned long *optr;
-	unsigned long subid;
-
-	vlen += 1;
-	if (vlen < 2 || vlen > UINT_MAX / sizeof(unsigned long))
-		goto fail_nullify;
-
-	*oid = kmalloc(vlen * sizeof(unsigned long), GFP_KERNEL);
-	if (!*oid)
-		return false;
-
-	optr = *oid;
-
-	if (!asn1_subid_decode(&iptr, end, &subid))
-		goto fail;
-
-	if (subid < 40) {
-		optr[0] = 0;
-		optr[1] = subid;
-	} else if (subid < 80) {
-		optr[0] = 1;
-		optr[1] = subid - 40;
-	} else {
-		optr[0] = 2;
-		optr[1] = subid - 80;
-	}
-
-	*oidlen = 2;
-	optr += 2;
-
-	while (iptr < end) {
-		if (++(*oidlen) > vlen)
-			goto fail;
-
-		if (!asn1_subid_decode(&iptr, end, optr++))
-			goto fail;
-	}
-	return true;
-
-fail:
-	kfree(*oid);
-fail_nullify:
-	*oid = NULL;
-	return false;
-}
-
-static bool oid_eq(unsigned long *oid1, unsigned int oid1len,
-		   unsigned long *oid2, unsigned int oid2len)
-{
-	if (oid1len != oid2len)
-		return false;
-
-	return memcmp(oid1, oid2, oid1len) == 0;
-}
-
 int
 ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
 			  struct ksmbd_conn *conn)
@@ -252,26 +162,18 @@ int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
 int ksmbd_gssapi_this_mech(void *context, size_t hdrlen, unsigned char tag,
 			   const void *value, size_t vlen)
 {
-	unsigned long *oid;
-	size_t oidlen;
-	int err = 0;
-
-	if (!asn1_oid_decode(value, vlen, &oid, &oidlen)) {
-		err = -EBADMSG;
-		goto out;
-	}
+	enum OID oid;
 
-	if (!oid_eq(oid, oidlen, SPNEGO_OID, SPNEGO_OID_LEN))
-		err = -EBADMSG;
-	kfree(oid);
-out:
-	if (err) {
+	oid = look_up_OID(value, vlen);
+	if (oid != OID_spnego) {
 		char buf[50];
 
 		sprint_oid(value, vlen, buf, sizeof(buf));
 		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+		return -EBADMSG;
 	}
-	return err;
+
+	return 0;
 }
 
 int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
@@ -279,37 +181,31 @@ int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
 				   size_t vlen)
 {
 	struct ksmbd_conn *conn = context;
-	unsigned long *oid;
-	size_t oidlen;
+	enum OID oid;
 	int mech_type;
-	char buf[50];
 
-	if (!asn1_oid_decode(value, vlen, &oid, &oidlen))
-		goto fail;
-
-	if (oid_eq(oid, oidlen, NTLMSSP_OID, NTLMSSP_OID_LEN))
+	oid = look_up_OID(value, vlen);
+	if (oid == OID_ntlmssp) {
 		mech_type = KSMBD_AUTH_NTLMSSP;
-	else if (oid_eq(oid, oidlen, MSKRB5_OID, MSKRB5_OID_LEN))
+	} else if (oid == OID_mskrb5) {
 		mech_type = KSMBD_AUTH_MSKRB5;
-	else if (oid_eq(oid, oidlen, KRB5_OID, KRB5_OID_LEN))
+	} else if (oid == OID_krb5) {
 		mech_type = KSMBD_AUTH_KRB5;
-	else if (oid_eq(oid, oidlen, KRB5U2U_OID, KRB5U2U_OID_LEN))
+	} else if (oid == OID_krb5u2u) {
 		mech_type = KSMBD_AUTH_KRB5U2U;
-	else
-		goto fail;
+	} else {
+		char buf[50];
+
+		sprint_oid(value, vlen, buf, sizeof(buf));
+		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+		return -EBADMSG;
+	}
 
 	conn->auth_mechs |= mech_type;
 	if (conn->preferred_auth_mech == 0)
 		conn->preferred_auth_mech = mech_type;
 
-	kfree(oid);
 	return 0;
-
-fail:
-	kfree(oid);
-	sprint_oid(value, vlen, buf, sizeof(buf));
-	ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
-	return -EBADMSG;
 }
 
 int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
-- 
2.25.1


