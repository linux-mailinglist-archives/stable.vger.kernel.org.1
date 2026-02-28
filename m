Return-Path: <stable+bounces-220225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BthN/oxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CC1C5AFC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7F431A75AC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AFC4EA383;
	Sat, 28 Feb 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpDyPkhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1694EA37D;
	Sat, 28 Feb 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300130; cv=none; b=BFRBy+aha2vjl3+CknuUU5xzj6QSCfWtNOVht1p/F3Lj8S5CMVGRlIMZQyjzjlk2SAN6b2NHZOZ1Ci/E4UWRtQHrwytVQxZjj+Cf08irKkZIHdZjgpx0OlBwUxS3k3xn9BKS9AMIkF7UkutHmo2o5AvXpEvaKsCDLfcUXUDE2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300130; c=relaxed/simple;
	bh=w45GHiWjNPrm28f3UB2SitASIEG08+jhtfcseUG+BY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFA6JqVEOcsfK7WKflm9g+fL03Y5uYykYdmLoZ7u7+6Qys2fZpF+zTIVQzBLI4YRdQgBHqJm7qLRifzgRVH730SUmMBjkrgCj2/Lo021aUXFdFhYIdyOqtfBY7OL0EbUlooBEpMPed6i5RPlcAw6TGDCeKkd2ALpji71DBYM5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpDyPkhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC05C19425;
	Sat, 28 Feb 2026 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300130;
	bh=w45GHiWjNPrm28f3UB2SitASIEG08+jhtfcseUG+BY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpDyPkhglY9G9ceGXVcEo9ywVO8QpGA5bQmkhJXJtwwZta7TDnAvT0g/5a5AuoWDm
	 gWkeR1SaI6c0nQCA/wQX/b0+y6wM5vAZ//y4/bGaWDhTl8YdQmvyw/HYj16CZETZkd
	 rvOY0IYAikcXAcS6eTsjAnPA7dh2cuTTi5lMOlMkkB9UVY2trb9M2lfepSSKZwAwqI
	 AfVZyqJoFfH8PunYIOo6+qCF00VwWYQM2SjLuNApD0vGQNOkz7aXoE2uXu3Ww6cgVE
	 XhA4MLtFQux5HZQRSt5W4iMgy5d9bqNNhCHeZK7Vd/DvPD+ylAiXylm5nud2DAWAJR
	 6z75IDYWNwUVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Remmet <j.remmet@phytec.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 147/844] gpio: pca953x: Add support for TCAL6408 TCAL6416
Date: Sat, 28 Feb 2026 12:21:00 -0500
Message-ID: <20260228173244.1509663-148-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-220225-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:url,qualcomm.com:email,phytec.de:email]
X-Rspamd-Queue-Id: 4F6CC1C5AFC
X-Rspamd-Action: no action

From: Jan Remmet <j.remmet@phytec.de>

[ Upstream commit a30a9cb9bca4296d25f253619883e7013b6be158 ]

TCAL6408 and TCAL6416 supports latchable inputs and maskable interrupt.
Tested on a TCAL6416, checked datasheets for the TCAL6408.

They use the same programming model ad the NXP PCAL64xx, but
support a lower supply power (1.08V to 3.6V) compared to PCAL
(1.65V to 5.5V)

Datasheet: https://www.ti.com/lit/ds/symlink/tcal6408.pdf
Datasheet: https://www.ti.com/lit/ds/symlink/tcal6416.pdf

Signed-off-by: Jan Remmet <j.remmet@phytec.de>
Link: https://lore.kernel.org/r/20251216-wip-jremmet-tcal6416rtw-v2-3-6516d98a9836@phytec.de
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/Kconfig        | 4 ++--
 drivers/gpio/gpio-pca953x.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bd185482a7fdf..3439e025ba1c6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1193,11 +1193,11 @@ config GPIO_PCA953X
 
 	  8 bits:       max7310, max7315, pca6107, pca9534, pca9538, pca9554,
 	                pca9556, pca9557, pca9574, tca6408, tca9554, xra1202,
-			pcal6408, pcal9554b, tca9538
+			pcal6408, pcal9554b, tca9538, tcal6408
 
 	  16 bits:      max7312, max7313, pca9535, pca9539, pca9555, pca9575,
 	                tca6416, pca6416, pcal6416, pcal9535, pcal9555a, max7318,
-			tca9539
+			tca9539, tcal6416
 
 	  18 bits:	tca6418
 
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f93a3dbb2daaf..52e96cc5f67bb 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -126,6 +126,9 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "xra1202", 8  | PCA953X_TYPE },
+
+	{ "tcal6408", 8  | PCA953X_TYPE | PCA_LATCH_INT, },
+	{ "tcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pca953x_id);
@@ -1469,6 +1472,9 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "ti,tca9538", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "ti,tca9539", .data = OF_953X(16, PCA_INT), },
 
+	{ .compatible = "ti,tcal6408", .data = OF_953X( 8, PCA_LATCH_INT), },
+	{ .compatible = "ti,tcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
+
 	{ .compatible = "onnn,cat9554", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "onnn,pca9654", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "onnn,pca9655", .data = OF_953X(16, PCA_INT), },
-- 
2.51.0


