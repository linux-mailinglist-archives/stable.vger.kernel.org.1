Return-Path: <stable+bounces-175989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD3B36AEF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC21C25394
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88341350D72;
	Tue, 26 Aug 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iS7707GE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46107350D54;
	Tue, 26 Aug 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218494; cv=none; b=Ni87TlhGZ3SqTaLSqlgbXoeY11iBiIdsHX4dfjffZWcAp3nHuj3bi4zUaADVGBzHvKqiYZMRY4Bim4DxOYDUyEoHkc0P5gJcmVMQP8w21OEDBgTHs/cGCozTMXCZWhKAWSU1R3TTrwQNb1WpzRklpAm0PV8sHP/SDKrq6UFkQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218494; c=relaxed/simple;
	bh=9yrhtf/BIFkwr+Cx54P+VEqoBVuujBpOF10zCEcYvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw6p3FAKLDAvAKMlPy7kJAiuckzEwlx8ONm5Sy+DL7TE8+2T/TCBbtuudLHd52p94f8qcA8rg5ytVmcExeKtKQ/+FquMryj15YP8hslMY1KTVd8O/f8Avj3Om2FufO0FLXPYdtBZg37lLSasvBv6/1zdI6lEoatkrKqnXPI+oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iS7707GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA7C4CEF1;
	Tue, 26 Aug 2025 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218494;
	bh=9yrhtf/BIFkwr+Cx54P+VEqoBVuujBpOF10zCEcYvVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iS7707GE9LvNPKtSIJEw7O8xcDDRcUxD28iJXrlIKzwwRW1i8giACqGnSWG0V+bxd
	 vo2v6Vqvibinzg6lIeNg+FIDRc9RO2O//B2eohNSJjysNS16pJ9mi9XLx+oisDsbXC
	 81ZCRw+OY4521ZB6u09Lvq7bctersH4VJy2XO93g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 022/403] iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Date: Tue, 26 Aug 2025 13:05:48 +0200
Message-ID: <20250826110906.381171705@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

commit 6d21f2c2dd843bceefd9455f2919f6bb526797f0 upstream.

Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
booting a board populated with a MAX11601 results in a flood of warnings:

max1363 1-0064: available_scan_mask 8 subset of 0. Never used
max1363 1-0064: available_scan_mask 9 subset of 0. Never used
max1363 1-0064: available_scan_mask 10 subset of 0. Never used
max1363 1-0064: available_scan_mask 11 subset of 0. Never used
max1363 1-0064: available_scan_mask 12 subset of 0. Never used
max1363 1-0064: available_scan_mask 13 subset of 0. Never used
...

These warnings are caused by incorrect offsets used for differential
channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.

The max1363_mode_table[] defines the differential channel mappings as
follows:

MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),

Update the macros to follow this same pattern, ensuring that the scan masks
are valid and preventing the warnings.

Cc: stable@vger.kernel.org
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20250516173900.677821-1-festevam@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/max1363.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -505,10 +505,10 @@ static const struct iio_event_spec max13
 	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),	\
 	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
@@ -603,14 +603,14 @@ static const enum max1363_modes max11608
 	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
 	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
 	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);



