Return-Path: <stable+bounces-246994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGhdLJ2+BGoeNgIAu9opvQ
	(envelope-from <stable+bounces-246994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:10:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17652538A36
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35A2303EE8C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F23A5E81;
	Wed, 13 May 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEpWwC7Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB7383C65
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695720; cv=none; b=gxkdPNglFs26KbP4OXJMu/awPilKixOolYlEgQOj3uxFiNt/BqOGxOuhXMKRW3U609haJ4sdSDWWUDnOw70G++gNSm/+cEpji3xI6rCVz/B5Rg9I8mz99bF3y+1WPsBI/K9dNe9VtDcElKUDjTkL+F045/krwZYf2fvHqCF73qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695720; c=relaxed/simple;
	bh=JUZ72pIP0zHoJejeVmAgf9J8PzKxseeODl2BqojmV6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0XAyRf9t4nK69VjI7Kdl/WAJi6znxeXYnkMwO4+Jz1nN9mbyf9ciCzosnWaCMLNzYNh+mnv99dktEGcB/wYMKyZhWd1Xkosmbv2CKspN8BtQkWHXqxDPmjNM3sbgezcNMPeqaCSaki3NN1uGKw/vfa7uv0kVLoo3AOKowRGqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEpWwC7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DFDC19425;
	Wed, 13 May 2026 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778695719;
	bh=JUZ72pIP0zHoJejeVmAgf9J8PzKxseeODl2BqojmV6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEpWwC7YZLptc1cf+ptu1D7VRi+EtCiGg8HFEJVz0kYAHZhCT9rNXmPJo4cYU+/Vl
	 hxy9OD4TDokSwUwAmr+3G9S5ZfoJ8QI1tuMZkDn8ngWzDLX6LPlXNACYTqFekOO8NB
	 O+AncjkjnTRK8fv2coXUG9lZrONMaf4VNvOlnF0+aXLfURmKrABavvE0WN4OqXdzVr
	 vG2QjIY5ehDbfjcSDXcaVlqb/uy2nKXteBUtMkmEPLcoI5S6x0ci/CfMd9n4feL+nR
	 49IlnqZmovYcma6c+X7iB+toUxgo45xhxM2oe37v8nPJ/8EtgTmBC4EieBCfWIeIa2
	 ylv9xe7Eng+nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] spi: zynq-qspi: fix controller deregistration
Date: Wed, 13 May 2026 14:08:36 -0400
Message-ID: <20260513180836.3912674-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513180836.3912674-1-sashal@kernel.org>
References: <2026051202-herald-flaky-02b7@gregkh>
 <20260513180836.3912674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17652538A36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246994-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,xilinx.com:email]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c9c012706c9fa8ca6d129a9161caf92ab625a3fd ]

Make sure to deregister the controller before disabling it during driver
unbind.

Note that clocks were also disabled before the recent commit
1f8fd9490e31 ("spi: zynq-qspi: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Cc: stable@vger.kernel.org	# 5.2: 8eb2fd00f65a
Cc: stable@vger.kernel.org	# 5.2
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-27-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index af252500195ce..406fd9d5337ee 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -643,7 +643,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	xqspi = spi_controller_get_devdata(ctlr);
 	xqspi->dev = dev;
-	platform_set_drvdata(pdev, xqspi);
+	platform_set_drvdata(pdev, ctlr);
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -702,9 +702,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	/* QSPI controller initializations */
 	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto remove_ctlr;
 	}
 
@@ -728,9 +728,16 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  */
 static void zynq_qspi_remove(struct platform_device *pdev)
 {
-	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
+
+	spi_controller_put(ctlr);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
-- 
2.53.0


