Return-Path: <stable+bounces-194752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95674C5A579
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF3D4F03C4
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C192DEA83;
	Thu, 13 Nov 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXfXcWvM"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B292D6E78
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073309; cv=none; b=Zf+BGIdUg2aHIe/Is2uXGKI14g6OdLPDQkB0wikXg6xGanfrX2K97EnvkQu39RVhbuQv326APsDcAQlYoElTz3SyBljCq/6EgbdZrF+OmyAOutaXjacEBCOF1Kex+gCDR40wc/TYiD/dkoZjPa9HG12FKCZtymoWX8C/ak/D+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073309; c=relaxed/simple;
	bh=4Zk9liUuRa2Zul+rXmroi0gbEc+SCrItK2dUK0Gvj9s=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=e8IYV6qJzimwpWG99J3LQoLM12Jtc9vCuGo5QdAAA9WbCdvA82mcaiECFMB3OQ/NUFJeWDYnB4ai2PJjrBwygQhduN7Fx65jo6Ft2BKDBY85i6BFp0sKmoeENQv9CxcluoeZIrLDcfbg6YYZVc17AvDjQTi6VaVGpLd4HJ4G+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXfXcWvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B723C4CEF7;
	Thu, 13 Nov 2025 22:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073308;
	bh=4Zk9liUuRa2Zul+rXmroi0gbEc+SCrItK2dUK0Gvj9s=;
	h=Subject:To:From:Date:From;
	b=MXfXcWvMucCta6pXBg1Ng/y9UEwGeJkPrE8YXMAVZhI9bdvq2DWiS7WJLFGYJmFmq
	 GY8cxVI6xSw+32+ox9lL2RKx71EDILz5WrAi6KzGxtgwz09FA/B9Ct/ku8oL+wpcGe
	 SfEXUlxxV3QZesOLtQY72PtHG5GCFSXFTyxWcI/k=
Subject: patch "iio: adc: ad7124: fix temperature channel" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,marcelo.schmitt@analog.com,u.kleine-koenig@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:53 -0500
Message-ID: <2025111353-passably-stump-a0f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: fix temperature channel

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e2cc390a6629c76924a2740c54b144b9b28fca59 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Oct 2025 15:24:31 -0500
Subject: iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix temperature channel not working due to gain and offset not being
initialized.  For channels other than the voltage ones calibration is
skipped (which is OK).  However that results in the calibration register
values tracked in st->channels[i].cfg all being zero.  These zeros are
later written to hardware before a measurement is made which caused the
raw temperature readings to be always 8388608 (0x800000).

To fix it, we just make sure the gain and offset values are set to the
default values and still return early without doing an internal
calibration.

While here, add a comment explaining why we don't bother calibrating
the temperature channel.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 910b40393f77..61623cc6cb25 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1525,10 +1525,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 	int ret, i;
 
 	for (i = 0; i < st->num_channels; i++) {
-
-		if (indio_dev->channels[i].type != IIO_VOLTAGE)
-			continue;
-
 		/*
 		 * For calibration the OFFSET register should hold its reset default
 		 * value. For the GAIN register there is no such requirement but
@@ -1538,6 +1534,14 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		st->channels[i].cfg.calibration_offset = 0x800000;
 		st->channels[i].cfg.calibration_gain = st->gain_default;
 
+		/*
+		 * Only the main voltage input channels are important enough
+		 * to be automatically calibrated here. For everything else,
+		 * just use the default values set above.
+		 */
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
 		/*
 		 * Full-scale calibration isn't supported at gain 1, so skip in
 		 * that case. Note that untypically full-scale calibration has
-- 
2.51.2



