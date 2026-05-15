Return-Path: <stable+bounces-247492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL7ZFwHbBmo6ogIAu9opvQ
	(envelope-from <stable+bounces-247492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E308C54B6F6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D258E30CA111
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8D382396;
	Fri, 15 May 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mvwxjRfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF33FF88C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833759; cv=none; b=KkJ59N+fu4cR0D5sQ1sy6yrmJTZ1PFcWXW9kCI6axmmqZ9snkYb+Mu+XU/N9dJVvBz6k9SM1bCnDTrGdtn625d/yeNvBuZQuqq2lLyxbfp5tW/4OaVVRX3Utrerzg+yoBfIp5jzrBLYCKxZK7QC2Y3b//ZXvdTFGo38UocUz5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833759; c=relaxed/simple;
	bh=cMmNRj0gGd6T5BPwjCE3iDUUT3RPYGORE8PE/lnPw8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LjrNTa/VwhID1htlbhvMJ/rIU85wWcbQkhm5AV2WIucsBual9oHYM8p7qGXMRiGGPoHQhQ9IS/RdNCpveTegUXyzpCKSC9nwyI3BfIq3LL2D4e8sww0sGTx3r09r8gPBaqojFg4nSSZ3na17TWSeHlfl1rSmYkLjrq/QFoa2xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mvwxjRfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A0C2BCB0;
	Fri, 15 May 2026 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833759;
	bh=cMmNRj0gGd6T5BPwjCE3iDUUT3RPYGORE8PE/lnPw8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=mvwxjRfcGgIVf5CSw8G1qICOQ+qyHvQAJRUHZopL62cJpAyCZMNuG4wxefqvRcGj4
	 IAmP5ZL8Vo/UhRmTVChaZmtj0N7DiEB2I2kWqb8kP2/GUfa7V/8jPTCHvJGB9wQRTy
	 nNf2FrKPl276qtKoDmBI1wv5wg2x4/ODc/Mx7rOM=
Subject: FAILED: patch "[PATCH] spi: npcm-pspi: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,tmaimon77@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:00 +0200
Message-ID: <2026051500-handmade-nanometer-fd9b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E308C54B6F6
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247492-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ebd81199e00e107980bf8c4d2c747ae50158f797
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051500-handmade-nanometer-fd9b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebd81199e00e107980bf8c4d2c747ae50158f797 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:34 +0200
Subject: [PATCH] spi: npcm-pspi: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 2a22f1b30cee ("spi: npcm: add NPCM PSPI controller driver")
Cc: stable@vger.kernel.org	# 5.0
Cc: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-5-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index e60b3cc398ec..cffef0a5977d 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -413,7 +413,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	/* set to default clock rate */
 	npcm_pspi_set_baudrate(priv, NPCM_PSPI_DEFAULT_CLK);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_disable_clk;
 
@@ -434,8 +434,14 @@ static void npcm_pspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	npcm_pspi_reset_hw(priv);
 	clk_disable_unprepare(priv->clk);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id npcm_pspi_match[] = {


