Return-Path: <stable+bounces-141115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BCAAB614
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D02817ADD5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2031E190;
	Tue,  6 May 2025 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SREqenGw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A7299513;
	Mon,  5 May 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485123; cv=none; b=B5fq+LjuXhcdfQetxMtLx1TA78YwPP+ArI54FoQ1mx84523sQOUIycY/LKOBErRULLJjgAbTfj3RXspteWCXoWaxFufLXMj8YfmPqDRW53mc7iigXMP0dy0Acys6cv6qQhvWmhMPWgmy9yI6TKQt7QWxFLJwDpIroH1HjF818KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485123; c=relaxed/simple;
	bh=PmAIxLvgHIUaUUWCZ1PQ4/6PEcSVEshIOVPJuhJj60g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S576Fo/dUwag21V8y0VQ6gc7/8stSYAHrRkeU5cFYx9VnujZTK0rhtYis5THHOodZ9j4ZofWPPKYCU6CYV2nFN42VJRpBdCV1IHVMVWqzT4U2Dde/RuYugm1dgZ/ZLF51DB92ROKzB5LhzEy30XYYyKowRtehetZiwzvJisNRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SREqenGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFB4C4CEE4;
	Mon,  5 May 2025 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485121;
	bh=PmAIxLvgHIUaUUWCZ1PQ4/6PEcSVEshIOVPJuhJj60g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SREqenGweD67JbjmokLVL9K+dJ4orwB9heuMT04GY9hc/BC8geyt2DHRAo4cI4ef4
	 62dnYXx4YAsGkFEmOPiX/eeWeoDIM2pFrUOCsU79bdXwy5MYloVsFoT1p0axNdR+F5
	 278JQ9BoNAqCnAcXvEo5XETaUZ+5xqH4BEYzCtM33inEYSMChgmtD6jiHgfVkvkcOq
	 MS5YJSTePfUZM63NgtjXoy1cYw6K+tXOAEACBb3PyuAef8wqwLaaqWo6yVpVzq2d2N
	 c+QbVdKk7Gm1fq7cNEc9nqsufZeBdHOSVkbiV7fVbpXhlR8s6aSWmp5xsgNZ58lmmM
	 cqTJURNSZFquw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	viro@zeniv.linux.org.uk,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 171/486] crypto: lzo - Fix compression buffer overrun
Date: Mon,  5 May 2025 18:34:07 -0400
Message-Id: <20250505223922.2682012-171-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit cc47f07234f72cbd8e2c973cdbf2a6730660a463 ]

Unlike the decompression code, the compression code in LZO never
checked for output overruns.  It instead assumes that the caller
always provides enough buffer space, disregarding the buffer length
provided by the caller.

Add a safe compression interface that checks for the end of buffer
before each write.  Use the safe interface in crypto/lzo.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/lzo-rle.c              |   2 +-
 crypto/lzo.c                  |   2 +-
 include/linux/lzo.h           |   8 +++
 lib/lzo/Makefile              |   2 +-
 lib/lzo/lzo1x_compress.c      | 102 +++++++++++++++++++++++++---------
 lib/lzo/lzo1x_compress_safe.c |  18 ++++++
 6 files changed, 106 insertions(+), 28 deletions(-)
 create mode 100644 lib/lzo/lzo1x_compress_safe.c

diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
index 0631d975bfac1..0abc2d87f0420 100644
--- a/crypto/lzo-rle.c
+++ b/crypto/lzo-rle.c
@@ -55,7 +55,7 @@ static int __lzorle_compress(const u8 *src, unsigned int slen,
 	size_t tmp_len = *dlen; /* size_t(ulong) <-> uint on 64 bit */
 	int err;
 
-	err = lzorle1x_1_compress(src, slen, dst, &tmp_len, ctx);
+	err = lzorle1x_1_compress_safe(src, slen, dst, &tmp_len, ctx);
 
 	if (err != LZO_E_OK)
 		return -EINVAL;
diff --git a/crypto/lzo.c b/crypto/lzo.c
index ebda132dd22bf..8338851c7406a 100644
--- a/crypto/lzo.c
+++ b/crypto/lzo.c
@@ -55,7 +55,7 @@ static int __lzo_compress(const u8 *src, unsigned int slen,
 	size_t tmp_len = *dlen; /* size_t(ulong) <-> uint on 64 bit */
 	int err;
 
-	err = lzo1x_1_compress(src, slen, dst, &tmp_len, ctx);
+	err = lzo1x_1_compress_safe(src, slen, dst, &tmp_len, ctx);
 
 	if (err != LZO_E_OK)
 		return -EINVAL;
diff --git a/include/linux/lzo.h b/include/linux/lzo.h
index e95c7d1092b28..4d30e3624acd2 100644
--- a/include/linux/lzo.h
+++ b/include/linux/lzo.h
@@ -24,10 +24,18 @@
 int lzo1x_1_compress(const unsigned char *src, size_t src_len,
 		     unsigned char *dst, size_t *dst_len, void *wrkmem);
 
+/* Same as above but does not write more than dst_len to dst. */
+int lzo1x_1_compress_safe(const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t *dst_len, void *wrkmem);
+
 /* This requires 'wrkmem' of size LZO1X_1_MEM_COMPRESS */
 int lzorle1x_1_compress(const unsigned char *src, size_t src_len,
 		     unsigned char *dst, size_t *dst_len, void *wrkmem);
 
+/* Same as above but does not write more than dst_len to dst. */
+int lzorle1x_1_compress_safe(const unsigned char *src, size_t src_len,
+			     unsigned char *dst, size_t *dst_len, void *wrkmem);
+
 /* safe decompression with overrun testing */
 int lzo1x_decompress_safe(const unsigned char *src, size_t src_len,
 			  unsigned char *dst, size_t *dst_len);
diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
index 2f58fafbbdddc..fc7b2b7ef4b20 100644
--- a/lib/lzo/Makefile
+++ b/lib/lzo/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-lzo_compress-objs := lzo1x_compress.o
+lzo_compress-objs := lzo1x_compress.o lzo1x_compress_safe.o
 lzo_decompress-objs := lzo1x_decompress_safe.o
 
 obj-$(CONFIG_LZO_COMPRESS) += lzo_compress.o
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 47d6d43ea9578..7b10ca86a8930 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -18,11 +18,22 @@
 #include <linux/lzo.h>
 #include "lzodefs.h"
 
-static noinline size_t
-lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
-		    unsigned char *out, size_t *out_len,
-		    size_t ti, void *wrkmem, signed char *state_offset,
-		    const unsigned char bitstream_version)
+#undef LZO_UNSAFE
+
+#ifndef LZO_SAFE
+#define LZO_UNSAFE 1
+#define LZO_SAFE(name) name
+#define HAVE_OP(x) 1
+#endif
+
+#define NEED_OP(x) if (!HAVE_OP(x)) goto output_overrun
+
+static noinline int
+LZO_SAFE(lzo1x_1_do_compress)(const unsigned char *in, size_t in_len,
+			      unsigned char **out, unsigned char *op_end,
+			      size_t *tp, void *wrkmem,
+			      signed char *state_offset,
+			      const unsigned char bitstream_version)
 {
 	const unsigned char *ip;
 	unsigned char *op;
@@ -30,8 +41,9 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 	const unsigned char * const ip_end = in + in_len - 20;
 	const unsigned char *ii;
 	lzo_dict_t * const dict = (lzo_dict_t *) wrkmem;
+	size_t ti = *tp;
 
-	op = out;
+	op = *out;
 	ip = in;
 	ii = ip;
 	ip += ti < 4 ? 4 - ti : 0;
@@ -116,25 +128,32 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		if (t != 0) {
 			if (t <= 3) {
 				op[*state_offset] |= t;
+				NEED_OP(4);
 				COPY4(op, ii);
 				op += t;
 			} else if (t <= 16) {
+				NEED_OP(17);
 				*op++ = (t - 3);
 				COPY8(op, ii);
 				COPY8(op + 8, ii + 8);
 				op += t;
 			} else {
 				if (t <= 18) {
+					NEED_OP(1);
 					*op++ = (t - 3);
 				} else {
 					size_t tt = t - 18;
+					NEED_OP(1);
 					*op++ = 0;
 					while (unlikely(tt > 255)) {
 						tt -= 255;
+						NEED_OP(1);
 						*op++ = 0;
 					}
+					NEED_OP(1);
 					*op++ = tt;
 				}
+				NEED_OP(t);
 				do {
 					COPY8(op, ii);
 					COPY8(op + 8, ii + 8);
@@ -151,6 +170,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		if (unlikely(run_length)) {
 			ip += run_length;
 			run_length -= MIN_ZERO_RUN_LENGTH;
+			NEED_OP(4);
 			put_unaligned_le32((run_length << 21) | 0xfffc18
 					   | (run_length & 0x7), op);
 			op += 4;
@@ -243,10 +263,12 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		ip += m_len;
 		if (m_len <= M2_MAX_LEN && m_off <= M2_MAX_OFFSET) {
 			m_off -= 1;
+			NEED_OP(2);
 			*op++ = (((m_len - 1) << 5) | ((m_off & 7) << 2));
 			*op++ = (m_off >> 3);
 		} else if (m_off <= M3_MAX_OFFSET) {
 			m_off -= 1;
+			NEED_OP(1);
 			if (m_len <= M3_MAX_LEN)
 				*op++ = (M3_MARKER | (m_len - 2));
 			else {
@@ -254,14 +276,18 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 				*op++ = M3_MARKER | 0;
 				while (unlikely(m_len > 255)) {
 					m_len -= 255;
+					NEED_OP(1);
 					*op++ = 0;
 				}
+				NEED_OP(1);
 				*op++ = (m_len);
 			}
+			NEED_OP(2);
 			*op++ = (m_off << 2);
 			*op++ = (m_off >> 6);
 		} else {
 			m_off -= 0x4000;
+			NEED_OP(1);
 			if (m_len <= M4_MAX_LEN)
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8)
 						| (m_len - 2));
@@ -282,11 +308,14 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 				m_len -= M4_MAX_LEN;
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8));
 				while (unlikely(m_len > 255)) {
+					NEED_OP(1);
 					m_len -= 255;
 					*op++ = 0;
 				}
+				NEED_OP(1);
 				*op++ = (m_len);
 			}
+			NEED_OP(2);
 			*op++ = (m_off << 2);
 			*op++ = (m_off >> 6);
 		}
@@ -295,14 +324,20 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		ii = ip;
 		goto next;
 	}
