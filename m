Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C026FA45E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjEHJ6c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjEHJ6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56E2B17C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9126F62284
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C03BC433D2;
        Mon,  8 May 2023 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539910;
        bh=CCBSryebc3uG0PaVN6xbha/mpSyz4nZJ2v/CDUz5eMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7r9AmGqW6UEA6Dty1Lmt25mkOarR8u7pEoVt46Jbv7B98Q5ylkBjFvGaGOI+W1ye
         0O4gwkp5NV0TvJ8++7lf4S8wJauAbPp5IyQ9dgRf2eIcujQVCZsahBDolY6fYw2crZ
         kjBPC26vouhjS03aLVmAF9NnuPdykcmvxvJWJKK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 144/611] drm/mediatek: dp: Only trigger DRM HPD events if bridge is attached
Date:   Mon,  8 May 2023 11:39:46 +0200
Message-Id: <20230508094426.913201100@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 36b617f7e4ae663fcadd202ea061ca695ca75539 ]

The MediaTek DisplayPort interface bridge driver starts its interrupts
as soon as its probed. However when the interrupts trigger the bridge
might not have been attached to a DRM device. As drm_helper_hpd_irq_event()
does not check whether the passed in drm_device is valid or not, a NULL
pointer passed in results in a kernel NULL pointer dereference in it.

Check whether the bridge is attached and only trigger an HPD event if
it is.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20230202045734.2773503-1-wenst@chromium.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 9d085c05c49c3..d28326350ea93 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1823,7 +1823,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
 
 	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
-		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
+		if (mtk_dp->bridge.dev)
+			drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
 
 		if (!mtk_dp->train_info.cable_plugged_in) {
 			mtk_dp_disable_sdp_aui(mtk_dp);
-- 
2.39.2



