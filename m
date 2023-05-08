Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEB6FA3A8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjEHJuW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjEHJuV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE04EDB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEB8621B8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910D3C4339B;
        Mon,  8 May 2023 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539419;
        bh=P1RJ20QJirQyRF3HhoWwKz3CHgv5xWwc6aSBD4SJCo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyQq3SnAzqpGf72SIz/QuSEZ26A2k/KYOV/yb2FNDTuAypDN2HeTpSwCy66/p4Vr4
         FP6MUNhnAoOS8kBzpGAU6W4XhpZr5IwGoS2GmbWP8CyXprciZ7jh0xdrz3I3UywDD+
         BWMSBBNppVDqMtKUklqrFfteGaSOV+oHkw62e/ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/611] ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm
Date:   Mon,  8 May 2023 11:37:25 +0200
Message-Id: <20230508094421.677385011@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 083a25b18d6ad9f1f540e629909aa3eaaaf01823 ]

The hw->formats may be set by snd_dmaengine_pcm_refine_runtime_hwparams()
in component's startup()/open(), but soc_pcm_hw_init() will init
hw->formats in dpcm_runtime_setup_fe() after component's startup()/open(),
which causes the valuable hw->formats to be cleared.

So need to store the hw->formats before initialization, then restore
it after initialization.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1678346017-3660-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 35a16c3f9591b..7a486ca9633c1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1649,10 +1649,14 @@ static void dpcm_runtime_setup_fe(struct snd_pcm_substream *substream)
 	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct snd_soc_dai *dai;
 	int stream = substream->stream;
+	u64 formats = hw->formats;
 	int i;
 
 	soc_pcm_hw_init(hw);
 
+	if (formats)
+		hw->formats &= formats;
+
 	for_each_rtd_cpu_dais(fe, i, dai) {
 		struct snd_soc_pcm_stream *cpu_stream;
 
-- 
2.39.2



