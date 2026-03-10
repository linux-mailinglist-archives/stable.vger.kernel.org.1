Return-Path: <stable+bounces-223785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMdzHSXRr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:07:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB6246F09
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001A2306EE2F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351813ED10A;
	Tue, 10 Mar 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="aAaOdvXn"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB383E5EF6;
	Tue, 10 Mar 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129868; cv=none; b=meCl7docabbpY0wIjCZtyV6szFCut+HssFtJ4plLywEkR41IdrGHLbL6ipgpmk3Pn8LE2ke8D7O30einUX505xaU3UhUrx3+qZf4EAHqycfYz0OMNrL27Lm6G0oACUf+3pfG+xU7aEnThoFGasyAaai4AhwTXYu8V6da0vFjCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129868; c=relaxed/simple;
	bh=iUWBljZc+c+VPy0nz/GTjnH0L2vq5pMf68IWb113iJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKZzhWxcYOorQAm0y0Jd7KRiS1Cq/zfC/YU9ph6yZ8bhSxMsPTQK/Rn5prV+okRTzZNEBaP37Mqx65DypCES20DiSz25WSt5tGIzWSvH7Y8az3cDvUSKSt4KQwbhoILdCXl+9DG+ZvVNDANryLG84Oheo+ro1e6LjlXMRz08iEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=aAaOdvXn; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=aAaOdvXnZ7RLY4DKP7GTyA3Xa6dSAGGagX71k2TBapmCf2YHnvhmW+rkLwbmhqxrPGaBLPq8ersoW
	 lUPqD1EGMxsxLQYfqhW/Jhm/UXlkXi8BnWXBHbn2kAL1WEL/LWTvj0QwKgljjrx8YDc1m6EbmvAXR0
	 Si9+a6NWcwn6uuQE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769afd069396-023dc;
	Tue, 10 Mar 2026 16:04:15 +0800 (CST)
X-RM-TRANSID:2f3769afd069396-023dc
From: XiaoHua Wang <561399680@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: pablo@netfilter.org,
	netdev@vger.kernel.org,
	sbrivio@redhat.com,
	XiaoHua Wang <561399680@139.com>
Subject: [PATCH 6.1.y 2/2] netfilter: nft_set_pipapo: prevent overflow in lookup table allocation
Date: Tue, 10 Mar 2026 16:02:46 +0800
Message-Id: <20260310080246.3543546-2-561399680@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310080246.3543546-1-561399680@139.com>
References: <20260310080246.3543546-1-561399680@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34DB6246F09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,redhat.com,139.com];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[561399680@139.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,139.com:mid,139.com:email]
X-Rspamd-Action: no action

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
[ Adjust context ]
Signed-off-by: XiaoHua Wang <561399680@139.com>
---
 net/netfilter/nft_set_pipapo.c | 58 ++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index ad9d0bb43248..c90fb381bf7a 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -610,6 +610,30 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			 nft_genmask_cur(net), get_jiffies_64());
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
@@ -628,6 +652,7 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
 	union nft_pipapo_map_bucket *new_mt, *old_mt = f->mt;
 	size_t new_bucket_size, copy;
 	int group, bucket;
+	ssize_t lt_size;
 
 	new_bucket_size = DIV_ROUND_UP(rules, BITS_PER_LONG);
 #ifdef NFT_PIPAPO_ALIGN
@@ -643,10 +668,11 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
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
 
@@ -845,7 +871,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 {
 	unsigned long *new_lt;
 	int groups, bb;
-	size_t lt_size;
+	ssize_t lt_size;
 
 	lt_size = f->groups * NFT_PIPAPO_BUCKETS(f->bb) * f->bsize *
 		  sizeof(*f->lt);
@@ -855,15 +881,17 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
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
@@ -874,7 +902,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		return;
 	}
 
-	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL_ACCOUNT);
+	new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return;
 
@@ -1348,13 +1376,15 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 
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
2.43.0



