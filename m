Return-Path: <stable+bounces-258215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKPBA2MkG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED6610A1E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9BD300C3AD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A78341AC7;
	Sat, 30 May 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPeoSpcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A99261B9E;
	Sat, 30 May 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163600; cv=none; b=NP9SIiS2cjvumkX3MPsGN7TJ122jL5BldaxmD7Lv6IOEOMmkWCmdnW1fLNUUngmM79OBGlB+qobM7k7O7fP7vyeYjf7PHwlqL/H6SwkxnfKL/T92CrsiIQ0vDPTymRvr81bXSwtsJcWrtQHwl7ooaJQlZ4wflYYf0iKIyROFe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163600; c=relaxed/simple;
	bh=nUSIcGIz9qykFq1snfpFAlEdQGh5+dQ0tFdENS50Atk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z94+yXfjE35KUa4+45HGlIe1NJxOLn9xlJ0QCOuMfAlHT+DQ8SDCuT6Tn78zh7wLCzwl3pTUUNDPU9QQeRaMXWqo9vx3dySrqs6TezKi6Ib3Q1dxMzmNfGRZt63atIVi3Y3EBhgUI6m8gBL3xKJtZcroEP4cufuSCULMP1GtKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPeoSpcx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C571F00893;
	Sat, 30 May 2026 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163598;
	bh=zpJC14mk2NHHFvuxBsfjIpCh7xSw2Vu6D0EejRwXW94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPeoSpcxm98ffHszemVbv1UknR8Bj+7Y8wJfIUEFhEngWnAleHdZmaf1psoJ6NGUA
	 Tq72gyR5Bygt6RZLDoOUae9R73V3RvAEn1sD6ZErd3SssMh0El295AnOwOs0aoskb1
	 OBliLKM78dKEYIgnZguhiNXtHQV9FtwviB2ikkMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjit Waghmode <ranjit.waghmode@xilinx.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 307/776] spi: zynqmp-gqspi: fix controller deregistration
Date: Sat, 30 May 2026 18:00:21 +0200
Message-ID: <20260530160248.499815440@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258215-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 24ED6610A1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 6895fc4faafc9082e15e4e624b23dd5f0c98feb5 upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Cc: stable@vger.kernel.org	# 4.2: 64640f6c972e
Cc: stable@vger.kernel.org	# 4.2
Cc: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-26-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-zynqmp-gqspi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1183,7 +1183,7 @@ static int zynqmp_qspi_probe(struct plat
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto clk_dis_all;
@@ -1224,6 +1224,8 @@ static void zynqmp_qspi_remove(struct pl
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(xqspi->ctlr);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);



