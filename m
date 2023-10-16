Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C77CAC04
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjJPOsp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJPOsn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A578FA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B286C433A9;
        Mon, 16 Oct 2023 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467721;
        bh=5z+EhAqUTOnfV8z5ZclYlNAEoPylcdgJOthHxyHFlEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccq0U3iuerf/DPuqF2Pm2jTX2IhM7DJssU+2aB70XhP93njuhytKzVbe1QWSCKnK5
         kRdXtZb27MfLxZl05b3lB52+zhdEnm2n91NzHsDFTTc2ORtct4GVDE77pBYUR+lCv/
         G2vy/h7idWwSZ68+GGxOHzFX/AKLhEzZ4SYlGTmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 075/191] drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP term
Date:   Mon, 16 Oct 2023 10:41:00 +0200
Message-ID: <20231016084017.157217080@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>

[ Upstream commit 258dd5e6e65995ee85a941eed9a06708a36b1bfe ]

The sta_himax83102 panel sometimes shows abnormally flickering
horizontal lines. The front gate output will precharge the X point of
the next pole circuit before TP(TouchPanel Enable) term starts, and wait
until the end of the TP term to resume the CLK. For this reason, the X
point must be maintained during the TP term. In abnormal case, we
measured a slight leakage at point X. This because during the TP term,
the GPW does not fully pull the VGL low, causing the TFT to not be
closed tightly.

To fix this, we completely pull GPW to VGL before entering the TP term.
This will ensure that the TFT is closed tightly and prevent the abnormal
display.

Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel")
Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index dc276c346fd1a..dcc5e79cfe879 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1343,9 +1343,7 @@ static const struct panel_init_cmd starry_himax83102_j02_init_cmd[] = {
 	_INIT_DCS_CMD(0xB1, 0x01, 0xBF, 0x11),
 	_INIT_DCS_CMD(0xCB, 0x86),
 	_INIT_DCS_CMD(0xD2, 0x3C, 0xFA),
-	_INIT_DCS_CMD(0xE9, 0xC5),
-	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
-	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
 	_INIT_DCS_CMD(0xE7, 0x02, 0x00, 0x28, 0x01, 0x7E, 0x0F, 0x7E, 0x10, 0xA0, 0x00, 0x00, 0x20, 0x40, 0x50, 0x40),
 	_INIT_DCS_CMD(0xBD, 0x02),
 	_INIT_DCS_CMD(0xD8, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0),
-- 
2.40.1



