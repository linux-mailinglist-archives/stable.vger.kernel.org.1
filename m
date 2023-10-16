Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DB7CAB6D
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjJPO0M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjJPO0J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A05FA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:25:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20934C433C8;
        Mon, 16 Oct 2023 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466357;
        bh=4DcPGfIwJf6ByVHakLGXfpYCF+x2wyPuPaz9qFG0q9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqU0GuqwNGkUwwE7qtmqsWAVKiXZB0n9b8OwWPcf0kA4/lbxGu1MAnLaZpYzfaAdv
         4/Baj9+eRh8SJl6P772Mwh7PhhO71k0GjO5yb6Rj0htXIRcbluEUhn6gAJMaMd8Z1z
         O40z2ZosauL6JGB4jGDuCBhusycJYeS7DywSBZG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 036/191] ASoC: Intel: sof_sdw: add support for SKU 0B14
Date:   Mon, 16 Oct 2023 10:40:21 +0200
Message-ID: <20231016084016.239660017@linuxfoundation.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit fb0b8d299781be8d46b3612aa96cef28da0d93f4 upstream.

One more missing SKU in the list.

Closes: https://github.com/thesofproject/linux/issues/4543
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230919092125.1922468-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/sof_sdw.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -388,6 +388,16 @@ static const struct dmi_system_id sof_sd
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B14"),
+		},
+		/* No Jack */
+		.driver_data = (void *)SOF_SDW_TGL_HDMI,
+	},
+
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-k0xxx"),
 		},


