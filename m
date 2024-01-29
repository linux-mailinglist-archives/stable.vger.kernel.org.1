Return-Path: <stable+bounces-16970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3411840F46
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AB1B2543C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A715957F;
	Mon, 29 Jan 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgSeM1br"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618215D5D2;
	Mon, 29 Jan 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548414; cv=none; b=jqk+f4kdybjyPks9mnQeHc+3DsduJh157JoWk2RDZgYaGVSR/KIW1itTx2Ry1PJCJMnNgw7nU5Y5si/2qaGh6u6QGr2P2kzTvNlRibx0PxA1gW5Qw1rloGcagoqhZd6V3oQIbtGuAIz3PBvwR0VmvYM/EF347l6YMlFg7cjUKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548414; c=relaxed/simple;
	bh=qZI3f66A4PiP6kCLvXe1VxdCDYQBvM0T/oSpDHRtwqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX2ooWTEaQs/8lTJ0JvGH0EXhbfgcJoK4rLryeMIyvQNKyeiAws3w8bd5l48CcRZjY/ip+dX78HSekn1QxgaJOpAZ7lCwwt3I0Ay/n6b7n2SrGvOoHCcCm27yaoG9w9SDoi8LC1THxsvbQs3emdRc5YE5QgapWcVdTfmkPp7SBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgSeM1br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5EDC433A6;
	Mon, 29 Jan 2024 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548413;
	bh=qZI3f66A4PiP6kCLvXe1VxdCDYQBvM0T/oSpDHRtwqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgSeM1brZKB1lGxM3SurxVsb2zv16CcxlPsBcvHhyAdcKWrzAmGYCZGUwvGJ7/mdt
	 /2eUoR3dCg+UtxP2lq3uZ5FjDI/+iFkc6sa+aYPSmMkEwl+G0nZwvM7TSphiVOckdK
	 40DaB735HqjOA9+fcy9KNKokkR2sLu65zNlizp5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/331] iio: adc: ad7091r: Set alert bit in config register
Date: Mon, 29 Jan 2024 09:01:14 -0800
Message-ID: <20240129170015.265607549@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

[ Upstream commit 149694f5e79b0c7a36ceb76e7c0d590db8f151c1 ]

The ad7091r-base driver sets up an interrupt handler for firing events
when inputs are either above or below a certain threshold.
However, for the interrupt signal to come from the device it must be
configured to enable the ALERT/BUSY/GPO pin to be used as ALERT, which
was not being done until now.
Enable interrupt signals on the ALERT/BUSY/GPO pin by setting the proper
bit in the configuration register.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Link: https://lore.kernel.org/r/e8da2ee98d6df88318b14baf3dc9630e20218418.1702746240.git.marcelo.schmitt1@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 020e71c7ffc2 ("iio: adc: ad7091r: Allow users to configure device events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7091r-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 0e5d3d2e9c98..8aaa854f816f 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -28,6 +28,7 @@
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
 #define AD7091R_REG_CONF_AUTO   BIT(8)
 #define AD7091R_REG_CONF_CMD    BIT(10)
 
@@ -232,6 +233,11 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
+		if (ret)
+			return ret;
+
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
-- 
2.43.0




