Return-Path: <stable+bounces-245537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFiiOn8nA2qj1AEAu9opvQ
	(envelope-from <stable+bounces-245537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:13:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 498D1520E0D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F778310BF11
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54D3905E1;
	Tue, 12 May 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiMftS6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A483905E8
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590138; cv=none; b=iZ2j5ZCJdsnfLWdx2OzQydvUzo0t9ySbqchV53K35dWAdjoxwahgj8Zc7sQ0I0oRwPLPDcggJ/O3MbBvb4n6f06C2k5x057kWMt7/7f/XQOgaFoOlqEFHrwg1KcfUFF9/ykXtCh0+QDOna+ZNw7MpRfGtBZr5/c+BXUJaHGv4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590138; c=relaxed/simple;
	bh=pcAXftDVVuc7ZE7goDducqWUA/tQfUwRBulkhaLQV3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sEuZGJP1Giuausu1S6lufSBfyowDoqp5X1WHmIoSTr96xuU6biDNvYxHsFINZpjmhhHUFQpxEaJHe1sClquQ7Be9WCiJ3VmMondtxT0LX9bIdedufn6w6q7qUdsGcMiDjAeHXjAfUA0gSw7uQDdYVqehMdO/AxNilT7W5uQxqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiMftS6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701A9C2BCB0;
	Tue, 12 May 2026 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590138;
	bh=pcAXftDVVuc7ZE7goDducqWUA/tQfUwRBulkhaLQV3o=;
	h=Subject:To:Cc:From:Date:From;
	b=IiMftS6jtSior5bP+qeK8I3L2iYbPpBLFoz61pJ/g+XiACwErAMx8PwmHe1GyCuol
	 oMd3nVDAAvBNInh++xPuXo3XkRw/SRAh+klZ5vPuTwNESqDix4eGI5rX9P/yHfHX7a
	 b11X3eaDMQrtmJuo+9MHkZI5fnvDvltNYL4jD2Cc=
Subject: FAILED: patch "[PATCH] spi: tegra20-sflash: fix controller deregistration" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org,jg1.han@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:46:57 +0200
Message-ID: <2026051257-afflicted-freebase-128a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 498D1520E0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245537-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,samsung.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ad7310e983327f939dd6c4e801eab13238992572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051257-afflicted-freebase-128a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad7310e983327f939dd6c4e801eab13238992572 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:52 +0200
Subject: [PATCH] spi: tegra20-sflash: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: f12f7318c44a ("spi: tegra20-sflash: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-23-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index d9d536d7f7b6..9256729f2d49 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -505,7 +505,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
 	pm_runtime_put(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_pm_disable;
@@ -528,11 +528,17 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP


