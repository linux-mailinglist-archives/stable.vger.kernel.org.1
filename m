Return-Path: <stable+bounces-246971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOpNNri1BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:32:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221D53817D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31129300D91C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AEF4C8FF0;
	Wed, 13 May 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldyoZl6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA33FFAB7
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693526; cv=none; b=eOj6BZAIIwxjHsYc+cXlsWpPyx62zWUFZw9/lgu5C3f6lsdGaHlaSiMBDMPBJTjBRuZkjH18SIF1MdqgTc2Le5lOkUJuBT0CcEOtcOp/5gs/6P1qvd/PEgP7b5nQno5+PXa2Vdx9xHzoiPvdKIYWl3bW4jI1qyvr64+tNUmVntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693526; c=relaxed/simple;
	bh=vBTx2er2YM5wH4Od8f7bRuGvuO7EqXtBqoN3LQfAd5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=au8S4rzLs17dzKEm/D6hSv0Mu/6Rf44BS/0gN3sznFbFBMcJFoPW+5wGdT7yYvkL4YyJKD6pUgGbtamMmPAUdy1uXVRojU40Qx3TtSQIC37qwy/i9Z7YFkVUNdkdPC9sYL0+JP2BZ5CiJqTXqY1TjF5UxR/32dYtzAKVGAAMHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldyoZl6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CE9C2BCB7;
	Wed, 13 May 2026 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693525;
	bh=vBTx2er2YM5wH4Od8f7bRuGvuO7EqXtBqoN3LQfAd5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldyoZl6DZ1Tw6cs8s72MEvy6tifJcBJKmGMWSNSvBp03uPPv9WWnvZLTegyC5kBbd
	 MHrE5CR7PwcWVI/NDnafQ5vrZ3uKb5enWFe2ztzadozbprYINcQU3ZrItbQzwDiCJI
	 G1rEPMTn+47aQH1VBjvv8NVewI+F12+K5F7K66M8atOVcYjRAbpo02WpzqCA/7oBPe
	 B510RtBkaYU9yWrBDn5phuqBZbkScnCxYy7eB80eU/S28f5xGcdEzUG3dNrRS4oV4N
	 r7ylAVqNlEULr7Rh3jhCp9erpoHugCqzzNASyoQszbkSq1EX/qYhL24Ys6hOA6QjJ+
	 27yqmR2/b5jLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] spi: sun4i: fix controller deregistration
Date: Wed, 13 May 2026 13:32:02 -0400
Message-ID: <20260513173202.3886782-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513173202.3886782-1-sashal@kernel.org>
References: <2026051252-playtime-pointless-2d55@gregkh>
 <20260513173202.3886782-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8221D53817D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246971-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 42108a2f03e0fdeabe9d02d085bdb058baa1189f ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b5f6517948cc ("spi: sunxi: Add Allwinner A10 SPI controller driver")
Cc: stable@vger.kernel.org	# 3.15
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-19-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1b80cfd98096b..3656515042124 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -503,7 +503,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
@@ -521,7 +521,15 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static void sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_controller *host = platform_get_drvdata(pdev);
+
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_force_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id sun4i_spi_match[] = {
-- 
2.53.0


