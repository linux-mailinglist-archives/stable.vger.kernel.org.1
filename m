Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D270C75E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjEVT2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjEVT2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8109C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A0E62849
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0961BC433D2;
        Mon, 22 May 2023 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783722;
        bh=+CClwmlhhoXRV/flrOSGPQcZOJ5y9G17Co5fZemzFmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3LeBkV62wmvoiqyYFLPaXEKw3RBZKIkuqSs6AjxTJ7ra2SlhfynW1ud5Mkmak32R
         K0/0RMBTeBvgU+Ry7N++GU2B0yyGCOaoigzMa+Hwws/Ot7LQ8GL5dj+9REeDojs4yq
         SXlkBqojnsVoyckPOJRQzgNZ2B7pSae2ZJn9VsxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eugene Huang <eugene.huang99@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/292] soundwire: dmi-quirks: add remapping for Intel Rooks County NUC M15
Date:   Mon, 22 May 2023 20:08:17 +0100
Message-Id: <20230522190409.464537481@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Eugene Huang <eugene.huang99@gmail.com>

[ Upstream commit 01b33e284ca28cc977bdcfb23be2c719f2139175 ]

Same DSDT problem as the HP Omen 16-k0005TX, except rt1316 amp is on
link2.

Link: https://github.com/thesofproject/linux/issues/4088
Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230314090618.498716-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/dmi-quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 7969881f126dc..58ea013fa918a 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -73,6 +73,23 @@ static const struct adr_remap hp_omen_16[] = {
 	{}
 };
 
+/*
+ * Intel NUC M15 LAPRC510 and LAPRC710
+ */
+static const struct adr_remap intel_rooks_county[] = {
+	/* rt711-sdca on link0 */
+	{
+		0x000020025d071100ull,
+		0x000030025d071101ull
+	},
+	/* rt1316-sdca on link2 */
+	{
+		0x000120025d071100ull,
+		0x000230025d131601ull
+	},
+	{}
+};
+
 static const struct dmi_system_id adr_remap_quirk_table[] = {
 	/* TGL devices */
 	{
@@ -98,6 +115,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
-- 
2.39.2



