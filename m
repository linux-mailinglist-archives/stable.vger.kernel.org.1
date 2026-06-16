Return-Path: <stable+bounces-264813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q/PnJ6p8MWpykgUAu9opvQ
	(envelope-from <stable+bounces-264813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:41:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C575692572
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:41:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1Bb2+Oa5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264813-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264813-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C672A303ECC5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAC33AD9B;
	Tue, 16 Jun 2026 16:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CC46AF1B;
	Tue, 16 Jun 2026 16:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628024; cv=none; b=uBtd1ul5T5CaSXPg8+zLkleWAH7MEsLxtUNUDcIAqcrcRigX4dX5CzWvZ801EphWeCLnNY4AtEERgsaLz2yc1ZqjdUtiRQCb7qLQVSnGYMNxPUDw3x8KPzyzeeY8dhswKBajh+dU6CrtI/nGFC/vDRfvFxL8tNILg2x2jlDORkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628024; c=relaxed/simple;
	bh=0ndhgYtlqSkiqH1rvIrAXx3wqws4vcBjv4v8hXKoiNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNre6TofuhZAeNu1ogwh6PAeOtTUTW275czrfhJ6BzdOIQDHGC1nS+bMAjsQhwGGkt/eaDE9CQT2QbFCaWRMhxkHIjIzivu3GJBsLfiQU89O5CvvJzQp2gNxSf0TLVpWKoSTJ3O2zzxzUMU1caZcjNdEF39flwbPJ1RWPjBrwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Bb2+Oa5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3697F1F000E9;
	Tue, 16 Jun 2026 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628023;
	bh=0QkJptTpVhAZn+hLEVts/kFQIJtdlADMvVd+QcKHHE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1Bb2+Oa5aLpECY2lF1u4YMPkY1oHYgYDkZwHbfqCXfFJQWvdgEOnL1ISATR4xzZMg
	 xZmuDeDuKTXU+QOUHO8Nn/oNNMxun8LMHPDiYV9Do3HHP8kQYagvsWz3KE9ZEcNElr
	 4+MR2TTj7yfLS79Vxq9kNp+68jEEKxeVGeEtOfLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Sowden <jeremy@azazel.net>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/452] netfilter: nf_tables: fix dst corruption in same register operation
Date: Tue, 16 Jun 2026 20:24:04 +0530
Message-ID: <20260616145118.714938895@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264813-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jeremy@azazel.net,m:fmancera@suse.de,m:fw@strlen.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:email,azazel.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C575692572

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 18014147d3ee7831dce53fe65d7fc8d428b02552 ]

For lshift and rshift, the shift operations are performed in a loop over
32-bit words. The loop calculates the shifted value and write it to dst,
and then immediately reads from src to calculate the carry for the next
iteration. Because src and dst could point to the same memory location,
the carry is incorrectly calculated using the newly modified dst value
instead of the original src value.

Adding a temporary local variable to cache the original value before
writing to dst and using it for the carry calculation solves the
problem. In addition, partial overlap is rejected from control plane for
all kind of operations including byteorder. This was tested with the
following bytecode:

table test_table ip flags 0 use 1 handle 1
ip test_table test_chain use 3 type filter hook input prio 0 policy accept packets 0 bytes 0 flags 1
ip test_table test_chain 2
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x66443322 0x00887766 ]
  [ counter pkts 0 bytes 0 ]
ip test_table test_chain 4 3
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x55443322 0x00887766 ]
  [ counter pkts 21794 bytes 1917798 ]

Fixes: 567d746b55bc ("netfilter: bitwise: add support for shifts.")
Acked-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  7 +++++++
 net/netfilter/nft_bitwise.c       | 18 ++++++++++++++----
 net/netfilter/nft_byteorder.c     | 13 ++++++++++---
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index ab0567951e3105..a1f828efc9e3de 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -188,6 +188,13 @@ static inline u64 nft_reg_load64(const u32 *sreg)
 	return get_unaligned((u64 *)sreg);
 }
 
+static inline bool nft_reg_overlap(u8 src, u8 dst, u32 len)
+{
+	unsigned int n = DIV_ROUND_UP(len, sizeof(u32));
+
+	return src != dst && src < dst + n && dst < src + n;
+}
+
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
 				 unsigned int len)
 {
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index af990c600745be..1afb36fb5994db 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -43,8 +43,10 @@ static void nft_bitwise_eval_lshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = DIV_ROUND_UP(priv->len, sizeof(u32)); i > 0; i--) {
-		dst[i - 1] = (src[i - 1] << shift) | carry;
-		carry = src[i - 1] >> (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i - 1];
+
+		dst[i - 1] = (tmp_src << shift) | carry;
+		carry = tmp_src >> (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -56,8 +58,10 @@ static void nft_bitwise_eval_rshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
-		dst[i] = carry | (src[i] >> shift);
-		carry = src[i] << (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i];
+
+		dst[i] = carry | (tmp_src >> shift);
+		carry = tmp_src << (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -235,6 +239,9 @@ static int nft_bitwise_init_bool(const struct nft_ctx *ctx,
 					      &priv->sreg2, priv->len);
 		if (err < 0)
 			return err;
+
+		if (nft_reg_overlap(priv->sreg2, priv->dreg, priv->len))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -265,6 +272,9 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
 	if (tb[NFTA_BITWISE_OP]) {
 		priv->op = ntohl(nla_get_be32(tb[NFTA_BITWISE_OP]));
 		switch (priv->op) {
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 2f82a444d21bf3..51f5de5c4ca363 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -144,9 +144,16 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
-					&priv->dreg, NULL, NFT_DATA_VALUE,
-					priv->len);
+	err = nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
+				       &priv->dreg, NULL, NFT_DATA_VALUE,
+				       priv->len);
+	if (err < 0)
+		return err;
+
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nft_byteorder_dump(struct sk_buff *skb,
-- 
2.53.0




