Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A447B87B3
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbjJDSIX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243850AbjJDSIW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC463AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC51C433C7;
        Wed,  4 Oct 2023 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442899;
        bh=5ArtlZzBMk1shb8+n0lLZSnOdIjxu0qGY7OIjIon8Fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imkdu5osqcfkDAgTfseHjw4hP4F62JNA2Dxaz8SsdO3h+qpLqs0IK2FL4N28MD6My
         p72goqRahc+O4048oKS5l/cCNgsOb950DcE/ZFSEasgcDiHKsqNev3Doxbd8XHCaOy
         kwuwmro45jy4V8KC5sy6HIdR/w9oIjviWYlxT2eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Malin Jonsson <malin.jonsson@ericsson.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 148/183] watchdog: iTCO_wdt: No need to stop the timer in probe
Date:   Wed,  4 Oct 2023 19:56:19 +0200
Message-ID: <20231004175210.206504989@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 1ae3e78c08209ac657c59f6f7ea21bbbd7f6a1d4 upstream.

The watchdog core can handle pinging of the watchdog before userspace
opens the device. For this reason instead of stopping the timer, just
mark it as running and let the watchdog core take care of it.

Cc: Malin Jonsson <malin.jonsson@ericsson.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20210921102900.61586-1-mika.westerberg@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/iTCO_wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index ced2fc0deb8c4..96ff06d7d735d 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -424,6 +424,16 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is * enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11)))
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -566,8 +576,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	iTCO_wdt_set_running(p);
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
-- 
2.40.1



