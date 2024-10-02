Return-Path: <stable+bounces-79780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47798DA2B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFECC1C2314B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD21D172F;
	Wed,  2 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0b/q51W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209161D1729;
	Wed,  2 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878444; cv=none; b=nM3j7Nm2CqE6lEEsfiihrLbZxKgNqIRbMCCwukhfoFN9L3h0s6nu/i2hocR0cvFMFFjF3iqHLQL14Qh3iEUwWjq/ST0sdEuMhSSH7Sf695EzNvVbb2jYr3nzzr/DldeqCtNCrkZenWuQc8xmk3c0KLvQZ0IBqX4eaBZxXVdfHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878444; c=relaxed/simple;
	bh=6tb26KfJLC+RbdzCZ82NrczCwAzXICyTotqx+7cqy3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB9t8Lj20fEr3TQ3jvEk0TVCOH+buQp6ql31UD45oMaqIOEkdaiZFagUNXYrDmI9CKP2iRHbx0ofwrZLOLb9T8jWZZnGlgRn4ceq+eQGkuaRA1mWbzXIjeFT1juRkS5XIrufsfNhFs9GYwWU+qQgXEqiHAhdZL1QKNLjosE9CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P0b/q51W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D1C4CEC2;
	Wed,  2 Oct 2024 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878444;
	bh=6tb26KfJLC+RbdzCZ82NrczCwAzXICyTotqx+7cqy3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0b/q51WZSY5RnA0DykTUzQqb7h0ishuHLrA6u2tdFD7/dmb0JrmQvlNhukL6lDZZ
	 uOmyL6WLiSI0Mvc+QILFJYwbqtqdprYc0tTsoGME7G5y4WRkVDIA4C0iyJTQY8AhLu
	 +yXxgPnS9H7saXIi4F9GD/+iI6QUH6M8TshZSZzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Stols <gstols@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 416/634] iio: adc: ad7606: fix standby gpio state to match the documentation
Date: Wed,  2 Oct 2024 14:58:36 +0200
Message-ID: <20241002125827.525723379@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Stols <gstols@baylibre.com>

[ Upstream commit 059fe4f8bbdf5cad212e1aeeb3e8968c80b9ff3b ]

The binding's documentation specifies that "As the line is active low, it
should be marked GPIO_ACTIVE_LOW". However, in the driver, it was handled
the opposite way. This commit sets the driver's behaviour in sync with the
documentation

Fixes: 722407a4e8c0 ("staging:iio:ad7606: Use GPIO descriptor API")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 8c66b1e364014..4d755ffc3f414 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -422,7 +422,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return PTR_ERR(st->gpio_range);
 
 	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
@@ -665,7 +665,7 @@ static int ad7606_suspend(struct device *dev)
 
 	if (st->gpio_standby) {
 		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
+		gpiod_set_value(st->gpio_standby, 1);
 	}
 
 	return 0;
-- 
2.43.0




