Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F387CA2BA
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJPIxl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjJPIxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71388E6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C675C433C9;
        Mon, 16 Oct 2023 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446419;
        bh=tEwh6fDnp+ZJVTHEF5PAS9GQIHAfHafwcWjuC9dL1CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvCJ3i54tPoSW+X9ixLo0XCiwQEI2cRvhBUEfsrP70Jk3rvn01d64N8BUG0klaC9F
         EIwE27xlfdB+HDEaWf3aywPnkEBqYyWH3mV9VaxDje4+NO7xfx1PtR1UAxcru2KJ0q
         csWhXjDfT5+ljlSrEi5gegMC4YQTY9sfTQd2lgl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Balamurugan C <balamurugan.c@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 025/131] ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.
Date:   Mon, 16 Oct 2023 10:40:08 +0200
Message-ID: <20231016084000.691241871@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balamurugan C <balamurugan.c@intel.com>

commit 381ddcd5875e496f2eae06bb65853271b7150fee upstream.

Adding support for ES83x6 codec in MTL match table.

Signed-off-by: Balamurugan C <balamurugan.c@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230919091136.1922253-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -25,6 +25,11 @@ static const struct snd_soc_acpi_codecs
 	.codecs = {"INTC10B0"}
 };
 
+static const struct snd_soc_acpi_codecs mtl_essx_83x6 = {
+	.num_codecs = 3,
+	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 	{
 		.comp_ids = &mtl_rt5682_rt5682s_hp,
@@ -33,6 +38,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_in
 		.quirk_data = &mtl_max98357a_amp,
 		.sof_tplg_filename = "sof-mtl-max98357a-rt5682.tplg",
 	},
+	{
+		.comp_ids = &mtl_essx_83x6,
+		.drv_name = "sof-essx8336",
+		.sof_tplg_filename = "sof-mtl-es8336", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_SSP_NUMBER |
+					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
+					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_mtl_machines);


