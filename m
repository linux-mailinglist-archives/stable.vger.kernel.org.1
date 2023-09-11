Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8765179C0DC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbjIKU6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjIKOTr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:19:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D6DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:19:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F23AC433C8;
        Mon, 11 Sep 2023 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441983;
        bh=0BGPyP21ZTsLmcX/87kRvFkjxdvZI5dmgO9Wt0wvrQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPXsWiANRHk6LZx3mZ4/7u9NBPV8ehddu5Wt/BdhNXUanqqa9c75OqQ4HRjdXViqk
         MyLbDDgCjhEhwpHDnoznM/lSFORZKUNhDf74DX6Lx2e8jXQhLbDzth8iBO5hysiXLJ
         Fht/w/Cz5/Ssg9ZOC531QvbpH+9uomh9OPYuOPqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 604/739] thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
Date:   Mon, 11 Sep 2023 15:46:43 +0200
Message-ID: <20230911134707.968752905@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit cbd8c5aae2a988bafd4586bea710eeddc30a82ce ]

There is a single IRQ handler for each LVTS thermal domain, and it is
supposed to check each of its underlying controllers for the origin of
the interrupt and clear its status. However due to a typo, only the
first controller was ever being handled, which resulted in the interrupt
never being cleared when it happened on the other controllers. Add the
missing index so interrupts are handled for all controllers.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230706153823.201943-2-nfraprado@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d6779..4ba144eba10eb 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -451,7 +451,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 
-		aux = lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
+		aux = lvts_ctrl_irq_handler(&lvts_td->lvts_ctrl[i]);
 		if (aux != IRQ_HANDLED)
 			continue;
 
-- 
2.40.1



