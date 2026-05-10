Return-Path: <stable+bounces-245016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP2aKOiEAGo5JwEAu9opvQ
	(envelope-from <stable+bounces-245016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:15:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133B504472
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0233008234
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F067389454;
	Sun, 10 May 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owF+VjTO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D693890E5
	for <stable@vger.kernel.org>; Sun, 10 May 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418912; cv=none; b=CUExvQ7bhtfzys+WXg/aCjOygVrtYzYB7RIy9aZ5PjeLLxnSXTuZznXHIoHAZ9fkS8I6v4uTahPE7szuM8I936m6T3TnKP9ZPPX/hI5P0gBeqAtG58/cAd4aesad4VpuVCrDCfTGq942/k9FFH2hQklTo/O92fSy4f2bNjaTXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418912; c=relaxed/simple;
	bh=LduMNgJIPDhfv/nuxY/rpgUaUlE+mzZZ8n1sIgEhT+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ4PPg+THLZkNpyYm9pM7HDnyTrQpGtxl21STtYhjlsfGYw6By6IuTNUdzPG3iHmAKp2cFu0OeEJAKPu2FehrL/ChOfTMZ5hukxjj9Nyx88MhQQDvhQVi9Lc7fyboCQFsJNDmKHeOqheC4xLGkd+Bj+VWnfdCc5O2XcNKB9sEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owF+VjTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6C7C2BCF6;
	Sun, 10 May 2026 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778418912;
	bh=LduMNgJIPDhfv/nuxY/rpgUaUlE+mzZZ8n1sIgEhT+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owF+VjTO0aX0IyfhpL/VHO6FBYqOHEGZwMB6YMWhSr3JpuGT7M/UvxArUi3QNP1bR
	 YTOnejwhWKsvrLUOkV2+6NQSPMv2fNq/0EgpbIRJIf56XrWFipJ6xsJzIpvyKaFQYn
	 vNnnHwWXorr2L420TxtVXPXDGUwP8KKMzh18sjRGSGSOINeQi9V7MYig70VZYeExRw
	 s4onYYOosKqvru4xhU6piH/Xo+D0QQOrxWaOJT/sDV52fBWKJ4vVI0X4QfsOFK7EVN
	 euplcnWIxRFCxFHTKYtEIYtRnC3oL9YuSU6huQbaUh4kdnPGNmN/9yRTQ4n88/4joa
	 Mb1Rr7bf90wqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] crypto: caam - guard HMAC key hex dumps in hash_digest_key
Date: Sun, 10 May 2026 09:15:08 -0400
Message-ID: <20260510131508.4113857-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510131508.4113857-1-sashal@kernel.org>
References: <2026050437-viability-scholar-82fb@gregkh>
 <20260510131508.4113857-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3133B504472
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
	TAGGED_FROM(0.00)[bounces-245016-lists,stable=lfdr.de];
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

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 177730a273b18e195263ed953853273e901b5064 ]

Use print_hex_dump_devel() for dumping sensitive HMAC key bytes in
hash_digest_key() to avoid leaking secrets at runtime when
CONFIG_DYNAMIC_DEBUG is enabled.

Fixes: 045e36780f11 ("crypto: caam - ahash hmac support")
Fixes: 3f16f6c9d632 ("crypto: caam/qi2 - add support for ahash algorithms")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 4 ++--
 drivers/crypto/caam/caamhash.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 06e0681fdbe15..ac97a15ac78b6 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -3268,7 +3268,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dpaa2_fl_set_addr(out_fle, key_dma);
 	dpaa2_fl_set_len(out_fle, digestsize);
 
-	print_hex_dump_debug("key_in@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -3288,7 +3288,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-		print_hex_dump_debug("digested key@" __stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 30cc46c4c33af..c1a06f033b118 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -393,7 +393,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	append_seq_store(desc, digestsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-	print_hex_dump_debug("key_in@"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -408,7 +408,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		wait_for_completion(&result.completion);
 		ret = result.err;
 
-		print_hex_dump_debug("digested key@"__stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
-- 
2.53.0


