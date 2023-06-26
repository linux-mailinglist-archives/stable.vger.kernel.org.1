Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4873E8FC
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjFZSbR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjFZSbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE71FD7
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E8960F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E5C433C8;
        Mon, 26 Jun 2023 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804250;
        bh=sSf0vIatUGAH0pQuqh6VfqVownHwOXL2AxjSa1+Qrag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmaDHk9wUZocg3zh4KXg8slI5VF6RBO5GZ9g1mWZ6QdhYZaofW56eVFH7Y87V5fvm
         lgG7lYCrY3Z1QwF0DrW9UtlXfUS2GyThJTki91JPqKtKsPsmlD5B1lE/y2koLoQC8w
         c1QGXEJWuIFYBRfJgGaaPJ2bh1t8nR3IEOENrICE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/170] xfrm: Linearize the skb after offloading if needed.
Date:   Mon, 26 Jun 2023 20:11:02 +0200
Message-ID: <20230626180804.747128181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit f015b900bc3285322029b4a7d132d6aeb0e51857 ]

With offloading enabled, esp_xmit() gets invoked very late, from within
validate_xmit_xfrm() which is after validate_xmit_skb() validates and
linearizes the skb if the underlying device does not support fragments.

esp_output_tail() may add a fragment to the skb while adding the auth
tag/ IV. Devices without the proper support will then send skb->data
points to with the correct length so the packet will have garbage at the
end. A pcap sniffer will claim that the proper data has been sent since
it parses the skb properly.

It is not affected with INET_ESP_OFFLOAD disabled.

Linearize the skb after offloading if the sending hardware requires it.
It was tested on v4, v6 has been adopted.

Fixes: 7785bba299a8d ("esp: Add a software GRO codepath")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4_offload.c | 3 +++
 net/ipv6/esp6_offload.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 3969fa805679c..ee848be59e65a 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -340,6 +340,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 242f4295940e6..fc6a5be732634 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -375,6 +375,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
-- 
2.39.2



