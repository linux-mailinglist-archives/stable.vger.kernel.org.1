Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDEE7B8811
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjJDSM0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbjJDSM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A02DE5
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:12:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86313C433C7;
        Wed,  4 Oct 2023 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443140;
        bh=vsM768sn3+IbGOXRh1TX2JLbog5zxqcd7xPmNgCLOwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqq3lTfTWxJ6fZMJEB9GGVcDIP/e3CsXCMqs7pFMr3ECUgCB+3wrRYTAIeIRN6RYC
         bGlw5gQacwdRYweAPPMvwwityDYprntDzUxLGC0Pgo88QQWRwFd/C91FeNlHqbnTny
         Wk6JMnNynTBpU9ETUtG5auvKki8KHPFp/PGy+jYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/259] ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful
Date:   Wed,  4 Oct 2023 19:53:43 +0200
Message-ID: <20231004175219.742431894@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 31bb7bd9ffee50d09ec931998b823a86132ab807 ]

All the fail paths during probe will free up the ops, on remove we should
only free it if the probe was successful.

Fixes: bc433fd76fae ("ASoC: SOF: Add ops_free")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Link: https://lore.kernel.org/r/20230915124015.19637-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 75a1e2c6539f2..eaa16755a2704 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -461,10 +461,9 @@ int snd_sof_device_remove(struct device *dev)
 		snd_sof_ipc_free(sdev);
 		snd_sof_free_debug(sdev);
 		snd_sof_remove(sdev);
+		sof_ops_free(sdev);
 	}
 
-	sof_ops_free(sdev);
-
 	/* release firmware */
 	snd_sof_fw_unload(sdev);
 
-- 
2.40.1



