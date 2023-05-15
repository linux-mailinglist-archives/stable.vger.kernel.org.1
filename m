Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC470384A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbjEORb3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbjEORak (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290C13C20
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CFB62D0F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6EFC433D2;
        Mon, 15 May 2023 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171641;
        bh=0AuSUziIZiY/+fob6rYligxFOFb6HxLolJjGmTrbkuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVduXU2mYENKWZeoc0jjic3uYTCxDIwSaODDJ84WnMs+OpKCw+GHVAtxS/8UR79t/
         wTckRoPQNlcqcoughnLzCszApVTM/BTHUoHYoUIGg3uJFJ2CqJO859PerxLN4ubu7L
         Msq7UE1QtXvy9SDZuLV1mb3HBYgEPPjdVPF1Y7xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 031/134] r8152: move setting r8153b_rx_agg_chg_indicate()
Date:   Mon, 15 May 2023 18:28:28 +0200
Message-Id: <20230515161704.103938201@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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
index b0e1ef97c4951..579524cb5d9b2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3020,12 +3020,16 @@ static int rtl_enable(struct r8152 *tp)
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
 
@@ -3079,7 +3083,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -3113,7 +3116,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.39.2



