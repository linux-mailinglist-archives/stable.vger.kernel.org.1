Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B57719E0C
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjFAN2S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjFAN2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F11192
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 972FA644D3
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC646C433D2;
        Thu,  1 Jun 2023 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626066;
        bh=8PxLH7uMhGIjLOjtRkRgDRDt/MoTg6Gwa1niyUtXc3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2J71docQLpv4/7k7M8odFYyC09ZshyFG5+HV9ZqkblFYR3VFYYy3RAa+/S/HuLAw0
         8W8CW7SBrQucYVRrv3hoKSQ7iZCXBP6ghkmnZY7qLk+cUjA3NOiFXTACYGhHvHwf4c
         WeMDKKDOsV5rzHr3u14rKOjClAtSU/4isIKcHMEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 08/42] tls: rx: strp: fix determining record length in copy mode
Date:   Thu,  1 Jun 2023 14:21:17 +0100
Message-Id: <20230601131939.425126927@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
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

[ Upstream commit 8b0c0dc9fbbd01e58a573a41c38885f9e4c17696 ]

We call tls_rx_msg_size(skb) before doing skb->len += chunk.
So the tls_rx_msg_size() code will see old skb->len, most
likely leading to an over-read.

Worst case we will over read an entire record, next iteration
will try to trim the skb but may end up turning frag len negative
or discarding the subsequent record (since we already told TCP
we've read it during previous read but now we'll trim it out of
the skb).

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_strp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 24016c865e004..9889df5ce0660 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -210,19 +210,28 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 					   skb_frag_size(frag),
 					   chunk));
 
-		sz = tls_rx_msg_size(strp, strp->anchor);
+		skb->len += chunk;
+		skb->data_len += chunk;
+		skb_frag_size_add(frag, chunk);
+
+		sz = tls_rx_msg_size(strp, skb);
 		if (sz < 0) {
 			desc->error = sz;
 			return 0;
 		}
 
 		/* We may have over-read, sz == 0 is guaranteed under-read */
-		if (sz > 0)
-			chunk =	min_t(size_t, chunk, sz - skb->len);
+		if (unlikely(sz && sz < skb->len)) {
+			int over = skb->len - sz;
+
+			WARN_ON_ONCE(over > chunk);
+			skb->len -= over;
+			skb->data_len -= over;
+			skb_frag_size_add(frag, -over);
+
+			chunk -= over;
+		}
 
-		skb->len += chunk;
-		skb->data_len += chunk;
-		skb_frag_size_add(frag, chunk);
 		frag++;
 		len -= chunk;
 		offset += chunk;
-- 
2.39.2



