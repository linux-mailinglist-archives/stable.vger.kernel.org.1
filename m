Return-Path: <stable+bounces-247099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGcZNDtMBWohUgIAu9opvQ
	(envelope-from <stable+bounces-247099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:14:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F1E53D986
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A6C23018F95
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E5399359;
	Thu, 14 May 2026 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpYHAclo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9803A7F6E
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732089; cv=none; b=fwDee/gJgnVGK28tU9fUzpfwhjmij1mPPqm45tajzL023bF39bjN/MJhqjisV5hW5djDqJ3IC/zwJy6jbEcBye6FVaLlr07c6NeE0rK05QKluaPSUP8DIxMEHMq5toPBu7vUXbNpwA/Haisvpdo3Aq0SuAgepbgs7vuc2qVg0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732089; c=relaxed/simple;
	bh=27+rBgkt8WT/AU+OiG/qN5+3Bu8xNkkxTQv65pxd4oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll938+v6mqLtal7DRdecLvUi50iZY2bFpBHXfNCyI1FgcEU1+Ry6uITNwK5smfIcPM0tI/T6sjmhzjgjO603IIgidM29sFfpwxNkt1FSOBzXMKQZMNlD9mIJmGPHmj3JAwoA3H1QKl3oud0c7xXIw8OgS8RmuBCCvdd63BKrTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpYHAclo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313BEC2BCB7;
	Thu, 14 May 2026 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778732088;
	bh=27+rBgkt8WT/AU+OiG/qN5+3Bu8xNkkxTQv65pxd4oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpYHAcloJyeIlRtjpCxYZ2FbRCyjyCEp7gFQ6dhN2m8nJXL7eAKSsuozEZNm0HYUD
	 tvDRfwVpnmNRfQW2tbccsJcj8/uDjSeyyqtaZASt04T+6uVV+nSxn1Jwx/S4tRUqsy
	 aRhH12AZrpCjLmG5IEuaGvjCEptObDgMMhLtiHFRBS1GnI9FJ7rVFuRy8wdU/kYnwc
	 /4IlOSkAmVhG0WnU5FUOmvp31WSsSpOxCaLmpZS30LydL+jMzPegZ4kxBgeDcsvR4R
	 dukQLrWmietDsWoD3thbFIdQNtULdh889wRPP9hhhCuAuFSuTDtzInhLRepbku9teC
	 D+Mq2KWzGESLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] spi: tegra20-sflash: fix controller deregistration
Date: Thu, 14 May 2026 00:14:46 -0400
Message-ID: <20260514041446.4193882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051257-sprint-buddhist-5107@gregkh>
References: <2026051257-sprint-buddhist-5107@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69F1E53D986
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
	TAGGED_FROM(0.00)[bounces-247099-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ad7310e983327f939dd6c4e801eab13238992572 ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: f12f7318c44a ("spi: tegra20-sflash: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-23-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kept the redundant `host->dev.of_node = pdev->dev.of_node;` line above the registration call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index d5c8ee20b8e5b..dc3fcab5faa95 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -506,7 +506,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 
 	host->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_pm_disable;
@@ -529,11 +529,17 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0


