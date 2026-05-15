Return-Path: <stable+bounces-248436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCnqIEFNB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B066553D09
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E9043162EE1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E93E7BA4;
	Fri, 15 May 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GuTajOtl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D52798F3;
	Fri, 15 May 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861727; cv=none; b=EE8RkVDmDB9PAcMs8W9VC2/PT+StGmCmtINH5aF2EpRTUkUTL+HFDchzWP9GYiS2xeHLNx2ukPgS4oHQH7saNel5XDB4yFGcVZjTzIyFZyoeKy8rnMb+Ao7PLhsJVXTo/YgpH1xKgn4QP3KTr37llpbPO0u4wRe4WMEkFGLYP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861727; c=relaxed/simple;
	bh=U+GzflHS1IhL3PrJyjjt6jwntL8+ZI8CWZa6zCeipso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXxZo1rMwivMZgBQjEu9FOP+XFNq3DuvuL+US32FMlQaHwfgtqpNPb97uImufuB1tbf+uIdK0Fautb1Mgq9Rt09wfozp/+O6b/p6pjt+jFeULayeyCQESPfOpNnKbmymzAwiZ1LhtHVurNQOONBO9VobcnrdWykPcoQ0ZKM03ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GuTajOtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E179CC2BCB0;
	Fri, 15 May 2026 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861727;
	bh=U+GzflHS1IhL3PrJyjjt6jwntL8+ZI8CWZa6zCeipso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuTajOtlwlgpGYwXQ42noDqmQ8aHw0LJ31pgUlasvV+zxa0QMUrHShnOEXYHJ4Y4F
	 Hwba6zWVu+NNMH4CP/ZC+VzuYRs34h/Xrbad6haLUyobpDOMwXKACCllre1Q8DRJIg
	 XPorUvg3cuF3zM7J1Mu4sC5WsdRaxAzg5Icb29HE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Zetao <lizetao1@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 441/474] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
Date: Fri, 15 May 2026 17:49:10 +0200
Message-ID: <20260515154724.627720870@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2B066553D09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248436-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zetao <lizetao1@huawei.com>

[ Upstream commit e922f3fff21445117e9196bd8e940ad8e15ca8c7 ]

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
Link: https://lore.kernel.org/r/20230823133938.1359106-18-lizetao1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e6464140d439 ("spi: microchip-core-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-microchip-core-qspi.c |   29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -519,30 +519,23 @@ static int mchp_coreqspi_probe(struct pl
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->regs),
 				     "failed to map registers\n");
 
-	qspi->clk = devm_clk_get(&pdev->dev, NULL);
+	qspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->clk),
 				     "could not get clock\n");
 
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to enable clock\n");
-
 	init_completion(&qspi->data_completion);
 	mutex_init(&qspi->op_lock);
 
 	qspi->irq = platform_get_irq(pdev, 0);
-	if (qspi->irq < 0) {
-		ret = qspi->irq;
-		goto out;
-	}
+	if (qspi->irq < 0)
+		return qspi->irq;
 
 	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
 			       IRQF_SHARED, pdev->name, qspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -553,18 +546,11 @@ static int mchp_coreqspi_probe(struct pl
 	ctlr->dev.of_node = np;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "spi_register_controller failed\n");
-		goto out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "spi_register_controller failed\n");
 
 	return 0;
-
-out:
-	clk_disable_unprepare(qspi->clk);
-
-	return ret;
 }
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
@@ -575,7 +561,6 @@ static void mchp_coreqspi_remove(struct
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
-	clk_disable_unprepare(qspi->clk);
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {



