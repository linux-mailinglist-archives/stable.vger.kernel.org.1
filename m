Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A445755364
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGPUSd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGPUSc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C2B126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA3A60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40537C433C7;
        Sun, 16 Jul 2023 20:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538710;
        bh=7zDQq9YlMZNjdo/ueWRSgcT7+mIdw9btaxgvLORz2Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBphDjb8jt1zxIJ5yPAxVIDTVcTi8IXexlLGh6mqq1qCOHp0e9aUV8psF7ehTsM05
         0uA+/Kl+618Cr4dwCq9RmmjvdGU5huUIhxuZ3cmlp3zBgT9TVRxt8kDsQWJkgNwpTm
         9jsVzgf23MWxY+P9mLQ/jENslUczR2u1B6T6XRT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Wahren <stefan.wahren@i2se.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 548/800] w1: w1_therm: fix locking behavior in convert_t
Date:   Sun, 16 Jul 2023 21:46:41 +0200
Message-ID: <20230716195001.820995556@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit dca5480ab7b77a889088ab7cac81934604510ac7 ]

The commit 67b392f7b8ed ("w1_therm: optimizing temperature read timings")
accidentially inverted the logic for lock handling of the bus mutex.

Before:
  pullup -> release lock before sleep
  no pullup -> release lock after sleep

After:
  pullup -> release lock after sleep
  no pullup -> release lock before sleep

This cause spurious measurements of 85 degree (powerup value) on the
Tarragon board with connected 1-w temperature sensor
(w1_therm.w1_strong_pull=0).

In the meantime a new feature for polling the conversion
completion has been integrated in these branches with
commit 021da53e65fd ("w1: w1_therm: Add sysfs entries to control
conversion time and driver features"). But this feature isn't
available for parasite power mode, so handle this separately.

Link: https://lore.kernel.org/regressions/2023042645-attentive-amends-7b0b@gregkh/T/
Fixes: 67b392f7b8ed ("w1_therm: optimizing temperature read timings")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Link: https://lore.kernel.org/r/20230427112152.12313-1-stefan.wahren@i2se.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_therm.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 067692626cf07..99c58bd9d2df0 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1159,29 +1159,26 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 
 			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-			if (strong_pullup) { /*some device need pullup */
+			if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+				ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
+				if (ret) {
+					dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
+					goto mt_unlock;
+				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else if (!strong_pullup) { /*no device need pullup */
 				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
 				mutex_unlock(&dev_master->bus_mutex);
-			} else { /*no device need pullup */
-				if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
-					ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
-					if (ret) {
-						dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
-						goto mt_unlock;
-					}
-					mutex_unlock(&dev_master->bus_mutex);
-				} else {
-					/* Fixed delay */
-					mutex_unlock(&dev_master->bus_mutex);
-					sleep_rem = msleep_interruptible(t_conv);
-					if (sleep_rem != 0) {
-						ret = -EINTR;
-						goto dec_refcnt;
-					}
+			} else { /*some device need pullup */
+				mutex_unlock(&dev_master->bus_mutex);
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto dec_refcnt;
 				}
 			}
 			ret = read_scratchpad(sl, info);
-- 
2.39.2



