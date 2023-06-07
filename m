Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A323B726EF8
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjFGUy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjFGUyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700691FE5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE826647B5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E7BC4339C;
        Wed,  7 Jun 2023 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171246;
        bh=/eoaW3P9E+ErBYCcLMXMWB0xr1a7FzmUtzq0etIXhCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itd2MLE6ZxstEpYi9xMURaSHCtCQHwTiQtdXwLHMBv2Pa/0faLge3SOuB0m2+CHnV
         cZPaIWch1nu02Ew3TB/QbC39P8sHdPdTKMa3R49MYd8psQ3Tg84VilbjKlSKcPxORQ
         pL6DXXkRxrhYR4Hb8hZVZrF9IpyfDC4ivbAB5/EA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jack Yang <mingliang@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Cambda Zhu <cambda@linux.alibaba.com>,
        Jason Xing <kerneljasonxing@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 15/99] tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set
Date:   Wed,  7 Jun 2023 22:16:07 +0200
Message-ID: <20230607200900.731642486@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cambda Zhu <cambda@linux.alibaba.com>

[ Upstream commit 34dfde4ad87b84d21278a7e19d92b5b2c68e6c4d ]

This patch replaces the tp->mss_cache check in getting TCP_MAXSEG
with tp->rx_opt.user_mss check for CLOSE/LISTEN sock. Since
tp->mss_cache is initialized with TCP_MSS_DEFAULT, checking if
it's zero is probably a bug.

With this change, getting TCP_MAXSEG before connecting will return
default MSS normally, and return user_mss if user_mss is set.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Jack Yang <mingliang@linux.alibaba.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+3kL9pYtkxkwxwNMzvC_w3LNUum_2=3u+UyLBmGmifHA@mail.gmail.com/#t
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Link: https://lore.kernel.org/netdev/14D45862-36EA-4076-974C-EA67513C92F6@linux.alibaba.com/
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230527040317.68247-1-cambda@linux.alibaba.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e427eabc7f278..fdf2ddc4864df 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3451,7 +3451,8 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-		if (!val && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		if (tp->rx_opt.user_mss &&
+		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 			val = tp->rx_opt.user_mss;
 		if (tp->repair)
 			val = tp->rx_opt.mss_clamp;
-- 
2.39.2



