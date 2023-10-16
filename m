Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D8A7CAB6B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJPOZv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjJPOZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:25:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9CB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:25:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EC7C433C8;
        Mon, 16 Oct 2023 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466348;
        bh=oewounC5tn8kx7cbd9qrQMdcFhqqp2R4EBXCbShujB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGo9kbIRxHdFMTpzLSocn9JsgbYhlb/i3xyefFip0D0iw1t6E06WiQj5H663d8adp
         kwmpO86wKyjQpQ5dHpWV9ZiJIRNKa5jXLb3YIwQWMXu7TqeQmRIA8j6U0MYDfQKeNc
         ka3/Cx/PnKTGe3cXjL+tdv4IMgzGPrPaS+zG6nJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Balamurugan C <balamurugan.c@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 034/191] ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in MTL match table
Date:   Mon, 16 Oct 2023 10:40:19 +0200
Message-ID: <20231016084016.194227867@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balamurugan C <balamurugan.c@intel.com>

commit d1f67278d4b2de3bf544ea9bcd9f64d03584df87 upstream.

Adding HDMI-In capture via I2S feature support in MTL platform.

Signed-off-by: Balamurugan C <balamurugan.c@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230919091136.1922253-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/sof_es8336.c               |   10 ++++++++++
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |   12 ++++++++++++
 2 files changed, 22 insertions(+)

--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -798,6 +798,16 @@ static const struct platform_device_id b
 					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
 					SOF_ES8336_JD_INVERTED),
 	},
+	{
+		.name = "mtl_es83x6_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_ES8336_SSP_CODEC(1) |
+					SOF_NO_OF_HDMI_CAPTURE_SSP(2) |
+					SOF_HDMI_CAPTURE_1_SSP(0) |
+					SOF_HDMI_CAPTURE_2_SSP(2) |
+					SOF_SSP_HDMI_CAPTURE_PRESENT |
+					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
+					SOF_ES8336_JD_INVERTED),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -30,6 +30,11 @@ static const struct snd_soc_acpi_codecs
 	.codecs = {"10EC5682", "RTL5682"},
 };
 
+static const struct snd_soc_acpi_codecs mtl_lt6911_hdmi = {
+	.num_codecs = 1,
+	.codecs = {"INTC10B0"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 	{
 		.comp_ids = &mtl_rt5682_rt5682s_hp,
@@ -46,6 +51,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_in
 		.sof_tplg_filename = "sof-mtl-max98360a-rt5682.tplg",
 	},
 	{
+		.comp_ids = &mtl_essx_83x6,
+		.drv_name = "mtl_es83x6_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &mtl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-mtl-es83x6-ssp1-hdmi-ssp02.tplg",
+	},
+	{
 		.comp_ids = &mtl_rt5682_rt5682s_hp,
 		.drv_name = "mtl_rt1019_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,


