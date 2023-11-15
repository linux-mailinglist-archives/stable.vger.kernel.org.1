Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440657ED458
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjKOU5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344628AbjKOU5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC81130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB0C3277C;
        Wed, 15 Nov 2023 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081329;
        bh=TPFSZR9P6uUm6qwTh4NOiaegPz001IGLHkrL12/SRpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TF7OIDJOI9YXU55ODp/aKmwqAp+MvrHWm6hef+EUhpfxh9+RRN06V5mCSflGmVZQd
         wSOA/JYNQUzAGDbnem4TOhCuuVLEA0xw5ExGh/qXK4iUR/QRuGeu8sl7ALBwvBdDtH
         jqdC/eqBT2V34EdPZmph8FTgR0CAApRQf7dvIkVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/244] drm/mipi-dsi: Create devm device attachment
Date:   Wed, 15 Nov 2023 15:34:39 -0500
Message-ID: <20231115203553.582007688@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit db6568498b35a4d5d5a99420df27ed25fae31406 ]

MIPI-DSI devices need to call mipi_dsi_attach() when their probe is done
to attach against their host.

However, at removal or when an error occurs, that attachment needs to be
undone through a call to mipi_dsi_detach().

Let's create a device-managed variant of the attachment function that
will automatically detach the device at unbind.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20210910101218.1632297-5-maxime@cerno.tech
Stable-dep-of: 941882a0e96d ("drm/bridge: lt8912b: Fix bridge_detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 35 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index bedbbfeab2a98..d98b08c65db93 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -392,6 +392,41 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
 
+static void devm_mipi_dsi_detach(void *arg)
+{
+	struct mipi_dsi_device *dsi = arg;
+
+	mipi_dsi_detach(dsi);
+}
+
+/**
+ * devm_mipi_dsi_attach - Attach a MIPI-DSI device to its DSI Host
+ * @dev: device to tie the MIPI-DSI device attachment lifetime to
+ * @dsi: DSI peripheral
+ *
+ * This is the managed version of mipi_dsi_attach() which automatically
+ * calls mipi_dsi_detach() when @dev is unbound.
+ *
+ * Returns:
+ * 0 on success, a negative error code on failure.
+ */
+int devm_mipi_dsi_attach(struct device *dev,
+			 struct mipi_dsi_device *dsi)
+{
+	int ret;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, devm_mipi_dsi_detach, dsi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
+
 static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
 					struct mipi_dsi_msg *msg)
 {
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 5105464052704..d9af72024d66d 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -233,6 +233,7 @@ devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *hos
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
+int devm_mipi_dsi_attach(struct device *dev, struct mipi_dsi_device *dsi);
 int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
-- 
2.42.0



