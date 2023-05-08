Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED66FA557
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjEHKI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjEHKIZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C823290F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D299D60F3A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F61C433EF;
        Mon,  8 May 2023 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540503;
        bh=4pi3Kl3JtxXjd+LQHSaOy8cyfcfjNs/hFBttoJ+VXdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2utQmb1nxtJ28cYa9r1zFtuSyUq/CSFnQwybsk6NRz4QJ35/6DAVU8EeZJL6pUY7
         APpqhkyOOIyegGkfjRg6H4PCgz7bJi6Tw1SToJ2ojMQqMMPTyKFyvgGicJ5kwGT6AV
         UuEJYBt50qPzg+RqWraL+NW9hPSkLiDU7vEhM3mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 390/611] net: dpaa: Fix uninitialized variable in dpaa_stop()
Date:   Mon,  8 May 2023 11:43:52 +0200
Message-Id: <20230508094434.966895033@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 461bb5b97049a149278f2c27a3aa12af16da6a2e ]

The return value is not initialized on the success path.

Fixes: 901bdff2f529 ("net: fman: Change return type of disable to void")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/8c9dc377-8495-495f-a4e5-4d2d0ee12f0c@kili.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index d8fb7d4ebd51e..981cc32480474 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -283,7 +283,8 @@ static int dpaa_stop(struct net_device *net_dev)
 {
 	struct mac_device *mac_dev;
 	struct dpaa_priv *priv;
-	int i, err, error;
+	int i, error;
+	int err = 0;
 
 	priv = netdev_priv(net_dev);
 	mac_dev = priv->mac_dev;
-- 
2.39.2



