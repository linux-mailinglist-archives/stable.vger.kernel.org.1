Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F977ECEE3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjKOTpB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjKOTo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959061BC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16828C433C8;
        Wed, 15 Nov 2023 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077495;
        bh=ot7m9S4fe6d8Xk8ohVBWQH9ICRy7i8ARfAmVzMJU3Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fM4+0ngowynEIDR5wPKNoubpB7GcZJDbudmQZH4MOO/XkfJ4L8g9kTjraxp59+fy2
         +wISYhe8RIUWJTFX2wkZIxJSD+QPayDCyKGYUSIncPjVdsCRDKEf8/eLuxg8UW+c7v
         uD9InrtMwLarw4RnfsRR5g1H91Az9DxObwyilXjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 320/603] firmware: tegra: Add suspend hook and reset BPMP IPC early on resume
Date:   Wed, 15 Nov 2023 14:14:25 -0500
Message-ID: <20231115191635.647098262@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit ea608a01d4ee66f8b51070e623f9adb8684c0dd4 ]

Add suspend hook and a 'suspended' field in the 'struct tegra_bpmp'
to mark if BPMP is suspended. Also, add a 'flags' field in the
'struct tegra_bpmp_message' whose 'TEGRA_BPMP_MESSAGE_RESET' bit can be
set from the Tegra MC driver to signal that the reset of BPMP IPC
channels is required before sending MRQ to the BPMP FW. Together both
the fields allow us to handle any requests that might be sent too soon
as they can cause hang during system resume.

One case where we see BPMP requests being sent before the BPMP driver
has resumed is the memory bandwidth requests which are triggered by
onlining the CPUs during system resume. The CPUs are onlined before the
BPMP has resumed and we need to reset the BPMP IPC channels to handle
these requests.

The additional check for 'flags' is done to avoid any un-intended BPMP
IPC reset if the tegra_bpmp_transfer*() API gets called during suspend
sequence after the BPMP driver is suspended.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Co-developed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/tegra/bpmp.c | 30 ++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 51d062e0c3f12..c1590d3aa9cb7 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -313,6 +313,8 @@ static ssize_t tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
 	return __tegra_bpmp_channel_write(channel, mrq, flags, data, size);
 }
 
+static int __maybe_unused tegra_bpmp_resume(struct device *dev);
+
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg)
 {
@@ -325,6 +327,14 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->suspended) {
+		/* Reset BPMP IPC channels during resume based on flags passed */
+		if (msg->flags & TEGRA_BPMP_MESSAGE_RESET)
+			tegra_bpmp_resume(bpmp->dev);
+		else
+			return -EAGAIN;
+	}
+
 	channel = bpmp->tx_channel;
 
 	spin_lock(&bpmp->atomic_tx_lock);
@@ -364,6 +374,14 @@ int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->suspended) {
+		/* Reset BPMP IPC channels during resume based on flags passed */
+		if (msg->flags & TEGRA_BPMP_MESSAGE_RESET)
+			tegra_bpmp_resume(bpmp->dev);
+		else
+			return -EAGAIN;
+	}
+
 	channel = tegra_bpmp_write_threaded(bpmp, msg->mrq, msg->tx.data,
 					    msg->tx.size);
 	if (IS_ERR(channel))
@@ -796,10 +814,21 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused tegra_bpmp_suspend(struct device *dev)
+{
+	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
+
+	bpmp->suspended = true;
+
+	return 0;
+}
+
 static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 
+	bpmp->suspended = false;
+
 	if (bpmp->soc->ops->resume)
 		return bpmp->soc->ops->resume(bpmp);
 	else
@@ -807,6 +836,7 @@ static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_bpmp_pm_ops = {
+	.suspend_noirq = tegra_bpmp_suspend,
 	.resume_noirq = tegra_bpmp_resume,
 };
 
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 5842e38bb2880..f5e4ac5b8cce8 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -102,8 +102,12 @@ struct tegra_bpmp {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_mirror;
 #endif
+
+	bool suspended;
 };
 
+#define TEGRA_BPMP_MESSAGE_RESET BIT(0)
+
 struct tegra_bpmp_message {
 	unsigned int mrq;
 
@@ -117,6 +121,8 @@ struct tegra_bpmp_message {
 		size_t size;
 		int ret;
 	} rx;
+
+	unsigned long flags;
 };
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
-- 
2.42.0



