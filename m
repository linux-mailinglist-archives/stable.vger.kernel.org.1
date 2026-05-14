Return-Path: <stable+bounces-247113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFm1OL5WBWqAVAIAu9opvQ
	(envelope-from <stable+bounces-247113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:59:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A253DCDF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C05301D4D4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D73AA4F9;
	Thu, 14 May 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0QYA8E+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E32FFDFC
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734778; cv=none; b=T9fxU5XUdWCbGC/2GVPzVFcCMtfjSUw+AYQQeDSbzWg8FD8hvs4Ngco26RVdZZG8+Nl1ORimG2GEbSoYf+eIYolMiEbZi6LcA4tKqofLPQMawqEa9cVOWTyh7YaFliJW6y6kFjnl8/jXJPHCdXOwXgjrE0pwiyEImhUU+Dtrtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734778; c=relaxed/simple;
	bh=/rIZl9h1TnI989VqExiBkKqdt+5BW/rRwc61WzTBaVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8vWZwS7GZfMnUkWaTpsR7H95tv48O7anETvIhU9+skKHYvuGN+qZYkfjo3UjB+wTmOrwW6L+E+WvaKtGwpyGfwMOH55CdRm9m0H7Sjrpo1avWxcCIU5W8dtCty1iHShfVFYEmgkVkYK92rc1hYEte3QJOoKtLNwOmOuhstgiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0QYA8E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5DDC2BCB7;
	Thu, 14 May 2026 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734778;
	bh=/rIZl9h1TnI989VqExiBkKqdt+5BW/rRwc61WzTBaVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0QYA8E+jDtdCz+L/T3851xax44zJifJtgAYDtzaBB1RHPY68KOhrMbfgY/fdcM97
	 etlycDI09L0osO5f/kAggnnx+WQxaUJlX7fk8ie4mQyWXaJKnrBAE3gjCGtagVfj5q
	 35t9iYbnME8YXaZmA1k+rnHsrGrnhhgEvWfY9Uxz5oCJft4X/fUdiRDv/xJ4GxCiHs
	 6UPfjsEBXsXImhm6apUmXBPeT/xaV+lSwvaCFIHaoMV6Nd5b+Si/aGlO5JJ0PRr8cQ
	 ch7GY6bzvV0/2y/eNc3khp9C1YuPW9hujFl2mLQZHWTKcZT7V9pmFC343lzHnguFdU
	 f5uX6wOKrslNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] spi: tegra20-sflash: fix controller deregistration
Date: Thu, 14 May 2026 00:59:34 -0400
Message-ID: <20260514045934.26261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051257-nucleus-fabric-feae@gregkh>
References: <2026051257-nucleus-fabric-feae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B7A253DCDF
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
	TAGGED_FROM(0.00)[bounces-247113-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
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
[ translated spi_controller/host API to legacy spi_master/master naming and dropped devm-managed registration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 0c5507473f972..956178f7dd869 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -506,7 +506,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_pm_disable;
@@ -529,11 +529,17 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
+
+	spi_master_put(master);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0


