Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F687B87B4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbjJDSI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjJDSI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD761A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22757C433C7;
        Wed,  4 Oct 2023 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442902;
        bh=K+IhzgOK8EzhXP3FEfsBlBB24zO2fOcIDGj4rohlmBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOv04MEAyfsEVny/H3fHzcrgV1WX3rQRLQ9/r3fqjPr+4yDuYddVowab7apebxl+p
         8sfyJohfkMtP8vNU+azY2B2W/9vBxuKuWvyM2oxsZF4ykU0XUrQWrOQpCpRNz3RVGZ
         OPg2iJYQT6zwz5ge1IExcu8O9FTHai6awxczpxuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "=?UTF-8?q?Daniel=20P . =20Berrang=C3=A9?=" <berrange@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 149/183] watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
Date:   Wed,  4 Oct 2023 19:56:20 +0200
Message-ID: <20231004175210.247158132@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit ef9b7bf52c2f47f0a9bf988543c577b92c92d15e upstream.

Daniel reported that the commit 1ae3e78c0820 ("watchdog: iTCO_wdt: No
need to stop the timer in probe") makes QEMU implementation of the iTCO
watchdog not to trigger reboot anymore when NO_REBOOT flag is initially
cleared using this option (in QEMU command line):

  -global ICH9-LPC.noreboot=false

The problem with the commit is that it left the unconditional setting of
NO_REBOOT that is not cleared anymore when the kernel keeps pinging the
watchdog (as opposed to the previous code that called iTCO_wdt_stop()
that cleared it).

Fix this so that we only set NO_REBOOT if the watchdog was not initially
running.

Fixes: 1ae3e78c0820 ("watchdog: iTCO_wdt: No need to stop the timer in probe")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20221028062750.45451-1-mika.westerberg@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/iTCO_wdt.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 96ff06d7d735d..a8052a3faaabb 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -424,14 +424,18 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
-static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+/* Returns true if the watchdog was running */
+static bool iTCO_wdt_set_running(struct iTCO_wdt_private *p)
 {
 	u16 val;
 
-	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is * enabled */
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled */
 	val = inw(TCO1_CNT(p));
-	if (!(val & BIT(11)))
+	if (!(val & BIT(11))) {
 		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+		return true;
+	}
+	return false;
 }
 
 /*
@@ -522,9 +526,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
 		/*
 		 * Bit 13: TCO_EN -> 0
@@ -576,7 +577,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	iTCO_wdt_set_running(p);
+	if (!iTCO_wdt_set_running(p)) {
+		/*
+		 * If the watchdog was not running set NO_REBOOT now to
+		 * prevent later reboots.
+		 */
+		p->update_no_reboot_bit(p->no_reboot_priv, true);
+	}
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
-- 
2.40.1



