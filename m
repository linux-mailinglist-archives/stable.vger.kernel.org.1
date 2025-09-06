Return-Path: <stable+bounces-177947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5AFB46D79
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9554C567550
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68D2836A0;
	Sat,  6 Sep 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx1irAWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993126F2AF
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163767; cv=none; b=XuRLMtAcTvjz8Bx0Bb98iX1QFA07yGtdc6Ygq88/q02/9fxg38e6wvSZizvZ7NkIuWB0Qwnma9+uJChIoDAPiQz7lQBLRD1kOLMGhrRgoRhOQNEr2YYRHRuH+9Iy1skiBs3V0+O2UnzAZT4E0kIKK/RhD0eDd9dQGqSX9ts0BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163767; c=relaxed/simple;
	bh=AbcTyj+WFawahVQ96hEab0mNPMlApvNvAOj7278JG14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuNIgqqLt/YhvORXzvllTa6uJ7I7VCM9jcvR27MafoY+0b844ZbCkq/Kl82r8LSnJhU3TZ/d1w4ZQEjBaUXSlGspqtcZ6GWGZ4Q0vv2XBOc59PtUwna8uQ2Ncjm/l+NWlGzWHSljHF1aMy8LU93XhQkq+m8N8BixKQINPSe96Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx1irAWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D488DC4CEE7;
	Sat,  6 Sep 2025 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757163766;
	bh=AbcTyj+WFawahVQ96hEab0mNPMlApvNvAOj7278JG14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx1irAWzSe7A0AIqLzjMaFOYe89Jgm1w3AdkSZINcNl3uk6Kafedxh55aro7GxpI+
	 xsg/605AN4OICOdQdtbrxBIGRSs3bXaYTi3K9US2Z3+KqsVOJxAxvrzO2JxeWjcwep
	 KlyRv3ltx9hq8gjpHUu5CpcfUP0KCDTTackCtUEjhXY8j1e9+9ZR1TPa5J4qbPEgA8
	 HElpBKIE935kdJAKuCdoxjRa4morCWsKxbuYaFqxGHaoL/HnGbuyeQLeIiPjk/YfnG
	 pXxgeCZW+/ugvtZFHT4KRs377sfyK3s+VEZMVpF3aqiiFGX5zF4ZxG7hh5jc6lGOQw
	 IgMXrZOhmQkJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Sat,  6 Sep 2025 09:02:44 -0400
Message-ID: <20250906130244.3876234-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051251-devalue-matchbook-7c38@gregkh>
References: <2025051251-devalue-matchbook-7c38@gregkh>
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
index 07bb90d724349..28521da567552 100644
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


