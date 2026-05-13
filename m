Return-Path: <stable+bounces-246982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IlpAiu7BGrFNQIAu9opvQ
	(envelope-from <stable+bounces-246982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:55:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C45386D7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E2A3118BF4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AF4DC54E;
	Wed, 13 May 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElZmdlTU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9039E9A0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694305; cv=none; b=QEkP/7f+Ya0DFoMnoj1TYn++mgAZsUjhlvyP/1ovsBEJGIIsN4APnBe5WnzuI6N7dgRJo9erV/WTN/Bd4M7VoYpH9MrtcSDrLBD4PdzhV4KNltr3osR0kTQODvVrdivlON3lG7ht/K2LSsmde1CpLWGXFKsEmCsxbp1L16U1cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694305; c=relaxed/simple;
	bh=HUU4w4jDqyduSamGz8uwpN3XQS8xvZexHMMloR4So1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk/W4j8fRdtZ6L+lAGjXGeedH9XkWZOOMKSkNXrAQXgIYKU6i31Lih5RbpL4eNnZpxbc0QvrAxtZ4b/2nmvQqQL5n8LFwBrL/ZYsSCs4GvCEGURM0f867as1EvRk+zkc1JKiTqp31upxzy2pZujCqgpAxIzXwph2xl4RfBe+pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElZmdlTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646EC2BCC6;
	Wed, 13 May 2026 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694305;
	bh=HUU4w4jDqyduSamGz8uwpN3XQS8xvZexHMMloR4So1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElZmdlTUPWq/wxoNwHKPNGnTqKo5gGFi6wAk14xavj36+o5K/TfcRTomObzApZbKd
	 ZSO0zFyAymLZ+aV92VTHuAxBuOwoQDPkHueTPTsHgBN9H3aNDU2Cbi4FKlSTBmEhTv
	 SqmFRCnuKnConXP87uWmPrzsHFnBYTf2SS+nkDxauYxzFAJJqlRCOFGQqUI7sGNgCf
	 lA7WRG8NiKkOSFjPZ9w01e0I6VO09LgXqUkW6wdZRtEpAHsO0NeUNH7NqFXIQtgwqm
	 r8OK2N5lC+C0na7WXGxLg6ymqHSfg+0kJrEb8VuVnrxktf6dwnIfnOVenFWrPI3YwK
	 O16CDnAlQlubw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] spi: sun4i: fix controller deregistration
Date: Wed, 13 May 2026 13:45:01 -0400
Message-ID: <20260513174501.3896424-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513174501.3896424-1-sashal@kernel.org>
References: <2026051252-unproven-faculty-80e7@gregkh>
 <20260513174501.3896424-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B8C45386D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246982-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
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
index b1afd5e100451..ccbebf9dafa0e 100644
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


