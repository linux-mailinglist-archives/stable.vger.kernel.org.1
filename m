Return-Path: <stable+bounces-247512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFoDD3rbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE254B793
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5967A30DA67F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9461401A36;
	Fri, 15 May 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JpLP/Gdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56B402434
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833817; cv=none; b=Z6DNN0NIdWOr9R3x9232zBN0p9m7y2QFF3NxO9HTQ8c+7I0UPDksLV+/R3DK8egZpThf4lc4OoIjEh7KIe2Ivj9tJQT4q38fnsgEQK4b92s2q9wLG0sDoL4HwB6q15o13ooY1Dfa2JFVBhDzA5ai6F3SS6YCohGCAekp4hbzOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833817; c=relaxed/simple;
	bh=uw2OOMuGojL+WGw11AcjsBxI48F62NUQEMug4vzNLkc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wad6vzijceWBepPL+sqq1qmATEjEwvY6oHsXQlFgiEmqBczxdVsI/hbIfMHQo/Bs1cLkjuQ2Mia9EmrJFoeXevBBHepV/6Jm303Nfw4Ve99NSsIM3YhFVuS92WUClKxYJ87rbnJCh8KYXYsGPsQxyQNhM72x4INlZTKWaya/z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JpLP/Gdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D791C2BCB0;
	Fri, 15 May 2026 08:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833817;
	bh=uw2OOMuGojL+WGw11AcjsBxI48F62NUQEMug4vzNLkc=;
	h=Subject:To:Cc:From:Date:From;
	b=JpLP/GdbqQihxiqztWb64iSCklU7cNooOCf1JKVSnktGLLrcm9pOHMDNdc53hyUiJ
	 LZET1dcOTisQa/3GJoFMnS0KYqJXHVrsmhP9YGS5fTmxR8ZO91gUcWVbfNfK8RdNlR
	 4BZkNvRGNHgmT3ouoi1grhTwqdS1jYXVN0As/zxI=
Subject: FAILED: patch "[PATCH] spi: sh-msiof: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,geert+renesas@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:55 +0200
Message-ID: <2026051555-asparagus-opium-98ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8AAE254B793
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
	TAGGED_FROM(0.00)[bounces-247512-lists,stable=lfdr.de];
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
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux-m68k.org:email,gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 45170f67a08b912ead6ccc387ba06954d1d4e53a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051555-asparagus-opium-98ab@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45170f67a08b912ead6ccc387ba06954d1d4e53a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:43 +0200
Subject: [PATCH] spi: sh-msiof: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 1bd6363bc0c6 ("spi: sh-msiof: Use core message handling instead of spi-bitbang")
Cc: stable@vger.kernel.org	# 3.15
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-14-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7f3e08810560..f114b6313f4f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1289,9 +1289,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err2;
 	}
 
@@ -1309,8 +1309,14 @@ static void sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
+	spi_controller_get(p->ctlr);
+
+	spi_unregister_controller(p->ctlr);
+
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(p->ctlr);
 }
 
 static const struct platform_device_id spi_driver_ids[] = {


