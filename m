Return-Path: <stable+bounces-175882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18061B36A67
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62FAA011FA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D614352FF3;
	Tue, 26 Aug 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rc0Cg1Vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22A35209C;
	Tue, 26 Aug 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218217; cv=none; b=qj9qPG4Nxroa1FreC6aWn7A2nws4I/yH83Ui787ByZTvgPeUHTXRaIkXh1GRkqO2kKAEe4iXzXfCvdoL+ZYPg322iuYA2G6TDzh6U3vtbpma0oWzToew9Jx/bYJdHmN4PXFVS0w3LQf2FuS1pZcBgM9sU38Edbi9fuT45CaSKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218217; c=relaxed/simple;
	bh=Rtio3tJl3uYNIg1wDCSrlgGYXWncdXTpM7IvbM1f6LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCqLiISLnt+0WA4zOkIm4MziYKS6+n/jItRsb5Fm9cXZATcQ3MLDKQ1Q51f+tzI0r7vuL0M2dxbjhYQjYdzZDlDxfaEOaRP1Mx+vH7BVzVCV34T+EXTSgJe7ZiQx8xh8YYYAWLEh7i+qifTijZNWCHk1i6xvKi47rPerk4YIgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rc0Cg1Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2DAC4CEF1;
	Tue, 26 Aug 2025 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218216;
	bh=Rtio3tJl3uYNIg1wDCSrlgGYXWncdXTpM7IvbM1f6LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rc0Cg1VdR7fkwzw4J0RJnDoehV9ueqlImw7xKTQ62JnTiX4+XOw4sEtKtdSnfVCU2
	 WrdevXw0U221i8LG5roIKIpdv//QQiY5m1k9JdKbcg0uoxgqs9XhpRuxqU6h20Zrvh
	 sVIsGIZ8dHUDpBy7k2xzGkV+uXKoQ84F4q9TrscA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 407/523] iio: proximity: isl29501: fix buffered read on big-endian systems
Date: Tue, 26 Aug 2025 13:10:17 +0200
Message-ID: <20250826110934.498532442@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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



