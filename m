Return-Path: <stable+bounces-177931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F91B46893
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0157B5620
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855D22D7B0;
	Sat,  6 Sep 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG+BmQP+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715422A808
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128766; cv=none; b=kG7gDbYPWBt46ZNxUM1s/qadz450qsH4I7tiLlIY+m2NRiCUPiMw4uaNNWE5oUmN0ReWG65g5qUeQOBnoIu+RbqqRXtLhHVKViQxUlO6goZg70QKm7PxsgLnGM03pRmOtkxk6lsQxjPjhHC5wszeI2dgdWkZuQgwuWpenE8NKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128766; c=relaxed/simple;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdyE3Fjk4X/532wkXZrmOPclcycRWl1rz2OwRoLC4vAmpYeqXnFB6FrY/dGp+hH5tnnWAO0qPCY2G2FMEND25mkbMNxjyuYcIQzJzms7clVBr5ZHoxouclEWcbXOx0rRSwWwzv+lI6PxWxkLJoY8H4hKPOUhzpXLyW2s/l5HPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG+BmQP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6149DC4CEF1;
	Sat,  6 Sep 2025 03:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757128766;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PG+BmQP+7hh9sGLFvoMtF6sWsptTxlwTY3f5p6nZ8gRoe0tyYP9he+8gJUrADrFe2
	 9sbNUKG0Gc7asWu3xxIH4tHpjzRmy1TB22OZXpAeeket+OadCqkKeLaZdFMm4YuwmU
	 FKPQOCGk21TlP5IkimGNStLIvpJ07cUg7rkMXuMGPKc9wIxEQp/b2ZTCws7285RPQW
	 AN7enHTc+bzlhrrhsHzSTJ64OgfiOn1jlZXOPh74Rb9TpFSOA9kfwg1U3n5FnHXXnG
	 3wis4P3k/XHoL5RD9tLEdbKgTYtboSKEqxWIwuq6ogxDL4SRbiq5SZuGObTAQ7mFec
	 R2PNOsMfynnzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 23:19:23 -0400
Message-ID: <20250906031923.3688416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051250-grimace-harpist-f05e@gregkh>
References: <2025051250-grimace-harpist-f05e@gregkh>
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


