Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB2719DC5
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjFAN0X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjFAN0F (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A5125
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18A664435
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB7C433EF;
        Thu,  1 Jun 2023 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625948;
        bh=LOj8PO2IKk4isEWSiuS7dpvXhrsKiGN/aU7Iwv3lRpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgYObuu2flOMxK9AGcx5pDJhDgjAyKxG6ZGM7bgE8ASeL8aWQN7pbDUAcAViz2DO4
         7cAFkw5lD6xo72SqlGY+/XoRhrYp2Mf/haEK7zNnH3kP51Fyyq3muMIvuWMfgEEb93
         d1//geJm4grcMosa/dayKbe4hSOj8NiBCSXcbTMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 15/45] tls: rx: strp: factor out copying skb data
Date:   Thu,  1 Jun 2023 14:21:11 +0100
Message-Id: <20230601131939.406712918@linuxfoundation.org>
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

[ Upstream commit c1c607b1e5d5477d82ca6a86a05a4f10907b33ee ]

We'll need to copy input skbs individually in the next patch.
Factor that code out (without assuming we're copying a full record).

Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: eca9bfafee3a ("tls: rx: strp: preserve decryption status of skbs when needed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_strp.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index e2e48217e7ac9..61fbf84baf9e0 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -34,31 +34,44 @@ static void tls_strp_anchor_free(struct tls_strparser *strp)
 	strp->anchor = NULL;
 }
 
-/* Create a new skb with the contents of input copied to its page frags */
-static struct sk_buff *tls_strp_msg_make_copy(struct tls_strparser *strp)
+static struct sk_buff *
+tls_strp_skb_copy(struct tls_strparser *strp, struct sk_buff *in_skb,
+		  int offset, int len)
 {
-	struct strp_msg *rxm;
 	struct sk_buff *skb;
-	int i, err, offset;
+	int i, err;
 
-	skb = alloc_skb_with_frags(0, strp->stm.full_len, TLS_PAGE_ORDER,
+	skb = alloc_skb_with_frags(0, len, TLS_PAGE_ORDER,
 				   &err, strp->sk->sk_allocation);
 	if (!skb)
 		return NULL;
 
-	offset = strp->stm.offset;
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		WARN_ON_ONCE(skb_copy_bits(strp->anchor, offset,
+		WARN_ON_ONCE(skb_copy_bits(in_skb, offset,
 					   skb_frag_address(frag),
 					   skb_frag_size(frag)));
 		offset += skb_frag_size(frag);
 	}
 
-	skb->len = strp->stm.full_len;
-	skb->data_len = strp->stm.full_len;
-	skb_copy_header(skb, strp->anchor);
+	skb->len = len;
+	skb->data_len = len;
+	skb_copy_header(skb, in_skb);
+	return skb;
+}
+
+/* Create a new skb with the contents of input copied to its page frags */
+static struct sk_buff *tls_strp_msg_make_copy(struct tls_strparser *strp)
+{
+	struct strp_msg *rxm;
+	struct sk_buff *skb;
+
+	skb = tls_strp_skb_copy(strp, strp->anchor, strp->stm.offset,
+				strp->stm.full_len);
+	if (!skb)
+		return NULL;
+
 	rxm = strp_msg(skb);
 	rxm->offset = 0;
 	return skb;
-- 
2.39.2



