Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899BA7B8A3F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbjJDSdm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244356AbjJDSdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4498
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479DCC433C8;
        Wed,  4 Oct 2023 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444416;
        bh=S129Yj3mGlAofaD+zi8EgzsYO+DXH8kSoZyNffIExls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y07wK1B1SLMJI+ZjxSO+Sal3qmLX97grkMJdDwLePolXHgerk+4LY2c90DO0DkE/u
         c6dte6gXRVt4jzOpmMJEgpnX+sbcX0QfMmsCOkRzMRp7L4QsFoAY6XMBDdFDR6EhgR
         JZVOMozD3MCAShfO/OJFyK4cZHPuBu1sU/7ID0Vg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 214/321] ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
Date:   Wed,  4 Oct 2023 19:55:59 +0200
Message-ID: <20231004175239.169546322@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 2d066c6a78654c179f95c9beda1985d4c6befa4e ]

In SoundWire mode leave hard RESET asserted when exiting probe,
and wait for an UNATTACHED notification before deasserting RESET.

If the boot state of the reset GPIO was deasserted it is possible
that the SoundWire core had already enumerated the CS42L42 before
cs42l42_sdw_probe() is called. When cs42l42_common_probe() hard
resets the CS42L42 it triggers a race condition:

1) After cs42l42_sdw_probe() returns the thread that called it
   will call cs42l42_sdw_update_status() to report the last
   status recorded by the SoundWire core.

2) The SoundWire bus master will see a PING with the CS42L42
   now reporting as unenumerated and will trigger the core
   SoundWire code to start enumerating CS42L42.

These two threads are racing against each other. If (1)
happens before (2) a stale ATTACHED notification will be
reported to the cs42l42 driver when in fact the status of
cs42l42 is now unattached.

To avoid this race condition:

- Leave RESET asserted on exit from cs42l42_sdw_probe().
  This ensures that an UNATTACHED notification must be
  sent to the cs42l42 driver. If cs42l42 was already
  enumerated it will be seen to drop off the bus, causing
  an UNATTACH notification. If it was never enumerated the
  status is already UNATTACHED and this will be reported
  by thread (1).

- When the UNATTACH notification is received, release RESET.
  This will cause CS42L42 to be enumerated and eventually
  report an ATTACHED notification.

- The ATTACHED notification is now valid.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230913150012.604775-4-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42-sdw.c | 20 ++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 11 ++++++++++-
 sound/soc/codecs/cs42l42.h     |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index eeab07c850f95..974bae4abfad1 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -344,6 +344,16 @@ static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
 	switch (status) {
 	case SDW_SLAVE_ATTACHED:
 		dev_dbg(cs42l42->dev, "ATTACHED\n");
+
+		/*
+		 * The SoundWire core can report stale ATTACH notifications
+		 * if we hard-reset CS42L42 in probe() but it had already been
+		 * enumerated. Reject the ATTACH if we haven't yet seen an
+		 * UNATTACH report for the device being in reset.
+		 */
+		if (cs42l42->sdw_waiting_first_unattach)
+			break;
+
 		/*
 		 * Initialise codec, this only needs to be done once.
 		 * When resuming from suspend, resume callback will handle re-init of codec,
@@ -354,6 +364,16 @@ static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
 		break;
 	case SDW_SLAVE_UNATTACHED:
 		dev_dbg(cs42l42->dev, "UNATTACHED\n");
+
+		if (cs42l42->sdw_waiting_first_unattach) {
+			/*
+			 * SoundWire core has seen that CS42L42 is not on
+			 * the bus so release RESET and wait for ATTACH.
+			 */
+			cs42l42->sdw_waiting_first_unattach = false;
+			gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+		}
+
 		break;
 	default:
 		break;
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index dc93861ddfb02..2961340f15e2e 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2330,7 +2330,16 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 		/* Ensure minimum reset pulse width */
 		usleep_range(10, 500);
 
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+		/*
+		 * On SoundWire keep the chip in reset until we get an UNATTACH
+		 * notification from the SoundWire core. This acts as a
+		 * synchronization point to reject stale ATTACH notifications
+		 * if the chip was already enumerated before we reset it.
+		 */
+		if (cs42l42->sdw_peripheral)
+			cs42l42->sdw_waiting_first_unattach = true;
+		else
+			gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 4bd7b85a57471..7785125b73ab9 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -53,6 +53,7 @@ struct  cs42l42_private {
 	u8 stream_use;
 	bool hp_adc_up_pending;
 	bool suspended;
+	bool sdw_waiting_first_unattach;
 	bool init_done;
 };
 
-- 
2.40.1



