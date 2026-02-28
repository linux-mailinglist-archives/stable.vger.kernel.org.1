Return-Path: <stable+bounces-220219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EH+JXUuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118ED1C5674
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844E3333D853
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08384DD6DA;
	Sat, 28 Feb 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cps5PGhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B904DC537;
	Sat, 28 Feb 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300124; cv=none; b=BmUYG4Jvh/ObbibneoQ/oaY6mU28Zx4rVdOz/jHKztXTr5p/DPTERFfAlK/2/bmHTyL++jsSRwRY9aEj6rbifyZQa/DCk4aQBEWZQRu9sux1HmMej7okZaGRnEnlQZR/K9WuH0CzPxI4C/3wUF7yY99v0wuzMQ0amdf4ICJ3JgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300124; c=relaxed/simple;
	bh=5fvreIE8mUPNC0VdxmGRMolDmw7x/N2lHp1Cli5MCvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCBgsYDJS9aM6oU/5ZJJI+8Q5IwuqNihKhx2HX5oT9w1YdN7O7/5uojqvX5UEvUvFrPdduBbxUHkkxwgXmm37mxKg0j6S9eFNumWQZGAplcbSVhaA66MWH9GD/89OdgYDrhJMFbrQaA0Oyry4WvSgDq56uXfR8tFMmpOKyB9PsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cps5PGhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD757C116D0;
	Sat, 28 Feb 2026 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300124;
	bh=5fvreIE8mUPNC0VdxmGRMolDmw7x/N2lHp1Cli5MCvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cps5PGhwyomf1bMroOlau3npJRDFlLEnc7K8Lw3ga7jst3JF/+WlZ5ls5mQf+mnEb
	 KVTOAmEtDaCqG0dRIhZV1KObU6vY2OfdX2OCVoTfktdUUVPMUNo8YlzYOOzcnpqZwx
	 J19Yq9eMCeIvBTNVKpRPbO29JlcVl20x3vL+EW7gUFRDgAUBQWqzC8ZMtumIYtnVVH
	 TljxfQW2DzTdrmxqGxfm1m8466NVRQStqvLoD+UhdndSDsBbaUGjrTCLLCbWz5zuCk
	 rcHHbUPwsqCk1Q4u/UCLix3Avp+Penl0Et2fd5/V1BwCd6CH2pqspEIZjFcCX8BGdw
	 Mb/raPxJhgupA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 141/844] spi: cadence-quadspi: Parse DT for flashes with the rest of the DT parsing
Date: Sat, 28 Feb 2026 12:20:54 -0500
Message-ID: <20260228173244.1509663-142-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220219-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,dolcini.it:email]
X-Rspamd-Queue-Id: 118ED1C5674
X-Rspamd-Action: no action

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 9f0736a4e136a6eb61e0cf530ddc18ab6d816ba3 ]

The recent refactoring of where runtime PM is enabled done in commit
f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
avoid imbalance") made the fact that when we do a pm_runtime_disable()
in the error paths of probe() we can trigger a runtime disable which in
turn results in duplicate clock disables.  This is particularly likely
to happen when there is missing or broken DT description for the flashes
attached to the controller.

Early on in the probe function we do a pm_runtime_get_noresume() since
the probe function leaves the device in a powered up state but in the
error path we can't assume that PM is enabled so we also manually
disable everything, including clocks. This means that when runtime PM is
active both it and the probe function release the same reference to the
main clock for the IP, triggering warnings from the clock subsystem:

[    8.693719] clk:75:7 already disabled
[    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb
...
[    8.694261]  clk_core_disable+0xa0/0xb4 (P)
[    8.694272]  clk_disable+0x38/0x60
[    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
[    8.694309]  platform_probe+0x5c/0xa4

Dealing with this issue properly is complicated by the fact that we
don't know if runtime PM is active so can't tell if it will disable the
clocks or not.  We can, however, sidestep the issue for the flash
descriptions by moving their parsing to when we parse the controller
properties which also save us doing a bunch of setup which can never be
used so let's do that.

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b9a560c75c5cd..b1cf182d65665 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1844,6 +1844,12 @@ static int cqspi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = cqspi_setup_flash(cqspi);
+	if (ret) {
+		dev_err(dev, "failed to setup flash parameters %d\n", ret);
+		return ret;
+	}
+
 	/* Obtain QSPI clock. */
 	cqspi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(cqspi->clk)) {
@@ -1987,12 +1993,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_get_noresume(dev);
 	}
 
-	ret = cqspi_setup_flash(cqspi);
-	if (ret) {
-		dev_err(dev, "failed to setup flash parameters %d\n", ret);
-		goto probe_setup_failed;
-	}
-
 	host->num_chipselect = cqspi->num_chipselect;
 
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
-- 
2.51.0


