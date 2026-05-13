Return-Path: <stable+bounces-246806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOWgEFpZBGozHQIAu9opvQ
	(envelope-from <stable+bounces-246806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D339531C01
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0621305D0D8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C43FCB03;
	Wed, 13 May 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEiNA0Ox"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B453DB964
	for <stable@vger.kernel.org>; Wed, 13 May 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669893; cv=none; b=ZOuq5Y7N/if9Jb9Kk6R44NHbgxfcEcKowSj7mEsg9fZZeB7OudJS3p1rA2QKj8r/b3h9rIvwlZdQ1F0JerPjxG9pB+cqJTBidw6txa2roQa5iBEoDP1Ssny4NdnKK0u7dF3Hq8Y5rjMjcHcWcurPCOVIOLHGEM8dgwuwy+zna9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669893; c=relaxed/simple;
	bh=ZV04lyVPArME+npQY4qcyNI8K6Mzz6Qn49etnV7UOjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIfRpmIyEPmSOKhqsmTqoVmqpJI5pu22jSi45/ZnRT1UA8686ynUnES4akEbjhF8tOvZ6eDyuF2nxSMPbcGTIT4gdnTOxI5lqj8phtuOKjvi9J5RYbTaMRdkbkBmFpaEC7nXLvjY9dATRRz/rzQRWsGzYwL8EA+12RGED7po2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEiNA0Ox; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso12088988a12.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778669889; x=1779274689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sLwoHvJvcfpvNr/4u698QcTPwR9URSepxShcHXDFhY=;
        b=iEiNA0OxKWjF86ugkka/LKfu/cPv7D/1pF7FBWSTF2DAgdavpAb+9ef3JvGDpDJ7ue
         zdIhgCIZ7CTRxOIe35rACkC9X4gtKXtEaK/9jThUNxlH2maL75wC+0mDG0Z5mekeFjSQ
         aWqK0/fCT0RVmHNVzoV6dfGldQkrd5reWR7RtHMj2IpVOvCl2X1NDmfRVQqxct8QleJG
         QcYhMgBxpA/pSGYiYNPR4cYvjs7gL+8Qzb9wZIY9dqYAhFdyqMyhhsXc4lV9g2+StMil
         39Wpf+8PZbhGCMG2PejWYB5Ixi0QRk4kqfIT+rvgxSYcN56JbvhINO4oWUcJgKEtVjPh
         S/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669889; x=1779274689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sLwoHvJvcfpvNr/4u698QcTPwR9URSepxShcHXDFhY=;
        b=GlKDlkD1zQJnUCw4cd4cvpMmGwsh5svzA6UeHtj4t6qFaMsrpCybvPsHnoFgaKtRY2
         IeupKyMlvmf1DYj7pVxF5JiVmiX5dQwtxKk5sVjX1xCPxS07qzFEkM4h9+45kBbOQWnM
         8qku86s62mA89GO3yLjWjwWIven7QcoGwnG5c7jnmV7CIckV95Vc6fSxsXGdGnRqKcbB
         HLNc0rKNp3q2s77zDD1o2XL6/E4blBXoJ7fg5r7gOAotG30s2Na+ngAIoPGbqZwoIUsr
         mySDw3T+YM2Eu1a1+7qXN97l6vgCTkORDwP+2xodo/QKExjVrtemyDzVYsXYb0QBDzBp
         6BOg==
X-Forwarded-Encrypted: i=1; AFNElJ+yFLTUPCDexnD3Se69SY5qDi7z0dnt7uWQ+lvBMWApuHzEVLQl9Oe9GlgRlCgC5G4ZMMPfGNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGY+CTH4Min5ae9ZDxy6FxkL79WlVWq7KWo6dH4N2RPY+m8/r9
	lM3BIblGkkDMHtor/6IdZqexNioNExlGiRsdrfa7jZbBZMlTwjTkDYOP
X-Gm-Gg: Acq92OEuSeah4OzwGRCT5ZR1mk0xUi5Nlm9rP7ZNcoxtEg3TXKpLzzEbPwKgGse4yH3
	uX01JQD10l1/4yrE+uvNrRoLIJJfUnXxz+LexYVy+AYF7ziCa/Ap8zeUU6vyk/N+V6yrzTQ1uv6
	axXSduqgYl8RNEWAzLWFaHKvet8tIB8AZuVJYFVPzgAFhclEV3gfkmqqsn+pbtkgkjpUolfScyX
	71DFt7+dZ8oXk45LvckKPgsFguAUUxw+FF+I84PmnqP2s3pfRdcZ22UtZqq80upq5WkXYtdNmF6
	Us3YjLHGXTXXQ+9ndTLrIdRCWZY/6nGmCFicf4gf1F1m8MduIGvIQwOJjiAlegz6bhrH21amOl6
	3faW3wgV77ApFrF7J9XQxj+dFvDBBldKGiKgDlLXzbNrY6VTOkZnmBAEyA8drTRMXXU2TvhuCmy
	4XtJX1g0qPJ8qRYzHVsks25+Hsf4DMTDNmBOaIaRBiGQ6AAraUbpLoJrKV
X-Received: by 2002:a17:907:3e85:b0:bd4:7b9c:6f1a with SMTP id a640c23a62f3a-bd47b9c7479mr48352066b.22.1778669888523;
        Wed, 13 May 2026 03:58:08 -0700 (PDT)
Received: from svery.. (109-252-11-240.nat.spd-mgts.ru. [109.252.11.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfebf0ab11sm472188166b.62.2026.05.13.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:58:08 -0700 (PDT)
From: Anastasia Tishchenko <sv3iry@gmail.com>
To: Lukas Wunner <lukas@wunner.de>,
	Stefan Berger <stefanb@linux.ibm.com>
Cc: Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anastasia Tishchenko <sv3iry@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: ecc - Fix carry overflow in vli multiplication
Date: Wed, 13 May 2026 13:57:40 +0300
Message-ID: <20260513105741.55534-1-sv3iry@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D339531C01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.win,gondor.apana.org.au,davemloft.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-246806-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sv3iry@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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
* Rename add_128_128() to check_add_128_128_overflow() and let it return a bool
  indicating whether an overflow occurred
* Rewrite an explicit if-else statement using constant-time bitwise arithmetic
  to avoid a timing side-channel

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


