Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C0719DC6
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjFAN0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjFAN0I (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF221A4
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7650064499
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92982C4339B;
        Thu,  1 Jun 2023 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625950;
        bh=yVWDrcpdDHcA+UFid/hKPKZTrk6HOSBK7Rahy0D0BDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFOX+ycw+3Mj3afJ8l1znetAR/tVvEyNJgsvjmNy7wYM2V80q3Il+dTFHaMtn+74f
         eGLGT6dfmJIDbg47Wcfuvn4TZ+a0gV3l9zLeTDY7GCsOHO15sGl8lMqlC5pnTxdGYM
         jpZ8dz1juSXwy4QEMGaR2p55MtNIdeBYguGKxkes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 16/45] tls: rx: strp: preserve decryption status of skbs when needed
Date:   Thu,  1 Jun 2023 14:21:12 +0100
Message-Id: <20230601131939.449979302@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit eca9bfafee3a0487e59c59201ae14c7594ba940a ]

When receive buffer is small we try to copy out the data from
TCP into a skb maintained by TLS to prevent connection from
stalling. Unfortunately if a single record is made up of a mix
of decrypted and non-decrypted skbs combining them into a single
skb leads to loss of decryption status, resulting in decryption
errors or data corruption.

Similarly when trying to use TCP receive queue directly we need
to make sure that all the skbs within the record have the same
status. If we don't the mixed status will be detected correctly
but we'll CoW the anchor, again collapsing it into a single paged
skb without decrypted status preserved. So the "fixup" code will
not know which parts of skb to re-encrypt.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tls.h    |   1 +
 net/tls/tls.h        |   5 ++
 net/tls/tls_device.c |  22 +++-----
 net/tls/tls_strp.c   | 117 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 114 insertions(+), 31 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 154949c7b0c88..c36bf4c50027e 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -124,6 +124,7 @@ struct tls_strparser {
 	u32 mark : 8;
 	u32 stopped : 1;
 	u32 copy_mode : 1;
+	u32 mixed_decrypted : 1;
 	u32 msg_ready : 1;
 
 	struct strp_msg stm;
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 804c3880d0288..0672acab27731 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -167,6 +167,11 @@ static inline bool tls_strp_msg_ready(struct tls_sw_context_rx *ctx)
 	return ctx->strp.msg_ready;
 }
 
+static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
+{
+	return ctx->strp.mixed_decrypted;
+}
+
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 3b87c7b04ac87..bf69c9d6d06c0 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1007,20 +1007,14 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_buff *skb = tls_strp_msg(sw_ctx);
 	struct strp_msg *rxm = strp_msg(skb);
-	int is_decrypted = skb->decrypted;
-	int is_encrypted = !is_decrypted;
-	struct sk_buff *skb_iter;
-	int left;
-
-	left = rxm->full_len + rxm->offset - skb_pagelen(skb);
-	/* Check if all the data is decrypted already */
-	skb_iter = skb_shinfo(skb)->frag_list;
-	while (skb_iter && left > 0) {
-		is_decrypted &= skb_iter->decrypted;
-		is_encrypted &= !skb_iter->decrypted;
-
-		left -= skb_iter->len;
-		skb_iter = skb_iter->next;
+	int is_decrypted, is_encrypted;
+
+	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
+		is_decrypted = skb->decrypted;
+		is_encrypted = !is_decrypted;
+	} else {
+		is_decrypted = 0;
+		is_encrypted = 0;
 	}
 
 	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 61fbf84baf9e0..da95abbb7ea32 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -29,7 +29,8 @@ static void tls_strp_anchor_free(struct tls_strparser *strp)
 	struct skb_shared_info *shinfo = skb_shinfo(strp->anchor);
 
 	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
-	shinfo->frag_list = NULL;
+	if (!strp->copy_mode)
+		shinfo->frag_list = NULL;
 	consume_skb(strp->anchor);
 	strp->anchor = NULL;
 }
@@ -195,22 +196,22 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
 	for (i = 0; i < shinfo->nr_frags; i++)
 		__skb_frag_unref(&shinfo->frags[i], false);
 	shinfo->nr_frags = 0;
+	if (strp->copy_mode) {
+		kfree_skb_list(shinfo->frag_list);
+		shinfo->frag_list = NULL;
+	}
 	strp->copy_mode = 0;
