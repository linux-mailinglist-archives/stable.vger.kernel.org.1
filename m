Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65B7B88A7
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbjJDSSV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbjJDSSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0485A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7213C433C8;
        Wed,  4 Oct 2023 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443495;
        bh=0g5xlZwZmusASmT1Rt5j2YqZeuoiOFVHb2O2ndrEBPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dx2XjkhjWTLfKG0SC3YC0ovxGqXkBB/UBmAMetICq4doEm2KWzWha45OXl5ShqPBc
         uURS+LrPC3YglMUGHwxuXp3FyqbtdvY54hkdzGnYKRKXSSU0kIYMzYTpcZuYhuFbPj
         KDzAW1Z+eR2NPtS4W6Rk87N1zROj+ovrvITgS+yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/259] ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag
Date:   Wed,  4 Oct 2023 19:55:49 +0200
Message-ID: <20231004175225.366893910@linuxfoundation.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 2f9426905a63be7ccf8cd10109caf1848aa0993a ]

The rpmsg pcm device is a device which should support
double buffering.

Found this issue with pipewire. When there is no
SNDRV_PCM_INFO_BATCH flag in driver, the pipewire will
set headroom to be zero, and because rpmsg pcm device
don't support residue report, when the latency setting
is small, the "delay" always larger than "target" in
alsa-pcm.c, that reading next period data is not
scheduled on time.

With SNDRV_PCM_INFO_BATCH flag in driver, the pipewire
will select a smaller period size for device, then
the task of reading next period data will be scheduled
on time.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1694414287-13291-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 35049043e5322..933bac7ea1864 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -19,6 +19,7 @@
 static struct snd_pcm_hardware imx_rpmsg_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
-- 
2.40.1



