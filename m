Return-Path: <stable+bounces-266106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQetMsyXMWq3ngUAu9opvQ
	(envelope-from <stable+bounces-266106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:37:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CF69444F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dKOenLKm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266106-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D16D319338D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065883C4143;
	Tue, 16 Jun 2026 18:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004F3D669D;
	Tue, 16 Jun 2026 18:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634691; cv=none; b=lzvq6jfJPQ6kqOPhbyvTTJS5PhYVjpinwmfPfsp/2hFa7aAOCmhLHWR4Wmip6VfbNjC7FsGpMq42G4mzoVbjMU6fDTKGj7O5w906VymnBS+z2m4jlHFwSn+rwbC+tIYI0f4XZDNjxNz025rlzFxRGjJs2UDJpalT/8gdd/1nSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634691; c=relaxed/simple;
	bh=DCOqoUGgmTMgZf/ZwuYxIh6A27Y7IYfxn9HGRRjao6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA9A2cr/wmBykE4ms+itN9+BC2OcWdeaOz2RE9CM+UWDckID4W0kYG1QkSQEsoSQv+7yoyJ3IMNj7D0ks6IbiwgQjac0kWejtnBP08FoW2iPSDLX4p3fAGhwbSaUvgMHvhOmi2dxAJwmsKzXcSRtlXjCmyeikWWQEtAbv2nQdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKOenLKm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5421F000E9;
	Tue, 16 Jun 2026 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634690;
	bh=rnudS9bGDm+efCDJO05850+MGbJhFhOv6FIGRHFFA5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dKOenLKmvWgIFL0++EAh3vofLdpEZjFpCCuQ9PKge0+8sWp9LbDpEXFFfrQHnmuZB
	 VeKrbYaW5nqZAM50O2Vv0xOC4HMYJbdgewTra/ki7PJDYMdJ8nRYwUa2QUBVgowfXY
	 /25b2dtPxQgCacTCWNpDeRF9N4fEMyhURpSMEo2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 313/411] spi: spi-ti-qspi: Convert to platform remove callback returning void
Date: Tue, 16 Jun 2026 20:29:11 +0530
Message-ID: <20260616145117.776185715@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:u.kleine-koenig@pengutronix.de,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266106-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,pengutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7CF69444F

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 2f2802d1a59d79a3d00cb429841db502c2bbc3df ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Add an error message to the error path that returned an error before to
replace the core's error message with more information. Apart from the
different wording of the error message, this patch doesn't introduce a
semantic difference.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231105172649.3738556-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0c18a1bacbb1 ("spi: ti-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ti-qspi.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -907,21 +907,22 @@ free_master:
 	return ret;
 }
 
-static int ti_qspi_remove(struct platform_device *pdev)
+static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
 	rc = spi_master_suspend(qspi->master);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
+			  ERR_PTR(rc));
+		return;
+	}
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
-
-	return 0;
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
@@ -930,7 +931,7 @@ static const struct dev_pm_ops ti_qspi_p
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove = ti_qspi_remove,
+	.remove_new = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,



