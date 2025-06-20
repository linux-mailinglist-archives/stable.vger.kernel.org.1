Return-Path: <stable+bounces-155079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8FAE18B0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD80A7A6FCF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D42857D5;
	Fri, 20 Jun 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Z5lglw4m"
X-Original-To: stable@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE95283CB5
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414766; cv=none; b=XSFoQ8LlKQwec3P24AgVL3wTxcF2bXiOr2N04ARcERa5Rx3slN298aWEc72+Njx01U1w6fo3fP9DNTpTUG0XSd6oz2GWJLLblccKa0xUapWKtMRBXpiwgumXJMRJBx9gM3f7T6LZWUIXZBizWCW5C+aKGBB8j1zhB8OHgxeBP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414766; c=relaxed/simple;
	bh=ubOwBTKJdg9Aa63i1epJd6uQoktyNpJaobxgYpnaWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbZBqRvgTuzJRDPjjQ2H6X5z9IunHRAEpXnVrl/4TPo8uq3daJPwvTk338CivYDys6p6Ya+ZTKafx4dpWIfdKkrgWfxIy//inrY2G0ZgZQaoXUKclgRYmaeRYPTs0nsv7a/+JZAFoLO/O0f4oWv9FWTCM3vvjTk/Vd4pQ0PKMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Z5lglw4m; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750414761; x=1750673961;
	bh=E2RzGGnLrRmWTIINDK1nhrzJ/uJ9A/gtHfwx8PmQsNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Z5lglw4mVmJ0j111y3coVt43PwN309ab8v1KUfp39Kd2ikPuBaoYKydJ6r60tisYN
	 mtxX9in0Z/b1f2ijvNiS/P5CUXPKSTlvUIT54jYtZtr1hP2RqGp5ggtDjhCCsZNqNf
	 iQtKlVWPZRC+O8PQrQBHqgpy0E11nkswA/gq2yZYb1wukV8SE86BlFcceebKu+MkDZ
	 J27bQz6C5aPJtxIOLl1genfpBm1GOD4z7ocOwnA57vq9XEGXfQsIC+IFCUFQnNmGXF
	 0zctwO8AxLxZLBCEvQDoGNAMBTfqSlhw26b53T6DmRjd/J5QEZN7t+9j9LBxjh0sFS
	 GnsqF4p+ftnEQ==
X-Pm-Submission-Id: 4bNtkD2l0PzB4l
From: Sean Nyekjaer <sean@geanix.com>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Fri, 20 Jun 2025 12:19:03 +0200
Message-ID: <20250620101904.10740-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025062052-quadrant-bagging-7786@gregkh>
References: <2025062052-quadrant-bagging-7786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 16038474e3a0263572f36326ef85057aaf341814)
---
 drivers/iio/accel/fxls8962af-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 8bc516a57e35..d9f5ec3b6eec 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -435,8 +436,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -735,6 +744,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
-- 
2.49.0


