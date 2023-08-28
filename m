Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4798E78AA5D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjH1KVs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjH1KVJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5B125
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4285638DF
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1CC433C9;
        Mon, 28 Aug 2023 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218049;
        bh=CGr4istvhSNeofqGbgvpYxzFDFrt3FgjOSSaTuTsox0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8mrPp+MDy57U4mGm0PAyYPatMQBLTolbmyA563vVf8sziAgrDOTmWzGUS9Dcyihe
         pdDB2/clYJsbcGxK7aDAor0lBuQIgWZBYc0qVILG/qFrh+c6arQbPJmgV4ynPNM5sQ
         0bj38QEqdwwID3MB9zAqMNB/NhDGR6hVFY2tuh8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Golle <daniel@makrotopia.org>,
        Simon Horman <horms@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 037/129] net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset
Date:   Mon, 28 Aug 2023 12:11:56 +0200
Message-ID: <20230828101158.614649277@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 604204fcb321abe81238551936ecda5269e81076 ]

When a hardware reset is triggered on devices not initializing WED the
calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
pointer on uninitialized stack memory.
Break out of both functions in case a hw_list entry is 0.

Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete callbacks")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 985cff910f30c..3b651efcc25e1 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -221,9 +221,13 @@ void mtk_wed_fe_reset(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
 		int err;
 
+		if (!hw)
+			break;
+
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset)
 			continue;
 
@@ -244,8 +248,12 @@ void mtk_wed_fe_reset_complete(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
+
+		if (!hw)
+			break;
 
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset_complete)
 			continue;
 
-- 
2.40.1



