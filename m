Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E76FABC7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjEHLRW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjEHLRW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6437614
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26BD62C07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64D0C433D2;
        Mon,  8 May 2023 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544640;
        bh=iBQ2AIKwdWgzI+9WWtgwn2oqfxhdlTiE1npyAcAZv68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inQvZf06gN4+OkDIuJqY0haBFFsbA8kzkT2Xa33aDKFRY15bU/hDvwn1xIywehWOn
         1w+pe/vXvuuSIuWIMATrJO59HvdMcsL4DCkjLPhKVib0uORvqzHEwHt8at2uSvNwq2
         uRrSRgkJBLeGf9805JmuEckAfjELiddAflz4sqGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 474/694] net: dpaa: Fix uninitialized variable in dpaa_stop()
Date:   Mon,  8 May 2023 11:45:09 +0200
Message-Id: <20230508094449.192807597@linuxfoundation.org>
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
index 9318a2554056d..f961966171210 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -299,7 +299,8 @@ static int dpaa_stop(struct net_device *net_dev)
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



