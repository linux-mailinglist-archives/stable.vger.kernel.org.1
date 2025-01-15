Return-Path: <stable+bounces-109100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B1A121D2
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA595188C397
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA71E98E7;
	Wed, 15 Jan 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYsyK6JR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64609248BAF;
	Wed, 15 Jan 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938851; cv=none; b=hFkM9KAi9TDuobdyK6wTLgvoXnbjIbiZdlhSiBZCHMffVSXwkfzNv/59nTEcR9O0/iHzqNzaa2W9WLAdKl2C495JTbqAopurOl66PALeGZyndYhZ6LRggDdrCM93BQRICG2IDN3fm9xnicJRjJALSzjTqQ46ldrSX6YfaP6Z0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938851; c=relaxed/simple;
	bh=fZ8tx/ztFBG+o/yVgFSE+HWaJr/RWnvZ565IaMqYHQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbTyHw2dzAJ1sdcrcxWDzUoWucpRSsI2mPHaHVG02CUDs4MXnj2+x2x0WEfSYkEGdgkLwsqxdY/+EanWt0yhJQquwXVY6oud+vnWSB1Wi/xPeK6Fv2S6yjMkiaflpWzxWwDNN1uHtCDib5wP+RqnBjj15HIZhlkELLYFKf20oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYsyK6JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB17C4CEDF;
	Wed, 15 Jan 2025 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938851;
	bh=fZ8tx/ztFBG+o/yVgFSE+HWaJr/RWnvZ565IaMqYHQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYsyK6JRX4WSL6dClqmfX7xVtKbde1Jl7T5zDXM2M2zJ7OG/QBHLFWKEGyrfNaWnr
	 49YFzmtBtltPLr63EjwFQrNZatUwODDVxElcB/6q4KkUNUbVGXDAycBNu+emn2yZ8P
	 bEdSTSPDAYDCD5u5xaf1/6axUSDL7Vx5FxZkpe9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 109/129] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Date: Wed, 15 Jan 2025 11:38:04 +0100
Message-ID: <20250115103558.695850852@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@gmail.com>

commit 2a8e34096ec70d73ebb6d9920688ea312700cbd9 upstream.

Using gpiod_set_value() to control the reset GPIO causes some verbose
warnings during boot when the reset GPIO is controlled by an I2C IO
expander.

As the caller can sleep, use the gpiod_set_value_cansleep() variant to
fix the issue.

Tested on a custom i.MX93 board with a ADS124S08 ADC.

Cc: stable@kernel.org
Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Link: https://patch.msgid.link/20241122164308.390340-1-festevam@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-ads124s08.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev
 	struct ads124s_private *priv = iio_priv(indio_dev);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value(priv->reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		udelay(200);
-		gpiod_set_value(priv->reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
 	}



