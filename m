Return-Path: <stable+bounces-163415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D70B0AE85
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93934AA7180
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFCC22FF2D;
	Sat, 19 Jul 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8MEfkqr"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF05233737
	for <Stable@vger.kernel.org>; Sat, 19 Jul 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911966; cv=none; b=hLrCzukjqPdUf1hXQZCvs56WrgdUgHwzd30W7t52BGRqTcjE37u8SZe4YiuL9TAb6kZH45Y43maDpbta4Ly/ap43J58yDHEIVsQOsQf9p4qVqrhfYmbaan7gQkq713ucfDPXxbMKz1ZYf67tloCFHxY+xCQ2Rpt0VbaYGDF/JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911966; c=relaxed/simple;
	bh=eS4mZSW2cE8QahscSaH7lRS23Fxy815SdFG3RRQCEu0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=EzO0rc5fO78ve4U7VNZ90/zJRfMRupk5bpqzB+UigPNK6o9qxjOfgvlFyRFPG6zTIc2OFEKA60XVzonlSxm5m+5LA+ceMU+FRvcLDM7QG7mR2hKQyVj36tXLQoVyGXwJ5kyKBRkobS+o1miouv7R6LDaf56nt/Yykmo0XwoGB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8MEfkqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B023C4CEE3;
	Sat, 19 Jul 2025 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752911966;
	bh=eS4mZSW2cE8QahscSaH7lRS23Fxy815SdFG3RRQCEu0=;
	h=Subject:To:From:Date:From;
	b=h8MEfkqr3QqjHN6OeGWUyw21gn+194SJCgNcXIjzntsFaZW9dTBSRK/0S4IqRXOSE
	 NusIY8I0YBuaohgRRHo82n44IjcKTb5mPRyb5gOiVLVBbqGfrb6dTHzylILu/swHvH
	 foB8ea5yVCiyGzH1dKKHJ6/E2/hJn+uejpzvYIQw=
Subject: patch "iio: imu: bno055: fix OOB access of hw_xlate array" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,lkp@intel.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:49:31 +0200
Message-ID: <2025071931-starlet-unelected-aa81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: bno055: fix OOB access of hw_xlate array

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 399b883ec828e436f1a721bf8551b4da8727e65b Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 9 Jul 2025 21:20:00 -0500
Subject: iio: imu: bno055: fix OOB access of hw_xlate array

Fix a potential out-of-bounds array access of the hw_xlate array in
bno055.c.

In bno055_get_regmask(), hw_xlate was iterated over the length of the
vals array instead of the length of the hw_xlate array. In the case of
bno055_gyr_scale, the vals array is larger than the hw_xlate array,
so this could result in an out-of-bounds access. In practice, this
shouldn't happen though because a match should always be found which
breaks out of the for loop before it iterates beyond the end of the
hw_xlate array.

By adding a new hw_xlate_len field to the bno055_sysfs_attr, we can be
sure we are iterating over the correct length.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507100510.rGt1YOOx-lkp@intel.com/
Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250709-iio-const-data-19-v2-1-fb3fc9191251@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bno055/bno055.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 3f4c18dc3ee9..0eb5e1334e55 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -118,6 +118,7 @@ struct bno055_sysfs_attr {
 	int len;
 	int *fusion_vals;
 	int *hw_xlate;
+	int hw_xlate_len;
 	int type;
 };
 
@@ -170,20 +171,24 @@ static int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
+static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
 static struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
 	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.hw_xlate = bno055_gyr_scale_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
 static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
 static struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
 	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.hw_xlate = bno055_gyr_lpf_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
@@ -561,7 +566,7 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 
 	idx = (hwval & mask) >> shift;
 	if (attr->hw_xlate)
-		for (i = 0; i < attr->len; i++)
+		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;
-- 
2.50.1



