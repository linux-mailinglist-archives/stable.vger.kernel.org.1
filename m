Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFA7ECD74
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjKOTgm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjKOTgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44119F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FD4C433C8;
        Wed, 15 Nov 2023 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076993;
        bh=Ljni98DJiBdWATp82nboyq3nvQ947Ki+3eCplWv92ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHxdK2oZ7e0izkwqvHnS0ov5kNtWwpDFPsxx8vsf18ewnllJIMkDho2DfqWWz5PKp
         dbN1y4GS4GdYh018GMh4Tweb4t/jcHmaRMqeoL9liCZeOZ2NK7tP4MzZD+wI45AvNe
         86C03iaFEDpWWwqloBBNDPVyr7VbxJgxu8Okt0pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Bianconi <lorenzo@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 072/603] net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
Date:   Wed, 15 Nov 2023 14:10:17 -0500
Message-ID: <20231115191618.097667035@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit c80471ba74b7f332ac19b985ccb76d852d507acf ]

Fix MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH and
MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH definitions for MT7986 (MT7986 is
the only SoC to use them).

Fixes: de84a090d99a ("net: ethernet: mtk_eth_wed: add wed support for mt7986 chipset")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 47ea69feb3b24..f87ab9b8a5901 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -64,8 +64,8 @@ struct mtk_wdma_desc {
 #define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
-#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
-#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(10) /* wed v2 */
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(11) /* wed v2 */
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR	BIT(17)
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT		BIT(18)
-- 
2.42.0



