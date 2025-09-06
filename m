Return-Path: <stable+bounces-177935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E38B468AA
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872291BC70C8
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25310246761;
	Sat,  6 Sep 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpBC63VH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8C27707
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757129833; cv=none; b=aKUGznNuGxZAf0GVKmWIs9eZkBVtcJv7wHQAZK6CAZ5nNQuUldS60bgY07PQGYnvbTYO4NQK09Qka5bub/eXu7ygJr7UyGhf+ZZo0/yDRlF6hrxNfaFylfb06yE0ObqIMbQWRPs/5J7Ra51XfBbdb1OWdyBo8cuNEZFxxIvjX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757129833; c=relaxed/simple;
	bh=c+HBu0wkeJGqXI8LPich3PmTtK5L7yiu2NNA1Hrk2ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r07Wgxrb/+XUH/kMQ/tElhMldDRx5KNqsV/4EyAlL/CjzfVZjbACM1dTzc3K1pgxTP4YUnHQiZ2wDgRrxRX5gORdB5cuQHcW7arLq6Yt0bb3/uLv+Eo2bscpfMerxH+dIbxTDI1TVOtDS+cIf6Mdaubb6xBS1oG2rhyh9YKFwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpBC63VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D1C4CEF9;
	Sat,  6 Sep 2025 03:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757129833;
	bh=c+HBu0wkeJGqXI8LPich3PmTtK5L7yiu2NNA1Hrk2ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpBC63VHRJ1pWR2jE4eIXrAtQ1vKQhebuzUvObtS4wXsJ29YbHIv90xm4GC5heKPc
	 N3uYfi3Nm9H/KEbCUIowF1ucNzvLkamGrKUQOauwUuhFrwqjpPPIAdGX0MIxHb7fw+
	 gHUX4GadX8fMVAbjrl0B0gPGPym5bhQF66uE2FY5suYrbrrol6erlvycBaiOF3c1ZE
	 bDC3RmND+QwqYvt8Delso1n11acRnemc0Ow7dKo8g3ijxqTkfrP0H2+pQ13DMAglFJ
	 JV+lf51aR8FzNDIpH2+fZpoZGjLgfBgvXVLSWncWXmiPssZn9lRExX8N6Ndc6wtEbq
	 R8HpjLOy1/S3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aaron Kling <webgeek1234@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] spi: tegra114: Don't fail set_cs_timing when delays are zero
Date: Fri,  5 Sep 2025 23:37:10 -0400
Message-ID: <20250906033710.3692213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906033710.3692213-1-sashal@kernel.org>
References: <2025050535-slider-herbicide-e70d@gregkh>
 <20250906033710.3692213-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Kling <webgeek1234@gmail.com>

[ Upstream commit 4426e6b4ecf632bb75d973051e1179b8bfac2320 ]

The original code would skip null delay pointers, but when the pointers
were converted to point within the spi_device struct, the check was not
updated to skip delays of zero. Hence all spi devices that didn't set
delays would fail to probe.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Link: https://patch.msgid.link/20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 6b56108308fc5..60799ab60eb45 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -729,9 +729,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if (setup->unit != SPI_DELAY_UNIT_SCK ||
-	    hold->unit != SPI_DELAY_UNIT_SCK ||
-	    inactive->unit != SPI_DELAY_UNIT_SCK) {
+	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
-- 
2.50.1


