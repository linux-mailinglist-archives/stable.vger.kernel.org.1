Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCC7ED640
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKOVwn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjKOUzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32070195
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C89AC4E777;
        Wed, 15 Nov 2023 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081747;
        bh=BIAalK+RQW4Q3t6btfzjDn8TAcOM0+Pm77y90mYTxaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbPxCg94rj4HLbRokYdmB/WmGDSHvDKrB5xrn87W9/OMmSsuOg2MewS5B9HhZNes5
         hE697cDgfwsd0NhiEyn/g7Ccku02gtvqkXRgAHjFaK6V6YQFQ12fmNReCyYoUMsIzU
         63C7BMuSXIgJ7LAGkXkbPQgNwtKYhqFcFs6SEIuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 099/191] ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described
Date:   Wed, 15 Nov 2023 15:46:14 -0500
Message-ID: <20231115204650.513290643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 4a221b2e3340f4a3c2b414c46c846a26c6caf820 ]

This patch fixes the warnings of "Function parameter or member 'xxx'
not described".

>> sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'component' not described in 'psc_dma_trigger'
   sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'substream' not described in 'psc_dma_trigger'
   sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'cmd' not described in 'psc_dma_trigger'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310061914.jJuekdHs-lkp@intel.com/
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Fixes: 6d1048bc1152 ("ASoC: fsl: mpc5200_dma: remove snd_pcm_ops")
Link: https://lore.kernel.org/r/87il7fcqm8.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/mpc5200_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 2319848821762..2e82731072c98 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -107,6 +107,9 @@ static int psc_dma_hw_free(struct snd_soc_component *component,
 
 /**
  * psc_dma_trigger: start and stop the DMA transfer.
+ * @component: triggered component
+ * @substream: triggered substream
+ * @cmd: triggered command
  *
  * This function is called by ALSA to start, stop, pause, and resume the DMA
  * transfer of data.
-- 
2.42.0



