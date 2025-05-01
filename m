Return-Path: <stable+bounces-139329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B11AA60F0
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C191BC4552
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FF204C00;
	Thu,  1 May 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNQnqPxU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09C1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114624; cv=none; b=s88lmrDCBsclWs1Lh/AxruLYg6OwIkg8aeMDSlC2ivJ0/deHm189IcDYNqzkXXQDhFXam66NTDTdAE9vNRRqN10tB/Bn7V9Tqh+zvXfumEjC52FGptDrx7vyYc2q+u0+uBn2tn+zaesQdJBVvf7nZVeE22SDrYt0bzhkBuXhSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114624; c=relaxed/simple;
	bh=TpcOPHNk7E1MH+MY5wbq3PBcNO/sh8ATswK0kUljvJA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PR/75KdpH9qeKNOodlqKFg/+BjigJ3sTUSgO37dULhGcnqlaCFw8cWcsJwRByi3Cfxo2EsSSz6X8zRCDEzRsVZcnhgilIe8HnDYi3dQTdJTjEdpqOVvVvASpU0ElcjU6jeGpXpNMFc6bDESclxV7x6S3Hy+KsfQPj+sV97Gb2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNQnqPxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98CC4CEED;
	Thu,  1 May 2025 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114623;
	bh=TpcOPHNk7E1MH+MY5wbq3PBcNO/sh8ATswK0kUljvJA=;
	h=Subject:To:From:Date:From;
	b=eNQnqPxUlZAjsQByFjCzAWeZlCUVO3y8nINfEqaPbbQPR1EEP0Gn3fF/bxdy9d6Nf
	 iOh8rczkA6zmwNY14y0kWFJBJsq4oz/2aU+GyQ9xIth/xFGu8BgD4T66CgiEj6KHeC
	 D6qNNSL4zMZnoI3z+ymuTTfCUGMxtvVCgBzn1swU=
Subject: patch "iio: adc: ad7606: fix serial register access" added to char-misc-linus
To: adureghello@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:49:03 +0200
Message-ID: <2025050103-facelift-applied-c96e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7606: fix serial register access

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f083f8a21cc785ebe3a33f756a3fa3660611f8db Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Fri, 18 Apr 2025 20:37:53 +0200
Subject: iio: adc: ad7606: fix serial register access

Fix register read/write routine as per datasheet.

When reading multiple consecutive registers, only the first one is read
properly. This is due to missing chip select deassert and assert again
between first and second 16bit transfer, as shown in the datasheet
AD7606C-16, rev 0, figure 110.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 885bf0b68e77..179115e90988 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -131,7 +131,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,
-- 
2.49.0



