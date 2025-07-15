Return-Path: <stable+bounces-162422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63AB05D8E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A737580B8D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D722EAD03;
	Tue, 15 Jul 2025 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2K4+3RAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294912E2EFF;
	Tue, 15 Jul 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586513; cv=none; b=ZeHV2i35UuoBz4amGZU1gNdKbeIrRscpTcmsj4Tw35TPvjGL0kzSbuvxNFrs3WqBR1HKD2bLykGXIsufquv0bP7pqr2XrZWamMSL0YaaYD5+oYTRgO3iwvB7BcyzwI/l++AkkaZfqJbAoAq/qB83YMC0GhT5nSYOVxVX40fIIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586513; c=relaxed/simple;
	bh=PeJo7r8J+DZ/TqByugAPEdeQWRZ9K9G1I645Hhesns8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOXdgfRgVjZF1Hl+okKzrLXl1P6RASiTcYnYA+/eW8L0FGBTaApMdnX7O1bOLL+sArua3BE+q8SPovhcJdt03+p5sJ4P4hxb6rwp2uAqEW7WmSeXaL6lEGG2SwldohBWa6Y+In3XnttqxotgMmhPBu6zS7C4yiNpDmsBBYDdHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2K4+3RAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B48C4CEE3;
	Tue, 15 Jul 2025 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586512;
	bh=PeJo7r8J+DZ/TqByugAPEdeQWRZ9K9G1I645Hhesns8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2K4+3RALYT0zCyEgAsfwA+6EIOqcQnwAcnsVjDUlZ7KcJ8RyfnlEIACq/W9I4uX3p
	 V8QF7p8+efniCvFCNcbdEfytTWjnPSfl5cIMcnj+nBmRMo/Ju7H5jn91FZalcr9OL3
	 Dox6tLFgjTxGjEGKVciFiWm4wr6djPi2ACx7Ost4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 093/148] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
Date: Tue, 15 Jul 2025 15:13:35 +0200
Message-ID: <20250715130804.037918285@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 826b3a6a34619b934cdc33eeb961fcb99ce92c09 ]

Interrupts are not necessary for DMA functionality, since the completion
event is provided by the DMA driver.

But if the driver fails to request the IRQ defined in the device tree,
it will call dspi_poll which would make the driver hang waiting for data
to become available in the RX FIFO.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200318001603.9650-9-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: fa60c094c19b ("spi: spi-fsl-dspi: Clear completion counter before initiating transfer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 99d048acca29e..7b62ecbe36321 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -793,13 +793,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
-			wait_for_completion(&dspi->xfer_done);
-			reinit_completion(&dspi->xfer_done);
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (dspi->irq) {
+				wait_for_completion(&dspi->xfer_done);
+				reinit_completion(&dspi->xfer_done);
+			} else {
+				do {
+					status = dspi_poll(dspi);
+				} while (status == -EINPROGRESS);
+			}
 		}
 
 		if (transfer->delay_usecs)
-- 
2.39.5




