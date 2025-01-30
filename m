Return-Path: <stable+bounces-111528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84418A22FB1
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1134D7A411A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8A1E9906;
	Thu, 30 Jan 2025 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GU3h9tbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA31E9B05;
	Thu, 30 Jan 2025 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246998; cv=none; b=g91j0yqyp+cVxfaxTrPd3rx9pTShB0MkvLZhSOOZ9ZAVw5boQ80JuxVAukR/nG/Hf+bZlnD969sF7NDPNBS5CssFqMxlVPsPTxLhedgo1vbfhceUcfE+3TMs2auWLt4xr+v5yi0mQcuVJnLUglLrVFKlccrCrzlBGiZFkX8wM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246998; c=relaxed/simple;
	bh=BH2Rd6Jr/MWWriybKIkoCPMfoxrEa5xSqOtXsb0b+DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfe4fukbXs40+OdIf2ONlr2+lrhOEz6CNaHfO2OcaaF9xaQ2rsS1mqtRiCdks9ist4Rz2tuTDBObBf9SMA3Z49xuY1ucwWYihJyDxBI6Ffq3Sh6pZONu1W/9SlnnHwvDxKaZvab4pwocDR2lpnNmYcNWvalJGSsORY/Q8mgBOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GU3h9tbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5A7C4CED2;
	Thu, 30 Jan 2025 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246998;
	bh=BH2Rd6Jr/MWWriybKIkoCPMfoxrEa5xSqOtXsb0b+DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU3h9tbLhelI5fo4O/Y/NpvpcrzB06du1bNNc9+e9oBaGyooc5x+hlUBCvXH42lDr
	 irFcE8XG2/IBpch0LLWMbdLcYMZ1CD3f2JQ9eEhEEDXUSx/z/moWucwJpEWoCC6XeZ
	 YFtDB5qSPnZRee9PHtnyg/gF0U5nd/D7pnK8+fhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 048/133] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Date: Thu, 30 Jan 2025 15:00:37 +0100
Message-ID: <20250130140144.456644620@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -184,9 +184,9 @@ static int ads124s_reset(struct iio_dev
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



