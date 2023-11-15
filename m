Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5307ECF15
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjKOTqQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjKOTqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B71AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C982C433CA;
        Wed, 15 Nov 2023 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077571;
        bh=1LZ/Y4xsVpolQRmoUR1hda6FH9y8C8G5KXX3UdNdzvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRX+uv9C7M+oB8KLDyts+/HSRiVfBKR+9O32zGu5JSsBvloK6XDgSqHUcDtGvB894
         JB0JUvxp+SbMjIvfgQvWezU6G+cnI9ZK2Um9qWqOUgYkntc90/GOL2sK/b31La/XSd
         PjCrCmAYcgCIST9xwKOXYnpuxj2jpgHYpDZ9p+Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 384/603] ASoC: SOF: core: Ensure sof_ops_free() is still called when probe never ran.
Date:   Wed, 15 Nov 2023 14:15:29 -0500
Message-ID: <20231115191639.865993141@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 2d1616b81485c..0938b259f7034 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -459,9 +459,10 @@ int snd_sof_device_remove(struct device *dev)
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_sof_pdata *pdata = sdev->pdata;
 	int ret;
+	bool aborted = false;
 
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
-		cancel_work_sync(&sdev->probe_work);
+		aborted = cancel_work_sync(&sdev->probe_work);
 
 	/*
 	 * Unregister any registered client device first before IPC and debugfs
@@ -487,6 +488,9 @@ int snd_sof_device_remove(struct device *dev)
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



