Return-Path: <stable+bounces-248588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMHqOKZPB2o9yAIAu9opvQ
	(envelope-from <stable+bounces-248588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:53:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC6554217
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE12B338ED18
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709248122C;
	Fri, 15 May 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="if+u0Vi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB13CF67B;
	Fri, 15 May 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862116; cv=none; b=LD4iP5wHWKAl3DUUY+MnS65bniFOhkjxwHgeGX6keLmcxR5swqdlXtInEIcAiBdvk97NXclLekRTHzUnunt7hs05TuzdNGfAd6yWZfMY0hx9QUdmksRametWEFGd0BDDhY5jdzs+Cy2UuivjMINpoLLjKrnL/dNbisG4e+bO6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862116; c=relaxed/simple;
	bh=7MsG61iorMdVb/bviZIZwkwjm3liE8gGtrxnt2nHlsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqd6zjhS5IZg4C+R2sHFBJ7Rj1+QEfsmmOOBj18USNZE/UtG4W0bYKmBg55fSdDwR1vEQlVLt89MiJkkcf7pySqon7+YcJNN0gI1zQQgNRp/gE1cMYP8Ls9LlRJI9cRc4x2hHL+maWx9zniTfPgnzLcG2YO3FqgV1gHnCQcx7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=if+u0Vi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86834C2BCB0;
	Fri, 15 May 2026 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862115;
	bh=7MsG61iorMdVb/bviZIZwkwjm3liE8gGtrxnt2nHlsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=if+u0Vi6klFFCTGD5QNBnZNSiYIrn/IK3jPpQ12tVq/WaEoxaAWbaX1Fe/0dO9NOc
	 GoUuDCovFuu0+t+BFiwCGmQ1hBMbOz4kg0POLV0MPCzxOehr8QVbEFilWIgqFRbybF
	 tG7o1VQkh/Vz8fyjIq7K4IphwJJdeBWOAhu+vG9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingoo Han <jg1.han@samsung.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 063/188] spi: mxs: fix controller deregistration
Date: Fri, 15 May 2026 17:48:00 +0200
Message-ID: <20260515154658.682601887@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 68AC6554217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248588-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,samsung.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 8b0d0011af20fb547aa67a1cefbf320992fd5e92 upstream.

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 33e195acf268 ("spi: mxs: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-mxs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -619,7 +619,7 @@ static int mxs_spi_probe(struct platform
 	if (ret)
 		goto out_pm_runtime_put;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register SPI host, %d\n", ret);
 		goto out_pm_runtime_put;
@@ -650,11 +650,17 @@ static void mxs_spi_remove(struct platfo
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



