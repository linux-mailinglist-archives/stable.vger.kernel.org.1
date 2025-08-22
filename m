Return-Path: <stable+bounces-172433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7202B31CA9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D46B437C7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DF307AEF;
	Fri, 22 Aug 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ea/jUDkk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9862FF17D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873792; cv=none; b=pO3h5xyqLHyokU/BCx5s4HxmAb6GUu+zmjgv5OPwniRePJx344S3BDAFZauFuubdODTg7wTzoqr4/GQNRUPE2FViy15WO/HGDQ7VXFcAEiVBXOil5+0a1dQ8FCJxf30IzY1AjvkKoyMcqkd2V0ueKB3O237glWVYsfxqHdwxQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873792; c=relaxed/simple;
	bh=5NzbgRUvSonQlDDUoVgpTMZVhkwqh7MbeAqvTQMqagM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mQ+ka6pTUbS+eelAyK0OXoCpR1pWdl+FZIOPrWaKXzcvHmy+5s8wFJ5DIeM2RHBHseInXiapx5lU5hvHlXZB5dQekDd7ORYUSuq9pOEzJif82rRSmL+wByFUAeTP4tPYuKDpodPE2n7zyNKJOEh7OrJBbMcBsvp/jWTBH7qB4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ea/jUDkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4199DC4CEED;
	Fri, 22 Aug 2025 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755873791;
	bh=5NzbgRUvSonQlDDUoVgpTMZVhkwqh7MbeAqvTQMqagM=;
	h=Subject:To:Cc:From:Date:From;
	b=ea/jUDkkQ9a5+a0f9jjN1YLRdKj8qJCCZL8PpALt5XOrgPE0oCSjw6u4l7LNQA92T
	 wB1V2lmiEymqp01CH1Hbdmw6dQmpPUnTPx44ZrH7XfWE4QLJ56fSvbVRq3zVyoWwcS
	 s1l6D3Z73COi5cFSpNCnn1IfTk51WzlgK/bEEq0U=
Subject: FAILED: patch "[PATCH] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1" failed to apply to 6.12-stable tree
To: jm@ti.com,adrian.hunter@intel.com,afd@ti.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:43:08 +0200
Message-ID: <2025082207-defog-stunned-9396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d2d7a96b29ea6ab093973a1a37d26126db70c79f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082207-defog-stunned-9396@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2d7a96b29ea6ab093973a1a37d26126db70c79f Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Wed, 20 Aug 2025 14:30:47 -0500
Subject: [PATCH] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1

This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
due to errata i2458 [0] so disable HS400 for these SoC revisions.

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
Fixes: 37f28165518f ("arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250820193047.4064142-1-jm@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e4fc345be7e5..17e62c61b6e6 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -156,6 +156,7 @@ struct sdhci_am654_data {
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
+#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
 };
 
 struct window {
@@ -765,6 +766,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	u32 ctl_cfg_2 = 0;
 	u32 mask;
 	u32 val;
@@ -820,6 +822,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
+	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
+		dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+	}
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -883,6 +891,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.1" },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id sdhci_am654_of_match[] = {
 	{
 		.compatible = "ti,am654-sdhci-5.1",
@@ -970,6 +984,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "parsing dt failed\n");
 
+	soc = soc_device_match(sdhci_am654_descope_hs400);
+	if (soc)
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
+
 	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 


