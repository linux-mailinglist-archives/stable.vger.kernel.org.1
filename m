Return-Path: <stable+bounces-177919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF7B46803
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7220AA5899
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A296185B67;
	Sat,  6 Sep 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC8Peltj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E63A55
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122428; cv=none; b=if25908GsMK7fcEjGgFcgjL4oiHX5l4ReeZD9+KkotDTcddWGFDEAFz2geCdfIcDVuap09f7i5c/YGP4TyYJjt2CaD1SkUF4HoUZlfY8L2X870O8zj4lT8ZSf/GlggYHCL/Pz1kctKvU6RkarDMPo2358RK1NCrmXI5vnPyV78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122428; c=relaxed/simple;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHjI+aV692AP5m+AJ1sCq6Y2//LM10brej3UbiHFc3PgC2lH3qXx1emDRYpAmfCSOXeJPZGjhYcfuz92XUg2BDfhcy4Cp7ZxWY7lQFJHvqmpydTucKNeSQGmPObvJcBpe4HR4tX/sX36V+bGcJdX9wC/W/z5Ew/SObH5PiIlOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC8Peltj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A3C4CEF1;
	Sat,  6 Sep 2025 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757122427;
	bh=Te4DoQh5rcFb9bYtob4gecQvEG8M1fu3ya4+VFyzrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GC8PeltjqHm6Qa7Op2+mx2DuiCk5nb+qtm2q/uk8e5oKuaCZGC1Arh8FTOzfPk/LP
	 +8j7wmiDnmg41rPH3P3u8DRQMGR1RJELzi9WLdZySI8jiEOtKiCm9HA5kScFG3hyH5
	 gUgNg/3Xwt6yUadPHurvdH9OnFr+UvICh8b7XlZaehZGkPvlE+zWStHidm1OWJnexz
	 nR0taR00GD7cUUhiTis+JAg8xR15p8q9K3My+0OOG23NuvfWLnP4RspdkKd4oyE3i8
	 VTabBlxxKm4DlOccKcX9HYx1m5Y6BkwKp55aOzQCY2FnS7PJgoz/zq05U4xDN1DNvB
	 DxCQzoanKB+Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: chemical: pms7003: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 21:33:44 -0400
Message-ID: <20250906013344.3653014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051249-bootleg-devious-fe49@gregkh>
References: <2025051249-bootleg-devious-fe49@gregkh>
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


