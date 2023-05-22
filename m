Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30A70C866
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjEVTih (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjEVTiZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B1102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB6B629BF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4284C433D2;
        Mon, 22 May 2023 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784288;
        bh=bKxfhCynXgrSYzy1URhSroKnX5vhAD3GQzPTf6eiNBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Us8apWYcodSGx6w1jx8vhjRrkxBSVXN35Jux7kOa+iri020xZBJi7y2BMqaYKdiM
         Np+/VxyZ2x6VMM+lGjACEX+05oAjkU14To2z/DD4I8eZIUDH0Y12NZIKDZUUMPmwN5
         Kl0bIi1TyUkesBu2FReqlGGZw3/DxlaFxDd7k4Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Saravana Kannan <saravanak@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 005/364] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
Date:   Mon, 22 May 2023 20:05:10 +0100
Message-Id: <20230522190412.944457654@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit a26cc2934331b57b5a7164bff344f0a2ec245fc0 ]

After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
detection more robust"), fw_devlink prints an error when consumer
devices don't have their fwnode set. This used to be ignored silently.

Set the fwnode mipi_dsi_device so fw_devlink can find them and properly
track their dependencies.

This fixes errors like this:
[    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device link with regulator-lcd-1v8
[    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device link with backlight-dsi

Reported-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Link: https://lore.kernel.org/lkml/2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm/
Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Link: https://lore.kernel.org/r/20230310063910.2474472-1-saravanak@google.com
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index b41aaf2bb9f16..7923cc21b78e8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 		return dsi;
 	}
 
-	dsi->dev.of_node = info->node;
+	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 
-- 
2.39.2



