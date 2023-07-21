Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93F75D3FF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGUTQk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGUTQk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC261FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E75361D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22380C433C8;
        Fri, 21 Jul 2023 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966998;
        bh=HOHt3h1k6j4IvmVeEXjr5UPiomF3r1nFxGNIIV+CHsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Yjb47b2ODRdKHB8qPZOQw037Hczx2GJSpQsHM+fY6hosnQMbO3KW3b4BnbnDvYQa
         osz1qCY5RGFpjVoguH149eFQiUeJ5pf1LvGPkfLYKEZbJmpkGtQjDx57Dn0ih9fByV
         130dTs9BnJ97hSkwctXyCLVDIjtR1VQ5ItqeJgYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Fertser <fercerpav@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 001/223] net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
Date:   Fri, 21 Jul 2023 18:04:14 +0200
Message-ID: <20230721160520.933089261@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
@@ -616,7 +616,6 @@ static int ncsi_rsp_handler_oem_mlx_gma(
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	int ret = 0;
@@ -630,7 +629,9 @@ static int ncsi_rsp_handler_oem_mlx_gma(
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	rtnl_lock();
+	ret = dev_set_mac_address(ndev, &saddr, NULL);
+	rtnl_unlock();
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 


