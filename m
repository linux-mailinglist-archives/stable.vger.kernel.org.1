Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E087039F0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbjEORqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjEORqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A219176E0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2719962EAD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCDFC433D2;
        Mon, 15 May 2023 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172712;
        bh=KLuqx3kSjc5fXA3+Hmba1xj5yoG/W0abJhg6nF1O4Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waM+iwQ+F2n6sqnlJzkCV/dOU/koDf6cYE+NslY1HNzoDj/HiLM9sc+BBh7os7WrA
         Q19N7xQhfm/U+o0gGUOBw6eLalKiY/Pb+GTp6jXQTwexUWL6wsszdKW5KOO1K+kDDW
         oqvaR2rN4btyYQvOcsRx1qcUvLLYr1KceoF1PpJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 242/381] rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time
Date:   Mon, 15 May 2023 18:28:13 +0200
Message-Id: <20230515161747.637457226@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 0e6255fa3f649170da6bd1a544680589cfae1131 ]

The VRTC alarm register can be programmed with an amount of seconds
after which the SoC will be woken up by the VRTC timer again. We are
already converting the alarm time from meson_vrtc_set_alarm() to
"seconds since 1970". This means we also need to use "seconds since
1970" for the current time.

This fixes a problem where setting the alarm to one minute in the future
results in the firmware (which handles wakeup) to output (on the serial
console) that the system will be woken up in billions of seconds.
ktime_get_raw_ts64() returns the time since boot, not since 1970. Switch
to ktime_get_real_ts64() to fix the calculation of the alarm time and to
make the SoC wake up at the specified date/time. Also the firmware
(which manages suspend) now prints either 59 or 60 seconds until wakeup
(depending on how long it takes for the system to enter suspend).

Fixes: 6ef35398e827 ("rtc: Add Amlogic Virtual Wake RTC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20230320212142.2355062-1-martin.blumenstingl@googlemail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-meson-vrtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index e6bd0808a092b..18ff8439b5bb5 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -23,7 +23,7 @@ static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct timespec64 time;
 
 	dev_dbg(dev, "%s\n", __func__);
-	ktime_get_raw_ts64(&time);
+	ktime_get_real_ts64(&time);
 	rtc_time64_to_tm(time.tv_sec, tm);
 
 	return 0;
@@ -96,7 +96,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 		long alarm_secs;
 		struct timespec64 time;
 
-		ktime_get_raw_ts64(&time);
+		ktime_get_real_ts64(&time);
 		local_time = time.tv_sec;
 
 		dev_dbg(dev, "alarm_time = %lus, local_time=%lus\n",
-- 
2.39.2



