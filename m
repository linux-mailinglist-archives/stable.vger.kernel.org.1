Return-Path: <stable+bounces-132956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB58A918AD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8749919E2AF4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402022CBE5;
	Thu, 17 Apr 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="naZ9cm7P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B021898FB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884235; cv=none; b=UMkr4S9vE3f/U7MAkBcqKGU1wTmzqcWfcJ865GZ2TNjWr3kiuXR5prigJv76G3iSclCBG+EXwNzCcXwLYcJLoIP5eUirmgAUWh/3EqTuh9EOoHycT3Fjh3Ax6I/+vsN/jmkpmoH40KZ/dIZIEG7R6g9ZvZ52oTynQmHta1Yy1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884235; c=relaxed/simple;
	bh=2D/UaCxtuSBtvhvYMF0yVB70j/fAZZRPLDLidUJWNPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ixSqwCFBxAQ7MXSqn5B4yT0PAOIA3LUuHaDb+1tM2NBqXB3wO3R1v9pDx+7RVaU5PQKaxQ25OHFIkYoN6BYAyDNUgk4z/ickHyJioCyiTy6eNF/4ypZr2Vz+PRDVpQ8+KhQHRQDpguDWKquh4XERrDSTbVghOKrpsa/Xh/fiJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=naZ9cm7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48CEC4CEE4;
	Thu, 17 Apr 2025 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884235;
	bh=2D/UaCxtuSBtvhvYMF0yVB70j/fAZZRPLDLidUJWNPE=;
	h=Subject:To:Cc:From:Date:From;
	b=naZ9cm7PB+cROvGPMQf61DK3ilM5UMVLLOF9bia4jR9LzYfVUwxE9PwrwOuHEILvg
	 qPtFRqvwEw4UtqO3Ao32YOeQmtNqzBLStGrR9EWs1X5fuTDe8gEer17einZt7dJ85D
	 PFMzC1K+tDOoe61orF9Vg4O4NGj2O0E4BGSxmIuY=
Subject: FAILED: patch "[PATCH] spi: cadence-qspi: Fix probe on AM62A LP SK" failed to apply to 5.4-stable tree
To: miquel.raynal@bootlin.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:03:52 +0200
Message-ID: <2025041752-harmless-scoring-d983@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b8665a1b49f5498edb7b21d730030c06b7348a3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041752-harmless-scoring-d983@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8665a1b49f5498edb7b21d730030c06b7348a3c Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 5 Mar 2025 21:09:32 +0100
Subject: [PATCH] spi: cadence-qspi: Fix probe on AM62A LP SK

In 2020, there's been an unnoticed change which rightfully attempted to
report probe deferrals upon DMA absence by checking the return value of
dma_request_chan_by_mask(). By doing so, it also reported errors which
were simply ignored otherwise, likely on purpose.

This change actually turned a void return into an error code. Hence, not
only the -EPROBE_DEFER error codes but all error codes got reported to
the callers, now failing to probe in the absence of Rx DMA channel,
despite the fact that DMA seems to not be supported natively by many
implementations.

Looking at the history, this change probably led to:
ad2775dc3fc5 ("spi: cadence-quadspi: Disable the DAC for Intel LGM SoC")
f724c296f2f2 ("spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA")

In my case, the AM62A LP SK core octo-SPI node from TI does not
advertise any DMA channel, hinting that there is likely no support for
it, but yet when the support for the am654 compatible was added, DMA
seemed to be used, so just discarding its use with the
CQSPI_DISABLE_DAC_MODE quirk for this compatible does not seem the
correct approach.

Let's get change the return condition back to:
- return a probe deferral error if we get one
- ignore the return value otherwise
The "error" log level was however likely too high for something that is
expected to fail, so let's lower it arbitrarily to the info level.

Fixes: 935da5e5100f ("mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20250305200933.2512925-2-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0cd37a7436d5..c90462783b3f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1658,6 +1658,12 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 		int ret = PTR_ERR(cqspi->rx_chan);
 
 		cqspi->rx_chan = NULL;
+		if (ret == -ENODEV) {
+			/* DMA support is not mandatory */
+			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
+			return 0;
+		}
+
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);


