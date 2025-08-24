Return-Path: <stable+bounces-172681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E130B32CDA
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B9B7A52CC
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFBB13D503;
	Sun, 24 Aug 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZiGRkQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61933E7
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998975; cv=none; b=rEor5O8SbmYy+NYfOYzKhVwtq+zqCsTMhl2Nss39LoDYWnn2rObJHwjd26/VxxyFW3pvjrzv5TWZjOhQLaen5e0l25v1T7z2xaeACa3uAJ9mywc9qw6q8YB4t/zjNgKViNy2O2j3rnfiCSeIoGyvSQDdjCFHHad6A2JAs+34iL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998975; c=relaxed/simple;
	bh=HHwfW3lW2emlZpo/Z+3QokN7Yhkcptjl9X0cxvzmL28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5wqVUTV21aQ0zRiXx1hMFOVRSjWh2J/Lafgp19/XSdJsx9fYgYNyZAAVhfLKx3iknyF+kerkND34AvBHvaXLdWMDpFpZTe+D8zUViMQSPQLK8ZMdzawqv3qNR3TQMg5Bw/xwn5o88SOQi7BUUqJcG1mDdsClP92+mOXter3520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZiGRkQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7DFC4CEE7;
	Sun, 24 Aug 2025 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755998974;
	bh=HHwfW3lW2emlZpo/Z+3QokN7Yhkcptjl9X0cxvzmL28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZiGRkQ5uhMkIi2KohLy/8kIFbOTw6ldHUEbkfWW5ZJomnjWJeCVBu3o5+r8Osed1
	 cT04yIVUtkeCmwrX3xsfPwPxd5+9okkoiumErx2xcCE8yoGzRTAcScqrxb8UwpEhsU
	 XGVpKxcbmg5bD/NhJJXtaHQ5DAiOrmx+aeJDFegkfMDFI51RYQZ1jcnWXp3YPdPveI
	 eNEy5s/on/8ITrM0DmRpiKalZySMuHyoHK56FHV2n/Su50Nnk1jOp5fEipKUsMvBJa
	 A8VY2XujhPCHs1KGO5RGYoSs6SCNiWz1XiVbj5OIaKPzJK76930nPHsTmIc3UsHiRr
	 vgFYLixYKu4+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: light: Use aligned_s64 instead of open coding alignment.
Date: Sat, 23 Aug 2025 21:29:31 -0400
Message-ID: <20250824012932.2578686-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082316-antennae-resurrect-e01a@gregkh>
References: <2025082316-antennae-resurrect-e01a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit a801016da0bbb955acf1a551584790e3816bb4db ]

Use this new type to both slightly simplify the code and avoid
confusing static analysis tools. Mostly this series is about consistency
to avoid this code pattern getting copied into more drivers.

Acked-By: Matti Vaittinen <mazziesaccount@gmail.com> #For bu27034, rpr0521
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20241215182912.481706-9-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 433b99e92294 ("iio: light: as73211: Ensure buffer holes are zeroed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/adjd_s311.c    | 2 +-
 drivers/iio/light/as73211.c      | 2 +-
 drivers/iio/light/bh1745.c       | 2 +-
 drivers/iio/light/isl29125.c     | 2 +-
 drivers/iio/light/ltr501.c       | 2 +-
 drivers/iio/light/max44000.c     | 2 +-
 drivers/iio/light/rohm-bu27034.c | 2 +-
 drivers/iio/light/rpr0521.c      | 2 +-
 drivers/iio/light/st_uvis25.h    | 2 +-
 drivers/iio/light/tcs3414.c      | 2 +-
 drivers/iio/light/tcs3472.c      | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c1b43053fbc7..cf96e3dd8bc6 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -56,7 +56,7 @@ struct adjd_s311_data {
 	struct i2c_client *client;
 	struct {
 		s16 chans[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 11fbdcdd26d6..37fffce35dd1 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -642,7 +642,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct as73211_data *data = iio_priv(indio_dev);
 	struct {
 		__le16 chan[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int data_result, ret;
 
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index a025e279df07..617d098d202a 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -743,7 +743,7 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	struct bh1745_data *data = iio_priv(indio_dev);
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u16 value;
 	int ret;
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b176bf4c884b..326dc39e7929 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -54,7 +54,7 @@ struct isl29125_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 640a5d3aa2c6..8c0b616815b2 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1285,7 +1285,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 	struct ltr501_data *data = iio_priv(indio_dev);
 	struct {
 		u16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	__le16 als_buf[2];
 	u8 mask = 0;
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index b935976871a6..e8b767680133 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -78,7 +78,7 @@ struct max44000_data {
 	/* Ensure naturally aligned timestamp */
 	struct {
 		u16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index 76711c3cdf7c..29da3313addb 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -205,7 +205,7 @@ struct bu27034_data {
 	struct {
 		u32 mlux;
 		__le16 channels[BU27034_NUM_HW_DATA_CHANS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 78c08e0bd077..0a5408c12cc0 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -203,7 +203,7 @@ struct rpr0521_data {
 	struct {
 		__le16 channels[3];
 		u8 garbage;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 283086887caf..1f93e3dc45c2 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -30,7 +30,7 @@ struct st_uvis25_hw {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u8 chan;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 4fecdf10aeb1..884e43e4cda4 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -56,7 +56,7 @@ struct tcs3414_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 04452b4664f3..afc90b5bb0ec 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -67,7 +67,7 @@ struct tcs3472_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
-- 
2.50.1


