Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE770C788
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjEVTaj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjEVTaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C19E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E13C62907
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BD0C433D2;
        Mon, 22 May 2023 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783836;
        bh=fbxzqInkITKSMqsBoaiGjzyqNiJiQWutNagn9JJGvmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgNvxVa9zV30xxQuriH+Zw6MpAGY3AQnxZvu1OSlqgZ1Yrc/Og9/2X8GMbibzHvxT
         li2EUL2rCyjmNohwkzUn88DdTqblqQyvDlrRJDKsyK7kdmrHhxGH913RVklI7DLltK
         5W0NYgeE+slBe8QgNFP9nP/WuPfNhxRm2msFaJYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 151/292] xfrm: dont check the default policy if the policy allows the packet
Date:   Mon, 22 May 2023 20:08:28 +0100
Message-Id: <20230522190409.736532866@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 430cac487400494c19a8b85299e979bb07b4671f ]

The current code doesn't let a simple "allow" policy counteract a
default policy blocking all incoming packets:

    ip x p setdefault in block
    ip x p a src 192.168.2.1/32 dst 192.168.2.2/32 dir in action allow

At this stage, we have an allow policy (with or without transforms)
for this packet. It doesn't matter what the default policy says, since
the policy we looked up lets the packet through. The case of a
blocking policy is already handled separately, so we can remove this
check.

Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7f49dab3b6b59..bea48a73a7313 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3637,12 +3637,6 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		}
 		xfrm_nr = ti;
 
-		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK &&
-		    !xfrm_nr) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
-			goto reject;
-		}
-
 		if (npols > 1) {
 			xfrm_tmpl_sort(stp, tpp, xfrm_nr, family);
 			tpp = stp;
-- 
2.39.2



