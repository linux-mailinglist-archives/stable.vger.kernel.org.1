Return-Path: <stable+bounces-21525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0485C945
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58C01F229D2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489E151CDC;
	Tue, 20 Feb 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n72bKB+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0A14A4E6;
	Tue, 20 Feb 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464687; cv=none; b=YJVsdGQ1VxYuDksvr16v5XB1h7NkuQd+om3Nt6qLgXOIqUuK5H/38dqe8f6J1Hs9IXpWJJW50F7E9RQl1LhkkpaPxc41GCpUdaDuQmT3l7V7j63ODcLjwRdVjVruzoPEWiLNqufUclpKaNg/LP25URMJytr3kOkX/Wc5Xec4oaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464687; c=relaxed/simple;
	bh=vzaykpN1cIHOHMtspXHqTR69JlqTzf3I79gBrgHs6sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pj0kH0fY7FVdOE2fSva4RcG8+wAVU1lEW17wijyShyx+c4XB4AnQKUBzwOVcXC491MY2Rq57+rVH3Uvk/5vlUKva6GEGBnk52Pp+sR7BJln2uEM8JxdkrSW5MSvRVqNVBQ9GONmyHoGWOoUq+u8iZ1Wh7F+F5jIBda8vbJx2NZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n72bKB+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64651C433C7;
	Tue, 20 Feb 2024 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464686;
	bh=vzaykpN1cIHOHMtspXHqTR69JlqTzf3I79gBrgHs6sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n72bKB+dKdw1q/AcZyH/+PpnOJxUyc0ycluN7uYEZ7jPKgDycemUNdwYVp8KrUq+5
	 2hmS6KCVQF6/bAZt4XaKeqoJAeDNsXSuFFlSJtplUYz+CEyDUIj+mcOtdAimKf0M/e
	 EZF4Qpjx4adFZ5zMImKq613tGk8kFHZG6gqzBe24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 105/309] iio: adc: ad4130: only set GPIO_CTRL if pin is unused
Date: Tue, 20 Feb 2024 21:54:24 +0100
Message-ID: <20240220205636.478837571@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Tanislav <demonsingur@gmail.com>

[ Upstream commit 78367c32bebfe833cd30c855755d863a4ff3fdee ]

Currently, GPIO_CTRL bits are set even if the pins are used for
measurements.

GPIO_CTRL bits should only be set if the pin is not used for
other functionality.

Fix this by only setting the GPIO_CTRL bits if the pin has no
other function.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240207132007.253768-2-demonsingur@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4130.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 9daeac16499b..62490424b6ae 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1891,10 +1891,14 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	/*
-	 * Configure all GPIOs for output. If configured, the interrupt function
-	 * of P2 takes priority over the GPIO out function.
+	 * Configure unused GPIOs for output. If configured, the interrupt
+	 * function of P2 takes priority over the GPIO out function.
 	 */
-	val =  AD4130_IO_CONTROL_GPIO_CTRL_MASK;
+	val = 0;
+	for (i = 0; i < AD4130_MAX_GPIOS; i++)
+		if (st->pins_fn[i + AD4130_AIN2_P1] == AD4130_PIN_FN_NONE)
+			val |= FIELD_PREP(AD4130_IO_CONTROL_GPIO_CTRL_MASK, BIT(i));
+
 	val |= FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st->int_pin_sel);
 
 	ret = regmap_write(st->regmap, AD4130_IO_CONTROL_REG, val);
-- 
2.43.0




