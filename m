Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAD7F4FF7
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjKVSxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 13:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbjKVSxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 13:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8801D44
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:53:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83A8C433C8;
        Wed, 22 Nov 2023 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700679180;
        bh=zxMgGobUnjmIDsLTMvbZdiXxDfoThC0jw/QQ93IEQV8=;
        h=Subject:To:Cc:From:Date:From;
        b=y6HKmOuSPfzASVpCy/6w8xP7Brhf9csjVnUugFgPHwita14bHkl8TQZw18YBxQ3D3
         wmDyBYZXN/3Fw2uR3Rs/MPlhojcxy0stnqdpcDCLFU20iONSEFFNp3KkJ1Ugxtk+wI
         6K/OnUDdJ3cstgf/yQ+YBrPXHIoQc2vrr+4zMbLo=
Subject: FAILED: patch "[PATCH] pmdomain: bcm: bcm2835-power: check if the ASB register is" failed to apply to 6.5-stable tree
To:     mcanal@igalia.com, florian.fainelli@broadcom.com,
        stefan.wahren@i2se.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 18:52:57 +0000
Message-ID: <2023112257-putdown-prozac-affa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 2e75396f1df61e1f1d26d0d703fc7292c4ae4371
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112257-putdown-prozac-affa@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

2e75396f1df6 ("pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e75396f1df61e1f1d26d0d703fc7292c4ae4371 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Tue, 24 Oct 2023 07:10:40 -0300
Subject: [PATCH] pmdomain: bcm: bcm2835-power: check if the ASB register is
 equal to enable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
refactored the ASB control by using a general function to handle both
the enable and disable. But this patch introduced a subtle regression:
we need to check if !!(readl(base + reg) & ASB_ACK) == enable, not just
check if (readl(base + reg) & ASB_ACK) == true.

Currently, this is causing an invalid register state in V3D when
unloading and loading the driver, because `bcm2835_asb_disable()` will
return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
ASB slave for V3D.

Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231024101251.6357-2-mcanal@igalia.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 1a179d4e011c..d2f0233cb620 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);
 
-	while (readl(base + reg) & ASB_ACK) {
+	while (!!(readl(base + reg) & ASB_ACK) == enable) {
 		cpu_relax();
 		if (ktime_get_ns() - start >= 1000)
 			return -ETIMEDOUT;

