Return-Path: <stable+bounces-247481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LWqOXHZBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:29:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D254B498
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 779B13034A36
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED23FE647;
	Fri, 15 May 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JfEX5Ng2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5C3FAE07
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833723; cv=none; b=uvTfnVTmBzNbDCYyu5wScyxIeoJaWWikKk3edSl1ARkL24baxYQE3gD/TYfpxJRCF700JkWV9cT8NRgOMmiZx7AVNnHlmdQUaUAfqT3/pLOeKTRw4LdGYVIX73RtpmIclJvA1kC84y/h6tW6SOC6mrMY2/fhC7czBixL/UNaWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833723; c=relaxed/simple;
	bh=AIOdgQE2AdmbkPoOsKUXNZsfMTwd0hvUZfmgt6OVQN4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eF+tN6KNF9Zm81qK3G9a2DUAiA57k/1Sk3bx4K7UJWncbsQKvx0Dcq6DuzCRHUO2rwJBzHaecNsHu8mTuvnqp9RZ1a9C9/MZifDXadXpg2toOulRUfJAoJkYg7+Zvg+0eoo0vOMFzddck4+Q2X2n5/aRzqPlL0zA9bwnxSXcV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JfEX5Ng2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA9C2BCB0;
	Fri, 15 May 2026 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833722;
	bh=AIOdgQE2AdmbkPoOsKUXNZsfMTwd0hvUZfmgt6OVQN4=;
	h=Subject:To:Cc:From:Date:From;
	b=JfEX5Ng253fldMMmUm6sBb0w97pnjTEECpW09Qc/nMTqrzbKOujbiXrITtIdDKfIm
	 8rOkAUfEN0/t1gi8agD+pJ7rsJ/Of2xTHblhybrBXeMqSY1gdOKkGCmO6id2EgDCGk
	 GahgwW7BCIZBNkLPA0w+1SqSqZQxY8E0fTKiyxew=
Subject: FAILED: patch "[PATCH] spi: fsl: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,hkallweit1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:28:12 +0200
Message-ID: <2026051512-magnetize-spoiling-b806@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B8D254B498
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247481-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b7abfed4c3754062d1f3ffd452e65a38667f586
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051512-magnetize-spoiling-b806@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b7abfed4c3754062d1f3ffd452e65a38667f586 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 08:47:49 +0200
Subject: [PATCH] spi: fsl: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 4178b6b1b595 ("spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup")
Cc: stable@vger.kernel.org	# 4.3
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410064749.496888-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bf3fc3ce0cc2..1252c41c206f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_probe;
 
@@ -705,7 +705,13 @@ static void of_fsl_spi_remove(struct platform_device *ofdev)
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -751,7 +757,13 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");


