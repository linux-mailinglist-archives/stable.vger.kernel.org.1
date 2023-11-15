Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31957ED0F6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjKOT6l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKOT6k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB75189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266ADC433C9;
        Wed, 15 Nov 2023 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078316;
        bh=ahA7RPMNUzIv4tAVUty6khnJEQ6qbtk7lVmwNsGbZ04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Z7XWx+c0toZ9kKN5PXlmQUXZ0orC5Yu3T9veAFZoqRboB3n5Oi9sWRA2oAecZQtd
         tmbXIcupMspoTSPst1GYVYpoSOdGUFdvHBHkyjrl+J13BTJ4pQDMPiZQT+UwPLAuJG
         gRbdgj82WDBQsYLdMsV8LFQGNmNBguqRSGwKLUmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 223/379] ASoC: SOF: core: Ensure sof_ops_free() is still called when probe never ran.
Date:   Wed, 15 Nov 2023 14:24:58 -0500
Message-ID: <20231115192658.316574537@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

[ Upstream commit f549a82aff57865c47b5abd17336b23cd9bb2d2c ]

In an effort to not call sof_ops_free twice, we stopped running it when
probe was aborted.

Check the result of cancel_work_sync to see if this was the case.

Fixes: 31bb7bd9ffee ("ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful")
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://lore.kernel.org/r/20231009115437.99976-2-maarten.lankhorst@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index eaa16755a2704..93e1c38392a32 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -434,9 +434,10 @@ int snd_sof_device_remove(struct device *dev)
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_sof_pdata *pdata = sdev->pdata;
 	int ret;
+	bool aborted = false;
 
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
-		cancel_work_sync(&sdev->probe_work);
+		aborted = cancel_work_sync(&sdev->probe_work);
 
 	/*
 	 * Unregister any registered client device first before IPC and debugfs
@@ -462,6 +463,9 @@ int snd_sof_device_remove(struct device *dev)
 		snd_sof_free_debug(sdev);
 		snd_sof_remove(sdev);
 		sof_ops_free(sdev);
+	} else if (aborted) {
+		/* probe_work never ran */
+		sof_ops_free(sdev);
 	}
 
 	/* release firmware */
-- 
2.42.0



