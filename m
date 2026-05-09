Return-Path: <stable+bounces-244984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBy5KB2E/2lz7QAAu9opvQ
	(envelope-from <stable+bounces-244984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 20:59:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1714501125
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5983E300C5B4
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68C3C65FF;
	Sat,  9 May 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV0/eGtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BB383C77
	for <stable@vger.kernel.org>; Sat,  9 May 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353173; cv=none; b=Brw00r/ejA/PVyLE8v09EEuPjewKieuSAKBETrG0kdj4Jv+OrpzKBWhneSNYMujyeYzYnx5dBtJManW+hgSmkDGQ47s0kPnZie5k7IMPNdsrHDIaytZANVDJa1wMBWGeZXqY+kjt+NIt4jwogXzSzckKn8nVYtouLBP+M00R4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353173; c=relaxed/simple;
	bh=QGV9Qv8PpcgMN3+7rIKyyIEAnJz7m+uRhRWGgklgJM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV4TQqXuXmUNNwX6d1DP7L9ae68KhJO3+3VL5UTQ76ealwfS0WvKOQaYkhrtuLZb6fxZDd0hhRkxhtKymR9YGpt67Hp/TQHOPy9dGb5mQXUjjLBTCOzqLKDJmpfcfQpY1RYtTZukrB3ywmSsjyfQNNAf10k8Mldb+Kf28Yh87as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV0/eGtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABC2C2BCC4;
	Sat,  9 May 2026 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778353173;
	bh=QGV9Qv8PpcgMN3+7rIKyyIEAnJz7m+uRhRWGgklgJM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PV0/eGtzEP/t8IdgzXfnWqPTTNf+LTFTEsKW3einBFoqn3U3Bk1czmDJWIN3HupnT
	 dygPZ6MwIJ8AguWCuwwiGHJigUWEvREv+bA7+xMg+lMxP5YqfOqvchxlYj13HGjPIS
	 5anP6CXh2xR0OZaPJfKsIndnvdqK1Is0y/+WBNjoMltQLOeJ0Ag+0eIDLkTemG/tAo
	 ysB/f0CqHNS2eykMe71Qz5nT4EdIeXkdgZWUV6XOaSTmO0dPqfSoFXO0uLB1SF4CTa
	 /f3RcqDI+6GJiBntZZSXrxLK4ZhW06z/q6JURWIB/roaX37FaN2+8DExCJcOmCWFG0
	 YqJZ1kludj0yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] crypto: caam - guard HMAC key hex dumps in hash_digest_key
Date: Sat,  9 May 2026 14:59:29 -0400
Message-ID: <20260509185929.3682915-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509185929.3682915-1-sashal@kernel.org>
References: <2026050436-deny-perm-ab84@gregkh>
 <20260509185929.3682915-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1714501125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244984-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,linux.dev:email]
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
index 78964e1712e58..3343ddc30076f 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -3269,7 +3269,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dpaa2_fl_set_addr(out_fle, key_dma);
 	dpaa2_fl_set_len(out_fle, digestsize);
 
-	print_hex_dump_debug("key_in@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -3289,7 +3289,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-		print_hex_dump_debug("digested key@" __stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 44122208f70cb..a0c417b7b8059 100644
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


