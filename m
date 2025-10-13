Return-Path: <stable+bounces-184810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F53BD49A9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5AA5504700
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A054308F1B;
	Mon, 13 Oct 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUhHvbBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F725784F;
	Mon, 13 Oct 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368500; cv=none; b=bZjendqZaMV0PELXgVJIPAsG+rnD6LDSKRuBogITStFmpxeOyA1mi5WW/+I389YsCiEFARD3nJpmUbWmv3w/t78j/R8Z7s7aB42qwcfhWmeTgsA2RKa8W8dZg10BU0YIiOOzmS9BR+Z1s4WUhcmYnvL5Co1BDq0jbPkrRssRaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368500; c=relaxed/simple;
	bh=QiBUuJiwG3ey1MyPML+c3TcTZDZOfdHIM0/QsRjcjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z762hXBjKy6X67OgfW3RfXguHVO/VnLLpHd70ecVPmJhnBZ/Ow9emOin0MsXspvCgfC3U57Grfv7mL4pN9c9M2/D3w928Rl7S0rEXTPMCwbxTOPvxssQf2hBMynWA4sXX9i2QAWjLkBJyq63neEyHUV5N9bSGDaNKnkO6xFhaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUhHvbBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D671C4CEE7;
	Mon, 13 Oct 2025 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368499;
	bh=QiBUuJiwG3ey1MyPML+c3TcTZDZOfdHIM0/QsRjcjEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUhHvbBemdAdfJECBs2PseFZ0dA3HWvW8IN6vrBw2v+FAr+GjtoKhvUblRUH5zHsb
	 sylYnZQb1qotgqrJJz9nWoLtWIVhY2ecDIfbNZUjPs0PvFF74A9J7Gbme549gpmC4P
	 P4llR+c8FpWW3rpcwTGxj02fTw9kRygzqmfMhh/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 140/262] iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
Date: Mon, 13 Oct 2025 16:44:42 +0200
Message-ID: <20251013144331.165263641@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit 0f85406bf830eb8747dd555ab53c9d97ee4af293 ]

There is an issue with the handling of negative channel scales
in iio_convert_raw_to_processed_unlocked() when the channel-scale
is of the IIO_VAL_INT_PLUS_[MICRO|NANO] type:

Things work for channel-scale values > -1.0 and < 0.0 because of
the use of signed values in:

	*processed += div_s64(raw64 * (s64)scale_val2 * scale, 1000000LL);

Things will break however for scale values < -1.0. Lets for example say
that raw = 2, (caller-provided)scale = 10 and (channel)scale_val = -1.5.

The result should then be 2 * 10 * -1.5 = -30.

channel-scale = -1.5 means scale_val = -1 and scale_val2 = 500000,
now lets see what gets stored in processed:

1. *processed = raw64 * scale_val * scale;
2. *processed += raw64 * scale_val2 * scale / 1000000LL;

1. Sets processed to 2 * -1 * 10 = -20
2. Adds 2 * 500000 * 10 / 1000000 = 10 to processed

And the end result is processed = -20 + 10 = -10, which is not correct.

Fix this by always using the abs value of both scale_val and scale_val2
and if either is negative multiply the end-result by -1.

Note there seems to be an unwritten rule about negative
IIO_VAL_INT_PLUS_[MICRO|NANO] values that:

i.   values > -1.0 and < 0.0 are written as val=0 val2=-xxx
ii.  values <= -1.0 are written as val=-xxx val2=xxx

But iio_format_value() will also correctly display a third option:

iii. values <= -1.0 written as val=-xxx val2=-xxx

Since iio_format_value() uses abs(val) when val2 < 0.

This fix also makes iio_convert_raw_to_processed() properly handle
channel-scales using this third option.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Cc: Matteo Martelli <matteomartelli3@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Link: https://patch.msgid.link/20250831104825.15097-2-hansg@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/inkern.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1155487f7aeac..0f394266ff8c0 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
@@ -602,7 +603,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
-	s64 raw64 = raw;
+	s64 denominator, raw64 = raw;
 
 	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
 				       IIO_CHAN_INFO_OFFSET);
@@ -646,20 +647,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000LL);
-		break;
 	case IIO_VAL_INT_PLUS_NANO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000000LL);
+		switch (scale_type) {
+		case IIO_VAL_INT_PLUS_MICRO:
+			denominator = MICRO;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			denominator = NANO;
+			break;
+		}
+		*processed = raw64 * scale * abs(scale_val);
+		*processed += div_s64(raw64 * scale * abs(scale_val2), denominator);
+		if (scale_val < 0 || scale_val2 < 0)
+			*processed *= -1;
 		break;
 	case IIO_VAL_FRACTIONAL:
 		*processed = div_s64(raw64 * (s64)scale_val * scale,
-- 
2.51.0




