Return-Path: <stable+bounces-219421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDaTOeWdnmk5WgQAu9opvQ
	(envelope-from <stable+bounces-219421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F9192B0D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65BFE30172D4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18563128D9;
	Wed, 25 Feb 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rma2PzYn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515A3033CB;
	Wed, 25 Feb 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002704; cv=none; b=MQqkpDiCpFLHRLKDEuC6ae/VAM2KQHZI8ToItlgIfq9jBZ724u6rgXsq1LUYjckjmIuzaSkDOFGgq+V/bF3nwWpxSKzIThf/NlPixN5VzW7Yfrq+8bcQ2qSgXjjR8zJrwSHxpVLesT46/RjI6jQoQNwW0UhvZ+olPG4WB+wG7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002704; c=relaxed/simple;
	bh=4ggRs9xtqrkJ4NXvXDdN9xjS+MT7jiDFK7pWmYihMRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1yMIG042+VTXUw+SRgQ/pnYXAKkWDA8ZN7ZKkVID0rcGYXdTYt6Q7Tbwv4fxlRH4ISHnupgfWdtUUIyUKAHlsYfmvbGbkISdxxVu8aryO5UmyG13HC6cjwOU+oqNuCAkZOLCoDhUCc3ethU28WAxKDds3XyLwJ+cJSBzZNsmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rma2PzYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734D9C116D0;
	Wed, 25 Feb 2026 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002704;
	bh=4ggRs9xtqrkJ4NXvXDdN9xjS+MT7jiDFK7pWmYihMRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rma2PzYnWGuwh/d1z4QYFa/BL1HSc1bvnsYeAC63y2Jo1v3HdcV1F6AZqO90uYkeV
	 gR8f9rpFvjALmJdZphxulmTg8LQM9wSPcY5iaEKv+GMvaB8Q+7OD+tEWzrl8oPgPvR
	 6/saQsxXIBnYuKDh9Hm9uEs+6blzTe2i3W9aoOvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 468/641] iio: pressure: mprls0025pa: fix SPI CS delay violation
Date: Tue, 24 Feb 2026 17:23:14 -0800
Message-ID: <20260225012359.853643625@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219421-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 9E4F9192B0D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit 583fa86ca581595b1f534a8de6d49ba8b3bf7196 ]

Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
during the SPI transfer there is a minimum time interval requirement
between the CS being asserted and the first clock edge (tHDSS).
This minimum interval of 2.5us is being violated if two consecutive SPI
transfers are queued up.

Fixes: a0858f0cd28e ("iio: pressure: mprls0025pa add SPI driver")
Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mprls0025pa_spi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index e6bb75de34119..cf17eb2e72083 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -8,6 +8,7 @@
  *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  */
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
@@ -40,17 +41,25 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
 	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
-	struct spi_transfer xfer = { };
+	struct spi_transfer xfers[2] = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
 	buf->tx[0] = cmd;
-	xfer.tx_buf = buf->tx;
-	xfer.rx_buf = data->buffer;
-	xfer.len = pkt_len;
 
-	return spi_sync_transfer(spi, &xfer, 1);
+	/*
+	 * Dummy transfer with no data, just cause a 2.5us+ delay between the CS assert
+	 * and the first clock edge as per the datasheet tHDSS timing requirement.
+	 */
+	xfers[0].delay.value = 2500;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].tx_buf = buf->tx;
+	xfers[1].rx_buf = data->buffer;
+	xfers[1].len = pkt_len;
+
+	return spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static const struct mpr_ops mpr_spi_ops = {
-- 
2.51.0




