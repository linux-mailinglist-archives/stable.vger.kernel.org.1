Return-Path: <stable+bounces-234586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFwXOLSj1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:51:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDE3C1C53
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A13B30F2E65
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA03624B0;
	Wed,  8 Apr 2026 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKI5AzZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2553ACF16;
	Wed,  8 Apr 2026 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673243; cv=none; b=HsUfRt0ppKw9EpN+5YMmwFurAcejWu04ZSKp2zBl9Cy+Vn3ajLfTlVh8UWuGR4gKBvZBaGGnwtuCz6T4GpFi6wi1tUDnG93NX2B8L62bFaOioHk/fjHhljVUwRqWcxNAQQCn2QB3CmtoVaC8CqNcmeIWTdI3nS86HYETArvCLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673243; c=relaxed/simple;
	bh=XdvGTwcoAe4YN7jZQVa2OqDJdTj4SMitJuPioAH5l8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G17dIWwBhdiHlQsSmsk8TDusbj0vbrafTr6dx3EruRz6XvY/lPzSHE1ii8Eh+FSLuIbdOhGrG/gYA4XGT8wQAETfNCEX5YhlVEZEXFhzFz2e95GeVBe40BIH4Fc5YA4SwH5qTs4ZBF3GfUuRAkcLDHnWsXpA4F3ITNSvkQAUC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKI5AzZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D89C19421;
	Wed,  8 Apr 2026 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673243;
	bh=XdvGTwcoAe4YN7jZQVa2OqDJdTj4SMitJuPioAH5l8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKI5AzZZgff0wmP0gyOAg6XfMQfnhl92zzyi5hEsRFFxB86GsRuRtB891KlUITZqm
	 6DbWaNe1JlMeN2Dy5yYnRNdchjFd6ig4EhkOLaxJ8YeUAM5toBPd2/YgsfkMWN+6uX
	 M3rCsyJ/xKkaItA/g6IAPDX7Sh49JoxqiElfRc8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 157/277] iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()
Date: Wed,  8 Apr 2026 20:02:22 +0200
Message-ID: <20260408175939.733456922@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234586-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: 70CDE3C1C53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

commit 768461517a28d80fe81ea4d5d03a90cd184ea6ad upstream.

Add a DMA-safe buffer and use it for spi_read() instead of a stack
memory. All SPI buffers must be DMA-safe.

Since we only need up to 3 bytes, we just use a u8[] instead of __be16
and __be32 and change the conversion functions appropriately.

Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-adc161s626.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

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
@@ -78,26 +80,20 @@ static int ti_adc_read_measurement(struc
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



