Return-Path: <stable+bounces-177918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864BB467F8
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48A43ADE60
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C11632C8;
	Sat,  6 Sep 2025 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur0+MMRi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B13594A
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121871; cv=none; b=EnJn32FDVQ/fD+R3WrCFiaJu6D277l1V2+xZoItNfeCe27VsBFmnDWENxDNabeH/74SDBO86baBroAJK2o8oLAcIM4MvMtaFQXbBPKUTgwUy8wGf/W4sW5qO84Jpv65/PENiWo/06PRbN2Q6K3mMiJUuyvgkYlkDOgnbzKYGKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121871; c=relaxed/simple;
	bh=sUQhfdkRfdkv8bI2QS0L/p+J0drOikhktbq/BFYqAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrMeWItfDd0B3tHqrCGToCweyIFUTtVUtZ4FscSpWHOB2kCjvw9ZmqcSxXRgFQmvx3U4EsdxPm75WvF+T1ycvEc2rEThEEkgk/qvohjtU26XHJ87UTIOv1rF8RRj0uyoEy99JQGSEHV9DA4DDdugCOs+kTbAw8XXH8/KXKhp7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur0+MMRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0ACC4CEF1;
	Sat,  6 Sep 2025 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757121870;
	bh=sUQhfdkRfdkv8bI2QS0L/p+J0drOikhktbq/BFYqAeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ur0+MMRiqcovLZE9CeCXiueatf6AaU4mmlIDf3ZfAXb5GW2tQFUlaJAgU3IDdQF+a
	 KYkdftf8xOCCvAlLbfQmgBc44077KcqXTIWqb5d2WBB7g8krIPTDVD1jOjO8svwYT/
	 HTvHul1NC2NSvFo2sc12miDLfk1xIP8/0OCGon2aA8Ok21XbcBqk/qlwdoC0jX25FX
	 hJYCTr27X6Ux/Bv6augxb3OlnYRzMz3Nm8WER2dNl/Lt8rlh+SkT3zqew2jilUX+CQ
	 WXgEnyf5K2eY3fW460y/I7t5ESnMRld7YA71n5oMjX8Zv5nouyY9DdG5dl62y0kCDN
	 di+1JNclAn2rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: pressure: mprls0025pa: use aligned_s64 for timestamp
Date: Fri,  5 Sep 2025 21:24:27 -0400
Message-ID: <20250906012428.3649138-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051255-unsaved-flick-8fed@gregkh>
References: <2025051255-unsaved-flick-8fed@gregkh>
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


