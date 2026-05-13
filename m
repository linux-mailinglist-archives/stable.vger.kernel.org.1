Return-Path: <stable+bounces-246803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LGfNL9WBGqjHAIAu9opvQ
	(envelope-from <stable+bounces-246803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:47:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE40531984
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D986302C0C1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA73EF64E;
	Wed, 13 May 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf40hjKM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B3EFD24
	for <stable@vger.kernel.org>; Wed, 13 May 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669239; cv=none; b=qdFFCQYHf1H0tSXfGr5s5Kcidee00qzP7LtoAX9/jvhz5IctQEpJKX3OKGn5dKrf1ihm3VSXYsJXi8BzIEWOHJ2TKwsNby7PCuDzoUgPVBHp+1GP4Wxc0cuZE2FxSBTudrIYTrvoaWi5LcarNWcsiS3mHkqeQ/EWVEDQZsYlZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669239; c=relaxed/simple;
	bh=OSAPTZ4bB1kxfjIUiuDj++83VkMSwbDE89SR8KPjrNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuPfMemL24WKWPXODXy49QaMzVxGSM1C0vqX1EKK/hBauz6odtVwXiNMvdBNZrI7k9ZhT6ViOu6uR4TH5BFK7kRxsHd9n9jwm3x3Zd3vbwYbfZzn6BGJ0R2wHprtASthaE5mNs+h8FaOm/NLY+vF0vIo4RFsZiaqS/oS3ghniAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf40hjKM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso4972747e87.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778669236; x=1779274036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMjpDUARMtR5AUsyIxsLefMdjzuzzMzYSmslCfW06Fc=;
        b=mf40hjKMsqiYbcm1924oMNUBMHdW28njVebsDzFP8EEb582YzMVE/sfOew+d9AbxTC
         wUtTYAMLeXcBZFeg4PH1LPa9jAEYYjlQP3mq6yu99rbtXv5ytwF13KWoRT9GPdrRXZCC
         aOfl8rNZLehEXgOM0DMM/iP+KQ9lVCGBeT5qsC4dGYjjRWuM0V9rfLWxmf2WaA4+6sFB
         Q7LCEkGftHsDNrVLoG9xyI/CGiG2xtsaOF4sWve0e+XZFeOsYy83yaHbxyIKMhxeeLOO
         0hs4Adq3X+jx7xdn0lz+JEPwmQaf2GeXnsHgU5Ikb3YliwuZtvhcS9nnRwhRO4irgkFp
         TOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669236; x=1779274036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMjpDUARMtR5AUsyIxsLefMdjzuzzMzYSmslCfW06Fc=;
        b=CzaHJhgffuaS+VHjLi4uUtaH/2tT/0Dz9+Dtuig0YrUpaXXzoa6aZ/6NlGX28bSIZu
         XneblRWoHvdIq+A5Ah9+wN0heOx+53q+/+iKVlmOdNzuCaug3pqQZ+qLbkYx57So59UW
         IIq4FPz6ZtTvq5lOO3ht0+DQ3u8ALoKA5pITNBDo7g2sOLZRQ3/01mlJ8+iEB5D5oOhU
         GohcHg+THSC578cBEwSrSW179Ru0IIZC+NQkLcYsjX/UG6ezkf+fGOscB8fl24Qh7sdm
         d0eDlJ43LlV9sc3APt87rLz/1zuXWJLcLn9Q58c5Bf6IUh905AKAroavR2tkWCJzp45T
         FIKA==
X-Forwarded-Encrypted: i=1; AFNElJ8EzsLCqibbky+hjtIbJRS2SoQxXaLTCPeCGnCT/2mNGTEAeEuGDKqevgIvel7bKUEt4eSMA6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvecuY5Lybt2nm+4UWDiWKKy/WSYWf8SJs9DXxkCtApl40XLQK
	ATs9pWWDVada9j/VmjDNfyLYH2rf3a0Ugh6wwBp5sEux9gXL6lCMYlhUV8I8pE94
X-Gm-Gg: Acq92OE67bS/m2Js969UFjzePuIGdKRG16urh0daEDDm8rrrZvhQnzsrQhe60KBANy0
	gdiZXSsYB14T5yOyvWyEfrRG5+CT3YkXmbTdYIC2IoXgEiR1Q7DXCC4R5BLyj7WUTQ9PkH3VYvB
	cL2EoVxiJcK7Z4m2IwUVgQRFOgBRRLeY5r8xlE2shlGR59prsMk+lsni45He5cai/yOCFaOwW7n
	qrL4qA0NHAkUP+Tmv7N/q2wcVTY0LTOUISS1wAOb1HCLAJ8VN4eVsmctqEFQdP7nmao9sa9EJA2
	77sBnfstNx+cpPgSMAuA7DvtSLZ74iqEFs42fl7Lg12+044+53S49pZ4+kFILeaukYzHpIx8lTZ
	4Smug6Za6FkFEReAKoQiVG8wCPXAwjtC3pJBH8bX2oON2nWlUWkaTAkWsinB7Zxdppmrk5PNgYx
	tnqp/M2R7e2Leqwr8QNDFsQJ9ZlK+wG+KSyIrb3AWToXqRug==
X-Received: by 2002:a05:6512:3ba2:b0:5a8:7f58:5fba with SMTP id 2adb3069b0e04-5a8ef93959emr932584e87.9.1778669236039;
        Wed, 13 May 2026 03:47:16 -0700 (PDT)
Received: from svery.. (109-252-11-240.nat.spd-mgts.ru. [109.252.11.240])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951d2cfsm4076485e87.25.2026.05.13.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:47:15 -0700 (PDT)
From: Anastasia Tishchenko <sv3iry@gmail.com>
To: tcherganov@astralinux.ru
Cc: Anastasia Tishchenko <sv3iry@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: ecc - Fix carry overflow in vli multiplication
Date: Wed, 13 May 2026 13:47:10 +0300
Message-ID: <20260513104711.54889-1-sv3iry@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EE40531984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246803-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sv3iry@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The carry flag calculation fails when r01.m_high is saturated
(0xFFFFFFFFFFFFFFFF) and addition of lower bits overflows.

The condition (r01.m_high < product.m_high) doesn't handle the case
where r01.m_high == product.m_high and an additional carry exists
from lower-bit overflow.

When commit 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
introduced crypto/ecc.c, it split the muladd() function in the
micro-ecc library into separate mul_64_64() and add_128_128() helpers.
It seems the check got lost in translation.

Add proper handling for this boundary by accounting for the carry
from the lower addition.

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
Signed-off-by: Anastasia Tishchenko <sv3iry@gmail.com>
Cc: stable@vger.kernel.org # v4.8+
---
Changes v1 -> v2:
* Rename add_128_128() to check_add_128_128_overflow() and let it return a bool indicating whether an overflow occurred
* Rewrite an explicit if-else statement using constant-time bitwise arithmetic to avoid a timing side-channel

Link to v1:
https://lore.kernel.org/r/20260508114844.29694-1-sv3iry@gmail.com/
---
 crypto/ecc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 43b0def3a225..6eb4d97a5f0d 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -393,14 +393,26 @@ static uint128_t mul_64_64(u64 left, u64 right)
 	return result;
 }
 
-static uint128_t add_128_128(uint128_t a, uint128_t b)
+/* Calculate addition with overflow checking. Returns true on wrap-around,
+ * false otherwise.
+ */
+static bool check_add_128_128_overflow(uint128_t *result, uint128_t a,
+				       uint128_t b)
 {
-	uint128_t result;
+	bool carry;
 
-	result.m_low = a.m_low + b.m_low;
-	result.m_high = a.m_high + b.m_high + (result.m_low < a.m_low);
+	result->m_low = a.m_low + b.m_low;
+	carry = (result->m_low < a.m_low);
 
-	return result;
+	result->m_high = a.m_high + b.m_high + carry;
+
+	/* Using constant-time bitwise arithmetic to prevent timing
+	 * side-channels.
+	 */
+	carry = (result->m_high < a.m_high) |
+		((result->m_high == a.m_high) & carry);
+
+	return carry;
 }
 
 static void vli_mult(u64 *result, const u64 *left, const u64 *right,
@@ -425,9 +437,7 @@ static void vli_mult(u64 *result, const u64 *left, const u64 *right,
 			uint128_t product;
 
 			product = mul_64_64(left[i], right[k - i]);
-
-			r01 = add_128_128(r01, product);
-			r2 += (r01.m_high < product.m_high);
+			r2 += check_add_128_128_overflow(&r01, r01, product);
 		}
 
 		result[k] = r01.m_low;
@@ -450,7 +460,7 @@ static void vli_umult(u64 *result, const u64 *left, u32 right,
 		uint128_t product;
 
 		product = mul_64_64(left[k], right);
-		r01 = add_128_128(r01, product);
+		check_add_128_128_overflow(&r01, r01, product);
 		/* no carry */
 		result[k] = r01.m_low;
 		r01.m_low = r01.m_high;
@@ -487,8 +497,7 @@ static void vli_square(u64 *result, const u64 *left, unsigned int ndigits)
 				product.m_low <<= 1;
 			}
 
-			r01 = add_128_128(r01, product);
-			r2 += (r01.m_high < product.m_high);
+			r2 += check_add_128_128_overflow(&r01, r01, product);
 		}
 
 		result[k] = r01.m_low;
-- 
2.43.0


