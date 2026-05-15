Return-Path: <stable+bounces-248766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKmUC9FMB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:41:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EE553C05
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10DDA3113E6D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01103BFE4C;
	Fri, 15 May 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6ErRj/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8B30569C;
	Fri, 15 May 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862575; cv=none; b=pXq4rUC3kUblcFTkp7i5/k7D67+KotFiOzYbpCvNRhYhDnwa1EPbOdiB9F8llCvls9N+xqco3sYNt66P8o1eGzjpDx0FB3oSiRrRCWDLaHgk9UKtX642riUA1n4qI11B2KxazlmUSRB9Bmn2noczQHuyqg+EM+ViHoANT1lCseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862575; c=relaxed/simple;
	bh=1D1s2m3sfhTJyJbhrhx/SCRzwrAnVbyYLOiMlFLQwwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ9thXHF1q5TFtg1JDCvSyYWBcxuCQPi2Z8/ofpDL3fVuLNTBPxpvsj1BJHM8WkSkcgwvu+r2EbwHymGDXHrUv5WnuYbFgYScDeQZpqODp7bbKqlfxNLPmzQvKRzG5SIquI5CwXM2pPHaCMyI1Y0HvydE0AAkFX4E9xTSiWrwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6ErRj/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04F9C2BCB0;
	Fri, 15 May 2026 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862575;
	bh=1D1s2m3sfhTJyJbhrhx/SCRzwrAnVbyYLOiMlFLQwwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6ErRj/h1Ht6noQ+l6WX2CEj1uIZKN+YiUeu+m9X0n2yOjpAPvnSMbaK/SGkhYBW3
	 LmAH7ej1euWYPvc1L6gCmq8lKBm8VGTET8HoyyyuhDs08hiqKsuxB3X60eczyvvaNf
	 a0n/G27AaP9jgjISaLB1TZRKrz54v9chekIfk+uQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingoo Han <jg1.han@samsung.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 102/201] spi: rspi: fix controller deregistration
Date: Fri, 15 May 2026 17:48:40 +0200
Message-ID: <20260515154700.751086371@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E24EE553C05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248766-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,samsung.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9944fa6726afb1e6eb7e2212764e7da0c97f2dcc upstream.

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 9e03d05eee4c ("spi: rcar: Use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.14
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-11-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-rspi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1171,8 +1171,14 @@ static void rspi_remove(struct platform_
 {
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(rspi->ctlr);
+
+	spi_unregister_controller(rspi->ctlr);
+
 	rspi_release_dma(rspi->ctlr);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(rspi->ctlr);
 }
 
 static const struct spi_ops rspi_ops = {
@@ -1376,9 +1382,9 @@ static int rspi_probe(struct platform_de
 	if (ret < 0)
 		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error3;
 	}
 



