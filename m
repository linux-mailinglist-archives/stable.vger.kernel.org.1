Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F72703855
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbjEORbj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbjEORbK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8C14930
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800D462084
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EAAC433EF;
        Mon, 15 May 2023 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171687;
        bh=9lzqGye6+idj4w5EqB2Kh33HZuYJ35XYhK8eGB5pQEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMrgrr1L+YmlMQ3Z8kZrRclwcImMeGHcKvIoE3tEySMjEx59nsUGBbwJar+nGwZmR
         8sSVueeMjfq6sjv+HeymFwSHMWiWyPe5rc/cem1BXj+BFA/DPKqDwuROXhjIb0Klnk
         uxDr3SZ7MAcYQewvV/RCeMgHMutan9OS1p4EINuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bard Liao <bard.liao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 016/134] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
Date:   Mon, 15 May 2023 18:28:13 +0200
Message-Id: <20230515161703.536518243@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

[ Upstream commit 3aa1e96a2b95e2ece198f8dd01e96818971b84df ]

A BE connected to more than one FE, e.g. in a mixer case, can go
through the following transitions.

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
stop FE2    -> BE state is STOP (see note [1] below)
release FE1 -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
release FE1 -> BE state is START
stop FE2    -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
play FE2    -> BE state is START (no change)
pause FE1   -> BE state is START (no change)
pause FE2   -> BE state is PAUSED
release FE1 -> BE state is START
release FE2 -> BE state is START (no change)
stop FE1    -> BE state is START (no change)
stop FE2    -> BE state is STOP

The existing code for PAUSE_RELEASE only allows for the case where the
BE is paused, which clearly would not work in the sequences above.

Extend the allowed states to restart the BE when PAUSE_RELEASE is
received, and increase the refcount if the BE is already in START.

[1] the existing logic does not move the BE state back to PAUSED when
the FE2 is stopped. This patch does not change the logic; it would be
painful to keep a history of changes on the FE side, the state machine
is already rather complicated with transitions based on the last BE
state and the trigger type.

Reported-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 83977a715a61d..7f96b7d4b3dac 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2155,7 +2155,10 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			if (!be->dpcm[stream].be_start &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto next;
 
 			be->dpcm[stream].be_start++;
-- 
2.39.2



