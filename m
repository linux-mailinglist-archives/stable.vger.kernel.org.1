Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C079BAD5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjIKWZ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbjIKPCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:02:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A6125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:02:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13527C433C7;
        Mon, 11 Sep 2023 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444546;
        bh=pXeiyDJYmNY3Jtw6VjkAeQ1/TPTEVQmLKMyi+mWaQS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6INyiyDH2AtuahKG2ZHFIoEBJu//+2vUZgGpGry2MXpgTlF3cGDPC2WNvniycabG
         MUOpvp22aTBzyaLReui0IFSw9Kr1Ctz3RqEjtjmrzkrlnjo8kd+NXF09McvB7n53IX
         P4mY+6kO2zJCVRkc7oIkFu0RM768SyhWelRO9hT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuming Fan <shumingf@realtek.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/600] ASoC: rt711-sdca: fix for JD event handling in ClockStop Mode0
Date:   Mon, 11 Sep 2023 15:41:04 +0200
Message-ID: <20230911134634.526020098@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 23adeb7056acd4fd866969f4afb91441776cc4f5 ]

When the system suspends, peripheral SDCA interrupts are disabled.
When system level resume is invoked, the peripheral SDCA interrupts
should be enabled to handle JD events.
Enable SDCA interrupts in resume sequence when ClockStop Mode0 is applied.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reported-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230721090711.128247-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711-sdca-sdw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index e23cec4c457de..487d3010ddc19 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -442,8 +442,16 @@ static int __maybe_unused rt711_sdca_dev_resume(struct device *dev)
 	if (!rt711->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt711->disable_irq == true) {
+			mutex_lock(&rt711->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_0);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
+			rt711->disable_irq = false;
+			mutex_unlock(&rt711->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
-- 
2.40.1



