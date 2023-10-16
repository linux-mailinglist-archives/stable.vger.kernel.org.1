Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB33B7CAB6E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjJPO0N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJPO0K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:26:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117810E
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:26:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99314C433C8;
        Mon, 16 Oct 2023 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466364;
        bh=s6vm35NNrqa73lKsRvB74NH1WP1udd4XtJ3qw2XOpnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mL8EVkJceYI+P7104nklGdbzByGhg8FR339uLLF4tJOxANEjtHa8HnfezCFip2+9m
         uAIsjTI8kbIsjxDjW2lSYDxPOIQ8Ro1Y3PYxGMR4m1gKrVfSBrGxUr1QRrdJdTCk7G
         tL/b14Pvz/LYXvLvdTxOgrrel0B2cLKzp8mF7E7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Balamurugan C <balamurugan.c@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 037/191] ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.
Date:   Mon, 16 Oct 2023 10:40:22 +0200
Message-ID: <20231016084016.262374562@linuxfoundation.org>
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
@@ -35,6 +35,11 @@ static const struct snd_soc_acpi_codecs
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
@@ -64,6 +69,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_in
 		.quirk_data = &mtl_rt1019p_amp,
 		.sof_tplg_filename = "sof-mtl-rt1019-rt5682.tplg",
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


