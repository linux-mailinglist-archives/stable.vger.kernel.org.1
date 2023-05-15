Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6D703630
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbjEORHl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbjEORHP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0426DC56
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBAB62ACC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20279C433EF;
        Mon, 15 May 2023 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170303;
        bh=EXFqXdXwVAsr36WwgbkX5Eo9j0ymXd0jAADfZQlwtuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qowYTArXlUnGyZNqM2/0MNf1HWhe7NKzSM4msviIkopx2FTOUlYiVHt1Imj/QL9le
         jDeBaKf3CIODUzVhP/fXt2yxyy240JFokzdM9MHJ5oBKiJaSdMWwG+j3jPIjGINC6D
         TW2Lf5VgHgCw4uNxTRqu9zmZygFlk05fAM05dl8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/239] r8152: move setting r8153b_rx_agg_chg_indicate()
Date:   Mon, 15 May 2023 18:25:22 +0200
Message-Id: <20230515161723.472290072@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit cce8334f4aacd9936309a002d4a4de92a07cd2c2 ]

Move setting r8153b_rx_agg_chg_indicate() for 2.5G devices. The
r8153b_rx_agg_chg_indicate() has to be called after enabling tx/rx.
Otherwise, the coalescing settings are useless.

Fixes: 195aae321c82 ("r8152: support new chips")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index a7665accc81c8..059d610901d84 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3027,12 +3027,16 @@ static int rtl_enable(struct r8152 *tp)
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
 
 	switch (tp->version) {
-	case RTL_VER_08:
-	case RTL_VER_09:
-	case RTL_VER_14:
-		r8153b_rx_agg_chg_indicate(tp);
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
 		break;
 	default:
+		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	}
 
@@ -3086,7 +3090,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -3120,7 +3123,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.39.2



