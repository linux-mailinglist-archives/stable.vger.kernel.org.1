Return-Path: <stable+bounces-198680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8CCA0A8D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F48934FCBA7
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02D34027B;
	Wed,  3 Dec 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oywQ6X6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33733FE0E;
	Wed,  3 Dec 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777336; cv=none; b=Fi0xxIIeqp8hvPW+/YK/pQUdCQOAUAIb6hoc5pfz8j1FFBWcjVAAB5iTwWk+Hup44oAUy+qH2JK5OcGnwpPxKLUneMBMZyszzUPiCSXqtoEn2p/XDiXckI7sDxIf1qUEMK28gMS6yLuFfH1nrKa3B8dgF3XhhKm0qccmrenoaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777336; c=relaxed/simple;
	bh=+fabW5JY2f1rmnBjkJKeP1cLWQnSbfx8wVRlrMDLdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhog9M6zBAUj5wBei5QxPiI+eVFnfcUAyo8idcooqpl4WAnF0UON9E+ElHVouW97vl0BnbKZuU6UfaJWKuSrWLUk5HTWEBkkvc4yTt6kqN+142RXjM3TJ7PlhQMVjjcQeAnv+NJ6S3ebnxogj5ih83E6zN5B24g2w3FGG14l4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oywQ6X6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7CFC4CEF5;
	Wed,  3 Dec 2025 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777336;
	bh=+fabW5JY2f1rmnBjkJKeP1cLWQnSbfx8wVRlrMDLdhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oywQ6X6Se31/GsTb3ZvGxte9uqYqALSFcag1DGaGf7ELdu9wtUWk62t6tpZGS1QMn
	 5qIfjq1pJ97IFbnLyvlVgOIkzhQD2/P5n+R+yIQBOK3MgqjNTETSB/CaORCZERS45Y
	 HGSmb/upAZYDXFvrA4/VdKmXQqi85qFRzS3f+JWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.17 146/146] spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm
Date: Wed,  3 Dec 2025 16:28:44 +0100
Message-ID: <20251203152351.817577211@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddharth Vadapalli <s-vadapalli@ti.com>

commit 295fe8406a357bc0abb901a21d1a554fd4dd1d05 upstream.

Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
to avoid imbalance") relocated code but missed updating the error handling
path associated with it.

Prior to the relocation, runtime pm was enabled after the code-block
associated with 'cqspi_request_mmap_dma()', due to which, the error
handling for the same didn't require invoking 'pm_runtime_disable()'.

Post refactoring, runtime pm has been enabled before the code-block and
when an error is encountered, jumping to 'probe_dma_failed' doesn't
invoke 'pm_runtime_disable()'. This leads to a race condition wherein
'cqspi_runtime_suspend()' is invoked while the error handling path executes
in parallel. The resulting error is the following:

  clk:103:0 already disabled
  WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa0, CPU#1: kworker/u8:0/12
  [TRIMMED]
  pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : clk_core_disable+0x80/0xa0
  lr : clk_core_disable+0x80/0xa0
  [TRIMMED]
  Call trace:
   clk_core_disable+0x80/0xa0 (P)
   clk_core_disable_lock+0x88/0x10c
   clk_disable+0x24/0x30
   cqspi_probe+0xa3c/0xae8
  [TRIMMED]

The error is due to the second invocation of 'clk_disable_unprepare()' on
'cqspi->clk' in the error handling within 'cqspi_probe()', with the first
invocation being within 'cqspi_runtime_suspend()'.

Fix this by correcting the error handling.

Fixes: f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://patch.msgid.link/20251119152545.2591651-1-s-vadapalli@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence-quadspi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2002,7 +2002,7 @@ static int cqspi_probe(struct platform_d
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_dma_failed;
+			goto probe_setup_failed;
 	}
 
 	ret = spi_register_controller(host);
@@ -2020,7 +2020,6 @@ static int cqspi_probe(struct platform_d
 probe_setup_failed:
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
-probe_dma_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)



