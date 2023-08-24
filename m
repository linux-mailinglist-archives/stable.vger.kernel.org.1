Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712627872BC
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHXO4o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbjHXO4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C41BC6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44C7563B14
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E01C433C7;
        Thu, 24 Aug 2023 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888973;
        bh=9G0h2QenOIxlAzyntXH5r4u7ATU6xkZBQNIqy9Egt4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D139mF1IURS7mEsWy10tj3o68mJtZyVG2zOoHl5EBKuUvdJ/v5iSVNHBSaWZqbMbx
         miO+17VTkWVTQZu5jrOCyYLSiX3IKMs63nALfRcf1AA2Bw9XE4StcNOQhu7AP9mO9k
         oFVrOcdEpDxR9bULYFhIm/e5RMy7rJ7HOPEtLkMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/139] net: af_key: fix sadb_x_filter validation
Date:   Thu, 24 Aug 2023 16:50:03 +0200
Message-ID: <20230824145027.118785520@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 75065a8929069bc93181848818e23f147a73f83a ]

When running xfrm_state_walk_init(), the xfrm_address_filter being used
is okay to have a splen/dplen that equals to sizeof(xfrm_address_t)<<3.
This commit replaces >= to > to make sure the boundary checking is
correct.

Fixes: 37bd22420f85 ("af_key: pfkey_dump needs parameter validation")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/key/af_key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index d34fed1a484a7..258fa046f440d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1848,9 +1848,9 @@ static int pfkey_dump(struct sock *sk, struct sk_buff *skb, const struct sadb_ms
 	if (ext_hdrs[SADB_X_EXT_FILTER - 1]) {
 		struct sadb_x_filter *xfilter = ext_hdrs[SADB_X_EXT_FILTER - 1];
 
-		if ((xfilter->sadb_x_filter_splen >=
+		if ((xfilter->sadb_x_filter_splen >
 			(sizeof(xfrm_address_t) << 3)) ||
-		    (xfilter->sadb_x_filter_dplen >=
+		    (xfilter->sadb_x_filter_dplen >
 			(sizeof(xfrm_address_t) << 3))) {
 			mutex_unlock(&pfk->dump_lock);
 			return -EINVAL;
-- 
2.40.1



