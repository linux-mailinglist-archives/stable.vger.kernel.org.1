Return-Path: <stable+bounces-177941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0FB468BB
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 06:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999A83A3393
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21824DCE5;
	Sat,  6 Sep 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFTNRkXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A021FF1A1
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131199; cv=none; b=JWgZWcqveUfo09vXGJpPGG7cWXyRETyTl5zr0Mi96C+PkGgDTuU3xVo/j/aKUuZ/egvmq5uQSuwqbUL7PwWzR7aAntR/Tq78zKnGWYsCOYKIfLTOI/EzyLnJ3Z0PAuJVe3tkNEGEw16QwS8WEL00EArZIuPeSVkZqBiKTzJglpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131199; c=relaxed/simple;
	bh=WT4S6ftIDjy3/ijtF6P1N94neMS2xFPGmIfG1BY2/P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIxuqE6OYXjJl6dfsrUDWJ2vieM7mFVK2uodyti2bs+KIoqYjL23lbm3/8TYlKj2DImIC/mDBAyQ06vN50+J1YfGJW3m0OiKYLGjBJpDc1MrleoPnb2iMEBXYtamzy7NDxef43pkCuV9MA5P02chiWqhoeEH6JeACPgpX3p0Zq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFTNRkXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A674FC4CEE7;
	Sat,  6 Sep 2025 03:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757131199;
	bh=WT4S6ftIDjy3/ijtF6P1N94neMS2xFPGmIfG1BY2/P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFTNRkXtMlJO1s0X51o1Te/CrQqHQ+6NBqucJIEusIXK5il1xymm3ILARSxG6DL2B
	 +W8x7VSgzQpaLlvo36WGkjKxoLmMTNjesJsRJ2rsvgmtD4G2tuZdS65K9Woc3/ZURy
	 5bMZ+RjpdlWwb5vXmEfoAMClq9jTji1BvJlROaNH2FLjTEHWio9O5qbQyXfCogJagM
	 VhU5UmWk3Cc/oB6V+y1veMfCOHkmnIzngQTnURIy1GnlEm6MNlcXCVyz2doss1mgVc
	 lNcE8XWxwGolxz/c0jRbXdlXyM2rPzr3qTIz3vz7hqO5uCG/Y9sbvIyjC0KTnIJfre
	 9sXwnQRL/CK7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 23:59:56 -0400
Message-ID: <20250906035956.3697140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051250-boned-reference-363b@gregkh>
References: <2025051250-boned-reference-363b@gregkh>
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
index e9d4405654bce..a93e0ad41767a 100644
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


