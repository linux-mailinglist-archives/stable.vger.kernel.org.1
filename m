Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDA7CAC45
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJPOwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPOwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB04AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13D8C433C8;
        Mon, 16 Oct 2023 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467940;
        bh=q0VM/riT0s38dZGFBsSTNN6Xru6X+oiPOxiA2Nd7T3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k25zbEKJTQMJP9yzk0+02tw9HqtPp/WBM/kC40hdBCSkNpjBKi2q7xVH5c6fGOTUB
         u6c4gc6MiuO8KYwqlYaONZVj3Z2G/w8iJWF3w7Rq2xBI9B4OF0g2cxdBEhzow6lRo3
         ggXXiJCzwbFiApXcpUuMiy9Lu8UqmW0prkaXfoLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 084/191] net: tcp: fix crashes trying to free half-baked MTU probes
Date:   Mon, 16 Oct 2023 10:41:09 +0200
Message-ID: <20231016084017.360802920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 71c299c711d1f44f0bf04f1fea66baad565240f1 ]

tcp_stream_alloc_skb() initializes the skb to use tcp_tsorted_anchor
which is a union with the destructor. We need to clean that
TCP-iness up before freeing.

Fixes: 736013292e3c ("tcp: let tcp_mtu_probe() build headless packets")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231010173651.3990234-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 37fd9537423f1..a8f58f5e99a77 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2441,6 +2441,7 @@ static int tcp_mtu_probe(struct sock *sk)
 
 	/* build the payload, and be prepared to abort if this fails. */
 	if (tcp_clone_payload(sk, nskb, probe_size)) {
+		tcp_skb_tsorted_anchor_cleanup(nskb);
 		consume_skb(nskb);
 		return -1;
 	}
-- 
2.40.1



