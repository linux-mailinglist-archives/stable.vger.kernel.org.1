Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A177ECC66
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjKOTaK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjKOTaJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6B130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9BDC433C8;
        Wed, 15 Nov 2023 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076605;
        bh=vSaNYjhgH+ybuevXhuDXiqx3yqUSqjbD2thZOhJK09c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0P+U/Wc+10jPibVsvU3j+qouizUcAmjwwVKzWnEHbu/jz8yTA3knd6hDN8QJDURd
         JJ4XgDVNKVKazTS5sF8Jcx2lKfD8dwDykIjzyfocJqWrtrSUZ0yRt7TxP3FX39X6R6
         yq3hQCyi+h00kM7kKJRj6BJEOTz1pnZsy4j/rNlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 335/550] ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described
Date:   Wed, 15 Nov 2023 14:15:19 -0500
Message-ID: <20231115191623.989188347@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 9014978100207..3f7ccae3f6b1a 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -100,6 +100,9 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
 
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



