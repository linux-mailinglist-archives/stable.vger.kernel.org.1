Return-Path: <stable+bounces-245628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBszA5QxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2792521C66
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED97F3101357
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD8360EDD;
	Tue, 12 May 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vR6nZZDi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34113905E6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593788; cv=none; b=LQ6D5xbqo1XNK0/mC6Mpu+KYG4nECUTHWkYZg1ToQuq1GPxE6QWE4MQf1hSSBASnm4eshl12kiGcpZQVOzFYZ+iih6j0gi1JwR4KGmR+cRXaB/SLIYLjffbiu+NCOo4XSmAm7oa7/sFnseWa4rrQ5/QVoJRkzehpJCV5Wzy1oO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593788; c=relaxed/simple;
	bh=AJxYDdvCxm9xCohhymp/MM63WVEWfV8ML17oo4UCEHQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=agN6aeMT8sBzKxnYqukF1/uSzTiPMs6erpM2/VLeQ8tLQRejBPsHLlz2mtxWiG65v9/BNR16MpRj17H5L6n+VGtmx5834B3YDz0450IKAHTqZVSFMOXw9V+cunkv6uOC9PEPyeZ7iTku9UEdg0vdfRZL1WLkvqEIg1Slp7IY2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vR6nZZDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA60C2BCB0;
	Tue, 12 May 2026 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593788;
	bh=AJxYDdvCxm9xCohhymp/MM63WVEWfV8ML17oo4UCEHQ=;
	h=Subject:To:Cc:From:Date:From;
	b=vR6nZZDieQ3aXZsWgUZLPKxthoD5wteRvdJPeBRJ68cFH0X+fQMeZ9WempVpMro48
	 EZeWHR414vzfm4t4dfcwXcQnfGaT+HRFVAZYyHnb1ObV1KXNcRlgKEXnyln3DoN/iB
	 9SqPTe/IQbIkm00hMNhDpQVwrTquUi7+Ab1zDhvY=
Subject: FAILED: patch "[PATCH] spi: topcliff-pch: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,masa-korg@dsn.okisemi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:49:40 +0200
Message-ID: <2026051240-defiance-marlin-3914@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2792521C66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245628-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,okisemi.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d6f477d6fc0767c57c5e1e6f55a1662820eef87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051240-defiance-marlin-3914@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d6f477d6fc0767c57c5e1e6f55a1662820eef87 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:18 +0200
Subject: [PATCH] spi: topcliff-pch: fix controller deregistration

Make sure to deregister the controller before disabling and releasing
underlying resources like interrupts and DMA during driver unbind.

Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
Cc: stable@vger.kernel.org	# 2.6.37
Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-8-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cae2dcefabea..c120436434d0 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,6 +1406,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_controller_get(data->host);
+
+	spi_unregister_controller(data->host);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1433,7 +1437,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_controller(data->host);
+
+	spi_controller_put(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,


