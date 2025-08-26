Return-Path: <stable+bounces-173288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FEB35C61
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28897C4A34
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C7F343D87;
	Tue, 26 Aug 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSFTIgVB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E3334393;
	Tue, 26 Aug 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207859; cv=none; b=aFYa9xKR5ixabRJ5E0eK1/H2FXDi0PcHwTGPTaum4RU1O9F77ZXLHITEH3LQgAcBEXmC3H3BYtdfTH0KyoEYJlk37mVNcXXbzTE2G3IwS3BmKWUfcpdz1w5U3xf7wT3VIlszL287eEQDbslHmB4ZyobefPh2S2rJl/fXe0IrvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207859; c=relaxed/simple;
	bh=z91Dd8//3mjB3pQCHCmo6RKjg3xLjPuEl+PEW6wb+1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HefzfnuJj26OUtAbjW7tpB5QpmlPwXgq+x8ZsKFho9jUlph1j7FrRLyNUZVaSq3IePOps5dDxL+mMBdTG6jY46ubgTDxP1Ik12y5L29YBTmQqxLdD5PbJlwlMrlNcJkKOqprQ+jFUZxhfp6KqkFL0HzipMtzSBEK3qFsxtnvkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSFTIgVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B31CC4CEF1;
	Tue, 26 Aug 2025 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207859;
	bh=z91Dd8//3mjB3pQCHCmo6RKjg3xLjPuEl+PEW6wb+1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSFTIgVBA8y2VUwWve+OMmG6pieI8ai+p4GmBB8mME5pqaqzGWhsolq/+tLe7Xo6f
	 58RUEC6dzitWACgo8TdD50cqAoCTrUMLqG0/3Oyy0Yzdu4bpVNfsIt62/kojsZh9gn
	 pf55hp64rNdHI433qlv5LNNVhPGSqh4ic8RC+efY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 343/457] spi: spi-fsl-lpspi: Clamp too high speed_hz
Date: Tue, 26 Aug 2025 13:10:27 +0200
Message-ID: <20250826110945.808264040@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit af357a6a3b7d685e7aa621c6fb1d4ed6c349ec9e ]

Currently the driver is not able to handle the case that a SPI device
specifies a higher spi-max-frequency than half of per-clk:

    per-clk should be at least two times of transfer speed

Fix this by clamping to the max possible value and use the minimum SCK
period of 2 cycles.

Fixes: 77736a98b859 ("spi: lpspi: add the error info of transfer speed setting")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://patch.msgid.link/20250807100742.9917-1-wahrenst@gmx.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5e3818445234..1a22d356a73d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -331,13 +331,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	}
 
 	if (config.speed_hz > perclk_rate / 2) {
-		dev_err(fsl_lpspi->dev,
-		      "per-clk should be at least two times of transfer speed");
-		return -EINVAL;
+		div = 2;
+	} else {
+		div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
 	}
 
-	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
-
 	for (prescale = 0; prescale <= prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;
 		if (scldiv >= 0 && scldiv < 256) {
-- 
2.50.1




