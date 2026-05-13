Return-Path: <stable+bounces-246979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGG5BJ+4BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BA5383E3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCD8D300D1D0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E04DC525;
	Wed, 13 May 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py2asltu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7E4DBD86
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694300; cv=none; b=cjpxfAEwxK2iCDpwMPIe7SMJ7srvZS2sz+2YMs2bC0bAhwSi7wA2H226D207TccrC1YgfqKLaSNmuGMcE+WlD5xBFDsdmbdHbrBgT/1GLi1kLVSoi6r3i9074T3cHWndM6bxHnnDaIQRrd4Xhjy6jmdXkT/afYKD1KUgBXAlCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694300; c=relaxed/simple;
	bh=h8sRLrnMjKEg99fD9qz6Cd+qwzqwo5lhTqnd1bfHqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsc5ODGFkDPohmEKAH7i4hDzneiyxdRirLQSOC9yUnBN3F7G8TmDf6nVgW94jNh60X6VbOvc6o9BWGPi7ROar+TSKXUR/zoHlYlLnB5jojixUczGYzabKY6Xyx+N8H+aoe5yaG/hAhwT1KA+642kNBm9pYD4kPSLrtkzJ5IC+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py2asltu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF4AC2BCB7;
	Wed, 13 May 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694300;
	bh=h8sRLrnMjKEg99fD9qz6Cd+qwzqwo5lhTqnd1bfHqeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py2asltumohNprjQkXNzrbCtDpO3e6ja94CviF2P9qKqM6m1YIO9YvqF6V/OZn3Ms
	 UNEsxF5GOM9Rz83Lrjtwr9BifwkVdhndPdVF043yzexkPfUPg8spnzwqW0JqXjgbfy
	 jGvDyzr64yakE6zbYy5/GN9IRUni77+XWWJYksGiSnKHgACH642THIj4mcrLeXaGcn
	 w0diO+BVapoxmB1Cd3U8XEvbelmWl7vuWcBbP32L0BxJkHtUN1FpxcAZDl98j0SFZo
	 pZT8QgIzQ3Ji+K+1dg4A6NrXL/TEGBnvPstuBaVN8B/IVWQ/6pE+TqluGHPPrJntbg
	 eFSa+HPrp1y3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] spi: syncuacer: fix controller deregistration
Date: Wed, 13 May 2026 13:44:55 -0400
Message-ID: <20260513174455.3896307-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513174455.3896307-1-sashal@kernel.org>
References: <2026051241-embezzle-retrial-5eb7@gregkh>
 <20260513174455.3896307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 691BA5383E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246979-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 75d849c3452e9611de031db45b3149ba9a99035f ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
Cc: stable@vger.kernel.org	# 5.3
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-21-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-synquacer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 6e366810b34d8..8d0a74263f02c 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -719,7 +719,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_controller(sspi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -740,9 +740,15 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
+
+	spi_controller_put(host);
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
-- 
2.53.0


