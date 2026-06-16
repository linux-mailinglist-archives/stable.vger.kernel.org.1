Return-Path: <stable+bounces-265631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PQ28DraMMWp9mQUAu9opvQ
	(envelope-from <stable+bounces-265631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:49:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD169384A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:49:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TppApd9U;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265631-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265631-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA536306EF03
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5144418E3;
	Tue, 16 Jun 2026 17:49:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D3169AD2;
	Tue, 16 Jun 2026 17:49:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632178; cv=none; b=gcIsZUw7nwV5YdjiswUNcpyz1eOimu0ppe54UMKE9/7fPr80Y8lvZLIz4yH3RhfPRkd64j3hH6fSqqXZONJOAktMCBdP97T2G6HmL1hgtXcn7/9JbgPIw8A/Xywo/k6XZsGruQE21RvXTOt+KGZ7yscpgya/PyEbinPg0CAx9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632178; c=relaxed/simple;
	bh=1HPGN62W/EalgbV6ETMnZ4ZbnQVG8k06oFt2Uamk9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHEr0s6APlpcFCEpU/kvUNVWDdT+dT6yBzuYyXVZXOy19nv8eDIFO4R/nobej37+Sky6N7VuwsSpC36ljtO5fFd4EofKaIAsLdRzOd87IWe+zAfEUqxd+j0WsnVLDbacUf6cBL7DxInjD1ZHah8Ni0D7SQ452WLCAIuadK/gI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TppApd9U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8E41F000E9;
	Tue, 16 Jun 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632176;
	bh=AA9sM/lhyxA5xId0fr4XIkYBHYLQZTwhOvjRr3jkGjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TppApd9U0vctKeC9XZPp7LY33Hnk6OGbynQB48yToddRV1qxdO8vSBBA/2Uwe3lUm
	 y6XPb69l8eYxqWYBw/6PuQ7s3SiihNadcm7I+Tp4i0jrL7coSyLj887d+bEExJG4Q1
	 1lEIzdIzzhUSiWAcLnkIERveKh0YPfMWu925iVw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 361/522] crypto: nx - Avoid -Wflex-array-member-not-at-end warning
Date: Tue, 16 Jun 2026 20:28:28 +0530
Message-ID: <20260616145142.680998475@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265631-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:gustavoars@kernel.org,m:herbert@gondor.apana.org.au,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9FD169384A

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/nx/nx-842.c |    6 ++++--
 drivers/crypto/nx/nx-842.h |   10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -251,7 +251,9 @@ int nx842_crypto_compress(struct crypto_
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
@@ -490,7 +492,7 @@ int nx842_crypto_decompress(struct crypt
 	}
 
 	memcpy(&ctx->header, src, hdr_len);
-	hdr = &ctx->header;
+	hdr = container_of(&ctx->header, struct nx842_crypto_header, hdr);
 
 	for (n = 0; n < hdr->groups; n++) {
 		/* ignore applies to last group */
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



