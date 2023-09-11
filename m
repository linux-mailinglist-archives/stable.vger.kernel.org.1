Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CE79BA56
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjIKVOB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjIKOpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4012A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0803C433C9;
        Mon, 11 Sep 2023 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443509;
        bh=R6R7i7V7O3o3XHJtcE2VDGeToADJdzPAQLkEogX96FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKZ/pf7BKjZcXv9jPwNeskwB4ZoMFzKeJhjSVjcp3kK4pN4vNty97DWEJRldLflKI
         eUJP/BTN//Xjn5G23FW8VTbKZzJF9w4kpauDgkLWfZ3C257i3o1wMqystUMZw16cxH
         Ds9eTZy6946aZESo14qMs+95kwA7Nj4EIqz22N0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 403/737] ASoC: SOF: amd: clear dsp to host interrupt status
Date:   Mon, 11 Sep 2023 15:44:22 +0200
Message-ID: <20230911134701.881543872@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 38592ae6dc9f84b7a994c43de2136b8115ca30f6 ]

DSP_SW_INTR_STAT_OFFSET is a common interrupt register which will be
accessed by both ACP firmware and driver. This register contains register
bits corresponds to host to dsp interrupts and vice versa.

when dsp to host interrupt is reported, only clear dsp to host
interrupt bit in DSP_SW_INTR_STAT_OFFSET.

Fixes: 2e7c6652f9b8 ("ASoC: SOF: amd: Fix for handling spurious interrupts from DSP")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230823073340.2829821-7-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 2ae76bcd3590c..973bd81059852 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -351,9 +351,9 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 	unsigned int val;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
-	if (val) {
-		val |= ACP_DSP_TO_HOST_IRQ;
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET, val);
+	if (val & ACP_DSP_TO_HOST_IRQ) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
+				  ACP_DSP_TO_HOST_IRQ);
 		return IRQ_WAKE_THREAD;
 	}
 
-- 
2.40.1



