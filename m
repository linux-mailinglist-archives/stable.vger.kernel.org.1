Return-Path: <stable+bounces-175378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CEB367C8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B488B56736C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED634AAFE;
	Tue, 26 Aug 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qHFkKvpJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA972BEC45;
	Tue, 26 Aug 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216880; cv=none; b=Qmap5DRtPzC+oKPSZQ7pnSQbCXKuNR6/UOrLU6jPZ5JoR+qdd7X1uLRfwTAJfTZicAEaLWzFe24hIg9odRx6dVviUVmh40abNKjS25KN5rprVPrrqxiDGRj1KA1JvHE1OBAT7ntaNzO/+YyOJQmoljdCul4FzSZJ5MVToSCej7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216880; c=relaxed/simple;
	bh=/DcYSMq6YL6MHnJaNMAQBPvxRag3WKza2HOZqJiS6r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE1F/VQv4dga5ygUwRuJkZ93H7dPzUrUV4epQm/cGf5a5x2djP4xp2tPJmJhTP6r6BguhmZ5TuPRJx+R+Ep7NdeflY+3CcdN2IMvkgRjAcaRHqJefTKYMpd4fPwEq1SgxnZc8cXqoH1BoaYrZkd25PqLPpxg3U0uScFURpgcD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qHFkKvpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F263FC4CEF1;
	Tue, 26 Aug 2025 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216880;
	bh=/DcYSMq6YL6MHnJaNMAQBPvxRag3WKza2HOZqJiS6r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHFkKvpJAQCAvE3gfA4y62AlQgmbLhUiIC/UWU+srzpFEBDWEYXFEsbbmParXkHGC
	 vsAwk3Oc67JdRCWXUMf4JFr4N/UBn8U6iyY68ez/Au8Rh9nTPzh4I49og5mYulcnia
	 mN9ylSsngzvLaqSF/5F1gYF2LwfmdebcwEErFjlc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salah Triki <salah.triki@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 578/644] iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
Date: Tue, 26 Aug 2025 13:11:09 +0200
Message-ID: <20250826111000.854874971@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salah Triki <salah.triki@gmail.com>

commit 43c0f6456f801181a80b73d95def0e0fd134e1cc upstream.

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR()` and propagate the error if
necessary.

Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optional")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250818092740.545379-2-salah.triki@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/bmp280-core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1064,11 +1064,12 @@ int bmp280_common_probe(struct device *d
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);



