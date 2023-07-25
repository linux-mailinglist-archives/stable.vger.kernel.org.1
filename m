Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDE7615D6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjGYLdp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjGYLdo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315C11B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF66D61691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB739C433C7;
        Tue, 25 Jul 2023 11:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284822;
        bh=VDce9/O6/Nb2vslHENbVXD/CwRk4e7GR8lqEDzkm6q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlHqrGjvhmIzpNZ3zXuGq3pY2Fm/e2pP8zIg6Gz4KIafIY7ppsZJVJIRRsRQyL9v5
         FVou8XTSOky6turtZY+Zglg7Q8BHwrwQ3yt16RMcyixeDrwhemfwEPU6EAo5Bc5Aq5
         3Dtw7XCTBfrnesQ3Lvqv/py4aC9q8WABdYp9q2FQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 493/509] tcp: annotate data-races around tp->tcp_tx_delay
Date:   Tue, 25 Jul 2023 12:47:12 +0200
Message-ID: <20230725104616.326348404@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 348b81b68b13ebd489a3e6a46aa1c384c731c919 ]

do_tcp_getsockopt() reads tp->tcp_tx_delay while another cpu
might change its value.

Fixes: a842fe1425cb ("tcp: add optional per socket transmit delay")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cc42ceadc1127..39919d1436cea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3447,7 +3447,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_TX_DELAY:
 		if (val)
 			tcp_enable_tx_delay();
-		tp->tcp_tx_delay = val;
+		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
 		err = -ENOPROTOOPT;
@@ -3902,7 +3902,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TX_DELAY:
-		val = tp->tcp_tx_delay;
+		val = READ_ONCE(tp->tcp_tx_delay);
 		break;
 
 	case TCP_TIMESTAMP:
-- 
2.39.2