-	*out_len = op - out;
-	return in_end - (ii - ti);
+	*out = op;
+	*tp = in_end - (ii - ti);
+	return LZO_E_OK;
+
+output_overrun:
+	return LZO_E_OUTPUT_OVERRUN;
 }
 
-static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem, const unsigned char bitstream_version)
+static int LZO_SAFE(lzogeneric1x_1_compress)(
+	const unsigned char *in, size_t in_len,
+	unsigned char *out, size_t *out_len,
+	void *wrkmem, const unsigned char bitstream_version)
 {
+	unsigned char * const op_end = out + *out_len;
 	const unsigned char *ip = in;
 	unsigned char *op = out;
 	unsigned char *data_start;
@@ -326,14 +361,18 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 	while (l > 20) {
 		size_t ll = min_t(size_t, l, m4_max_offset + 1);
 		uintptr_t ll_end = (uintptr_t) ip + ll;
+		int err;
+
 		if ((ll_end + ((t + ll) >> 5)) <= ll_end)
 			break;
 		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
 		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
-		t = lzo1x_1_do_compress(ip, ll, op, out_len, t, wrkmem,
-					&state_offset, bitstream_version);
+		err = LZO_SAFE(lzo1x_1_do_compress)(
+			ip, ll, &op, op_end, &t, wrkmem,
+			&state_offset, bitstream_version);
+		if (err != LZO_E_OK)
+			return err;
 		ip += ll;
-		op += *out_len;
 		l  -= ll;
 	}
 	t += l;
@@ -342,20 +381,26 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		const unsigned char *ii = in + in_len - t;
 
 		if (op == data_start && t <= 238) {
+			NEED_OP(1);
 			*op++ = (17 + t);
 		} else if (t <= 3) {
 			op[state_offset] |= t;
 		} else if (t <= 18) {
+			NEED_OP(1);
 			*op++ = (t - 3);
 		} else {
 			size_t tt = t - 18;
+			NEED_OP(1);
 			*op++ = 0;
 			while (tt > 255) {
 				tt -= 255;
+				NEED_OP(1);
 				*op++ = 0;
 			}
+			NEED_OP(1);
 			*op++ = tt;
 		}
+		NEED_OP(t);
 		if (t >= 16) do {
 			COPY8(op, ii);
 			COPY8(op + 8, ii + 8);
@@ -368,31 +413,38 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		} while (--t > 0);
 	}
 
+	NEED_OP(3);
 	*op++ = M4_MARKER | 1;
 	*op++ = 0;
 	*op++ = 0;
 
 	*out_len = op - out;
 	return LZO_E_OK;
+
+output_overrun:
+	return LZO_E_OUTPUT_OVERRUN;
 }
 
-int lzo1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem)
+int LZO_SAFE(lzo1x_1_compress)(const unsigned char *in, size_t in_len,
+			       unsigned char *out, size_t *out_len,
+			       void *wrkmem)
 {
-	return lzogeneric1x_1_compress(in, in_len, out, out_len, wrkmem, 0);
+	return LZO_SAFE(lzogeneric1x_1_compress)(
+		in, in_len, out, out_len, wrkmem, 0);
 }
 
-int lzorle1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem)
+int LZO_SAFE(lzorle1x_1_compress)(const unsigned char *in, size_t in_len,
+				  unsigned char *out, size_t *out_len,
+				  void *wrkmem)
 {
-	return lzogeneric1x_1_compress(in, in_len, out, out_len,
-				       wrkmem, LZO_VERSION);
+	return LZO_SAFE(lzogeneric1x_1_compress)(
+		in, in_len, out, out_len, wrkmem, LZO_VERSION);
 }
 
-EXPORT_SYMBOL_GPL(lzo1x_1_compress);
-EXPORT_SYMBOL_GPL(lzorle1x_1_compress);
+EXPORT_SYMBOL_GPL(LZO_SAFE(lzo1x_1_compress));
+EXPORT_SYMBOL_GPL(LZO_SAFE(lzorle1x_1_compress));
 
+#ifndef LZO_UNSAFE
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LZO1X-1 Compressor");
+#endif
diff --git a/lib/lzo/lzo1x_compress_safe.c b/lib/lzo/lzo1x_compress_safe.c
new file mode 100644
index 0000000000000..371c9f8494928
--- /dev/null
+++ b/lib/lzo/lzo1x_compress_safe.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  LZO1X Compressor from LZO
+ *
+ *  Copyright (C) 1996-2012 Markus F.X.J. Oberhumer <markus@oberhumer.com>
+ *
+ *  The full LZO package can be found at:
+ *  http://www.oberhumer.com/opensource/lzo/
+ *
+ *  Changed for Linux kernel use by:
+ *  Nitin Gupta <nitingupta910@gmail.com>
+ *  Richard Purdie <rpurdie@openedhand.com>
+ */
+
+#define LZO_SAFE(name) name##_safe
+#define HAVE_OP(x) ((size_t)(op_end - op) >= (size_t)(x))
+
+#include "lzo1x_compress.c"
-- 
2.39.5


