Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BBB719DC2
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjFAN0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjFANZ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9C1AE
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9484064487
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD607C433EF;
        Thu,  1 Jun 2023 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625941;
        bh=HvYB3sTj+zEtPV5oF6dRSGstJrS4nBdZFsPZM6m4bRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCGs/MRU7L/xGNhFNTDwjDGOBPgYkBIMKvYk2ffZqm2oYxsjIIz8tf/7CiDb9IVWG
         1PURiWVquJV7I+Mgww8ytsbgVgzHZ00Aa6SxTGiZWSjuLUIXFFXdzhK3Lonj5I5jN5
         +w2g57xbeGiLr4cX2jze94myT9+Pz03f2xKMFnE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 12/45] tls: rx: strp: set the skb->len of detached / CoWed skbs
Date:   Thu,  1 Jun 2023 14:21:08 +0100
Message-Id: <20230601131939.270419067@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 210620ae44a83f25220450bbfcc22e6fe986b25f ]

alloc_skb_with_frags() fills in page frag sizes but does not
set skb->len and skb->data_len. Set those correctly otherwise
device offload will most likely generate an empty skb and
hit the BUG() at the end of __skb_nsg().

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_strp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 955ac3e0bf4d3..24016c865e004 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -56,6 +56,8 @@ static struct sk_buff *tls_strp_msg_make_copy(struct tls_strparser *strp)
 		offset += skb_frag_size(frag);
 	}
 
+	skb->len = strp->stm.full_len;
+	skb->data_len = strp->stm.full_len;
 	skb_copy_header(skb, strp->anchor);
 	rxm = strp_msg(skb);
 	rxm->offset = 0;
-- 
2.39.2



