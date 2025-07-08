Return-Path: <stable+bounces-160800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA3AFD1E8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F900167BC7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75122E2F0E;
	Tue,  8 Jul 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQqDOGI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F14289E2C;
	Tue,  8 Jul 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992727; cv=none; b=swhE+UEIfxG69BLlUibduvDK4Mwb5aT9e/xugMQJTSc7XhHbuauMLx/r9dHGYKq2dlH9XYw4UC8E5erWFFtFnYT9GQP/MF1XvJkLCpaeZb794LLtFreWbdMie0JSu30wH640kQKQgV39veUYMKHhBFDo48NXSlz0fJb19cHXxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992727; c=relaxed/simple;
	bh=Fs+hqsUyCpD09mdMMGg6LT7sosSzu0ljF9fGXeZTQ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY7sgAUlLXDTFpHImreOg23+u0fnEeYQP2RPppzpB6ODIaTOgVrVxrp2g7L9/0lOEEi/S4jKBBJdKGvw8llgzJgLCP9be/27sexjygQBnLD6/DTcVWZDC72V2+a9xqgqW8umPK69UnIx7vbIpzPH1b3vHXa3CFNsRdi274NCH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQqDOGI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C8CC4CEED;
	Tue,  8 Jul 2025 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992727;
	bh=Fs+hqsUyCpD09mdMMGg6LT7sosSzu0ljF9fGXeZTQ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQqDOGI7uk0aerCh0KRvzyQFzDrOs7a7ZSlIwxFhq7TCFmP35b9jxAB8tJ9pXucdD
	 EFxQg4dGkMZenivaCjFDMZkj56dpG456N28uzfeuDwRqQoN5jlYb61UpTYZzmavUze
	 cwFqgooXoXVjctYoTktv6aV1aUAbViEktNbIZLpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 059/232] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
Date: Tue,  8 Jul 2025 18:20:55 +0200
Message-ID: <20250708162243.009331655@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@linaro.org>

[ Upstream commit fa60c094c19b97e103d653f528f8d9c178b6a5f5 ]

In target mode, extra interrupts can be received between the end of a
transfer and halting the module if the host continues sending more data.
If the interrupt from this occurs after the reinit_completion() then the
completion counter is left at a non-zero value. The next unrelated
transfer initiated by userspace will then complete immediately without
waiting for the interrupt or writing to the RX buffer.

Fix it by resetting the counter before the transfer so that lingering
values are cleared. This is done after clearing the FIFOs and the
status register but before the transfer is initiated, so no interrupts
should be received at this point resulting in other race conditions.

Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
Signed-off-by: James Clark <james.clark@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250627-james-nxp-spi-dma-v4-1-178dba20c120@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7c43df252328d..e26363ae74890 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -983,11 +983,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
+			/*
+			 * Reinitialize the completion before transferring data
+			 * to avoid the case where it might remain in the done
+			 * state due to a spurious interrupt from a previous
+			 * transfer. This could falsely signal that the current
+			 * transfer has completed.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
+
 			dspi_fifo_write(dspi);
 
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
-				reinit_completion(&dspi->xfer_done);
 			} else {
 				do {
 					status = dspi_poll(dspi);
-- 
2.39.5




