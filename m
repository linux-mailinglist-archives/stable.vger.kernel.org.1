Return-Path: <stable+bounces-247521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF5IK2bbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:37:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0954B76D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35F8D30BEA00
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2A3FBEB9;
	Fri, 15 May 2026 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1O4tcWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B63914FA
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833843; cv=none; b=Zq2speHElc7t/4oA9At1tmGLMCj17KgDiyQQfkye25K1rHr6nnaTu8Kh439KNbo7xkdJSEV1pqTgbrCbY9Oo/DrxzUg6Wy8I39brrnps7u7SgWqAPgsFL+x3JmA9gBEUoSKjhxTYK2X0j9vGJ6iAoa0lra76hRrItVDEDjJISFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833843; c=relaxed/simple;
	bh=IWsLX1fT9H43S0BGdc+1wltmhhYI7oWG0dxcAYTfYiU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hKn9c5v44pXVcHv+VtQD0LyDXYf4cGG8YVK713FIvBuJrYGY1fGl3N9sqR7EeMO0aLhQoRv48Z6//x6d2CnI1deCBv+Q0zHklNeUseRlF6HstsrqI2VwrxRz+zfic9ILC25czPJR8VlZb1cgavdqjOn5XzUo5hqdVLFNsLJzvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e1O4tcWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D218FC2BCB0;
	Fri, 15 May 2026 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833843;
	bh=IWsLX1fT9H43S0BGdc+1wltmhhYI7oWG0dxcAYTfYiU=;
	h=Subject:To:Cc:From:Date:From;
	b=e1O4tcWiEGo8yrl6bwyt/zYq1ajQToIY8LLhk3g46fuidGQmiAwgdFMlHFpvBf2gf
	 7i6kT0ueeFmEtrowKQVIdgziLenr+qf30XAiEFAL8T4z79/nrwojinrXQ+KMJ0xW8q
	 KffCnJKjpuz/9enVbYuHT2tmw1dJp8O0mtcTrkog=
Subject: FAILED: patch "[PATCH] spi: img-spfi: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,abrestic@chromium.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:30:18 +0200
Message-ID: <2026051518-spender-perjury-ed61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27C0954B76D
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
	TAGGED_FROM(0.00)[bounces-247521-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,chromium.org:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fc3a83b0d9c16b941c9028f5a8db9541dce4ddf2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051518-spender-perjury-ed61@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc3a83b0d9c16b941c9028f5a8db9541dce4ddf2 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:14 +0200
Subject: [PATCH] spi: img-spfi: fix controller deregistration

Make sure to deregister the controller before disabling and releasing
underlying resources like clocks and DMA during driver unbind.

Fixes: deba25800a12 ("spi: Add driver for IMG SPFI controller")
Cc: stable@vger.kernel.org	# 3.19
Cc: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-16-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 902fb64815c9..57625a3ce2f2 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -643,7 +643,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(spfi->dev);
 	pm_runtime_enable(spfi->dev);
 
-	ret = devm_spi_register_controller(spfi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -669,6 +669,10 @@ static void img_spfi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
 	if (spfi->rx_ch)
@@ -679,6 +683,8 @@ static void img_spfi_remove(struct platform_device *pdev)
 		clk_disable_unprepare(spfi->spfi_clk);
 		clk_disable_unprepare(spfi->sys_clk);
 	}
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM


