Return-Path: <stable+bounces-153338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7894ADD409
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07901945597
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3F2EE60B;
	Tue, 17 Jun 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bm4066Kj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A62E92BC;
	Tue, 17 Jun 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175626; cv=none; b=TCsMUoFWluZgPQ8x7CPKUbzQDyGX32FZo11cdPGvQgWJ2HL1xXgNEgQf/lBqFmk26LYgnsbT7ZInUf16TTUsIrv0ihxWQkhR4QUvARC6PHVrKepQmOslu+l/FrHu0x/tDKkavHKxvf4MuBHO26YJo5ArOUn4fTeLpeBVIsJkwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175626; c=relaxed/simple;
	bh=Z9Mw4VNWnUgGu4ak/IV3lxqV1+g/yQMj6IjblkEwhUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWPewttPxFdhYCONTItdcEjVW5MBrq+bTJDMXFRmV0nsZi4t47VHPN/dxzI33Ag4+pVY2W2uPl8rcF4GyYTLUveEwIVnYFihg+14erzCF9CDdGLW6prcUFimPPywuXFN79ry6P59Ka4y7HkNhH0IWerVIg6ujWKZfwtMY0p8vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bm4066Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C684C4CEF0;
	Tue, 17 Jun 2025 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175626;
	bh=Z9Mw4VNWnUgGu4ak/IV3lxqV1+g/yQMj6IjblkEwhUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bm4066Kjs3wLwL/K3Z6dVU/QBhVmhTisNwGeA2Jn+/4HwzXynyvmX9l+zOaIcgJ5v
	 bsY48LBo1259zEYAS4QuF+9ExD0SkRM+nYAHyYtGYM3/L1T+R6O58kVRflvrpKpc9J
	 cTA9miz9Q2/BwTSBe6hVc4JwrfXiW/L22Lxx2O0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 148/512] netfilter: nft_set_pipapo: prevent overflow in lookup table allocation
Date: Tue, 17 Jun 2025 17:21:54 +0200
Message-ID: <20250617152425.605146540@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 4c5c6aa9967dbe55bd017bb509885928d0f31206 ]

When calculating the lookup table size, ensure the following
multiplication does not overflow:

- desc->field_len[] maximum value is U8_MAX multiplied by
  NFT_PIPAPO_GROUPS_PER_BYTE(f) that can be 2, worst case.
- NFT_PIPAPO_BUCKETS(f->bb) is 2^8, worst case.
- sizeof(unsigned long), from sizeof(*f->lt), lt in
  struct nft_pipapo_field.

Then, use check_mul_overflow() to multiply by bucket size and then use
check_add_overflow() to the alignment for avx2 (if needed). Finally, add
lt_size_check_overflow() helper and use it to consolidate this.

While at it, replace leftover allocation using the GFP_KERNEL to
GFP_KERNEL_ACCOUNT for consistency, in pipapo_resize().

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 58 ++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7be342b495f5f..0529e4ef75207 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -683,6 +683,30 @@ static int pipapo_realloc_mt(struct nft_pipapo_field *f,
 	return 0;
 }
 
+
+/**
+ * lt_calculate_size() - Get storage size for lookup table with overflow check
+ * @groups:	Amount of bit groups
+ * @bb:		Number of bits grouped together in lookup table buckets
+ * @bsize:	Size of each bucket in lookup table, in longs
+ *
+ * Return: allocation size including alignment overhead, negative on overflow
+ */
+static ssize_t lt_calculate_size(unsigned int groups, unsigned int bb,
+				 unsigned int bsize)
+{
+	ssize_t ret = groups * NFT_PIPAPO_BUCKETS(bb) * sizeof(long);
+
+	if (check_mul_overflow(ret, bsize, &ret))
+		return -1;
+	if (check_add_overflow(ret, NFT_PIPAPO_ALIGN_HEADROOM, &ret))
+		return -1;
+	if (ret > INT_MAX)
+		return -1;
+
+	return ret;
+}
+
 /**
  * pipapo_resize() - Resize lookup or mapping table, or both
  * @f:		Field containing lookup and mapping tables
@@ -701,6 +725,7 @@ static int pipapo_resize(struct nft_pipapo_field *f,
 	long *new_lt = NULL, *new_p, *old_lt = f->lt, *old_p;
 	unsigned int new_bucket_size, copy;
 	int group, bucket, err;
+	ssize_t lt_size;
 
 	if (rules >= NFT_PIPAPO_RULE0_MAX)
 		return -ENOSPC;
@@ -719,10 +744,11 @@ static int pipapo_resize(struct nft_pipapo_field *f,
 	else
 		copy = new_bucket_size;
 
-	new_lt = kvzalloc(f->groups * NFT_PIPAPO_BUCKETS(f->bb) *
-			  new_bucket_size * sizeof(*new_lt) +
-			  NFT_PIPAPO_ALIGN_HEADROOM,
-			  GFP_KERNEL);
+	lt_size = lt_calculate_size(f->groups, f->bb, new_bucket_size);
+	if (lt_size < 0)
+		return -ENOMEM;
+
+	new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return -ENOMEM;
 
@@ -907,7 +933,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 {
 	unsigned int groups, bb;
 	unsigned long *new_lt;
-	size_t lt_size;
+	ssize_t lt_size;
 
 	lt_size = f->groups * NFT_PIPAPO_BUCKETS(f->bb) * f->bsize *
 		  sizeof(*f->lt);
@@ -917,15 +943,17 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		groups = f->groups * 2;
 		bb = NFT_PIPAPO_GROUP_BITS_LARGE_SET;
 
-		lt_size = groups * NFT_PIPAPO_BUCKETS(bb) * f->bsize *
-			  sizeof(*f->lt);
+		lt_size = lt_calculate_size(groups, bb, f->bsize);
+		if (lt_size < 0)
+			return;
 	} else if (f->bb == NFT_PIPAPO_GROUP_BITS_LARGE_SET &&
 		   lt_size < NFT_PIPAPO_LT_SIZE_LOW) {
 		groups = f->groups / 2;
 		bb = NFT_PIPAPO_GROUP_BITS_SMALL_SET;
 
-		lt_size = groups * NFT_PIPAPO_BUCKETS(bb) * f->bsize *
-			  sizeof(*f->lt);
+		lt_size = lt_calculate_size(groups, bb, f->bsize);
+		if (lt_size < 0)
+			return;
 
 		/* Don't increase group width if the resulting lookup table size
 		 * would exceed the upper size threshold for a "small" set.
@@ -936,7 +964,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		return;
 	}
 
-	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL_ACCOUNT);
+	new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return;
 
@@ -1451,13 +1479,15 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 
 	for (i = 0; i < old->field_count; i++) {
 		unsigned long *new_lt;
+		ssize_t lt_size;
 
 		memcpy(dst, src, offsetof(struct nft_pipapo_field, lt));
 
-		new_lt = kvzalloc(src->groups * NFT_PIPAPO_BUCKETS(src->bb) *
-				  src->bsize * sizeof(*dst->lt) +
-				  NFT_PIPAPO_ALIGN_HEADROOM,
-				  GFP_KERNEL_ACCOUNT);
+		lt_size = lt_calculate_size(src->groups, src->bb, src->bsize);
+		if (lt_size < 0)
+			goto out_lt;
+
+		new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 		if (!new_lt)
 			goto out_lt;
 
-- 
2.39.5




