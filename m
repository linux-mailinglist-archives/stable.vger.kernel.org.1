Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E369978AC2A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjH1Kht (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjH1KhP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D29A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FAF63F25
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D827C433C8;
        Mon, 28 Aug 2023 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219031;
        bh=37UlUW5qEBmm5mgatx9mThVnt8CWCTx5bB6Hy5dNST0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxB3rNa9JaGN5//JQtnyNm8Izzek6bJa3XP7zGJfCmkznuHbCZDwuz0U1xnt0ivLY
         8r75tOMJnA1rSy337LdP0GeILaT061P32V+zjhwrt5H+vo2aj/HGwyOAwrzMcFVLik
         K7q6E+AvVe6oOm8P1uiLpbhFC6vE2v8MppbyU8gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vijay Khemka <vijaykhemka@fb.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/158] net/ncsi: Fix gma flag setting after response
Date:   Mon, 28 Aug 2023 12:12:26 +0200
Message-ID: <20230828101158.997892908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vijay Khemka <vijaykhemka@fb.com>

[ Upstream commit 9e860947d8d7a1504476ac49abfce90a4ce600f3 ]

gma_flag was set at the time of GMA command request but it should
only be set after getting successful response. Movinng this flag
setting in GMA response handler.

This flag is used mainly for not repeating GMA command once
received MAC address.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/ncsi-manage.c | 3 ---
 net/ncsi/ncsi-rsp.c    | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 9bd12f7517ed5..6710f6b8764be 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -770,9 +770,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
 		return -1;
 	}
 
-	/* Set the flag for GMA command which should only be called once */
-	nca->ndp->gma_flag = 1;
-
 	/* Get Mac address from NCSI device */
 	return nch->handler(nca);
 }
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 7c893c3799202..e1c6bb4ab98fd 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -627,6 +627,9 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
 	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	/* Set the flag for GMA command which should only be called once */
+	ndp->gma_flag = 1;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
@@ -671,6 +674,9 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
 		return -ENXIO;
 
+	/* Set the flag for GMA command which should only be called once */
+	ndp->gma_flag = 1;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-- 
2.40.1



