Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7438E6FA940
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjEHKtj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjEHKtS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D827F37
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9650E61DA2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E3C433D2;
        Mon,  8 May 2023 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542918;
        bh=A9vllGUu3kXWYI47sBMngSVjcFVzLoYQHACbBQ9Zo00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbRsGxg8tQvbsHFeIuq/OaybvgipiwcB9HJMoWjKkkRmC7+1XWXoty7wAXi9npNXU
         BJn6w8CsLCBmgmE8dPxwwnneyDnbfrQ9U243vGTW1EQinAWHPGJQDMrRUOCrTj0u2z
         ti7Q3z2x5ePdDaGVGvXVPvQa17MWzhQ9sy6KAFTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 589/663] soundwire: intel: dont save hw_params for use in prepare
Date:   Mon,  8 May 2023 11:46:55 +0200
Message-Id: <20230508094448.529130024@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 0a0d1740bd8fd7dafb81fcb102fb5d0b83b1ce73 ]

The existing code copies the hw_params pointer and reuses it later in
.prepare, specifically to re-initialize the ALH DMA channel
information that's lost in suspend-resume cycles.

This is not needed, we can directly access the information from the
substream/rtd - as done for the HDAudio DAIs in
sound/soc/sof/intel/hda-dai.c

In addition, using the saved pointer causes the suspend-resume test
cases to fail on specific platforms, depending on which version of GCC
is used. Péter Ujfalusi and I have spent long hours to root-cause this
problem that was reported by the Intel CI first with 6.2-rc1 and again
v6.3-rc1. In the latter case we were lucky that the problem was 100%
reproducible on local test devices, and found out that adding a
dev_dbg() or adding a call to usleep_range() just before accessing the
saved pointer "fixed" the issue. With errors appearing just by
changing the compiler version or minor changes in the code generated,
clearly we have a memory management Heisenbug.

The root-cause seems to be that the hw_params pointer is not
persistent. The soc-pcm code allocates the hw_params structure on the
stack, and passes it to the BE dailink hw_params and DAIs
hw_params. Saving such a pointer and reusing it later during the
.prepare stage cannot possibly work reliably, it's broken-by-design
since v5.10. It's astonishing that the problem was not seen earlier.

This simple fix will have to be back-ported to -stable, due to changes
to avoid the use of the get/set_dmadata routines this patch will only
apply on kernels older than v6.1.

Fixes: a5a0239c27fe ("soundwire: intel: reinitialize IP+DSP in .prepare(), but only when resuming")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230321022642.1426611-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.h |  2 --
 drivers/soundwire/intel.c          | 11 +++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index e0a64b28c6b9c..4393607c7e4ad 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -84,7 +84,6 @@ struct sdw_cdns_stream_config {
  * @bus: Bus handle
  * @stream_type: Stream type
  * @link_id: Master link id
- * @hw_params: hw_params to be applied in .prepare step
  * @suspended: status set when suspended, to be used in .prepare
  * @paused: status set in .trigger, to be used in suspend
  * @direction: stream direction
@@ -96,7 +95,6 @@ struct sdw_cdns_dai_runtime {
 	struct sdw_bus *bus;
 	enum sdw_stream_type stream_type;
 	int link_id;
-	struct snd_pcm_hw_params *hw_params;
 	bool suspended;
 	bool paused;
 	int direction;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index bc9c50bacc494..c852745989167 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -833,7 +833,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	dai_runtime->paused = false;
 	dai_runtime->suspended = false;
 	dai_runtime->pdi = pdi;
-	dai_runtime->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_params_stream(sdw, substream->stream, dai, params,
@@ -886,6 +885,11 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 	}
 
 	if (dai_runtime->suspended) {
+		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+		struct snd_pcm_hw_params *hw_params;
+
+		hw_params = &rtd->dpcm[substream->stream].hw_params;
+
 		dai_runtime->suspended = false;
 
 		/*
@@ -897,7 +901,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		 */
 
 		/* configure stream */
-		ch = params_channels(dai_runtime->hw_params);
+		ch = params_channels(hw_params);
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			dir = SDW_DATA_DIR_RX;
 		else
@@ -909,7 +913,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 
 		/* Inform DSP about PDI stream number */
 		ret = intel_params_stream(sdw, substream->stream, dai,
-					  dai_runtime->hw_params,
+					  hw_params,
 					  sdw->instance,
 					  dai_runtime->pdi->intel_alh_id);
 	}
@@ -948,7 +952,6 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	dai_runtime->hw_params = NULL;
 	dai_runtime->pdi = NULL;
 
 	return 0;
-- 
2.39.2



