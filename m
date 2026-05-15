Return-Path: <stable+bounces-247493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDFnNI7ZBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:30:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F244054B4BE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62FE03022B87
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0783491C4;
	Fri, 15 May 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNJ6yHsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03133E958A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833762; cv=none; b=Zb94AsmJ7zgTpITHqLfC80Jyix07dnMilo6rJN2keEOwtNDlnJfcF4oxmBu/5S3HE7L/a6dOp7Y1XxCapUqdobqf/14zmkQTrh8KIred9KvrFfQPLdLBkKLbV8HEygxVNuparq13h3zmx8O6IswyEiRpvPNNXPx+nq+tMQ3on4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833762; c=relaxed/simple;
	bh=CQ/OaVb/5lVjfVcEtCewkkqmmQiUkN//9S4WCZfhH98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E9SObJQeFI5257pME9ypK12YBhMpHUZFgJxNnb8CL+0xK89WgJdV9EbgoYvrcso+cHygcbOTUcslsXen46SkohWumGoRK+AZSsjPcUIOzK1FlJaw4HP32vGjtsU/VYLMmCtNOZ0fMqv94BjYHlZ8jSIYza3YM0cE3//fzt8vgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CNJ6yHsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F377C2BCB8;
	Fri, 15 May 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833762;
	bh=CQ/OaVb/5lVjfVcEtCewkkqmmQiUkN//9S4WCZfhH98=;
	h=Subject:To:Cc:From:Date:From;
	b=CNJ6yHsctSs2Be0OL8/zWxz9azL0hzlja1jyO6iW/C5LMBQUFprZH0+9rQjaDVqKs
	 nELopg4xeY3EyPvFflIQY14UXATwPQ03mEAu+2W3bc/v5mvHU1sIyANIaKc/SA+0gq
	 6MA7cn1lAuMKbCGQ0eBRCgXQhwlPmyHeihHsvU2k=
Subject: FAILED: patch "[PATCH] spi: npcm-pspi: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,tmaimon77@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:01 +0200
Message-ID: <2026051501-repurpose-robin-8d96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F244054B4BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247493-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ebd81199e00e107980bf8c4d2c747ae50158f797
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051501-repurpose-robin-8d96@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


