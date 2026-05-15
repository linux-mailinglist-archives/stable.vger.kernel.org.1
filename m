Return-Path: <stable+bounces-248765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DqQO51PB2o9yAIAu9opvQ
	(envelope-from <stable+bounces-248765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:53:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C2554208
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 090EC3113E5B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCE2798F3;
	Fri, 15 May 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2XbAv9zK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8930569C;
	Fri, 15 May 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862572; cv=none; b=A89WaEmxEa445ViBImjyjbAJ647gH52JExHMzJpgvx5p+POBLjHQQyzhDR85O0XQLmoSDU6EWCfGlXg1yAX+hf1/1DNGk43G56XGoJCwb5vDn7qYIRAlpV7oRIFHZIgEHchlP0Wm+s5stYRqZemZZXtMRazpw9M+7R3Nnw/LZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862572; c=relaxed/simple;
	bh=iudBr4CraeU3Hrh3KyQUb71fLtRVzs8oIISkh9Nmfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUe63qive1c9xLA5nw+ztK4sVexCBYC0KNj5z7MN2yFgOKAuIjvb8OjP9H2rEkiqk/BOdDEnJHVxP7YDJepPqMNGO44N6ajggvZOFriwut+ZkowxSuArwuQT6/uJeBHH9j1yZhc33qz16of8GD/qu87FJFT+OO8NBoC1V+TbCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2XbAv9zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D4C2BCB0;
	Fri, 15 May 2026 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862572;
	bh=iudBr4CraeU3Hrh3KyQUb71fLtRVzs8oIISkh9Nmfh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2XbAv9zK+C/aJ3xOrvfM728FMzggdfysfW2LeHtp7ocIqibxHxJdr78nGMVhGnkX/
	 P7IkG4+Rp1OrFFgigxj1CM+j5wDXrR9hKSnEVwkwWopIgE9p6BB/6eC05lU+myasT1
	 E5ycejX6yIupMEj5ZOgRy/JaRU9fQDGkbqhfnBmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lanqing Liu <lanqing.liu@spreadtrum.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 101/201] spi: sprd: fix controller deregistration
Date: Fri, 15 May 2026 17:48:39 +0200
Message-ID: <20260515154700.728347340@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AF6C2554208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248765-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spreadtrum.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 123d17dbc5f07059752fa5e616385ca29a8f935a upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Note that the controller is suspended before disabling and releasing
resources since commit de082d866cce ("spi: sprd: Add the SPI irq
function for the SPI DMA mode") which avoids issues like unclocked
accesses but prevents SPI device drivers from doing I/O during
deregistration.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Cc: stable@vger.kernel.org	# 4.20
Cc: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-17-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sprd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -977,7 +977,7 @@ static int sprd_spi_probe(struct platfor
 		goto err_rpm_put;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, sctlr);
+	ret = spi_register_controller(sctlr);
 	if (ret)
 		goto err_rpm_put;
 
@@ -1008,7 +1008,9 @@ static void sprd_spi_remove(struct platf
 	if (ret < 0)
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 
-	spi_controller_suspend(sctlr);
+	spi_controller_get(sctlr);
+
+	spi_unregister_controller(sctlr);
 
 	if (ret >= 0) {
 		if (ss->dma.enable)
@@ -1017,6 +1019,8 @@ static void sprd_spi_remove(struct platf
 	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(sctlr);
 }
 
 static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)



