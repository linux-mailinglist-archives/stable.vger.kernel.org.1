Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F278ABB2
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjH1Kdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjH1KdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145EE43
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D46163D71
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E72DC433C7;
        Mon, 28 Aug 2023 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218772;
        bh=/MEV30OOwz3UNR5faw0PkjLTROE/wzzcEsXSZ/yOmR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjXTNVUAaqPbyENUwl4/iVGBOzYLNQ+jva8KB3WzY7Ls2stksP9mU1e0oWVvgNXX8
         ZlDFSrWK9+kf1vFoqY+Y86HO23xWg8Gaxm7wi8PJj9qW4L/rJ9MtDQ+egZ0iOH/DP1
         pO+iICOj+pRjU4TdtzNoDSBnkvS7NCxuUyA/WuEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6.1 077/122] batman-adv: Trigger events for auto adjusted MTU
Date:   Mon, 28 Aug 2023 12:13:12 +0200
Message-ID: <20230828101158.979412393@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit c6a953cce8d0438391e6da48c8d0793d3fbfcfa6 upstream.

If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
.ndo_change_mtu based changes because core networking code took care of it.
But for auto-adjustments after hard-interfaces changes, these events were
simply missing.

Due to this problem, non-batman-adv components weren't aware of MTU changes
and thus couldn't perform their own tasks correctly.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/hard-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,7 @@ out:
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.


