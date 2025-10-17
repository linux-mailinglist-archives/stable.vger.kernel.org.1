Return-Path: <stable+bounces-187264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC7BEA2C0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3190094518A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC232C929;
	Fri, 17 Oct 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6GM4K6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF992F12C6;
	Fri, 17 Oct 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715582; cv=none; b=n3qRgzn/KI8ktlUd3FbFphBw9AAjeV/5Kna0GjOTFV2WFvfuOqIgu4leJy2DrDvY5IrakYmqXYoxAmnmfwnCRAcBeMGi4ou9/1ZjwnyBAETFByLfjPmqOL/kQP84Wo9X3DDzliiv53+RkYCzHjH59lmCBNDDGpSpW6oHn5vHOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715582; c=relaxed/simple;
	bh=8/KUQ0GUD7RO7Nt3s+ycZX/CtYgRyMFeRlQJW9eHI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFnole+UTZoutxOvsOPoAc3RmWDKa4sF9bNMk8E/auqo8R95p7oqtGz0px07tpjDBbWyFI2Bd1+xg+phsK/2na/3IEeIsWFZQnvXbf7wlrigSBqeP1ZIeBOr4ZYS3LLOtQTR8rHqUUe2Zh4VWFGNPqx0qRCa5CpwtortkiMO6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6GM4K6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E4C4CEFE;
	Fri, 17 Oct 2025 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715582;
	bh=8/KUQ0GUD7RO7Nt3s+ycZX/CtYgRyMFeRlQJW9eHI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6GM4K6XfIdi149DPEo3WU1aAhBFqygmqMhErmGBvsB3+W4PLkyKJrBJqjq8h+JMy
	 ylEXS5dQFLDaFlm7Sq/4BynuqZ49WGO6smXa5p1H2BPrerf0WBG2wPRvtSf1apwZL0
	 8iUuZTos1n+a0tkkQ7qw5iIL3SONtSfQ5eJrzAPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maarten Zanders <maarten@zanders.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.17 265/371] mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N
Date: Fri, 17 Oct 2025 16:54:00 +0200
Message-ID: <20251017145211.666416306@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Zanders <maarten@zanders.be>

commit 1001cc1171248ebb21d371fbe086b5d3f11b410b upstream.

Commit f04ced6d545e ("mtd: nand: raw: gpmi: improve power management
handling") moved all clock handling into PM callbacks. With CONFIG_PM
disabled, those callbacks are missing, leaving the driver unusable.

Add clock init/teardown for !CONFIG_PM builds to restore basic operation.
Keeping the driver working without requiring CONFIG_PM is preferred over
adding a Kconfig dependency.

Fixes: f04ced6d545e ("mtd: nand: raw: gpmi: improve power management handling")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -145,6 +145,9 @@ err_clk:
 	return ret;
 }
 
+#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
+#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
+
 static int gpmi_init(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
@@ -2765,6 +2768,11 @@ static int gpmi_nand_probe(struct platfo
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
+#ifndef CONFIG_PM
+	ret = gpmi_enable_clk(this);
+	if (ret)
+		goto exit_acquire_resources;
+#endif
 
 	ret = gpmi_init(this);
 	if (ret)
@@ -2800,6 +2808,9 @@ static void gpmi_nand_remove(struct plat
 	release_resources(this);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+#ifndef CONFIG_PM
+	gpmi_disable_clk(this);
+#endif
 }
 
 static int gpmi_pm_suspend(struct device *dev)
@@ -2846,9 +2857,6 @@ static int gpmi_pm_resume(struct device
 	return 0;
 }
 
-#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
-#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
-
 static int gpmi_runtime_suspend(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);



