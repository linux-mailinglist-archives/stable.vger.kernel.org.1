Return-Path: <stable+bounces-242127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAqbIsJe82lT1wEAu9opvQ
	(envelope-from <stable+bounces-242127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A34A3B60
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A600300A638
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BE40FDA1;
	Thu, 30 Apr 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ikg1185U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025F3A4F32
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557183; cv=none; b=Fo2m/EmP5/YczMs22ZbmjVlzBFt2zd8BAAFHunaS42BjEsMMEivppnS9CoDw6v2DABweulgiLYnBkGvwNXLuJcpRuDF7rxj32AEcn8oy3Ko9XMacCHHDNlpKivQjSS3p5TWwNw6kCeG+nQioVDlaZtSk8x/l/S6U0PSdTSsBotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557183; c=relaxed/simple;
	bh=ZtbvF+vPb+VH2cT1LltZ4eNrjkHRpA87feuipyiSJO8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qUWBDRzfrO0a/+w/+YP7G66cAzvuXJDszGkO/x5cBMPaP9x9xc4hDNTHV9b8jnAgovTtbzQs/fD+UMMv4HMd9hTEjiBJ9oUNKpxW5/Zt7wmDDME+67mnB7bXk0LOb0/bry9JyUHO5eTA3eiDD9bWrjHdl4TZPIUluMa87kkIB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ikg1185U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13710C2BCB3;
	Thu, 30 Apr 2026 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777557183;
	bh=ZtbvF+vPb+VH2cT1LltZ4eNrjkHRpA87feuipyiSJO8=;
	h=Subject:To:Cc:From:Date:From;
	b=Ikg1185URFqDdLlNUNPb7ZIQKRg0Fh/3SR1JmwkY/dwSxEkiut/34fd/W9DsyuNIK
	 3MEsZUM2673uhA/vhT3KeYPhwViqLnN0bK7FIkHtRr2E8KWEq7GIfz7/lVCKS5ofWK
	 M/wnyQpTxrKyAYW/dchP/pxytlDx+yd1CtgLxl5E=
Subject: FAILED: patch "[PATCH] spi: imx: fix use-after-free on unbind" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Apr 2026 15:52:52 +0200
Message-ID: <2026043052-amplify-gag-dbbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 113A34A3B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242127-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,pengutronix.de:email]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c78c2002380a1fe31bfb01a3d5f29809e55a096
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026043052-amplify-gag-dbbc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c78c2002380a1fe31bfb01a3d5f29809e55a096 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 24 Mar 2026 09:23:22 +0100
Subject: [PATCH] spi: imx: fix use-after-free on unbind

The SPI subsystem frees the controller and any subsystem allocated
driver data as part of deregistration (unless the allocation is device
managed).

Take another reference before deregistering the controller so that the
driver data is not freed until the driver is done with it.

Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller")
Cc: stable@vger.kernel.org	# 5.19
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260324082326.901043-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 64c6c09e1e7b..a8d90c86a8a1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2401,6 +2401,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
+	spi_controller_get(controller);
+
 	spi_unregister_controller(controller);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
@@ -2414,6 +2416,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
+
+	spi_controller_put(controller);
 }
 
 static int spi_imx_runtime_resume(struct device *dev)


