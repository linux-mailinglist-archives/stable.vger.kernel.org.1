Return-Path: <stable+bounces-177940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C3BB468B6
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE47B88C6
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18323D7F4;
	Sat,  6 Sep 2025 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbO4Qk8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9B1DF254
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757130863; cv=none; b=n7n0mEaz+vAau/KmouDshEzNgRFgAZ5J/EPnvzqS2uBWySXCuXQnJ3eoybyAyVqnnHwWltdFL1i2uxWmiz4zyc1s6OzOK9cB+WMwGMbmcUuSy/FxkjbanL1YXt7UHX+gSIAeUncBpA2NqB3ayuAwYJi6mXt6cUlYk3itSgyEK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757130863; c=relaxed/simple;
	bh=WfLH0JOHfUPZCHQyk75ANsmoDU5fe6+H2WymXI39LWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQL9jU4BDpUT3DSDOtHwhO1hxdHuuLuuL0cu3VzWBJsLXIhtU22rOw59gAT5G7x3mx6tojXJNoqpZb+3YJpFzK8zY/E97GxtqeMkEToPbhq8UtCUOSdhOiNR+hEEyDzZd/hnIW0oiWmPwh8YFgo/vievCSHTq1X+rIALE+m60C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbO4Qk8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9943AC4CEF8;
	Sat,  6 Sep 2025 03:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757130863;
	bh=WfLH0JOHfUPZCHQyk75ANsmoDU5fe6+H2WymXI39LWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbO4Qk8Y5gnneafLF4Qeo9WW6hJJcagcSzc83HUJIeu2c5uRojIMJnQ25RPyR6a1H
	 RwIhkUg+Mqgb5rmNkpCUc/Kgdy2sHKd6Xo3ndyCONoPyw6Z3Wy71ynxWL/PettmATH
	 WQ4s1Xdpso1QV2WVc3Tb1+LMwfR/FUEve//fO5Pg1RX0QdcwKs9p0GRqOH4O8gd8T3
	 ptBYOh1YyzV1sVM+CWqTMUgcenVQE13VAB1fwskIaccIX/K12YiA2mSArV9hmsbHDV
	 uWIoe8QC0rUktucqvkXG6twcb8aUpPytCKVAQiSIGMAKaGjBHaKSqK5p6tQ2+a2Of9
	 boIzoRpSreBTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aaron Kling <webgeek1234@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] spi: tegra114: Don't fail set_cs_timing when delays are zero
Date: Fri,  5 Sep 2025 23:54:20 -0400
Message-ID: <20250906035420.3696014-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906035420.3696014-1-sashal@kernel.org>
References: <2025050535-ducking-playroom-1844@gregkh>
 <20250906035420.3696014-1-sashal@kernel.org>
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
index b6f081227cbd4..af9ed52445fe6 100644
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


