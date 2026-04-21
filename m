Return-Path: <stable+bounces-240146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NF5GUp052ke8AEAu9opvQ
	(envelope-from <stable+bounces-240146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:57:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F1B43AF92
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E090B303D082
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5F3D5659;
	Tue, 21 Apr 2026 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNdnNnfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807F3BD653;
	Tue, 21 Apr 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776208; cv=none; b=SrflIlJ3wbYKnqDKL0KITJjGYahy2pauXG7NOpDpnU+MqIAWuc1YliREdASVBbyAad4yXjfjusu8CSqzYk6Iwx5HX2o7+OJvfsHwQ1a7ufZLK/NZ5wK1WzXXwv08rBjd527SohmGtNiBpHkH6o0Hhv13SQU3dEni38f4xmsYUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776208; c=relaxed/simple;
	bh=NdRxYl/Lw28QZ+YmuAY12uroQ7H2A+Oz8gEvYUbQAiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJXU5W6skB7zviryeO/T+qZiDIZYFo/SJwllSQBlo4VxKe4WAFd/5ZwiO6Kmz0bNNso/HTiCTgIgRWEQ9Tkuh6g4IFYLIr2bJFK7nedeE6R80iSkQODtnFQt3Uf/3DEUkEtlOnEn9km3dQXme0JBSikftb85xvfK31Q5ePVq28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNdnNnfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC3C2BCB3;
	Tue, 21 Apr 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776207;
	bh=NdRxYl/Lw28QZ+YmuAY12uroQ7H2A+Oz8gEvYUbQAiI=;
	h=From:To:Cc:Subject:Date:From;
	b=vNdnNnfVuxCs1oy6pbhPvnV55bUVpSTKoCnqVtMsj3OLw6Qh/vCJkH6nUI9NEA9uE
	 Y3jUsIUfXt49tJy+ZpGTvm0DMFVU+sSbOoHvu6STcxdR7NxjsaA5ovAZw7WidcHy3U
	 At4/PEhI5wyIli7e+QgyeAoz5v737Bua1VDMBfxoVHnCXbCWqZY54YM7GWr6TAJgfh
	 lYnh8zUYJwTSBa2xuFfHvE6LPPwrAO87CEBGLFPXISKu1mPZmCws0aWbIXtEk/E/aH
	 pCcJeQrG/EIqCQT6qzrZHz4V2/TNVBYm4znFkDZJnkqhoqcC4qEJznSTCyK34k/ziQ
	 Tk9D9Zr/VpSKg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAej-00000006RuU-1hua;
	Tue, 21 Apr 2026 14:56:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Date: Tue, 21 Apr 2026 14:56:32 +0200
Message-ID: <20260421125632.1537235-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240146-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F1B43AF92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to balance the runtime PM usage count before returning on
probe failure (e.g. probe deferral) so that the controller can be
suspended when a driver is later bound.

Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
Cc: stable@vger.kernel.org	# 5.10
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4747899e0646..e5c907c45b87 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2373,6 +2373,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);
-- 
2.52.0


