Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E01755533
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGPUie (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGPUid (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4389F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94AF660EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792BAC433C7;
        Sun, 16 Jul 2023 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539911;
        bh=GWlHizJabDCW3b+FlxkKSDpF+g052nAKhhHI+n4fq1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAuXPaNZhnOdE16T5SlDwlTRzAIbLWz54LscmcC7wQtoS0q2qi6lnPR9OblUEb+9Z
         oqgArVUQ57alwVxlEP4FdPG9jWeiXwM72ZxuqVUDq83rMFS9aeYdH1OzMhZGY5gboR
         jYNZc/8y4NKEvFVBptsLwcti9ujtHq0jQmBqCn8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/591] drm/bridge: tc358767: Switch to devm MIPI-DSI helpers
Date:   Sun, 16 Jul 2023 21:45:15 +0200
Message-ID: <20230716194928.419330985@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit f47d6140b7a4c858d82d263e7577ff6fb5279a9c ]

DSI device registering and attaching needs to be undone upon
deregistration. This fixes module unload/load.

Fixes: bbfd3190b656 ("drm/bridge: tc358767: Add DSI-to-DPI mode support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230517122107.1766673-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b9b681086fc49..7ef78283e3d3e 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1890,7 +1890,7 @@ static int tc_mipi_dsi_host_attach(struct tc_data *tc)
 	if (dsi_lanes < 0)
 		return dsi_lanes;
 
-	dsi = mipi_dsi_device_register_full(host, &info);
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi))
 		return dev_err_probe(dev, PTR_ERR(dsi),
 				     "failed to create dsi device\n");
@@ -1901,7 +1901,7 @@ static int tc_mipi_dsi_host_attach(struct tc_data *tc)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "failed to attach dsi to host: %d\n", ret);
 		return ret;
-- 
2.39.2



