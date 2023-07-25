Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF50761393
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjGYLLk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjGYLL0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4741BD9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84DBF6165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B7C433C7;
        Tue, 25 Jul 2023 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283444;
        bh=8NFxaijFKs4/2ZNVK+BGO4u8DhMMqn+PRnQWTKk6JHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+7zwFNQtrZM77g2mc7f9C5mVouvKF9lBX7YGLGKi4uwZbv5kUO+vAgRz8CrbU4At
         W4EsRkpK1UePnf5K4CZTmUacR7JiNVGyRGOjKavWBWxSvD1x2aulk9kwnT2k45LTpm
         NV0erQKw9uD+N2YIzAM+3VDhRKb7vnrMoAUUp9eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 78/78] nixge: fix mac address error handling again
Date:   Tue, 25 Jul 2023 12:47:09 +0200
Message-ID: <20230725104454.302083573@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit a68229ca634066975fff6d4780155bd2eb14a82a upstream.

The change to eth_hw_addr_set() caused gcc to correctly spot a
bug that was introduced in an earlier incorrect fix:

In file included from include/linux/etherdevice.h:21,
                 from drivers/net/ethernet/ni/nixge.c:7:
In function '__dev_addr_set',
    inlined from 'eth_hw_addr_set' at include/linux/etherdevice.h:319:2,
    inlined from 'nixge_probe' at drivers/net/ethernet/ni/nixge.c:1286:3:
include/linux/netdevice.h:4648:9: error: 'memcpy' reading 6 bytes from a region of size 0 [-Werror=stringop-overread]
 4648 |         memcpy(dev->dev_addr, addr, len);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As nixge_get_nvmem_address() can return either NULL or an error
pointer, the NULL check is wrong, and we can end up reading from
ERR_PTR(-EOPNOTSUPP), which gcc knows to contain zero readable
bytes.

Make the function always return an error pointer again but fix
the check to match that.

Fixes: f3956ebb3bf0 ("ethernet: use eth_hw_addr_set() instead of ether_addr_copy()")
Fixes: abcd3d6fc640 ("net: nixge: Fix error path for obtaining mac address")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ni/nixge.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1211,7 +1211,7 @@ static void *nixge_get_nvmem_address(str
 
 	cell = nvmem_cell_get(dev, "address");
 	if (IS_ERR(cell))
-		return NULL;
+		return cell;
 
 	mac = nvmem_cell_read(cell, &cell_size);
 	nvmem_cell_put(cell);
@@ -1284,7 +1284,7 @@ static int nixge_probe(struct platform_d
 	ndev->max_mtu = NIXGE_JUMBO_MTU;
 
 	mac_addr = nixge_get_nvmem_address(&pdev->dev);
-	if (mac_addr && is_valid_ether_addr(mac_addr)) {
+	if (!IS_ERR(mac_addr) && is_valid_ether_addr(mac_addr)) {
 		eth_hw_addr_set(ndev, mac_addr);
 		kfree(mac_addr);
 	} else {


