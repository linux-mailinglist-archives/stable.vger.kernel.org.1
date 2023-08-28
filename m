Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0078AD1B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjH1Kpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjH1Kp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBDCD7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089E8641F4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F49C433C9;
        Mon, 28 Aug 2023 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219465;
        bh=yBYDjRJf+mEO6t3p+k352pY3cMmhu+AHDD8xUDp9P7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2v0BKDoA5IVTuUCH/DO0+XIodJF3CkfSFDBPjlnVp/Jtfj2vpm7lTFNCsf31OW63B
         IRKK+hgfK0/nnu8q+2lQO2aqLGfzZO4bEQ6/XdXI1W7aL/NrIp3RntQz9+Vvi+x/ZQ
         Z1F2P5KvAMrl1SBjMK8SdpCrohvM2jIS4pdYhHXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Fertser <fercerpav@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 45/89] net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
Date:   Mon, 28 Aug 2023 12:13:46 +0200
Message-ID: <20230828101151.684010399@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mikhaylov <fr0st61te@gmail.com>

commit 790071347a0a1a89e618eedcd51c687ea783aeb3 upstream.

Change ndo_set_mac_address to dev_set_mac_address because
dev_set_mac_address provides a way to notify network layer about MAC
change. In other case, services may not aware about MAC change and keep
using old one which set from network adapter driver.

As example, DHCP client from systemd do not update MAC address without
notification from net subsystem which leads to the problem with acquiring
the right address from DHCP server.

Fixes: cb10c7c0dfd9e ("net/ncsi: Add NCSI Broadcom OEM command")
Cc: stable@vger.kernel.org # v6.0+ 2f38e84 net/ncsi: make one oem_gma function for all mfr id
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ncsi/ncsi-rsp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -616,7 +616,6 @@ static int ncsi_rsp_handler_oem_gma(stru
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
@@ -643,7 +642,9 @@ static int ncsi_rsp_handler_oem_gma(stru
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	rtnl_lock();
+	ret = dev_set_mac_address(ndev, &saddr, NULL);
+	rtnl_unlock();
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 


