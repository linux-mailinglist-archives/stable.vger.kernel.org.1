Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCF7A37A5
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbjIQTXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbjIQTW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75652118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:22:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C49C433C7;
        Sun, 17 Sep 2023 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978570;
        bh=OmYeRM+Hg7u+9D93VxTplgE8FqPwiDuc+rK3ST9kfJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxX4OlEl8HQSQolbvwgXRFjrtLeYAVQVjOIj/5YY6o9reoHIgddkn9Gbx9uKCe5XT
         ryCs5CSCWa8YVrvx0xzgfVROgu+M/xyt41yL3erTW/Hk1pHSBSsG3RHdVJU5SfbV2M
         h3XTezRulh8/UKdruPLrmA/ux9K13SD4dkjYowx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/406] crypto: blake2b - sync with blake2s implementation
Date:   Sun, 17 Sep 2023 21:09:10 +0200
Message-ID: <20230917191103.663752909@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 28dcca4cc0c01e2467549a36b1b0eacfdb01236c ]

Sync the BLAKE2b code with the BLAKE2s code as much as possible:

- Move a lot of code into new headers <crypto/blake2b.h> and
  <crypto/internal/blake2b.h>, and adjust it to be like the
  corresponding BLAKE2s code, i.e. like <crypto/blake2s.h> and
  <crypto/internal/blake2s.h>.

- Rename constants, e.g. BLAKE2B_*_DIGEST_SIZE => BLAKE2B_*_HASH_SIZE.

- Use a macro BLAKE2B_ALG() to define the shash_alg structs.

- Export blake2b_compress_generic() for use as a fallback.

This makes it much easier to add optimized implementations of BLAKE2b,
as optimized implementations can use the helper functions
crypto_blake2b_{setkey,init,update,final}() and
blake2b_compress_generic().  The ARM implementation will use these.

But this change is also helpful because it eliminates unnecessary
differences between the BLAKE2b and BLAKE2s code, so that the same
improvements can easily be made to both.  (The two algorithms are
basically identical, except for the word size and constants.)  It also
makes it straightforward to add a library API for BLAKE2b in the future
if/when it's needed.

This change does make the BLAKE2b code slightly more complicated than it
needs to be, as it doesn't actually provide a library API yet.  For
example, __blake2b_update() doesn't really need to exist yet; it could
just be inlined into crypto_blake2b_update().  But I believe this is
outweighed by the benefits of keeping the code in sync.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 9ae4577bc077 ("crypto: api - Use work queue in crypto_destroy_instance")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/blake2b_generic.c          | 226 +++++++-----------------------
 include/crypto/blake2b.h          |  67 +++++++++
 include/crypto/internal/blake2b.h | 115 +++++++++++++++
 3 files changed, 230 insertions(+), 178 deletions(-)
 create mode 100644 include/crypto/blake2b.h
 create mode 100644 include/crypto/internal/blake2b.h

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index a2ffe60e06d34..963f7fe0e4ea8 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -20,36 +20,11 @@
 
 #include <asm/unaligned.h>
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <crypto/internal/blake2b.h>
 #include <crypto/internal/hash.h>
 
