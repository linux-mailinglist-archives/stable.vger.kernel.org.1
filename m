Return-Path: <stable+bounces-176330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B754B36BA2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A007BB199
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C33568F0;
	Tue, 26 Aug 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ElNUd/2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772F352FEE;
	Tue, 26 Aug 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219378; cv=none; b=GiJjVIoIf0DaWjicVrj0zSR4Ip9OZZF1F7DfRq6JWN8LbDWGeFxwk0vRhaT20esJz1naWN/y5WVmv+wHwET19HzRZEdtD/ygaxK3mBk/rtREz0F6MJULP/dEJVf9DsLrxIqYFDxur4iyEhY/Yy/Rp8TQuhUrpM8DdP/xUEyLeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219378; c=relaxed/simple;
	bh=Vb3LMFbrP5l0jDPoACsk+nu6jsceIB9jLAprf62dZJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC0Iy33MrktvnCOupfogxaIrBjqcYIyMkMGI3wEIvJdqJ9LrQ9BzNhcYqAOlhnbc1pCC3qT8mj/ZOFSAByk7pSFS7OrGnUBeRYE9hH0eALbB0WAvh3GnzQGVDxpVcH96DqWsndHZIGKpsurv3VdTNI2e3WySbdi5jXR3eE43EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ElNUd/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F11DC4CEF1;
	Tue, 26 Aug 2025 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219377;
	bh=Vb3LMFbrP5l0jDPoACsk+nu6jsceIB9jLAprf62dZJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2ElNUd/2Pm49ZgW7AbOWjSUqjw4P2gj6Bli8GFuY5Yhw9HDBAaXNKQsbyKSbLdviY
	 NRx/jfuq8H/LmtwAc8iH3VaLouChfeWBWFn4AM2wEtVJ6bFGwwkLTdoaWmu8qno1l8
	 TaasavCKxjmBFTLYWVAUy7XJm4EdkS9U/apPBLBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 317/403] iio: proximity: isl29501: fix buffered read on big-endian systems
Date: Tue, 26 Aug 2025 13:10:43 +0200
Message-ID: <20250826110915.570500958@linuxfoundation.org>
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

From: David Lechner <dlechner@baylibre.com>

commit de18e978d0cda23e4c102e18092b63a5b0b3a800 upstream.

Fix passing a u32 value as a u16 buffer scan item. This works on little-
endian systems, but not on big-endian systems.

A new local variable is introduced for getting the register value and
the array is changed to a struct to make the data layout more explicit
rather than just changing the type and having to recalculate the proper
length needed for the timestamp.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/proximity/isl29501.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_hand
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
+	u32 value;
+	struct {
+		u16 data;
+		aligned_s64 ts;
+	} scan = { };
 
-	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
+		isl29501_register_read(isl29501, REG_DISTANCE, &value);
+		scan.data = value;
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;



