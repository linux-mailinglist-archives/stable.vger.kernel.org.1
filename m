Return-Path: <stable+bounces-246405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AvQHltzA2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:37:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610A527DC1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD0131449A3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899621DED4C;
	Tue, 12 May 2026 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPn37flI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494803EDE55;
	Tue, 12 May 2026 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609141; cv=none; b=KWmhNWBBDeMHXh7LhWk4fBCFYbUYKcwcYGcRVfuJqDNtqcTUs2lWlr3T3FVZdyt2Dr85gFmVR3x5yFgLUV080FkupK9q19qVs1VWG9cUMkh2J7ZXpPgnhqBeWX6oTkjxuwu2ZidcKMkbcdpFB6zr+hG7MhHBTSXMtWEotaMQUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609141; c=relaxed/simple;
	bh=Q9kWanIz12eGF0OJaTk6Vf2KbIQuIEeEnb0CbiWPjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzmko1udEcK+HC7H1C9tMOvkD20jfGG6R9+UYAWNL22xlJJuj+25lJ0Oc3/5FbWbBk9J0a7DXONOBi8mhT22uczeMlle9I0OwNMUZ5ONuQhvJ2dpdhqUEzDM8RXk+mLblZiTkIU9E5RO3lLly6bIRm8RH6/KoQ8Ty3Pyoo2SKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPn37flI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EB4C2BCB0;
	Tue, 12 May 2026 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609141;
	bh=Q9kWanIz12eGF0OJaTk6Vf2KbIQuIEeEnb0CbiWPjCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPn37flIZ2FUIxh6SSF6EcCwMCyrSsWVPDiNGhn3hjCGm3gpZfjldSIntTbOkFIUW
	 9UaLG4C6/1H614uADqKYxWGcldZs7jMVZ/f4esBrsC/7Oxcv2ItArvDBNiKms6AUt4
	 OfV1Oj9myd3cHL4n0r7Be/6Xvl1PfNC9XyJAT6O0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 082/307] spi: sun4i: fix controller deregistration
Date: Tue, 12 May 2026 19:37:57 +0200
Message-ID: <20260512173941.850958763@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2610A527DC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246405-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 42108a2f03e0fdeabe9d02d085bdb058baa1189f upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b5f6517948cc ("spi: sunxi: Add Allwinner A10 SPI controller driver")
Cc: stable@vger.kernel.org	# 3.15
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-19-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sun4i.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -504,7 +504,7 @@ static int sun4i_spi_probe(struct platfo
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
@@ -522,7 +522,15 @@ err_free_host:
 
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



