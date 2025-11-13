Return-Path: <stable+bounces-194744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B433C5A561
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D63A84EF5C1
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FA76026;
	Thu, 13 Nov 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2DXTgLB"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F97261B
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073293; cv=none; b=GeTrKD5ocve8N9pmqxsQzDWZsJezrelZj3xlcBat1uSyBcwRXW+x5Yt7eKMgJf/YQ5x/vGEuvFeVpy9N755Gc3Az5mz+yufZrTKI2aZYcfD771ZV+3nZlE/qrIgXFa6Z7tWnMffGnxIpBSBFn4oOW782yIQM7JeV8585HhNkyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073293; c=relaxed/simple;
	bh=iJMc37q1COIzvkMOs2JrgjtM9UwV9MvReD8Op97iy9s=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=KaxXPOiP1cYg0WnNWkB8QRXedos8SBQY5U461rCLrF8yM8pF93i8x7IrNmwr4r/ErJ2Knco2TZ9EYQHuFD73ZnZxEVXB98ssT91Qfyg/fjYFRm4i3fTGi1UQ0rA8dkSXM/4hGKRk/AFX6oS10T+5QkENQ1VH6bKyfB9v3JFXNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2DXTgLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA6C4AF0B;
	Thu, 13 Nov 2025 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073293;
	bh=iJMc37q1COIzvkMOs2JrgjtM9UwV9MvReD8Op97iy9s=;
	h=Subject:To:From:Date:From;
	b=j2DXTgLB2ym4t8hj5hz32qeyhi7hmwJvZ9EOzcwFUmyFqIS8gvruErIy6u2K+eOZP
	 iKABM4kNNDflmk9Z34xeBlyOW37px4pqMa0WwxF5PbELwJn3EBBPN2VIYIIwvE//k1
	 wMmZFwXr1H6JRWX9yp/TnpuEkJmomr8FMS5Mkzgc=
Subject: patch "iio: adc: ad7380: fix SPI offload trigger rate" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:49 -0500
Message-ID: <2025111349-tumble-overhand-00bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7380: fix SPI offload trigger rate

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 632757312d7eb320b66ca60e0cfe098ec53cee08 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Sep 2025 15:50:34 -0500
Subject: iio: adc: ad7380: fix SPI offload trigger rate

Add a special case to double the SPI offload trigger rate when all
channels of a single-ended chip are enabled in a buffered read.

The single-ended chips in the AD738x family can only do simultaneous
sampling of half their channels and have a multiplexer to allow reading
the other half. To comply with the IIO definition of sampling_frequency,
we need to trigger twice as often when the sequencer is enabled to so
that both banks can be read in a single sample period.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7380.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index fa251dc1aae6..bfd908deefc0 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1227,6 +1227,14 @@ static int ad7380_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the sequencer is required to read all channels, we need to
+	 * trigger twice per sample period in order to read one complete set
+	 * of samples.
+	 */
+	if (st->seq)
+		config.periodic.frequency_hz *= 2;
+
 	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
 	if (ret)
 		spi_unoptimize_message(&st->offload_msg);
-- 
2.51.2



