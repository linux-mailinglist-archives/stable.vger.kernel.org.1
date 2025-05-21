Return-Path: <stable+bounces-145824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634EABF434
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E553B9A1A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB89266B5E;
	Wed, 21 May 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XxTfHOMV"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF0264FB5
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829802; cv=none; b=RhlcDJMeYtDl3+kjGz447XPYwt5qBrb8Pm+OBG1kGorsZiaXRWPqAHVAuTHqevJnjztKx1JwM1ZPk3UZPlPMk2t01AsYL0K2vtRtPLcWwx3uNvnMM/cUXLYLaYwb1KEo7p2BP8OtMOrFsCnTWjGPaMCNecMKnCYr2GNNJQ33eiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829802; c=relaxed/simple;
	bh=5hHnMOVEV00BfumJbcwsdXTuYBowBD1eMiFGoga8smg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=MAz/o/kdeNAWZA6ZkAONngzwx/AseI5RQpUIBLZer6zXHExGPbrv1GpbdF4Kj9hoy/tFrs1BeIAozbq3OnwGPLEFLmSX0vPpv8yn+iz5a6m4/QtiHQubRX1ZpwG+V1K0khparAVA9lU6cV+raHpKoNdUe1i4iObsRyUvU2UEFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XxTfHOMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58CC4CEE4;
	Wed, 21 May 2025 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829802;
	bh=5hHnMOVEV00BfumJbcwsdXTuYBowBD1eMiFGoga8smg=;
	h=Subject:To:From:Date:From;
	b=XxTfHOMVowX9JqmNj1m1jYRjYCyokQ1LkmvRrXM+UhUp3/xISt8vqCucdfeN2KSgQ
	 SPAImKQIF3FFypkC0mV7OZE/3dwLDo8p9rTrQAmSuFRNK7q8fLeBSNVcjmBW1rEjSP
	 Q1CjwgJxQlsi9LSitUsv47gj5BChc3QO7zPFc4go=
Subject: patch "iio: adc: ad7606_spi: fix reg write value mask" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,adureghello@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:16:10 +0200
Message-ID: <2025052110-gentile-unglue-3801@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7606_spi: fix reg write value mask

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 89944d88f8795c6c89b9514cb365998145511cd4 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 20:55:34 -0500
Subject: iio: adc: ad7606_spi: fix reg write value mask

Fix incorrect value mask for register write. Register values are 8-bit,
not 9. If this function was called with a value > 0xFF and an even addr,
it would cause writing to the next register.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 179115e90988..b37458ce3c70 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -155,7 +155,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
-				  (val & 0x1FF));
+				  (val & 0xFF));
 
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
-- 
2.49.0



