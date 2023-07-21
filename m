Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C875D390
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGUTMK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGUTMJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FAE4C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C14061D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF52C433C9;
        Fri, 21 Jul 2023 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966727;
        bh=M+m7MiydM2ia4HSXZj21M/dC1iZRWupB58WripmwcL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ou8tvHNzpiCLR9aknctM95iuAE44Slh1OnkLfd59e8oUmJ5Ct1jSo1aZrPxJ3gFfM
         faIb8ToqzpLpOkM3TlC/FpGLIzEj4zqRou74Noz+kc4OHf/NIhHMqyb57sebsOGRl4
         tKbCYYW6cHBn/Ovbw65d1PHXUP6MLUzk9MxoBeq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 439/532] net/sched: make psched_mtu() RTNL-less safe
Date:   Fri, 21 Jul 2023 18:05:43 +0200
Message-ID: <20230721160638.374585958@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 150e33e62c1fa4af5aaab02776b6c3812711d478 ]

Eric Dumazet says[1]:
-------
Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
without holding RTNL, so dev->mtu can be changed underneath.
KCSAN could issue a warning.
-------

Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.

[1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/

v1 -> v2: Fix commit message

Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230711021634.561598-1-pctammela@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/pkt_sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9cd2d4e84913f..d0d9dd2483dd3 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -141,7 +141,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
-- 
2.39.2



