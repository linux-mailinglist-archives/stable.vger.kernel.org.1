Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6E77587D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjHIKxQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjHIKxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF32D4A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68ED763126
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744AEC433C7;
        Wed,  9 Aug 2023 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578256;
        bh=nLoFPEg4TGxg/UPaFhZXvS/2CB0UebmfFKASio1QZcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCBZ1bxG2vd+L39cRN3i0LmRrdnKdg6iW/K9c+NWVKCQ4geYAXzp4f32AoE5GmfYI
         YL9sQmAHQ4opSsXd1k5A1EK1jL+bJD9Y7fMDMJ3aoj44hIJclGE08ptZLtrdXsHelu
         WEqWJzEnfUkFvxP+1VeEw9CZpiYWI9C7J28VLmbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 132/165] sunvnet: fix sparc64 build error after gso code split
Date:   Wed,  9 Aug 2023 12:41:03 +0200
Message-ID: <20230809103647.132815854@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

commit d9ffa069e006fa2873b94fbf2387546942d4f85b upstream.

After merging the net-next tree, today's linux-next build (sparc64
defconfig) failed like this:

drivers/net/ethernet/sun/sunvnet_common.c: In function 'vnet_handle_offloads':
drivers/net/ethernet/sun/sunvnet_common.c:1277:16: error: implicit declaration of function 'skb_gso_segment'; did you mean 'skb_gso_reset'? [-Werror=implicit-function-declaration]
 1277 |         segs = skb_gso_segment(skb, dev->features & ~NETIF_F_TSO);
      |                ^~~~~~~~~~~~~~~
      |                skb_gso_reset
drivers/net/ethernet/sun/sunvnet_common.c:1277:14: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
 1277 |         segs = skb_gso_segment(skb, dev->features & ~NETIF_F_TSO);
      |              ^

Fixes: d457a0e329b0 ("net: move gso declarations and functions to their own files")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230613164639.164b2991@canb.auug.org.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/sunvnet_common.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <net/ip.h>
+#include <net/gso.h>
 #include <net/icmp.h>
 #include <net/route.h>
 


