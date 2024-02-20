Return-Path: <stable+bounces-21130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1C85C740
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A1A1C20E41
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84961509BF;
	Tue, 20 Feb 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lTr3KXk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEA76C9C;
	Tue, 20 Feb 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463447; cv=none; b=oKNIx4UpzR6BOB2gZOlQojnYdGyewLHSdr+WkkbxvnO5tuA+eWPmViBtxiAYW31dFkpBUJAQ9VO8Q4m+I32llzE0mSvcjZ3zPYOgvVlbGBuczQCfVY9Y7MMoBj8uj7hm4nnjnSsvh9TxCCytOnXCBtRm7pGmtHQRVG6toMQWSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463447; c=relaxed/simple;
	bh=VWvrR1slrzNDnQixeRfq8WKztzgOjtuCMr4xvz5fpHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwCjH9xh9pIntOmhpA75EuwRDxoVmidMj65yydV7RVnRVcMbH6LUGAWwk7eZUDUGn7W69t4WFSirsrWwLroXAAHONMMeZqLPMUJmKqL3Jr+yF5M6xdAX1mpPQOiwAcrGdZPZWSLx50Xo01Fp0TXGtMlF38bDPcHFfp/YybPHWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lTr3KXk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63CBC433C7;
	Tue, 20 Feb 2024 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463447;
	bh=VWvrR1slrzNDnQixeRfq8WKztzgOjtuCMr4xvz5fpHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTr3KXk2DUx7BTA/LFD1mpgLpugbmTOusRxAVuJ9fMb1agYEKuEc++mgJMx/NdeyX
	 K47gBBIi+oOD7uHP35OcOkKnQkMVk3fQhWn+nPapETy4J0TqbCnODMeZ2bgIYlouev
	 KOBD0YKkSPV8PuGI8L1IsVEkTCkClbojnRhvvNhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/331] spi: ppc4xx: Drop write-only variable
Date: Tue, 20 Feb 2024 21:52:42 +0100
Message-ID: <20240220205639.051359406@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit b3aa619a8b4706f35cb62f780c14e68796b37f3f ]

Since commit 24778be20f87 ("spi: convert drivers to use
bits_per_word_mask") the bits_per_word variable is only written to. The
check that was there before isn't needed any more as the spi core
ensures that only 8 bit transfers are used, so the variable can go away
together with all assignments to it.

Fixes: 24778be20f87 ("spi: convert drivers to use bits_per_word_mask")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20240210164006.208149-8-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-ppc4xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 03aab661be9d..e982d3189fdc 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -166,10 +166,8 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	int scr;
 	u8 cdm = 0;
 	u32 speed;
-	u8 bits_per_word;
 
 	/* Start with the generic configuration for this device. */
-	bits_per_word = spi->bits_per_word;
 	speed = spi->max_speed_hz;
 
 	/*
@@ -177,9 +175,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	 * the transfer to overwrite the generic configuration with zeros.
 	 */
 	if (t) {
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
 		if (t->speed_hz)
 			speed = min(t->speed_hz, spi->max_speed_hz);
 	}
-- 
2.43.0




