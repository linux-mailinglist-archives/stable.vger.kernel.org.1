Return-Path: <stable+bounces-247519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LXHFpzbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED254B7E4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A814030E0009
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1D3DEAC5;
	Fri, 15 May 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZP4uHI1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2C3932EE
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833837; cv=none; b=fLUhAr8HjDDlSoPPdSGiuLkAZ6T/DS2gYg0r0ZU7pqx4NTwXDOBPeOc9lMRVFrZOmRnIOhE8PKWuvRuOrJroWgaLKf6/AXrdUY9/h7y6ASkiXiwSnXcUcTj47VvTMJeTHKySImkoDGYjHKKxmk63ldovRc0NajUJ4qNQsgpHbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833837; c=relaxed/simple;
	bh=Wb4U7CHzDmPhfpGDY0MHmlJQPdQWiGHOiNV4ZPFdrEY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AYbCWW1IqVs5j35K5M7r9qWjDumPyaTIrSdjNbCoBvEIvH7h1VoeuM3UM9Zs6E/rP+EI+6Zj97DSn2uOMdsRHpt8URmAh27CHEGBfLG41j9NoTPlna1e42V9FIgqpsdRk9DWa6K2vWTVk90l/aoVpqH5YOuD8fjB5QIJQNxdStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZP4uHI1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B022C2BCB8;
	Fri, 15 May 2026 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833837;
	bh=Wb4U7CHzDmPhfpGDY0MHmlJQPdQWiGHOiNV4ZPFdrEY=;
	h=Subject:To:Cc:From:Date:From;
	b=ZP4uHI1UEonuvAfC0VtlEEjD0AStvUNHDjb93/uArYADzN26Ucsm+uo85k6koJtm8
	 tgqT8yWSR74xnwh47IskCCGLOCM1tMlntoFgJzp2hdLMu1CX9w1GqEl73om6mwAxUz
	 eJ+/8so5vUbnaTy4Uwvwfz7e4MgNsQPTnxopmzII=
Subject: FAILED: patch "[PATCH] spi: slave-mt27xx: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,leilk.liu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:30:06 +0200
Message-ID: <2026051506-fiftieth-elite-9098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6ED254B7E4
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
	TAGGED_FROM(0.00)[bounces-247519-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,mediatek.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ab840cbda4fe6c40e52f6415c47056797c663bb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051506-fiftieth-elite-9098@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab840cbda4fe6c40e52f6415c47056797c663bb2 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:45 +0200
Subject: [PATCH] spi: slave-mt27xx: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks (by disabling runtime PM) during driver unbind.

Fixes: 805be7ddf367 ("spi: mediatek: add spi slave for Mediatek MT2712")
Cc: stable@vger.kernel.org	# 4.20
Cc: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-16-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index ce889cb33228..7aedeaa5889d 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -453,7 +453,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	clk_disable_unprepare(mdata->spi_clk);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -473,7 +473,15 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 static void mtk_spi_slave_remove(struct platform_device *pdev)
 {
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(ctlr);
 }
 
 #ifdef CONFIG_PM_SLEEP