-#define BLAKE2B_160_DIGEST_SIZE		(160 / 8)
-#define BLAKE2B_256_DIGEST_SIZE		(256 / 8)
-#define BLAKE2B_384_DIGEST_SIZE		(384 / 8)
-#define BLAKE2B_512_DIGEST_SIZE		(512 / 8)
-
-enum blake2b_constant {
-	BLAKE2B_BLOCKBYTES    = 128,
-	BLAKE2B_KEYBYTES      = 64,
-};
-
-struct blake2b_state {
-	u64      h[8];
-	u64      t[2];
-	u64      f[2];
-	u8       buf[BLAKE2B_BLOCKBYTES];
-	size_t   buflen;
-};
-
-static const u64 blake2b_IV[8] = {
-	0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL,
-	0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
-	0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
-	0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL
-};
-
 static const u8 blake2b_sigma[12][16] = {
 	{  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
 	{ 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 },
@@ -95,8 +70,8 @@ static void blake2b_increment_counter(struct blake2b_state *S, const u64 inc)
 		G(r,7,v[ 3],v[ 4],v[ 9],v[14]); \
 	} while (0)
 
-static void blake2b_compress(struct blake2b_state *S,
-			     const u8 block[BLAKE2B_BLOCKBYTES])
+static void blake2b_compress_one_generic(struct blake2b_state *S,
+					 const u8 block[BLAKE2B_BLOCK_SIZE])
 {
 	u64 m[16];
 	u64 v[16];
@@ -108,14 +83,14 @@ static void blake2b_compress(struct blake2b_state *S,
 	for (i = 0; i < 8; ++i)
 		v[i] = S->h[i];
 
-	v[ 8] = blake2b_IV[0];
-	v[ 9] = blake2b_IV[1];
-	v[10] = blake2b_IV[2];
-	v[11] = blake2b_IV[3];
-	v[12] = blake2b_IV[4] ^ S->t[0];
-	v[13] = blake2b_IV[5] ^ S->t[1];
-	v[14] = blake2b_IV[6] ^ S->f[0];
-	v[15] = blake2b_IV[7] ^ S->f[1];
+	v[ 8] = BLAKE2B_IV0;
+	v[ 9] = BLAKE2B_IV1;
+	v[10] = BLAKE2B_IV2;
+	v[11] = BLAKE2B_IV3;
+	v[12] = BLAKE2B_IV4 ^ S->t[0];
+	v[13] = BLAKE2B_IV5 ^ S->t[1];
+	v[14] = BLAKE2B_IV6 ^ S->f[0];
+	v[15] = BLAKE2B_IV7 ^ S->f[1];
 
 	ROUND(0);
 	ROUND(1);
@@ -139,159 +114,54 @@ static void blake2b_compress(struct blake2b_state *S,
 #undef G
 #undef ROUND
 
-struct blake2b_tfm_ctx {
-	u8 key[BLAKE2B_KEYBYTES];
-	unsigned int keylen;
-};
-
-static int blake2b_setkey(struct crypto_shash *tfm, const u8 *key,
-			  unsigned int keylen)
+void blake2b_compress_generic(struct blake2b_state *state,
+			      const u8 *block, size_t nblocks, u32 inc)
 {
-	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(tfm);
-
-	if (keylen == 0 || keylen > BLAKE2B_KEYBYTES)
-		return -EINVAL;
-
-	memcpy(tctx->key, key, keylen);
-	tctx->keylen = keylen;
-
-	return 0;
+	do {
+		blake2b_increment_counter(state, inc);
+		blake2b_compress_one_generic(state, block);
+		block += BLAKE2B_BLOCK_SIZE;
+	} while (--nblocks);
 }
+EXPORT_SYMBOL(blake2b_compress_generic);
 
-static int blake2b_init(struct shash_desc *desc)
+static int crypto_blake2b_update_generic(struct shash_desc *desc,
+					 const u8 *in, unsigned int inlen)
 {
-	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
-	struct blake2b_state *state = shash_desc_ctx(desc);
-	const int digestsize = crypto_shash_digestsize(desc->tfm);
-
-	memset(state, 0, sizeof(*state));
-	memcpy(state->h, blake2b_IV, sizeof(state->h));
-
-	/* Parameter block is all zeros except index 0, no xor for 1..7 */
-	state->h[0] ^= 0x01010000 | tctx->keylen << 8 | digestsize;
-
-	if (tctx->keylen) {
-		/*
-		 * Prefill the buffer with the key, next call to _update or
-		 * _final will process it
-		 */
-		memcpy(state->buf, tctx->key, tctx->keylen);
-		state->buflen = BLAKE2B_BLOCKBYTES;
-	}
-	return 0;
+	return crypto_blake2b_update(desc, in, inlen, blake2b_compress_generic);
 }
 
-static int blake2b_update(struct shash_desc *desc, const u8 *in,
-			  unsigned int inlen)
+static int crypto_blake2b_final_generic(struct shash_desc *desc, u8 *out)
 {
-	struct blake2b_state *state = shash_desc_ctx(desc);
-	const size_t left = state->buflen;
-	const size_t fill = BLAKE2B_BLOCKBYTES - left;
-
-	if (!inlen)
-		return 0;
-
-	if (inlen > fill) {
-		state->buflen = 0;
-		/* Fill buffer */
-		memcpy(state->buf + left, in, fill);
-		blake2b_increment_counter(state, BLAKE2B_BLOCKBYTES);
-		/* Compress */
-		blake2b_compress(state, state->buf);
-		in += fill;
-		inlen -= fill;
-		while (inlen > BLAKE2B_BLOCKBYTES) {
-			blake2b_increment_counter(state, BLAKE2B_BLOCKBYTES);
-			blake2b_compress(state, in);
-			in += BLAKE2B_BLOCKBYTES;
-			inlen -= BLAKE2B_BLOCKBYTES;
-		}
-	}
-	memcpy(state->buf + state->buflen, in, inlen);
-	state->buflen += inlen;
-
-	return 0;
+	return crypto_blake2b_final(desc, out, blake2b_compress_generic);
 }
 
-static int blake2b_final(struct shash_desc *desc, u8 *out)
-{
-	struct blake2b_state *state = shash_desc_ctx(desc);
-	const int digestsize = crypto_shash_digestsize(desc->tfm);
-	size_t i;
-
-	blake2b_increment_counter(state, state->buflen);
-	/* Set last block */
-	state->f[0] = (u64)-1;
-	/* Padding */
-	memset(state->buf + state->buflen, 0, BLAKE2B_BLOCKBYTES - state->buflen);
-	blake2b_compress(state, state->buf);
-
-	/* Avoid temporary buffer and switch the internal output to LE order */
-	for (i = 0; i < ARRAY_SIZE(state->h); i++)
-		__cpu_to_le64s(&state->h[i]);
-
-	memcpy(out, state->h, digestsize);
-	return 0;
-}
+#define BLAKE2B_ALG(name, driver_name, digest_size)			\
+	{								\
+		.base.cra_name		= name,				\
+		.base.cra_driver_name	= driver_name,			\
+		.base.cra_priority	= 100,				\
+		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,	\
+		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,		\
+		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx), \
+		.base.cra_module	= THIS_MODULE,			\
+		.digestsize		= digest_size,			\
+		.setkey			= crypto_blake2b_setkey,	\
+		.init			= crypto_blake2b_init,		\
+		.update			= crypto_blake2b_update_generic, \
+		.final			= crypto_blake2b_final_generic,	\
+		.descsize		= sizeof(struct blake2b_state),	\
+	}
 
 static struct shash_alg blake2b_algs[] = {
-	{
-		.base.cra_name		= "blake2b-160",
-		.base.cra_driver_name	= "blake2b-160-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCKBYTES,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_160_DIGEST_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-256",
-		.base.cra_driver_name	= "blake2b-256-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCKBYTES,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_256_DIGEST_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-384",
-		.base.cra_driver_name	= "blake2b-384-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCKBYTES,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_384_DIGEST_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-512",
-		.base.cra_driver_name	= "blake2b-512-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCKBYTES,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_512_DIGEST_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}
+	BLAKE2B_ALG("blake2b-160", "blake2b-160-generic",
+		    BLAKE2B_160_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-256", "blake2b-256-generic",
+		    BLAKE2B_256_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-384", "blake2b-384-generic",
+		    BLAKE2B_384_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-512", "blake2b-512-generic",
+		    BLAKE2B_512_HASH_SIZE),
 };
 
 static int __init blake2b_mod_init(void)
diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
new file mode 100644
index 0000000000000..18875f16f8cad
--- /dev/null
+++ b/include/crypto/blake2b.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _CRYPTO_BLAKE2B_H
+#define _CRYPTO_BLAKE2B_H
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+enum blake2b_lengths {
+	BLAKE2B_BLOCK_SIZE = 128,
+	BLAKE2B_HASH_SIZE = 64,
+	BLAKE2B_KEY_SIZE = 64,
+
+	BLAKE2B_160_HASH_SIZE = 20,
+	BLAKE2B_256_HASH_SIZE = 32,
+	BLAKE2B_384_HASH_SIZE = 48,
+	BLAKE2B_512_HASH_SIZE = 64,
+};
+
+struct blake2b_state {
+	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
+	u64 h[8];
+	u64 t[2];
+	u64 f[2];
+	u8 buf[BLAKE2B_BLOCK_SIZE];
+	unsigned int buflen;
+	unsigned int outlen;
+};
+
+enum blake2b_iv {
+	BLAKE2B_IV0 = 0x6A09E667F3BCC908ULL,
+	BLAKE2B_IV1 = 0xBB67AE8584CAA73BULL,
+	BLAKE2B_IV2 = 0x3C6EF372FE94F82BULL,
+	BLAKE2B_IV3 = 0xA54FF53A5F1D36F1ULL,
+	BLAKE2B_IV4 = 0x510E527FADE682D1ULL,
+	BLAKE2B_IV5 = 0x9B05688C2B3E6C1FULL,
+	BLAKE2B_IV6 = 0x1F83D9ABFB41BD6BULL,
+	BLAKE2B_IV7 = 0x5BE0CD19137E2179ULL,
+};
+
+static inline void __blake2b_init(struct blake2b_state *state, size_t outlen,
+				  const void *key, size_t keylen)
+{
+	state->h[0] = BLAKE2B_IV0 ^ (0x01010000 | keylen << 8 | outlen);
+	state->h[1] = BLAKE2B_IV1;
+	state->h[2] = BLAKE2B_IV2;
+	state->h[3] = BLAKE2B_IV3;
+	state->h[4] = BLAKE2B_IV4;
+	state->h[5] = BLAKE2B_IV5;
+	state->h[6] = BLAKE2B_IV6;
+	state->h[7] = BLAKE2B_IV7;
+	state->t[0] = 0;
+	state->t[1] = 0;
+	state->f[0] = 0;
+	state->f[1] = 0;
+	state->buflen = 0;
+	state->outlen = outlen;
+	if (keylen) {
+		memcpy(state->buf, key, keylen);
+		memset(&state->buf[keylen], 0, BLAKE2B_BLOCK_SIZE - keylen);
+		state->buflen = BLAKE2B_BLOCK_SIZE;
+	}
+}
+
+#endif /* _CRYPTO_BLAKE2B_H */
diff --git a/include/crypto/internal/blake2b.h b/include/crypto/internal/blake2b.h
new file mode 100644
index 0000000000000..982fe5e8471cd
--- /dev/null
+++ b/include/crypto/internal/blake2b.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Helper functions for BLAKE2b implementations.
+ * Keep this in sync with the corresponding BLAKE2s header.
+ */
+
+#ifndef _CRYPTO_INTERNAL_BLAKE2B_H
+#define _CRYPTO_INTERNAL_BLAKE2B_H
+
+#include <crypto/blake2b.h>
+#include <crypto/internal/hash.h>
+#include <linux/string.h>
+
+void blake2b_compress_generic(struct blake2b_state *state,
+			      const u8 *block, size_t nblocks, u32 inc);
+
+static inline void blake2b_set_lastblock(struct blake2b_state *state)
+{
+	state->f[0] = -1;
+}
+
+typedef void (*blake2b_compress_t)(struct blake2b_state *state,
+				   const u8 *block, size_t nblocks, u32 inc);
+
+static inline void __blake2b_update(struct blake2b_state *state,
+				    const u8 *in, size_t inlen,
+				    blake2b_compress_t compress)
+{
+	const size_t fill = BLAKE2B_BLOCK_SIZE - state->buflen;
+
+	if (unlikely(!inlen))
+		return;
+	if (inlen > fill) {
+		memcpy(state->buf + state->buflen, in, fill);
+		(*compress)(state, state->buf, 1, BLAKE2B_BLOCK_SIZE);
+		state->buflen = 0;
+		in += fill;
+		inlen -= fill;
+	}
+	if (inlen > BLAKE2B_BLOCK_SIZE) {
+		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2B_BLOCK_SIZE);
+		/* Hash one less (full) block than strictly possible */
+		(*compress)(state, in, nblocks - 1, BLAKE2B_BLOCK_SIZE);
+		in += BLAKE2B_BLOCK_SIZE * (nblocks - 1);
+		inlen -= BLAKE2B_BLOCK_SIZE * (nblocks - 1);
+	}
+	memcpy(state->buf + state->buflen, in, inlen);
+	state->buflen += inlen;
+}
+
+static inline void __blake2b_final(struct blake2b_state *state, u8 *out,
+				   blake2b_compress_t compress)
+{
+	int i;
+
+	blake2b_set_lastblock(state);
+	memset(state->buf + state->buflen, 0,
+	       BLAKE2B_BLOCK_SIZE - state->buflen); /* Padding */
+	(*compress)(state, state->buf, 1, state->buflen);
+	for (i = 0; i < ARRAY_SIZE(state->h); i++)
+		__cpu_to_le64s(&state->h[i]);
+	memcpy(out, state->h, state->outlen);
+}
+
+/* Helper functions for shash implementations of BLAKE2b */
+
+struct blake2b_tfm_ctx {
+	u8 key[BLAKE2B_KEY_SIZE];
+	unsigned int keylen;
+};
+
+static inline int crypto_blake2b_setkey(struct crypto_shash *tfm,
+					const u8 *key, unsigned int keylen)
+{
+	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen == 0 || keylen > BLAKE2B_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(tctx->key, key, keylen);
+	tctx->keylen = keylen;
+
+	return 0;
+}
+
+static inline int crypto_blake2b_init(struct shash_desc *desc)
+{
+	const struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct blake2b_state *state = shash_desc_ctx(desc);
+	unsigned int outlen = crypto_shash_digestsize(desc->tfm);
+
+	__blake2b_init(state, outlen, tctx->key, tctx->keylen);
+	return 0;
+}
+
+static inline int crypto_blake2b_update(struct shash_desc *desc,
+					const u8 *in, unsigned int inlen,
+					blake2b_compress_t compress)
+{
+	struct blake2b_state *state = shash_desc_ctx(desc);
+
+	__blake2b_update(state, in, inlen, compress);
+	return 0;
+}
+
+static inline int crypto_blake2b_final(struct shash_desc *desc, u8 *out,
+				       blake2b_compress_t compress)
+{
+	struct blake2b_state *state = shash_desc_ctx(desc);
+
+	__blake2b_final(state, out, compress);
+	return 0;
+}
+
+#endif /* _CRYPTO_INTERNAL_BLAKE2B_H */
-- 
2.40.1



