Return-Path: <stable+bounces-20604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF285A8C1
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D21F21042
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511973C46F;
	Mon, 19 Feb 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cnFdTHEX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5863BB3B
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359712; cv=none; b=XageFOx5AnDu6QpW8nFxeE5CSGNAAdsaweLvVB0d3RmgqpRwGgZejSvwAi7ZBw81Mu+w8idOQA9Qk1Yhbz7eflPyYzrlqghLvHf4blqah+oYOWiWbb59XEriVRvtEWK4E5LwLY0PVdCN8dzK4NtnCr35jIKY0xSwY9oyLTuwGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359712; c=relaxed/simple;
	bh=ciNNFu1gbTXPk8d4io2l5XIy6sSF0WD35XCROTAO51k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fm06V8jRcpPJcLHdccWBOF1iBD/lpB6yyLPd2ChIzg10Ed7n0UDHe6pDIiJjOW9OFcbFjUjVz7RGz8zH4yHOCfqI3DTR0UdWv0L5SOSrYR4vL66bibDRi+3bp2r1pem6uRoHYKgq1Onvz8pbKyggtaYzaUMiE1Zj3ISyyRKjX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnFdTHEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A4FC433C7;
	Mon, 19 Feb 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359711;
	bh=ciNNFu1gbTXPk8d4io2l5XIy6sSF0WD35XCROTAO51k=;
	h=Subject:To:Cc:From:Date:From;
	b=cnFdTHEXQTVXIAhAGx1yPaQDqMwg7rCPUdLC206O5b66FciEg9Lw5zC/F8hxGlhRf
	 m2SdZ3unIs70Ir+6ZyynOJKra1QWfgX+AN6h7KWOb6iDD/sGU2OTZrrFi6F2ahXddK
	 5Kr3QsyWPOY5Eme63IMVpDS9P0dVh1fEJlvy/BfI=
Subject: FAILED: patch "[PATCH] iio: imu: adis: ensure proper DMA alignment" failed to apply to 5.4-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:21:48 +0100
Message-ID: <2024021948-stoneware-sway-5a5d@gregkh>
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
git cherry-pick -x 8e98b87f515d8c4bae521048a037b2cc431c3fd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021948-stoneware-sway-5a5d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8e98b87f515d ("iio: imu: adis: ensure proper DMA alignment")
c39010ea6ba1 ("iio: adis: stylistic changes")
31fa357ac809 ("iio: adis: handle devices that cannot unmask the drdy pin")
b600bd7eb333 ("iio: adis: do not disabe IRQs in 'adis_init()'")
7e77ef8b8d60 ("iio: adis: set GPIO reset pin direction")
30f6a542b7d3 ("iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable")
fa623cddc040 ("iio: adis16460: Use Managed device functions")
fff7352bf7a3 ("iio: imu: Add support for adis16475")
698211065d4a ("iio: imu: adis: Add irq flag variable")
fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
2dd86ba82133 ("iio: imu: adis: update 'adis_data' struct doc-string")
3543b1998dd3 ("iio: imu: adis: add doc-string for 'adis' struct")
62504d1b44ec ("iio: adis16460: Make use of __adis_initial_startup")
1fd456702692 ("iio: imu: adis: add support product ID check in adis_initial_startup")
ecb010d44108 ("iio: imu: adis: Refactor adis_initial_startup")
fdcf6bbb4ed3 ("iio: imu: adis: Add self_test_reg variable")
3f17ada8f38c ("iio: imu: adis: add unlocked __adis_initial_startup()")
e914cfdf12ab ("iio: gyro: adis16136: initialize adis_data statically")
99460853a894 ("iio: imu: adis16400: initialize adis_data statically")
97928677fe35 ("iio: imu: adis16480: initialize adis_data statically")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e98b87f515d8c4bae521048a037b2cc431c3fd5 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 14:10:49 +0100
Subject: [PATCH] iio: imu: adis: ensure proper DMA alignment

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for the sigma_delta ADCs.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: ccd2b52f4ac6 ("staging:iio: Add common ADIS library")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240117-adis-improv-v1-1-7f90e9fad200@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index dc9ea299e088..8898966bc0f0 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -11,6 +11,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 
 #define ADIS_WRITE_REG(reg) ((0x80 | (reg)))
@@ -131,7 +132,7 @@ struct adis {
 	unsigned long		irq_flag;
 	void			*buffer;
 
-	u8			tx[10] ____cacheline_aligned;
+	u8			tx[10] __aligned(IIO_DMA_MINALIGN);
 	u8			rx[4];
 };
 


