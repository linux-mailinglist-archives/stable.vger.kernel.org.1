Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7F70C70F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjEVTZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjEVTZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BAB10C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7126862887
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDC5C4339B;
        Mon, 22 May 2023 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783520;
        bh=Vu0+qWqefyWhMzSESBgfYJzPeVchKVsuZgJb+f4X4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiN7BR7R2oNxFw3Bp5ckKQsf1EhW5T7d5nLyinvgqjU/xOM3W6EUOTFzLcUZXDc7t
         8eXFxAEkUKyfBrJyORvkFiWc67qs8jFaAarO7xmYOLtdXuGE+PiVkUB/TownAJmHkQ
         2x4EqKf5vjBWGhFXFUQEFhVH2372E7jqq77qoQWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Toby Chen <tobyc@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/292] drm/rockchip: dw_hdmi: cleanup drm encoder during unbind
Date:   Mon, 22 May 2023 20:06:51 +0100
Message-Id: <20230522190407.288619778@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Toby Chen <tobyc@nvidia.com>

[ Upstream commit b5af48eedcb53491c02ded55d5991e03d6da6dbf ]

This fixes a use-after-free crash during rmmod.

The DRM encoder is embedded inside the larger rockchip_hdmi,
which is allocated with the component. The component memory
gets freed before the main drm device is destroyed. Fix it
by running encoder cleanup before tearing down its container.

Signed-off-by: Toby Chen <tobyc@nvidia.com>
[moved encoder cleanup above clk_disable, similar to bind-error-path]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230317005126.496-1-tobyc@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 2f4b8f64cbad3..ae857bf8bd624 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -640,6 +640,7 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
+	drm_encoder_cleanup(&hdmi->encoder.encoder);
 	clk_disable_unprepare(hdmi->ref_clk);
 
 	regulator_disable(hdmi->avdd_1v8);
-- 
2.39.2



