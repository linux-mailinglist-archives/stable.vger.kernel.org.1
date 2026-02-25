Return-Path: <stable+bounces-218663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EtkJWJYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB91906FB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7005131B7D69
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD324A05D;
	Wed, 25 Feb 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HwWfdFkY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E401D5141;
	Wed, 25 Feb 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983516; cv=none; b=i940VuP4ThOo3FM4RZR00vGVw1/aoKd7YBIGKpuFynZywQze8niyDoBTmMm0ldT0rw0lu0zG7jGSgafkKYmRB2m/d3By+7xvpD5yg2Djna4BNWtj8VP2Cpd4ra3OSr2/CFROhTHQqXZUTtd21QkAHdfWzSAhwdhcYXXysU9P0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983516; c=relaxed/simple;
	bh=V6WHkgQE6zaBHl5hNCHqUpelKjiUnrhiYoXOWm2mVKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ5RPivFSf2Hh8DDv2qEW5igwcsEWuH+le0Z7ICblIn6V3cg7JswWChIHrpJCVnJI8BJk4uUnjk/hPWoJJYiB9ubRgcWGWNYdJ4W5Ib7KPkGxTAczfPRsk7VFT7s0UCNKru9HxPDxnVLf3UTRGwpdj9XIUGPdN86j1VYuENj2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HwWfdFkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36302C116D0;
	Wed, 25 Feb 2026 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983516;
	bh=V6WHkgQE6zaBHl5hNCHqUpelKjiUnrhiYoXOWm2mVKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwWfdFkYivgIHZjRF8HmN5GX2bL+1bykBeiY4WfG6WhNYMbOp7YALbfR2rXFA9tfH
	 OJ621jYxBryyqCtINsVFLTx5QRmRtU0upBNoj+ruwstK7ozYD5THXZT1iswda1S5Np
	 VHqOrIa5nFmHGqZBX2hsGpYPi0F5LGtTIQPHwgxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 581/781] iio: pressure: mprls0025pa: fix pressure calculation
Date: Tue, 24 Feb 2026 17:21:30 -0800
Message-ID: <20260225012414.049053939@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218663-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,subdimension.ro:email]
X-Rspamd-Queue-Id: 40CB91906FB
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit d63403d4e31ae537fefc5c0ee9d90f29b4fc532b ]

A sign change is needed for proper calculation of the pressure.

This is a minor fix since it only affects users that might have custom
silicon from Honeywell that has honeywell,pmin-pascal != 0.

Also due to the fact that raw pressure values can not be lower
than output_min (400k-3.3M) there is no need to calculate a decimal for
the offset.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mprls0025pa.c | 26 +++++++++++---------------
 drivers/iio/pressure/mprls0025pa.h |  2 --
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 6ba45d4c16b30..d4133fef91fac 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -59,7 +59,7 @@
  *
  * Values given to the userspace in sysfs interface:
  * * raw	- press_cnt
- * * offset	- (-1 * outputmin) - pmin / scale
+ * * offset	- (-1 * outputmin) + pmin / scale
  *                note: With all sensors from the datasheet pmin = 0
  *                which reduces the offset to (-1 * outputmin)
  */
@@ -313,8 +313,7 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = data->offset;
-		*val2 = data->offset2;
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -330,8 +329,9 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	s64 scale, offset;
+	s64 odelta, pdelta;
 	u32 func;
+	s32 tmp;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -405,17 +405,13 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
 
-	/* use 64 bit calculation for preserving a reasonable precision */
-	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-			data->outmax - data->outmin);
-	data->scale = div_s64_rem(scale, NANO, &data->scale2);
-	/*
-	 * multiply with NANO before dividing by scale and later divide by NANO
-	 * again.
-	 */
-	offset = ((-1LL) * (s64)data->outmin) * NANO -
-		  div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
-	data->offset = div_s64_rem(offset, NANO, &data->offset2);
+	odelta = data->outmax - data->outmin;
+	pdelta = data->pmax - data->pmin;
+
+	data->scale = div_s64_rem(div_s64(pdelta * NANO, odelta), NANO, &tmp);
+	data->scale2 = tmp;
+
+	data->offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler, 0,
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d62a018eaff32..b6944b3051267 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -53,7 +53,6 @@ enum mpr_func_id {
  * @scale: pressure scale
  * @scale2: pressure scale, decimal number
  * @offset: pressure offset
- * @offset2: pressure offset, decimal number
  * @gpiod_reset: reset
  * @irq: end of conversion irq. used to distinguish between irq mode and
  *       reading in a loop until data is ready
@@ -75,7 +74,6 @@ struct mpr_data {
 	int			scale;
 	int			scale2;
 	int			offset;
-	int			offset2;
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;
-- 
2.51.0




