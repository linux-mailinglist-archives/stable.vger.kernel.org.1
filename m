Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279166FA58A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjEHKKe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjEHKKd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B737E6B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5025A623A7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692BDC433D2;
        Mon,  8 May 2023 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540631;
        bh=4TEmajR8fIFI1ReSA48F4F7ESgwf1iVTFHwUC1OI8ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K83sdHsaqArXEKmSzK5LDd/MWhNtiFnmEDx9AgUPkmbwfZYjMeRN5vL4QPptgSFHI
         kfSTmG5uuaorIWMYZ2a9JjwvwYRQu0fBs5C6qenNYAVo/Z46hnVME02ChHlxSgIe77
         Nq+i7R3owwHX4oXK2YipBCWDR7gPOzSuuiDrwFCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 438/611] drm/panel: novatek-nt35950: Only unregister DSI1 if it exists
Date:   Mon,  8 May 2023 11:44:40 +0200
Message-Id: <20230508094436.402393884@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit a50be876f4fe2349dc8b056a49d87f69c944570f ]

Commit 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
introduced logic to unregister DSI1 on any sort of probe failure, as
that's not done automatically by kernel APIs.

It did not however account for cases where only one DSI host is used.
Fix that.

Fixes: 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 4359b02754aac..5d04957b1144f 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -594,7 +594,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 	ret = drm_panel_of_backlight(&nt->panel);
 	if (ret) {
-		mipi_dsi_device_unregister(nt->dsi[1]);
+		if (num_dsis == 2)
+			mipi_dsi_device_unregister(nt->dsi[1]);
 
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 	}
@@ -614,7 +615,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
 			/* If we fail to attach to either host, we're done */
-			mipi_dsi_device_unregister(nt->dsi[1]);
+			if (num_dsis == 2)
+				mipi_dsi_device_unregister(nt->dsi[1]);
 
 			return dev_err_probe(dev, ret,
 					     "Cannot attach to DSI%d host.\n", i);
-- 
2.39.2



