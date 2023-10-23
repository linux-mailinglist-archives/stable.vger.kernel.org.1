Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36A7D33C1
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjJWLds (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjJWLds (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03ADFF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3003AC433C7;
        Mon, 23 Oct 2023 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060825;
        bh=2oVNCDvAfMD5iiUhajQALHV14USaIfLTV4cojuEOGtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nlp6EOMdtZwVlizaoxk41ht3aelvTZnj1xpuLKx+cJ14rn8DTNmr4e0R05qwGelRT
         dP/ISmDy5RZ4SrmEzHflxe91MWBr8/S7V3D8CEKF/EgJxB+FAXonW0CXrY8Io/IcFa
         KcZcQa/UNS6d+M6xBl5zgvtzaMJb2N8PoPz0jxqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kai Uwe Broulik <foss-linux@broulik.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/123] drm: panel-orientation-quirks: Add quirk for One Mix 2S
Date:   Mon, 23 Oct 2023 12:57:36 +0200
Message-ID: <20231023104820.984669024@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Uwe Broulik <foss-linux@broulik.de>

[ Upstream commit cbb7eb2dbd9472816e42a1b0fdb51af49abbf812 ]

The One Mix 2S is a mini laptop with a 1200x1920 portrait screen
mounted in a landscape oriented clamshell case. Because of the too
generic DMI strings this entry is also doing bios-date matching.

Signed-off-by: Kai Uwe Broulik <foss-linux@broulik.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231001114710.336172-1-foss-linux@broulik.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 6106fa7c43028..43de9dfcba19a 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -44,6 +44,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
+	.width = 1200,
+	.height = 1920,
+	.bios_dates = (const char * const []){ "05/21/2018", "10/26/2018",
+		"03/04/2019", NULL },
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data gpd_pocket = {
 	.width = 1200,
 	.height = 1920,
@@ -329,6 +337,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* One Mix 2S (generic strings, also match on bios date) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		},
+		.driver_data = (void *)&gpd_onemix2s,
 	},
 	{}
 };
-- 
2.40.1



