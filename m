Return-Path: <stable+bounces-62946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CF941661
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9282F1C230F2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191121BA883;
	Tue, 30 Jul 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5YLrBiB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BA1BC093;
	Tue, 30 Jul 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355153; cv=none; b=j0ghf57Q8BkgpSDH/JTDoy1KTJfEa/GVLzQxd9nk9lV6YjYns29btpJIfZzfEUk0U6woOkQWPBTqvJXoPfyt8JNDACBtTWPGhOpTSEt0KvKhAdSheujmuwjQvVH1eVxE7EHBa9SDUPD1bHEC1KcMlMnCgMCjJsXYcJS6wbKOUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355153; c=relaxed/simple;
	bh=VRpuWLPuaaVTcB41U3EvN7frrX1z2rJ0vzz6FC7oCHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy76cEcYRekE9oqd4hYrhIbxemOlU/WXFFYGeltrI25askZoxY/w+HnUZYLhRAoxBG5igulKkgxtCcRfao+mxFr0+e6scte8tIn6eAgpbEN45W9+V4i/aWXn5lDwHJQf7y3YZPnLcSi+V2qN3kiuVanbk2iMkjGu/pNbEc4ZETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5YLrBiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A6C32782;
	Tue, 30 Jul 2024 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355153;
	bh=VRpuWLPuaaVTcB41U3EvN7frrX1z2rJ0vzz6FC7oCHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5YLrBiBsNKg7M40pPmTdhehRtNuUB/dpBPxEdPK8AYHWozC55AVrc9y8O3b0GWKx
	 7Td/JNBaI0LqqhSDXYsJ/mIj1O34wKQGdligpxTkM+IQwtD9ZyisTnerH4+qZYwKuZ
	 aPCzwX3oZ7Ky8mVUy4jTvyerkDVu1V5fBm3evki8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Tung <chineweff@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 024/809] hwmon: (adt7475) Fix default duty on fan is disabled
Date: Tue, 30 Jul 2024 17:38:20 +0200
Message-ID: <20240730151725.613245480@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

From: Wayne Tung <chineweff@gmail.com>

[ Upstream commit 39b24cced70fdc336dbc0070f8b3bde61d8513a8 ]

According to the comments on fan is disabled, we change to manual mode
and set the duty cycle to 0.
For setting the duty cycle part, the register is wrong. Fix it.

Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monitoring chip")
Signed-off-by: Wayne Tung <chineweff@gmail.com>
Link: https://lore.kernel.org/r/20240701073252.317397-1-chineweff@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/adt7475.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb304832..ec3336804720e 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1900,7 +1900,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
 
-		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
 					  data->pwm[INPUT][index]);
 
 		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
-- 
2.43.0




