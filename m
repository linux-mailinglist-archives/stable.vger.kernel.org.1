Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1806FA777
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjEHKar (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjEHKan (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEFE72C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93282626CF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B1CC433EF;
        Mon,  8 May 2023 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541841;
        bh=XWG19OrXHotSvNPbXH+zJ8nVDfaw5KTqABFpEFd8XZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rql5i9Ne/+Y3i1hlWf9gU61kGYx29fV6zAIfi/1m/Ia0fV4+8kB0tuHqkpdPlCPQG
         1xvXdMsarTX9BARsX6vBJ7FIBDeUB51KB5+Rr0exbH3hEsq9NjvSDZaV/O/kSm+n8g
         7cdZCL/UNNNVfjCeyhNi6xWIFI8Rwy5KoBgUyQ1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xinlei Lee <xinlei.lee@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 209/663] drm/mediatek: dp: Change the aux retries times when receiving AUX_DEFER
Date:   Mon,  8 May 2023 11:40:35 +0200
Message-Id: <20230508094435.141546989@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Xinlei Lee <xinlei.lee@mediatek.com>

[ Upstream commit 9243d70e05c5989f84f840612965f96b524da925 ]

DP 1.4a Section 2.8.7.1.5.6.1:
A DP Source device shall retry at least seven times upon receiving
AUX_DEFER before giving up the AUX transaction.

The drm_dp_i2c_do_msg() function in the drm_dp_helper.c file will
judge the status of the msg->reply parameter passed to aux_transfer
for different processing.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/1680072203-10394-1-git-send-email-xinlei.lee@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d28326350ea93..007af69e5026f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -806,10 +806,9 @@ static int mtk_dp_aux_wait_for_completion(struct mtk_dp *mtk_dp, bool is_read)
 }
 
 static int mtk_dp_aux_do_transfer(struct mtk_dp *mtk_dp, bool is_read, u8 cmd,
-				  u32 addr, u8 *buf, size_t length)
+				  u32 addr, u8 *buf, size_t length, u8 *reply_cmd)
 {
 	int ret;
-	u32 reply_cmd;
 
 	if (is_read && (length > DP_AUX_MAX_PAYLOAD_BYTES ||
 			(cmd == DP_AUX_NATIVE_READ && !length)))
@@ -841,10 +840,10 @@ static int mtk_dp_aux_do_transfer(struct mtk_dp *mtk_dp, bool is_read, u8 cmd,
 	/* Wait for feedback from sink device. */
 	ret = mtk_dp_aux_wait_for_completion(mtk_dp, is_read);
 
-	reply_cmd = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3624) &
-		    AUX_RX_REPLY_COMMAND_AUX_TX_P0_MASK;
+	*reply_cmd = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3624) &
+		     AUX_RX_REPLY_COMMAND_AUX_TX_P0_MASK;
 
-	if (ret || reply_cmd) {
+	if (ret) {
 		u32 phy_status = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3628) &
 				 AUX_RX_PHY_STATE_AUX_TX_P0_MASK;
 		if (phy_status != AUX_RX_PHY_STATE_AUX_TX_P0_RX_IDLE) {
@@ -2071,7 +2070,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 		ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
 					     msg->address + accessed_bytes,
 					     msg->buffer + accessed_bytes,
-					     to_access);
+					     to_access, &msg->reply);
 
 		if (ret) {
 			drm_info(mtk_dp->drm_dev,
@@ -2081,7 +2080,6 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 		accessed_bytes += to_access;
 	} while (accessed_bytes < msg->size);
 
-	msg->reply = DP_AUX_NATIVE_REPLY_ACK | DP_AUX_I2C_REPLY_ACK;
 	return msg->size;
 err:
 	msg->reply = DP_AUX_NATIVE_REPLY_NACK | DP_AUX_I2C_REPLY_NACK;
-- 
2.39.2



