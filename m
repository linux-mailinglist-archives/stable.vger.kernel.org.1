Return-Path: <stable+bounces-99054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A69E6E6F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227221887A4A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DDA20125F;
	Fri,  6 Dec 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9mbYJkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883B1FDE0C
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488476; cv=none; b=pO3+9P/QqkoV6wsXDp+2qL1XsQbNQVVeVy7Uo7xS20NZp71dI1yeuvNzjT7oBT6m0QBhc0860Uzmien/8DAlfBdFZOuAh7khfZatTa5cOBs4kPNdEgTjfuVg01PT10g874S09pao2ju3cBw0eOKf63ZkGkHIRpVVib5odDFRzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488476; c=relaxed/simple;
	bh=j+3bFFfLY8niDOD4wXjMuADSV2Uj+9MmhMI+oKQRO1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=daS705UZi/sjCAXRV1w2py8q1Wq8OXskkuDSpp/2PpUXMrpzQvNrZeIs2zn+cAAgNnrSwOeatb11E8+GIUJZZk5mmWxgAGi7rL3sOiUJ7V93Vp2p/9eyKH+NM2YhphrGV49aa6K2j1XpcZQd1T8QpshxLl3xq4qp1rBoZiNBZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9mbYJkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956DBC4AF09;
	Fri,  6 Dec 2024 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733488476;
	bh=j+3bFFfLY8niDOD4wXjMuADSV2Uj+9MmhMI+oKQRO1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=T9mbYJkSyeFPlV3HHzihwyNMhv34607I/8eFcS9J7cQ7xIpK8C/szAprduDwyPL6x
	 /DbAg2JM85su22+Zr5hqxRgetRty0b/hFjEc7mKgXC0SpnuuXGO0Dp8cQfXLgem5jt
	 uN5ULkrJ4cYw8DTZ4euWNeud5fa2aBrZteyiulmQ=
Subject: FAILED: patch "[PATCH] iio: adc: ad7923: Fix buffer overflow for tx_buf and" failed to apply to 5.15-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,quzicheng@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:34:32 +0100
Message-ID: <2024120632-reprogram-skyrocket-0fdd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3a4187ec454e19903fd15f6e1825a4b84e59a4cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120632-reprogram-skyrocket-0fdd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a4187ec454e19903fd15f6e1825a4b84e59a4cd Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 29 Oct 2024 13:46:37 +0000
Subject: [PATCH] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer

The AD7923 was updated to support devices with 8 channels, but the size
of tx_buf and ring_xfer was not increased accordingly, leading to a
potential buffer overflow in ad7923_update_scan_mode().

Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Link: https://patch.msgid.link/20241029134637.2261336-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 09680015a7ab..acc44cb34f82 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -48,7 +48,7 @@
 
 struct ad7923_state {
 	struct spi_device		*spi;
-	struct spi_transfer		ring_xfer[5];
+	struct spi_transfer		ring_xfer[9];
 	struct spi_transfer		scan_single_xfer[2];
 	struct spi_message		ring_msg;
 	struct spi_message		scan_single_msg;
@@ -64,7 +64,7 @@ struct ad7923_state {
 	 * Length = 8 channels + 4 extra for 8 byte timestamp
 	 */
 	__be16				rx_buf[12] __aligned(IIO_DMA_MINALIGN);
-	__be16				tx_buf[4];
+	__be16				tx_buf[8];
 };
 
 struct ad7923_chip_info {


