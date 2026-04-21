Return-Path: <stable+bounces-240142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKTFFMlz52lE9AEAu9opvQ
	(envelope-from <stable+bounces-240142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C940143AEC8
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E9D302B743
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ABF3D6476;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIwGrDFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAE34CDD;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=JiaYEIhqgziwVxsWgz5Cu+hY2lzUgrMeO0jjaGnAl/BMJZasUTtGb6NJbkQQq1lPGBthwIivUFOGuCjZnQWbSsyItu5FWRkO4Ck1dGiXE4Nrzj4DCKAdYiXslFGRGRF5SP3tz9AYUcMNDyBbt1uC/2TkePoJ8uuMXtkONTGmX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=3U1QY5N85lS4mCVnz/TZvVbzIVXjgbkWXAMpxK9sciY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3nNUK87qOHOdDLPCgevRJG6ku8xJlSJdLZveDRUAGyHnc3SHfXpQaIY2SjxLj8eTEfJKlbidqQjvDltm5EFePgUll4DAzafaTbCt3eH48xrYMtchitp1JKMXPLhWFEwp6AV6r7gfNKqPEdC6u/wcO7CGDEPdEJ1EJvvLnFqkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIwGrDFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21259C2BCB0;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=3U1QY5N85lS4mCVnz/TZvVbzIVXjgbkWXAMpxK9sciY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIwGrDFJkOwNSkOjZnv6O6KpnbjQaaUt5ZiU8C51+ngYJ3rwwkACbszQQc7MooAdR
	 QzUI0MG7KOR93L5/Z3qXxSY62W34CSeJl/pMp48KCewjOQBdM8ldnE+w4e+dvmpqix
	 QlH6OE/geixGu22/XcUlugbs/VHXV67BPP4XQfZEBsmDQE/b/S5DhjX8mPy7qw1T8g
	 7ddMnfmqo6TXZIpcjt9xjJ42ATxpeGbuAXg3/p2Fu9BLyNGdhK0uHrmlvbRIChjc7e
	 OhTczlpsFLmXVP+xuDHLY4D8Tetw304hiP1vJ1/5iABHgQ7FxpBGBiWpMFuJFn/+rt
	 3vEibbtvKFUMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIO-3qs3;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
Date: Tue, 21 Apr 2026 14:53:49 +0200
Message-ID: <20260421125354.1534871-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421125354.1534871-1-johan@kernel.org>
References: <20260421125354.1534871-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240142-lists,stable=lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.226.201:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C940143AEC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A recent attempt to fix the probe error handling introduced a runtime PM
disable depth imbalance by incorrectly disabling runtime PM on early
failures (e.g. probe deferral).

Fixes: f18c8cfa4f1a ("spi: cadence-qspi: Fix probe error path and remove")
Cc: stable@vger.kernel.org	# 7.0
Cc: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 50ef65fc5ded..5040e4e1cce0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1871,7 +1871,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clocks.\n");
-		goto disable_rpm;
+		return ret;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1981,7 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
-			goto disable_controller;
+			goto disable_rpm;
 		}
 	}
 
@@ -1999,14 +1999,13 @@ static int cqspi_probe(struct platform_device *pdev)
 release_dma_chan:
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
-disable_controller:
+disable_rpm:
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
-disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_disable(dev);
 
 	return ret;
 }
-- 
2.52.0