+	strp->mixed_decrypted = 0;
 }
 
-static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
-			   unsigned int offset, size_t in_len)
+static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
+				struct sk_buff *in_skb, unsigned int offset,
+				size_t in_len)
 {
-	struct tls_strparser *strp = (struct tls_strparser *)desc->arg.data;
-	struct sk_buff *skb;
-	skb_frag_t *frag;
 	size_t len, chunk;
+	skb_frag_t *frag;
 	int sz;
 
-	if (strp->msg_ready)
-		return 0;
-
-	skb = strp->anchor;
 	frag = &skb_shinfo(skb)->frags[skb->len / PAGE_SIZE];
 
 	len = in_len;
@@ -228,10 +229,8 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		skb_frag_size_add(frag, chunk);
 
 		sz = tls_rx_msg_size(strp, skb);
-		if (sz < 0) {
-			desc->error = sz;
-			return 0;
-		}
+		if (sz < 0)
+			return sz;
 
 		/* We may have over-read, sz == 0 is guaranteed under-read */
 		if (unlikely(sz && sz < skb->len)) {
@@ -271,15 +270,99 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		offset += chunk;
 	}
 
-	if (strp->stm.full_len == skb->len) {
+read_done:
+	return in_len - len;
+}
+
+static int tls_strp_copyin_skb(struct tls_strparser *strp, struct sk_buff *skb,
+			       struct sk_buff *in_skb, unsigned int offset,
+			       size_t in_len)
+{
+	struct sk_buff *nskb, *first, *last;
+	struct skb_shared_info *shinfo;
+	size_t chunk;
+	int sz;
+
+	if (strp->stm.full_len)
+		chunk = strp->stm.full_len - skb->len;
+	else
+		chunk = TLS_MAX_PAYLOAD_SIZE + PAGE_SIZE;
+	chunk = min(chunk, in_len);
+
+	nskb = tls_strp_skb_copy(strp, in_skb, offset, chunk);
+	if (!nskb)
+		return -ENOMEM;
+
+	shinfo = skb_shinfo(skb);
+	if (!shinfo->frag_list) {
+		shinfo->frag_list = nskb;
+		nskb->prev = nskb;
+	} else {
+		first = shinfo->frag_list;
+		last = first->prev;
+		last->next = nskb;
+		first->prev = nskb;
+	}
+
+	skb->len += chunk;
+	skb->data_len += chunk;
+
+	if (!strp->stm.full_len) {
+		sz = tls_rx_msg_size(strp, skb);
+		if (sz < 0)
+			return sz;
+
+		/* We may have over-read, sz == 0 is guaranteed under-read */
+		if (unlikely(sz && sz < skb->len)) {
+			int over = skb->len - sz;
+
+			WARN_ON_ONCE(over > chunk);
+			skb->len -= over;
+			skb->data_len -= over;
+			__pskb_trim(nskb, nskb->len - over);
+
+			chunk -= over;
+		}
+
+		strp->stm.full_len = sz;
+	}
+
+	return chunk;
+}
+
+static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
+			   unsigned int offset, size_t in_len)
+{
+	struct tls_strparser *strp = (struct tls_strparser *)desc->arg.data;
+	struct sk_buff *skb;
+	int ret;
+
+	if (strp->msg_ready)
+		return 0;
+
+	skb = strp->anchor;
+	if (!skb->len)
+		skb_copy_decrypted(skb, in_skb);
+	else
+		strp->mixed_decrypted |= !!skb_cmp_decrypted(skb, in_skb);
+
+	if (IS_ENABLED(CONFIG_TLS_DEVICE) && strp->mixed_decrypted)
+		ret = tls_strp_copyin_skb(strp, skb, in_skb, offset, in_len);
+	else
+		ret = tls_strp_copyin_frag(strp, skb, in_skb, offset, in_len);
+	if (ret < 0) {
+		desc->error = ret;
+		ret = 0;
+	}
+
+	if (strp->stm.full_len && strp->stm.full_len == skb->len) {
 		desc->count = 0;
 
 		strp->msg_ready = 1;
 		tls_rx_msg_ready(strp);
 	}
 
-read_done:
-	return in_len - len;
+	return ret;
 }
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
-- 
2.39.2



