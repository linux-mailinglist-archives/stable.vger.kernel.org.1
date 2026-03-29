Return-Path: <stable+bounces-230926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF+bMa4pyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE8352402
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1054D3015E26
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F3375F99;
	Sun, 29 Mar 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWehkZKH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655C375AB5
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790940; cv=none; b=HxMWXBtmhzBnnwemiXCKmTQOwE5m9MILl2Y9iHaR9x9fnggv0lupZL/JKiPLwzx/cHlvvTeG678AWWG99KzgPDq7tjm9eYua9lGFkHmEAvXIfJRlFcCvBajj4IwnWwxwp0vr4ZyFx0J1BHisQPIvMbWQILLPU/RMqi7cspVaoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790940; c=relaxed/simple;
	bh=xR3G453xqLMxpXI2GzGQf6I8ah1UMqctQ+dtsQvCU98=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ihLiGO8GT7NtBZVmeRhLUN4UphZGHSA20lrbZ6XhZQ7qL4QlNQOKLiu1pmrvRNcsoD1vkwTi7ETG8H7ELiTCl0khBvUoeA8CdzZFa4PYtoX8ZbAPps9uWkK/SKG7fLE6g8GlfvRssEh5d8Xu/GgHxCQtotZz1ih3221aa0F56TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWehkZKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86267C116C6;
	Sun, 29 Mar 2026 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790939;
	bh=xR3G453xqLMxpXI2GzGQf6I8ah1UMqctQ+dtsQvCU98=;
	h=Subject:To:From:Date:From;
	b=MWehkZKHz8lDfM9WRL1ROLjXZarTqYAHNrNbhhO5yVDoGf9rs0gG2/yHco5ccDYJc
	 Kl4NUjTKplxKhm7fW+L6lOiTRhYqXGGm2h9vV+rx6MzBUUvmfGX8Kp9sixZiju7SBl
	 EYkPefTXIjeYC/9l8EaGvRtvzDQ+4UE9n5fraBeg=
Subject: patch "iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:15 +0200
Message-ID: <2026032915-reforest-grit-64e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230926-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,baylibre.com:email,intel.com:email]
X-Rspamd-Queue-Id: 33EE8352402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 768461517a28d80fe81ea4d5d03a90cd184ea6ad Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 18:13:32 -0500
Subject: iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()

Add a DMA-safe buffer and use it for spi_read() instead of a stack
memory. All SPI buffers must be DMA-safe.

Since we only need up to 3 bytes, we just use a u8[] instead of __be16
and __be32 and change the conversion functions appropriately.

Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc161s626.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 42968d96572b..be1cc2e77862 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/buffer.h>
@@ -70,6 +71,7 @@ struct ti_adc_data {
 
 	u8 read_size;
 	u8 shift;
+	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ti_adc_read_measurement(struct ti_adc_data *data,
@@ -78,26 +80,20 @@ static int ti_adc_read_measurement(struct ti_adc_data *data,
 	int ret;
 
 	switch (data->read_size) {
-	case 2: {
-		__be16 buf;
-
-		ret = spi_read(data->spi, (void *) &buf, 2);
+	case 2:
+		ret = spi_read(data->spi, data->buf, 2);
 		if (ret)
 			return ret;
 
-		*val = be16_to_cpu(buf);
+		*val = get_unaligned_be16(data->buf);
 		break;
-	}
-	case 3: {
-		__be32 buf;
-
-		ret = spi_read(data->spi, (void *) &buf, 3);
+	case 3:
+		ret = spi_read(data->spi, data->buf, 3);
 		if (ret)
 			return ret;
 
-		*val = be32_to_cpu(buf) >> 8;
+		*val = get_unaligned_be24(data->buf);
 		break;
-	}
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0



