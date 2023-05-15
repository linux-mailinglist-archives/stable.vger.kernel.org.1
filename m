Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5D703397
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbjEOQjD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbjEOQjA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B819A5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB916285C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D0AC433D2;
        Mon, 15 May 2023 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168737;
        bh=tbAGR8olSID+ZXh68YMbQgpn1M1MrEf6vi/Iqaw5Vyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fR6gZp5uaWKCItUMGNhcP9dSVamtIMyJ/yyCt5BKwu4HfvtoFIhCQM2yUPauablg5
         eCrmXCMm+4+hqtpPTlYi6bad5bNGIGl5JaJJOoKWUiYGzBZ0oFDR6s2VY+4evBYvt6
         uMTubvY5HKY7euwWf2HnehWZPsuzJaFnwTBatceQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/191] ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
Date:   Mon, 15 May 2023 18:24:02 +0200
Message-Id: <20230515161707.401676269@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e38c5e80c3d293a883c6f1d553f2146ec0bda35e ]

The Acer Iconia One 7 B1-750 tablet mostly works fine with the defaults
for an Bay Trail CR tablet. Except for the internal mic, instead of
an analog mic on IN3 a digital mic on DMIC1 is uses.

Add a quirk with these settings for this tablet.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230322145332.131525-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -400,6 +400,18 @@ static int byt_rt5640_aif1_hw_params(str
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),


