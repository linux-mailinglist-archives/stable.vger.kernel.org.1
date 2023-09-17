Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B47A3AD1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbjIQUJK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbjIQUIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA86B5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A395DC433C8;
        Sun, 17 Sep 2023 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981330;
        bh=zYRfxKPcriCvoGI9fywpXsZmSrvi6rqJoeM8DZLje/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozJ3lrQ6rl2EGJkb53ADmogqYWr5r9CIpjGTbLASBqZYhgcrMsHm1AUJfnDaU2HBL
         xFpnqXOX7hElAczxzPdxuRYRhafih9O63nS4czfAmFLQmu/52hTmwcpbUx8yPsyrMw
         sSz+z11foMkPPwZnqZBdlBWa9H61RvdnbwxJSQTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuming Fan <shumingf@realtek.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 021/511] ASoC: rt711: fix for JD event handling in ClockStop Mode0
Date:   Sun, 17 Sep 2023 21:07:28 +0200
Message-ID: <20230917191114.341841680@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit b69de265bd0e877015a00fbba453ef72af162e0f ]

When the system suspends, peripheral Imp-defined interrupt is disabled.
When system level resume is invoked, the peripheral Imp-defined interrupts
should be enabled to handle JD events.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reported-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230721090654.128230-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711-sdw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 4fe68bcf2a7c2..9545b8a7eb192 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -541,8 +541,15 @@ static int __maybe_unused rt711_dev_resume(struct device *dev)
 	if (!rt711->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt711->disable_irq == true) {
+			mutex_lock(&rt711->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
+			rt711->disable_irq = false;
+			mutex_unlock(&rt711->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
-- 
2.40.1



