Return-Path: <stable+bounces-247461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH60Jo/OBmp7oAIAu9opvQ
	(envelope-from <stable+bounces-247461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03F54AC3E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F20E6300D938
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0B37DAB9;
	Fri, 15 May 2026 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXixubnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6236495E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830820; cv=none; b=EA9U4EiE6U5+uNI+neGnqWKloLtau3KNa/Pillp9hC16gTdvOWsphniqwpqoHpyjwXfz/BVWui8yRC7f9c4SgTtVsZpR+3s41UCl37d7LHVLcXRM+lQ5C0y+ZwcYtka8/gPiIFpaPBsgavq+v+CVk4sCyYLrEyIg0S1lt8p2xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830820; c=relaxed/simple;
	bh=flFcnag4kbVTFeRdO+q5sqPQ0hTu1zRbfdlssTFf4NY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wy84Cq8ayuknWdoSC1gVo+rscByJ9xnjGDzjIrLFfXzPxzFcDjeCJnJLIzAPoTVKHR0iRMudkmn4ZM9dUrVXCIXoGAUpykviM+5ip6g+pSLd6kjJu/mAAGiOy2HRozvI5v8q4f1zY4wDN90aMo27Sp9vWC1G3FoFICnOu7m8uCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXixubnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBCC2BCB0;
	Fri, 15 May 2026 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830820;
	bh=flFcnag4kbVTFeRdO+q5sqPQ0hTu1zRbfdlssTFf4NY=;
	h=Subject:To:Cc:From:Date:From;
	b=rXixubnMkpZPTITG3DVAqfBsP1TLFN+izFODE7RJUuyGRw2326VfEWp3xHkYVrG7j
	 ry7l6tkeWFcufcVr8M2NiQZUeDoOUQYN0CwhM7CHgif+VABw0ADaRRzoTe8BAgOMnK
	 +etNrz+fqdjgvc83ORui4FELfgX6DBNC2951TCxo=
Subject: FAILED: patch "[PATCH] spi: ep93xx: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:40:07 +0200
Message-ID: <2026051507-small-deprive-f013@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C03F54AC3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247461-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f4838934b695a58eda0833583cb8028e73a19529
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051507-small-deprive-f013@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4838934b695a58eda0833583cb8028e73a19529 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:11 +0200
Subject: [PATCH] spi: ep93xx: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 011f23a3c2f2 ("spi/ep93xx: implemented driver for Cirrus EP93xx SPI controller")
Cc: stable@vger.kernel.org	# 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-13-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 90d5f3ea6508..db50018050e5 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -689,7 +689,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
-	error = devm_spi_register_controller(&pdev->dev, host);
+	error = spi_register_controller(host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
 		goto fail_free_dma;
@@ -713,7 +713,13 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ep93xx_spi_release_dma(espi);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id ep93xx_spi_of_ids[] = {


