Return-Path: <stable+bounces-244898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Fpw3D62q/mkyuwAAu9opvQ
	(envelope-from <stable+bounces-244898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:31:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4424FDE02
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B49C301325E
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EFA212D7C;
	Sat,  9 May 2026 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA66dWvE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8872F8E8D
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297513; cv=none; b=DOFzC7Y0/SZBSNRgZwn91Gs2Tf0oB9hDZJoLQfj5gEtY0y1461MlEn8RybryITkLAMK9Z9Ot4malaXcuDocDW2u6txJNTulZ5HUoQOgFxhWYY1/RHbP/wa9Y2F4PNckXjlEw71f0zSW6cY3icIl0TNZA4yohW38QokKvNRkObSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297513; c=relaxed/simple;
	bh=vkHaQGjsoO3xKSYO2domPHzO88f2gdyczA66GNGQWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjcAp91+iVjkrG1QSXw+KZ6E0XQU0ARNiElNTtnR6z804dUErGo4ZQijoYETuFn65kWldCT3f8t650HOIB8BAT2yh2/bVZwqCPRhMmPvNW3QTupWAR0jqweXZgZtKbZ+zWBb0Pmm5KKZQhNPSqgL2OetlE9mmEZYDboiwbgUnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA66dWvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8A6C2BCB0;
	Sat,  9 May 2026 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778297513;
	bh=vkHaQGjsoO3xKSYO2domPHzO88f2gdyczA66GNGQWIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sA66dWvE1vpGlUCB5xdE1i9nftVO8/3yz0918Moc4aO+Jqsmx+5JZuIzWpIOingft
	 1ruYdYUZd3RXNb9SwSbCVQxKIl04xQM35USWN+0jf+xYrVQkR7Hh1lqtbpelbqIUx2
	 bbhXYvV147TWOjyu6c+nN7SsBSJWYGRNzWkdp8g4aTJoqJycNIE4q+a4AQaCPb2kGC
	 NetyexvSUo+ooaohaVqjE4y8C5ZVn1ZgOOLOp1dTdhr9VqvSRzbY6Ln/nbiy6nVeCp
	 EFsua5vleqf/XQCRy7/XPwkUQrrBmDxbIzkfCqAm+NXaHLJ6aeDM3c2wv0GnN7EfzP
	 dZT3Zx61GClbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] crypto: nx - Avoid -Wflex-array-member-not-at-end warning
Date: Fri,  8 May 2026 23:31:48 -0400
Message-ID: <20260509033150.3082044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050440-dude-evade-6747@gregkh>
References: <2026050440-dude-evade-6747@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E4424FDE02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244898-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 1e6b251ce1759392666856908113dd5d7cea044d ]

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally. So, we are deprecating flexible-array
members in the middle of another structure.

There is currently an object (`header`) in `struct nx842_crypto_ctx`
that contains a flexible structure (`struct nx842_crypto_header`):

struct nx842_crypto_ctx {
	...
        struct nx842_crypto_header header;
        struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
	...
};

So, in order to avoid ending up with a flexible-array member in the
middle of another struct, we use the `struct_group_tagged()` helper to
separate the flexible array from the rest of the members in the flexible
structure:

struct nx842_crypto_header {
	struct_group_tagged(nx842_crypto_header_hdr, hdr,

		... the rest of the members

	);
        struct nx842_crypto_header_group group[];
} __packed;

With the change described above, we can now declare an object of the
type of the tagged struct, without embedding the flexible array in the
middle of another struct:

struct nx842_crypto_ctx {
	...
        struct nx842_crypto_header_hdr header;
        struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
	...
 } __packed;

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible
array if needed.

So, with these changes, fix the following warning:

In file included from drivers/crypto/nx/nx-842.c:55:
drivers/crypto/nx/nx-842.h:174:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  174 |         struct nx842_crypto_header header;
      |                                    ^~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: adb3faf2db1a ("crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/nx/nx-842.c |  6 ++++--
 drivers/crypto/nx/nx-842.h | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 2ab90ec10e61e..82214cde2bcd9 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -251,7 +251,9 @@ int nx842_crypto_compress(struct crypto_tfm *tfm,
 			  u8 *dst, unsigned int *dlen)
 {
 	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct nx842_crypto_header *hdr = &ctx->header;
+	struct nx842_crypto_header *hdr =
+				container_of(&ctx->header,
+					     struct nx842_crypto_header, hdr);
 	struct nx842_crypto_param p;
 	struct nx842_constraints c = *ctx->driver->constraints;
 	unsigned int groups, hdrsize, h;
@@ -490,7 +492,7 @@ int nx842_crypto_decompress(struct crypto_tfm *tfm,
 	}
 
 	memcpy(&ctx->header, src, hdr_len);
-	hdr = &ctx->header;
+	hdr = container_of(&ctx->header, struct nx842_crypto_header, hdr);
 
 	for (n = 0; n < hdr->groups; n++) {
 		/* ignore applies to last group */
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index 7590bfb24d79b..25fa70b2112cf 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -157,9 +157,11 @@ struct nx842_crypto_header_group {
 } __packed;
 
 struct nx842_crypto_header {
-	__be16 magic;		/* NX842_CRYPTO_MAGIC */
-	__be16 ignore;		/* decompressed end bytes to ignore */
-	u8 groups;		/* total groups in this header */
+	struct_group_tagged(nx842_crypto_header_hdr, hdr,
+		__be16 magic;		/* NX842_CRYPTO_MAGIC */
+		__be16 ignore;		/* decompressed end bytes to ignore */
+		u8 groups;		/* total groups in this header */
+	);
 	struct nx842_crypto_header_group group[];
 } __packed;
 
@@ -171,7 +173,7 @@ struct nx842_crypto_ctx {
 	u8 *wmem;
 	u8 *sbounce, *dbounce;
 
-	struct nx842_crypto_header header;
+	struct nx842_crypto_header_hdr header;
 	struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
 
 	struct nx842_driver *driver;
-- 
2.53.0


