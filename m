Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4940770C9B3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjEVTu6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjEVTur (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A97B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4971762B03
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4DC433D2;
        Mon, 22 May 2023 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785043;
        bh=ueyEfP2NTjol+XB7hPp+1HvJlvZbTcXgw0f7TazNQiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAMTbeepOzy0kCo4suY1lL36mh1HFreF1m2UQDuAn6NKE7j+hJsFCSprMpiJMjGlC
         669EnFTlW8pP98oIzyy/2pANuhcQXc31NKe+ya6kM58L25nj2N+yQoss4rd9s1mvil
         NByiNiT2UZWO7jSKDZ/wUe4/3uv9SZqA0HAKjmp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 249/364] ASoC: SOF: ipc3-topology: Make sure that only one cmd is sent in dai_config
Date:   Mon, 22 May 2023 20:09:14 +0100
Message-Id: <20230522190418.921103774@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 4708449eafe60742334606168926985798c9c9b8 ]

The commands in sof_ipc_dai_config.flags are encoded as bits:
1 (bit0) - hw_params
2 (bit1) - hw_free
4 (bit2) - pause

These are commands, they cannot be combined as one would assume, for
example
3 (bit0 | bit1) is invalid.

This can happen right at the second start of a stream as at the end of the
first stream we set the hw_free command (bit1) and on the second start we
would OR on top of it the hw_params (bit0).

Fixes: b66bfc3a9810 ("ASoC: SOF: sof-audio: Fix broken early bclk feature for SSP")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Link: https://lore.kernel.org/r/20230512110317.5180-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-topology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index b1f425b39db94..ffa4c6dea752a 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2111,10 +2111,13 @@ static int sof_ipc3_dai_config(struct snd_sof_dev *sdev, struct snd_sof_widget *
 	 * For the case of PAUSE/HW_FREE, since there are no quirks, flags can be used as is.
 	 */
 
-	if (flags & SOF_DAI_CONFIG_FLAGS_HW_PARAMS)
+	if (flags & SOF_DAI_CONFIG_FLAGS_HW_PARAMS) {
+		/* Clear stale command */
+		config->flags &= ~SOF_DAI_CONFIG_FLAGS_CMD_MASK;
 		config->flags |= flags;
-	else
+	} else {
 		config->flags = flags;
+	}
 
 	/* only send the IPC if the widget is set up in the DSP */
 	if (swidget->use_count > 0) {
-- 
2.39.2



