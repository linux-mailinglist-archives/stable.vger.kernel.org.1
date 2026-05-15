Return-Path: <stable+bounces-247434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dn8E8PNBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:39:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C557554AB70
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A8C300DE28
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089F3EB7FE;
	Fri, 15 May 2026 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCp2iu57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1F3F0A81
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830671; cv=none; b=j0+SClifWLyJFaLfaPB1sDxMEZfPtpkdMOR5wsgEfyF/SD++IUC4UmBak+e6W8/khBuazlAb9k7tVk2d6B3NGHrs3KC8cQyRvuFNlgZD8CkvcH0Kzvs4r2VHuR/LKqF/K6FEA2YX3vjn0uufM3X0NnILoK797KQVIvZCV+rr5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830671; c=relaxed/simple;
	bh=A4nXjEKxtqcEkEkt99xUjbwAUWcQDetaqCnAIKINA0E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DzTsqS2QaHgEZ5Y1gH+6kOOVDMaPl3kPvmgll7XkI8/EQtTaoV6a5u4LRVZij6ezBrv1urGLwDuhj755jNlr3gYFYM3GXDeSXliTCZHRawRcOMBLSUu13K5cTmOoahqHa6+9R8JhfFrwLs4fpUS80zuC4dn9zE2ElkDJ97pO+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCp2iu57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0DFC2BCF6;
	Fri, 15 May 2026 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830670;
	bh=A4nXjEKxtqcEkEkt99xUjbwAUWcQDetaqCnAIKINA0E=;
	h=Subject:To:Cc:From:Date:From;
	b=sCp2iu575UVt75ng291xu+rwDoYOjHNJDDvl8QYgE4DJPOeDz3FtIP8ok0caIWRqE
	 /w7l5JHjD5YChxbT98Yr4Bm3OdMDIAJUXuuxiFMElK1UpbY8KMounlC+LUI8bMhsey
	 Se219iybu7uG/Z9VWWvKa47xYhpgY2jvX45SawKY=
Subject: FAILED: patch "[PATCH] spi: mxs: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,jg1.han@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:37:41 +0200
Message-ID: <2026051541-driller-ungreased-94a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C557554AB70
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
	TAGGED_FROM(0.00)[bounces-247434-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8b0d0011af20fb547aa67a1cefbf320992fd5e92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051541-driller-ungreased-94a3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b0d0011af20fb547aa67a1cefbf320992fd5e92 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:33 +0200
Subject: [PATCH] spi: mxs: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 33e195acf268 ("spi: mxs: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index b3301c69e2de..0164e04d59a1 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -619,7 +619,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_pm_runtime_put;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register SPI host, %d\n", ret);
 		goto out_pm_runtime_put;
@@ -650,11 +650,17 @@ static void mxs_spi_remove(struct platform_device *pdev)
 	spi = spi_controller_get_devdata(host);
 	ssp = &spi->ssp;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mxs_spi_runtime_suspend(&pdev->dev);
 
 	dma_release_channel(ssp->dmach);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver mxs_spi_driver = {


