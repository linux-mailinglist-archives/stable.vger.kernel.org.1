Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BF7ECE38
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjKOTlj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjKOTli (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDF189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5B0C433C9;
        Wed, 15 Nov 2023 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077295;
        bh=Kc9XiUrTLV81auMzpX64UP9Eo4VNUGTv/c5mzaFHtzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DW4kmPmbHY0QhaoQtrWF4wcZG5SfIkaGuPp5hru5kAoNc+oKG5bhPywfgYTQSvGZl
         3emoD9A+qM8TjYKoTVu3Z4C0f+UK2VnM9FvzkI8EsYbKQrNsAN5a93rkyl0dgWpI/i
         LiaL5Jq+oO9xBejLr8rjRw42LUANtgiA6Neyla9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 216/603] drm: bridge: samsung-dsim: Fix waiting for empty cmd transfer FIFO on older Exynos
Date:   Wed, 15 Nov 2023 14:12:41 -0500
Message-ID: <20231115191628.235677581@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 15f389da11257b806da75a070cfa41ca0cc15aae ]

Samsung DSIM used in older Exynos SoCs (like Exynos 4210, 4x12, 3250)
doesn't report empty level of packer header FIFO. In case of those SoCs,
use the old way of waiting for empty command tranfsfer FIFO, removed
recently by commit 14806c641582 ("drm: bridge: samsung-dsim: Drain command transfer FIFO before transfer").

Fixes: 14806c641582 ("drm: bridge: samsung-dsim: Drain command transfer FIFO before transfer")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230809145641.3213210-1-m.szyprowski@samsung.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 18 ++++++++++++++++--
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 6f2ca74238d14..19bdb32dbc9aa 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -413,6 +413,7 @@ static const struct samsung_dsim_driver_data exynos3_dsi_driver_data = {
 	.m_min = 41,
 	.m_max = 125,
 	.min_freq = 500,
+	.has_broken_fifoctrl_emptyhdr = 1,
 };
 
 static const struct samsung_dsim_driver_data exynos4_dsi_driver_data = {
@@ -429,6 +430,7 @@ static const struct samsung_dsim_driver_data exynos4_dsi_driver_data = {
 	.m_min = 41,
 	.m_max = 125,
 	.min_freq = 500,
+	.has_broken_fifoctrl_emptyhdr = 1,
 };
 
 static const struct samsung_dsim_driver_data exynos5_dsi_driver_data = {
@@ -1010,8 +1012,20 @@ static int samsung_dsim_wait_for_hdr_fifo(struct samsung_dsim *dsi)
 	do {
 		u32 reg = samsung_dsim_read(dsi, DSIM_FIFOCTRL_REG);
 
-		if (reg & DSIM_SFR_HEADER_EMPTY)
-			return 0;
+		if (!dsi->driver_data->has_broken_fifoctrl_emptyhdr) {
+			if (reg & DSIM_SFR_HEADER_EMPTY)
+				return 0;
+		} else {
+			if (!(reg & DSIM_SFR_HEADER_FULL)) {
+				/*
+				 * Wait a little bit, so the pending data can
+				 * actually leave the FIFO to avoid overflow.
+				 */
+				if (!cond_resched())
+					usleep_range(950, 1050);
+				return 0;
+			}
+		}
 
 		if (!cond_resched())
 			usleep_range(950, 1050);
diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
index 05100e91ecb96..6fc9bb2979e45 100644
--- a/include/drm/bridge/samsung-dsim.h
+++ b/include/drm/bridge/samsung-dsim.h
@@ -53,6 +53,7 @@ struct samsung_dsim_driver_data {
 	unsigned int plltmr_reg;
 	unsigned int has_freqband:1;
 	unsigned int has_clklane_stop:1;
+	unsigned int has_broken_fifoctrl_emptyhdr:1;
 	unsigned int num_clks;
 	unsigned int min_freq;
 	unsigned int max_freq;
-- 
2.42.0



