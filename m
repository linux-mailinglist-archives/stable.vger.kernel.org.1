Return-Path: <stable+bounces-240149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO8kLFV252nf9AEAu9opvQ
	(envelope-from <stable+bounces-240149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B143B1D2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE473054F5E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535F3D6681;
	Tue, 21 Apr 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pop12fNt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238513D646C;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776538; cv=none; b=VZyDAwMMBXjD4zIxPJ9ANE+7a3pPG8OJ1ldzOPdkq+nAcMowm6sPh7AMOPl0N2Ci376i+x+7AU/8dl/bMmBQGaVyVVXAyRMkszA5fJHDmiZzYvkiJQxcmY3Pe0JkLFn+A/hXBXsStJsLO2leRgA6snWzrkmAH4gZEHjWj9rJrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776538; c=relaxed/simple;
	bh=846VjW4Nlxcmbqblp8RsOVDvtgBdU72+KDiNQFuM5N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEXoQQqYl1mouNh8GGg+RfaaqhkjzTZ4kpsK8yxjJRvJYYuxoQdHJRK4g4bKsg6Tsg9y0+dUcSr+GeENoSgiWTzrBK4PoMTxvXA2D/yT9BQLpbMXbiSRdC+szSarKlZ4/uMusN/gdRQMx3VqZc/76+YZaVc5lpXF/eK1rQsSso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pop12fNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5399C2BCB3;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776537;
	bh=846VjW4Nlxcmbqblp8RsOVDvtgBdU72+KDiNQFuM5N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pop12fNtlEo5mTj9MG2/vYAFTxfDarVlpUqIrWn1RZ/plOv4m/D9YM9ILZbHjIt+s
	 o6/W0dpb8e86vvyxaVW9XvwyPQeJ+JlBKrANHB5XExHe3RkTKAq2/nXIO2e+zQlDcF
	 bXGv8mvBizoIUMZuyX7bfKsJ7bsmYL4fQx1xSRWY2uH6Gp6HZlOBQe7qPjMiKUud8x
	 LfR6pvslmPm5LeZJJRoJO9gUlJXj2yZ0KKMKmuF+H6JwDqrVZCIRGnKrRrDbnK/LyO
	 U+fhoFaOM3VuUxDTFObB0W/Kkg3dylAENcVF6Cml2zaylDBvq+jtTR4M3Mv9njFCJn
	 9q752APmMxoYw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAk3-00000006S0t-2oue;
	Tue, 21 Apr 2026 15:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] spi: orion: fix clock imbalance on registration failure
Date: Tue, 21 Apr 2026 15:02:10 +0200
Message-ID: <20260421130211.1537628-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421130211.1537628-1-johan@kernel.org>
References: <20260421130211.1537628-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240149-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 395B143B1D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure that the controller is not runtime suspended before disabling
clocks on probe failure.

Also restore the autosuspend setting.

Fixes: 5c6786945b4e ("spi: spi-orion: add runtime PM support")
Cc: stable@vger.kernel.org	# 3.17
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-orion.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c61ebfd1d18d..a5ce970ff5a8 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -774,6 +774,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	status = orion_spi_reset(spi);
@@ -784,10 +785,15 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto out_rel_pm;
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return status;
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
 out:
-- 
2.52.0


