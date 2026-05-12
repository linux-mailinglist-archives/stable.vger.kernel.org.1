Return-Path: <stable+bounces-245512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM0/A9gvA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:49:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 663FC5219FA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864A230E5CEA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A82397323;
	Tue, 12 May 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l8pT5mHr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A583B8139
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590013; cv=none; b=kiURZ12IxxpLG3iSAglOCltg115FmLiS7/wxF1qfRr2fuCEvQRkRGmlVP34gpjWw5PC05X3NxnrKyXofL/SYutroNnF3pvyHZqf0iGKjkaobn9GwUItllmqqxFRElbA4igf76R+kZBDNGMn9zXEbMgFMMDwPIdfvIqEZ23B/E38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590013; c=relaxed/simple;
	bh=+hpxov8+8u0C3RM9PL21dAE9jqu50fgk5toYyPbKYA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z5XDToF3PDDOCEde3zF1EOK5gF272Hmlp2G3+Zl2FdUKpE5eBx02ny+nQUUqEB2799qsbaSmLLZ9hGZ0vKcsS8egcMOF0sqNz2G6WDRDykdREGvsC5Q6sITOKg+lVbjVAFSQZQBQ6EkF6fzQSXXohyUrTgT2HUEcz2lgIMTcCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l8pT5mHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B5C2BCF5;
	Tue, 12 May 2026 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590012;
	bh=+hpxov8+8u0C3RM9PL21dAE9jqu50fgk5toYyPbKYA8=;
	h=Subject:To:Cc:From:Date:From;
	b=l8pT5mHruIPhBHIm0uK+diWuPhM/qSDxCXpqXM/uG+o3HOzqTpFpa1geCLDee7qxl
	 huLvfg+xmh57xyrhh2BNPwJPSxWiLlgPQgnPqOBJTR1bs9FRaAL17rrI5ffwI+rGzt
	 9jUfD804pW6LKWfq5zlRhcw8Us/uHD8htwP0GlC8=
Subject: FAILED: patch "[PATCH] spi: syncuacer: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,masahisa.kojima@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:45:42 +0200
Message-ID: <2026051241-embezzle-retrial-5eb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 663FC5219FA
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
	TAGGED_FROM(0.00)[bounces-245512-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linaro.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 75d849c3452e9611de031db45b3149ba9a99035f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051241-embezzle-retrial-5eb7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75d849c3452e9611de031db45b3149ba9a99035f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:50 +0200
Subject: [PATCH] spi: syncuacer: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
Cc: stable@vger.kernel.org	# 5.3
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-21-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index d0a875249910..290c439897c4 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -716,7 +716,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_controller(sspi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -737,9 +737,15 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
+
+	spi_controller_put(host);
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)


