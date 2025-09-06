Return-Path: <stable+bounces-177920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B0B46804
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EB21BC7370
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D774A55;
	Sat,  6 Sep 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBaDhCGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FD188000
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122431; cv=none; b=N2o9v0X86ypefKniChZl2bvmn5FqU+iYEpQcq7HHYjyAyzvFyD/WDDeF50BnctYCtFTGnOC82tTj4yau9Oe1Fc/7LLC2+v9pkn7crJTJu2i/2upjX+74Bp3FddW9Zh3jtX8fGTuyYtmNMUQxUpkmh7zI5qLM2yyiGIu6WI9ZPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122431; c=relaxed/simple;
	bh=sUQhfdkRfdkv8bI2QS0L/p+J0drOikhktbq/BFYqAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv1U/6sMNce4vkq+JvB31m2UIVwAYBOER03ROG7YxifsMfkHizfVfB4HEmSrnwUaIJF5xifMGCyxNxmNdo707IcsVevAm81ghS6L/h3HVHAEtsdRyLoKX7yGUBCnnwp1f/0ElCcHtYZS8NA0eH2shLglkK5DE+aTh91eHRTQFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBaDhCGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C26C4CEF1;
	Sat,  6 Sep 2025 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757122430;
	bh=sUQhfdkRfdkv8bI2QS0L/p+J0drOikhktbq/BFYqAeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBaDhCGvHOFEC2m6OXvOV98brLfbhXSXHSHqY0swnxjP0xrsu4/cgSmKi9mJY6d3m
	 ga1J0zDrZpy+ihG2KEKgC+Q6pP5N9Vmb+GTHeFB4XTHOz7e/wQ/cMQOe1QjCOwn2PX
	 yBorvFjpvSG99DJuwUDAOPu9YF2Z1vbLvyEpXIoz56+E/hlXnMFf2FoJ0j6i4EREfN
	 Np2nDbxhLqO6xgJ4bxiR6QgJjDMAKX7mkp0ke5/zCzKOi5ya8TJwC4s2GzXE4sCjx7
	 L5b/menvDgg5NT5jGAxkq16d8zCFV6O4v/+N/5ZoJsJ1jFe+rzbQk+DOnkItJh7rpC
	 nVkJik8uAPHbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: pressure: mprls0025pa: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 21:33:47 -0400
Message-ID: <20250906013347.3653180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051224-transpire-bleach-c69f@gregkh>
References: <2025051224-transpire-bleach-c69f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit ffcd19e9f4cca0c8f9e23e88f968711acefbb37b ]

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure the struct itself it also 8-byte aligned.

While touching this, convert struct mpr_chan to an anonymous struct
to consolidate the code a bit to make it easier for future readers.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250418-iio-more-timestamp-alignment-v2-2-d6a5d2b1c9fe@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Applied changes to mprls0025pa.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mprls0025pa.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index e3f0de020a40c..829c472812e49 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -87,11 +87,6 @@ static const struct mpr_func_spec mpr_func_spec[] = {
 	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
 };
 
-struct mpr_chan {
-	s32			pres;		/* pressure value */
-	s64			ts;		/* timestamp */
-};
-
 struct mpr_data {
 	struct i2c_client	*client;
 	struct mutex		lock;		/*
@@ -120,7 +115,10 @@ struct mpr_data {
 						 * loop until data is ready
 						 */
 	struct completion	completion;	/* handshake from irq to read */
-	struct mpr_chan		chan;		/*
+	struct {
+		s32 pres;			/* pressure value */
+		aligned_s64 ts;			/* timestamp */
+	} chan;				/*
 						 * channel values for buffered
 						 * mode
 						 */
-- 
2.50.1


