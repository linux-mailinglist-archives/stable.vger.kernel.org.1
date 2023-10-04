Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA37B8859
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbjJDSPN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbjJDSPM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE29E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BBFC433CA;
        Wed,  4 Oct 2023 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443309;
        bh=8v8O5RC3CTmnnogEIhD0NTQYDcEqhVkiQJwPYG620Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVpJvKAVCMQGsADyJVSXSHHl3L505HfaGDwt/f27mIxV6J6wLG0VFpjG5c/GN0ofJ
         RnIPtwVy2CDwVG3OcHsI0v//+uUDifNm+CwVrFPsP1/WDaY0jalkFF1OeCZOj9kSeo
         1yp3AwUImXUvPirC6dnt+jZxeeNXLCHjHSeyfCME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 111/259] drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA and EOT packet
Date:   Wed,  4 Oct 2023 19:54:44 +0200
Message-ID: <20231004175222.442987814@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit ca161b259cc84fe1f4a2ce4c73c3832cf6f713f1 ]

Do not generate the HS front and back porch gaps, the HSA gap and
EOT packet, as per "SN65DSI83 datasheet SLLSEC1I - SEPTEMBER 2012
- REVISED OCTOBER 2020", page 22, these packets are not required.
This makes the TI SN65DSI83 bridge work with Samsung DSIM on i.MX8MN.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230403190242.224490-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 55efd3eb66723..3f43b44145a89 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -655,7 +655,9 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.40.1



