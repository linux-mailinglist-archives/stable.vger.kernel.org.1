Return-Path: <stable+bounces-247491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJZqNhLbBmo6ogIAu9opvQ
	(envelope-from <stable+bounces-247491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1854B728
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDD93002122
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89E40149F;
	Fri, 15 May 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mmfuH4S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD58401489
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833756; cv=none; b=EEkfq23l8kbL3jBQYiDXrnxPeib1/X6vUi1lfVtXzke/3pxcDmkPdKghfwNl6h6fplKPUiVDaqri/vHH0l++0e3F9ABhtvy3T4kXWgD6hF/cSqKTuLMWj/7i+focYwR2llHvPXa4lsMWQD7dx2VksF2T5IhqJAo+snweru5p+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833756; c=relaxed/simple;
	bh=CYmX3Uqsp66KYRX+dEp5MhCWbgmpgaBTZ+gKgkN9q3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SJbexBFySjZJmBPHIIRgWTvh7U1AzOo1Djr8XX8RoGBHzCy8n2K99Oonq+zCQUi0k9RC2+5xltN/lfMZv4lnI3O+QeMH0Fz94Tc6jDjRv81nGbojdCgOlrU/jp2UMBG7JH9O/F0AbosoEg5piY83rPA9vnW4RORYQTalvR7Wjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mmfuH4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4459AC2BCB0;
	Fri, 15 May 2026 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833756;
	bh=CYmX3Uqsp66KYRX+dEp5MhCWbgmpgaBTZ+gKgkN9q3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=1mmfuH4SRepr6Ak1SC4kn3egNBGoUqt4REwRUlmcNp84Ng1sGnRwvvTOFnl7tXvA8
	 8BkE3LbDgeLlClz3Gzl/aV4XodBWz8CqQpFcl2S087cGDcsI3fpXevw5RXe2J0sbgj
	 bx6DkNnoQPpfvdlTfS0GiYqJVxhjEfgaZbh/OGaA=
Subject: FAILED: patch "[PATCH] spi: coldfire-qspi: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,sfking@fdwdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:28:50 +0200
Message-ID: <2026051550-impotence-starlit-8530@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38A1854B728
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
	TAGGED_FROM(0.00)[bounces-247491-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,fdwdc.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e7c510e192ff2a1264d999575eea39a506424264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051550-impotence-starlit-8530@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7c510e192ff2a1264d999575eea39a506424264 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:09 +0200
Subject: [PATCH] spi: coldfire-qspi: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks (via runtime pm) during driver unbind.

Fixes: 34b8c6617366 ("spi: Add Freescale/Motorola Coldfire QSPI driver")
Cc: stable@vger.kernel.org	# 2.6.34
Cc: Steven King <sfking@fdwdc.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-11-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index fdf37636cb9f..b45f44de85dc 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -410,9 +410,9 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	pm_runtime_enable(&pdev->dev);
 
-	status = devm_spi_register_controller(&pdev->dev, host);
+	status = spi_register_controller(host);
 	if (status) {
-		dev_dbg(&pdev->dev, "devm_spi_register_controller failed\n");
+		dev_dbg(&pdev->dev, "failed to register controller\n");
 		goto fail1;
 	}
 
@@ -436,11 +436,17 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	/* disable the hardware (set the baud rate to 0) */
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
 	mcfqspi_cs_teardown(mcfqspi);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP


