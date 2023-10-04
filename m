Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7C7B88DF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjJDSUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbjJDSUO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F098
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD142C433C8;
        Wed,  4 Oct 2023 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443611;
        bh=8PINg+jmf6dHIqNCulj9cA3AUYgVCy/+yDIwjzv8sqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z75zkmVzBF8ySLSEdnLpgB+PNzuSs9fw8UgbSPYDLkQVbRIwpxPnMIGMfP9qkfJ8/
         eKiuMg0/XzJBPCGvWUb20LCiAcUqJ9hjlfLkcbYQXJoqIpkAhs26kLhuTgH6gWlyPI
         6W+b/tnjlkkZUYSZj9Ptwu+FA8xFO1ANE4hb3Z9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 189/259] ASoC: SOF: Intel: MTL: Reduce the DSP init timeout
Date:   Wed,  4 Oct 2023 19:56:02 +0200
Message-ID: <20231004175225.964467467@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit e0f96246c4402514acda040be19ee24c1619e01a ]

20s seems unnecessarily large for the DSP init timeout. This coupled with
multiple FW boot attempts causes an excessive delay in the error path when
booting in recovery mode. Reduce it to 0.5s and use the existing
HDA_DSP_INIT_TIMEOUT_US.

Link: https://github.com/thesofproject/linux/issues/4565
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230915134153.9688-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/mtl.c | 2 +-
 sound/soc/sof/intel/mtl.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 10298532816fe..d7048f1d6a048 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -453,7 +453,7 @@ static int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_bo
 	/* step 3: wait for IPC DONE bit from ROM */
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, chip->ipc_ack, status,
 					    ((status & chip->ipc_ack_mask) == chip->ipc_ack_mask),
-					    HDA_DSP_REG_POLL_INTERVAL_US, MTL_DSP_PURGE_TIMEOUT_US);
+					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_INIT_TIMEOUT_US);
 	if (ret < 0) {
 		if (hda->boot_iteration == HDA_FW_BOOT_ATTEMPTS)
 			dev_err(sdev->dev, "timeout waiting for purge IPC done\n");
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index 788bf0e3ea879..00e3526889d3d 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -54,7 +54,6 @@
 #define MTL_DSP_IRQSTS_IPC		BIT(0)
 #define MTL_DSP_IRQSTS_SDW		BIT(6)
 
-#define MTL_DSP_PURGE_TIMEOUT_US	20000000 /* 20s */
 #define MTL_DSP_REG_POLL_INTERVAL_US	10	/* 10 us */
 
 /* Memory windows */
-- 
2.40.1



