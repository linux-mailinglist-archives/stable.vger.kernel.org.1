Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA550791015
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbjIDCUj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 22:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDCUj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 22:20:39 -0400
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA1DBB
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 19:20:35 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3842KCx71601269; Mon, 4 Sep 2023 11:20:13 +0900
X-Iguazu-Qid: 2yAa6hjhCm80lfKiTz
X-Iguazu-QSIG: v=2; s=0; t=1693794012; q=2yAa6hjhCm80lfKiTz; m=xOuukD6pRvtJEyo5vi08hdAhSLEsaEiwFhf0C+2FNqM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1802) id 3842KAel2026887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Sep 2023 11:20:11 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bard.liao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.10] ASoC: rt5682: Fix a problem with error handling in the io init function of the soundwire
Date:   Mon,  4 Sep 2023 11:20:00 +0900
X-TSB-HOP2: ON
Message-Id: <20230904022000.343666-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oder Chiou <oder_chiou@realtek.com>

commit 9266d95405ae0c078f188ec8bca3a004631be429 upstream.

The device checking error should be a jump to pm_runtime_put_autosuspend()
as done before returning value.

Fixes: 867f8d18df4f ('ASoC: rt5682: fix getting the wrong device id when the suspend_stress_test')
Reviewed-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210607222239.582139-13-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 sound/soc/codecs/rt5682-sdw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 2fb6b1edf93317..1e9109a95e6e0d 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -413,9 +413,11 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 		usleep_range(30000, 30005);
 		loop--;
 	}
+
 	if (val != DEVICE_ID) {
 		dev_err(dev, "Device with ID register %x is not rt5682\n", val);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_nodev;
 	}
 
 	rt5682_calibrate(rt5682);
@@ -486,10 +488,11 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 	rt5682->hw_init = true;
 	rt5682->first_hw_init = true;
 
+err_nodev:
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
-	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
+	dev_dbg(&slave->dev, "%s hw_init complete: %d\n", __func__, ret);
 
 	return ret;
 }
-- 
2.40.1


