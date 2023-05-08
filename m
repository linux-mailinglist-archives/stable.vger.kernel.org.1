Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E806FAA3B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjEHLA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjEHLAV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FF30AF0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C7462A06
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D94AC433D2;
        Mon,  8 May 2023 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543541;
        bh=XKmx4AqyYTLec9xfWqdBiLAs+9S9/CApIyw0O1o60J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAjIldJ2B/IHNS0gd34xVhToB/rC1mNP0M94etc3l095UpME73+qxHHX7UDWNWvf5
         f7qxXuLhycjlwVWILB1U26oibQjzMCK4zjCCwRiSOh5iUo6USzMqbO8eVTvke3eict
         IfuOND3oc5gyCZvt4pYnAJXUbbg8XpIoA1Etw9Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Huanhuan Wang <huanhuan.wang@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 124/694] nfp: fix incorrect pointer deference when offloading IPsec with bonding
Date:   Mon,  8 May 2023 11:39:19 +0200
Message-Id: <20230508094436.494646437@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Huanhuan Wang <huanhuan.wang@corigine.com>

commit 63cfd210034c772fad047afa13dd5a4664b0a72e upstream.

There are two pointers in struct xfrm_dev_offload, *dev, *real_dev.
The *dev points whether bonding interface or real interface, if
bonding IPsec offload is used, it points bonding interface; if not,
it points real interface. And *real_dev always points real interface.
So nfp should always use real_dev instead of dev.

Prior to this change the system becomes unresponsive when offloading
IPsec for a device which is a lower device to a bonding device.

Fixes: 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
CC: stable@vger.kernel.org
Signed-off-by: Huanhuan Wang <huanhuan.wang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20230420140125.38521-1-louis.peens@corigine.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -269,7 +269,7 @@ static void set_sha2_512hmac(struct nfp_
 static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 				  struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xso.dev;
+	struct net_device *netdev = x->xso.real_dev;
 	struct nfp_ipsec_cfg_mssg msg = {};
 	int i, key_len, trunc_len, err = 0;
 	struct nfp_ipsec_cfg_add_sa *cfg;
@@ -513,7 +513,7 @@ static void nfp_net_xfrm_del_state(struc
 		.cmd = NFP_IPSEC_CFG_MSSG_INV_SA,
 		.sa_idx = x->xso.offload_handle - 1,
 	};
-	struct net_device *netdev = x->xso.dev;
+	struct net_device *netdev = x->xso.real_dev;
 	struct nfp_net *nn;
 	int err;
 


