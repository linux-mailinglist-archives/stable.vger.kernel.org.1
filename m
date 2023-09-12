Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E974579BD1F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbjIKU6L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjIKOHd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A1CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E231C433C9;
        Mon, 11 Sep 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441248;
        bh=cqWSo0Ugx2kz5P7I1wAWzDzifL6shcu57BUg1eYTAdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPjmrGFgTtrkRL+ZQduh/AVy2SpvzDxzwAEBoKIx2XUCEZVvZnZSFnYa6mByrWXS/
         9phT2vA1QZZ/gQuvby4OqQ+REI1OOWvAcREwaRX4dpfqqpEf1zImkdK4xrf7YLOjCV
         pNOB9W/CBFhSKRgtkyjhZ4Lcqo5+XdOBmYpV0Wl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 320/739] ASoC: SOF: Intel: hda-mlink: fix off-by-one error
Date:   Mon, 11 Sep 2023 15:41:59 +0200
Message-ID: <20230911134700.044946338@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 7075b0c91b3cd5d32b4ac7403f771a3253d3fbf6 ]

The HCHAN parameter should be the highest channel number, not the
channel count.

While we're at it, handle LCHAN with the dual __ffs helper.

Fixes: ccc2f0c1b6b6 ("ASoC: SOF: Intel: hda-mlink: add helper to program SoundWire PCMSyCM registers")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Link: https://lore.kernel.org/r/20230807210959.506849-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-mlink.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-mlink.c b/sound/soc/sof/intel/hda-mlink.c
index b7cbf66badf5b..acad3ea2f4710 100644
--- a/sound/soc/sof/intel/hda-mlink.c
+++ b/sound/soc/sof/intel/hda-mlink.c
@@ -781,6 +781,8 @@ int hdac_bus_eml_sdw_map_stream_ch(struct hdac_bus *bus, int sublink, int y,
 {
 	struct hdac_ext2_link *h2link;
 	u16 __iomem *pcmsycm;
+	int hchan;
+	int lchan;
 	u16 val;
 
 	h2link = find_ext2_link(bus, true, AZX_REG_ML_LEPTR_ID_SDW);
@@ -791,9 +793,17 @@ int hdac_bus_eml_sdw_map_stream_ch(struct hdac_bus *bus, int sublink, int y,
 		h2link->instance_offset * sublink +
 		AZX_REG_SDW_SHIM_PCMSyCM(y);
 
+	if (channel_mask) {
+		hchan = __fls(channel_mask);
+		lchan = __ffs(channel_mask);
+	} else {
+		hchan = 0;
+		lchan = 0;
+	}
+
 	mutex_lock(&h2link->eml_lock);
 
-	hdaml_shim_map_stream_ch(pcmsycm, 0, hweight32(channel_mask),
+	hdaml_shim_map_stream_ch(pcmsycm, lchan, hchan,
 				 stream_id, dir);
 
 	mutex_unlock(&h2link->eml_lock);
-- 
2.40.1



