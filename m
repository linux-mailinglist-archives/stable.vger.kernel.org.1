Return-Path: <stable+bounces-177929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF63B46888
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418075C47FE
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAD20469E;
	Sat,  6 Sep 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNqiqEtC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201A1F0E50
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757127645; cv=none; b=pjF+fJa9qCBkHQhZ7+WbQwLEkANPN+hwHrkrKf7B4otjn/4geFgC+/2OJpbdoHGmxBMQJ+Xdtc6PmqZBjTRr4BlxoAig19SjUARU4ujC8H0J8rDq95TaEpzMXXCsa0X0zEVzVlFeiZ9cqJc3yfFzgyzBltpluHBbDZ0HVlx4sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757127645; c=relaxed/simple;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN9kXdBFtimF6331cNMMoZUTyWfYFAaBP7pxJ2KsLaY7benELMgV5BChOMgetI6ddnbt+CFvT2BvQ0QM+oGdCW8bbgj1h8ja99AxPBJF1n80YHdSu6+dsP7WhOUST0dIvjzCSTsBXePPwoVB/FyVxBJVt/7M6Ln+JtGtrO7Qkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNqiqEtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6B6C4CEF1;
	Sat,  6 Sep 2025 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757127644;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNqiqEtCaTG3Gcbb/P8zI4+zK7R8ni5e7Y/HhfZu1FmWXRsGnitOs46sx1B4MtMwJ
	 68UWuSwmtcmOBSUf3yDPZ21VWiaIH9DhFyvNvs8Qi18b+WfF5B2CfUXVK0tIC6DisB
	 n1x+8Q/cV/0/IIgTrs7TwQvnYnvY9o8KSml+jXz1ZWduch/u8fzRlrCpyk4cgm3/th
	 uygq3oWEyKzaeTkDOrCyl2dFosU45kO/i0dqvsqw8Pa7FGrKefbPnSHC5TOrIHPTYU
	 yjiKdOAOHRQ9MutkLWFFP1YjF+r0lY8BC+W3u/ZsvXThZQrL/wifkG6GvQhxRjvij1
	 N1GlSyIkTJCcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 23:00:42 -0400
Message-ID: <20250906030042.3682560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051241-pushing-regain-cfd8@gregkh>
References: <2025051241-pushing-regain-cfd8@gregkh>
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


