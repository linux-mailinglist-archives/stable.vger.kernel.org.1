Return-Path: <stable+bounces-177927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F217B46875
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3C5567BA4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D607483;
	Sat,  6 Sep 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsMeyA6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939B25761
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125844; cv=none; b=LHP3cZuvNxbEiIxk75GSefydROXEROPV2RDV7wGzFb9T//0KKY11Nz1Ubpex3AHffjqh0jQi/QJldNRgKXkYWl5q/3fmM12JxPUekQqC8y6bIgI1xKmU51VVFQN0JQPy5dy+6oIwBR47T0doYLK4jn/+mRJGmIU00QRhJ37hJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125844; c=relaxed/simple;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHXvVQ9vfDtUNkwChkpvCrSCqF7eSdh6etQ0sqGd9rJGJ+QQF9Vc9MSP+BtbgxgIO85wlKxReHzN5T/arJZMdW/8DOZAe6d4iJktBKUYPOvtMr0QL8RwfdZxWrVUTEQUBWkKfbYaSdb/pmPNDRUQQElTv9zH7dDq8RGbztCCBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsMeyA6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B620C4CEF1;
	Sat,  6 Sep 2025 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757125843;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsMeyA6HxvVetRVkbH8CMQh8peaAPM3AAbrnm4eTg9EFOd1QMdDIjlo6Z2knybsnm
	 WwRJggwBOxwHQeFcHtpG7S11kDIgYiB+MWDTiggYKpNv/8kCXo2kzwBPl97yy8OxH5
	 hSz2fNiIx2PXjGuHxsckJfAPqHK+rkwza4a+R5C/vQrI0JkMc45zkEKb9TLuldzaH7
	 sq1eI7m1h3EgTdAB1LabBpM0+qs3Ou5fmZu6880Xdhr1DW7VCeYLYCnu9YiwSpMINn
	 eLSWnG5w5yjYgc8pf1+/EA7KsWtkkU7W3TPj9egkGv2JJ5ugdXQnPpCa7X1yGM2X10
	 8f7YjwikKj/0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 22:30:41 -0400
Message-ID: <20250906023041.3672164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051249-syrup-sectional-cd45@gregkh>
References: <2025051249-syrup-sectional-cd45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 6ffa698674053e82e811520642db2650d00d2c01 ]

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Also move the unaligned.h header while touching this since it was the
only one not in alphabetical order.

Fixes: 13e945631c2f ("iio:chemical:pms7003: Fix timestamp alignment and prevent data leak.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ linux/unaligned.h => asm/unaligned.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/pms7003.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9857d93b307e..70c92cbfc9f14 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <asm/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 
-- 
2.50.1


