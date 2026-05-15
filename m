Return-Path: <stable+bounces-247375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGECHEywBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC1549993
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C7F306D439
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5003093BB;
	Fri, 15 May 2026 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+zZxIb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126D3F4132
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823136; cv=none; b=PiWuBCFki3qlp8/ph8XooO/9L9pNt9LmJ3li3LTF8r17W/KJ9TN9FOWmw31spca6YfJWAAV+nbWmFreOteMOlFAu4c5zJCFubmyibCXr3QbkoOAnoud0zbf96iFRbuSWD6nCIzVMsYlXTxxidO9n2CkkimHqQD+4NXxhXLF7NwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823136; c=relaxed/simple;
	bh=R2Ao7g9Zg4nN6RiLHRO5af9cVK6OebAWEqIAE5HNOpI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nUQozbSLFjMA+7ahsxSO643Sty7dtIMBsJVVrsNdWW5ATGjBMTGizNK9ZFzveYDO+5cx/NspRz35n7GRgKxxAtH/Wk92KDovJzfsoEBTxdDzUOlE1RR8OIaDABBAzUkFDyuWsrA+n7aqD38E2/Xhwcmpl619NOFCATlb9NXKjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+zZxIb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E09DC2BCB0;
	Fri, 15 May 2026 05:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823136;
	bh=R2Ao7g9Zg4nN6RiLHRO5af9cVK6OebAWEqIAE5HNOpI=;
	h=Subject:To:Cc:From:Date:From;
	b=1+zZxIb/9081W7p/1+JYB0t/bbTSqql7AwttrsXGhOCM5jWDTmA50KKIYrcdyAqLa
	 JbuNaGBx746xZjSGfAt9k0gIre/QLypq7q8ue0xiYa/0CKAhQCDfWqaGW9Wf1GMDmI
	 I2mlzgsFPs8FkumwJXnJyWkpGrcE7fOU5gg5h8FQ=
Subject: FAILED: patch "[PATCH] spi: at91-usart: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,radu.pirea@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:32:20 +0200
Message-ID: <2026051520-clover-nemesis-ddb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CABC1549993
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
	TAGGED_FROM(0.00)[bounces-247375-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9acecc9bcff058eaef40fd7a4c3650e88b06b220
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-clover-nemesis-ddb7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9acecc9bcff058eaef40fd7a4c3650e88b06b220 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:02 +0200
Subject: [PATCH] spi: at91-usart: fix controller deregistration

Make sure to deregister the controller before disabling and releasing
underlying resources like clocks and DMA during driver unbind.

Fixes: e1892546ff66 ("spi: at91-usart: Add driver for at91-usart as SPI")
Cc: stable@vger.kernel.org	# 4.20
Cc: Radu Pirea <radu.pirea@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 76eb3ba75ab1..79edc1cd13c0 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -556,7 +556,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&aus->lock);
 	init_completion(&aus->xfer_completion);
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
+	ret = spi_register_controller(controller);
 	if (ret)
 		goto at91_usart_fail_register_controller;
 
@@ -634,8 +634,14 @@ static void at91_usart_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
+
+	spi_controller_put(ctlr);
 }
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {


