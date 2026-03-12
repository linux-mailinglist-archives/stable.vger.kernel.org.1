Return-Path: <stable+bounces-225018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCa7BD4fs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1F3278B58
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D403014431
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206681F9F70;
	Thu, 12 Mar 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cV1l76Vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60421E7660;
	Thu, 12 Mar 2026 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346618; cv=none; b=TArOFfRgsvbVM2YhhrOZJ1/pLXiUIM+sac1J2wOWt8bNftwiq8GglkP7aGNdRNr+E9oD59OjyjYglpj4jRxfWUVvJO/PKpnfTX+g4bvM73Rao9Xeg/TUTH9umVqck4v6yaqiwBEcrFy9jtHm91JrR8z9I2b24JuXiHzIOWh4DE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346618; c=relaxed/simple;
	bh=P3V94OlwnrZFkOPzPWtNPbRM8BOnO25icPJtwNCrt8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGddvTP1CS1skQFIa2Xlo3bh0D36KIiM+oG7tRVzmhAM5NnWOQv/IlIZmLrRDNwo7DjRSobKsf5JCGnsxCv17NAW+N9Yis0VFV1MTqjwWitmN1FKopeCXHuoaTYTyCiWZ0V8ZKL7+wU0BjV5yJ5cKiIA6yS928gAYbb1b08HpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cV1l76Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C5C4CEF7;
	Thu, 12 Mar 2026 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346618;
	bh=P3V94OlwnrZFkOPzPWtNPbRM8BOnO25icPJtwNCrt8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cV1l76VjI/3DO0kqr05xjWIHUfsV9k6jMNgOLvUZiq8ULkjQ+nkdnZlgj+1uviYB7
	 quEIQJkPtJbm7RA+eynCplA22gQnQ3opT0cG1b6FenUv8YRGVmaVRRSFCtitUxPMkt
	 xnzjoARfsSl1vgrghYE/jiEDYI9PNlnDR8AdZGoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Fend <matthias.fend@emfend.at>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/265] media: dw9714: add support for powerdown pin
Date: Thu, 12 Mar 2026 21:07:19 +0100
Message-ID: <20260312201020.087233944@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,emfend.at,linux.intel.com,xs4all.nl,kernel.org];
	TAGGED_FROM(0.00)[bounces-225018-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: BB1F3278B58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Fend <matthias.fend@emfend.at>

[ Upstream commit 03dca1842421b068d6a65b8ae16e2191882c7753 ]

Add support for the powerdown pin (xSD), which can be used to put the VCM
driver into power down mode. This is useful, for example, if the VCM
driver's power supply cannot be controlled. The use of the powerdown pin is
optional.

Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Stable-dep-of: 401aec35ac7b ("media: dw9714: Fix powerup sequence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/Kconfig  |  2 +-
 drivers/media/i2c/dw9714.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 5cb596f38de33..4703071352541 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -748,7 +748,7 @@ config VIDEO_AK7375
 
 config VIDEO_DW9714
 	tristate "DW9714 lens voice coil support"
-	depends on I2C && VIDEO_DEV
+	depends on GPIOLIB && I2C && VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_ASYNC
diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index 37572cd0c104b..e69dd3e14b844 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2015--2017 Intel Corporation.
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -38,6 +39,7 @@ struct dw9714_device {
 	struct v4l2_subdev sd;
 	u16 current_val;
 	struct regulator *vcc;
+	struct gpio_desc *powerdown_gpio;
 };
 
 static inline struct dw9714_device *to_dw9714_vcm(struct v4l2_ctrl *ctrl)
@@ -145,6 +147,8 @@ static int dw9714_power_up(struct dw9714_device *dw9714_dev)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(dw9714_dev->powerdown_gpio, 0);
+
 	usleep_range(1000, 2000);
 
 	return 0;
@@ -152,6 +156,8 @@ static int dw9714_power_up(struct dw9714_device *dw9714_dev)
 
 static int dw9714_power_down(struct dw9714_device *dw9714_dev)
 {
+	gpiod_set_value_cansleep(dw9714_dev->powerdown_gpio, 1);
+
 	return regulator_disable(dw9714_dev->vcc);
 }
 
@@ -169,6 +175,14 @@ static int dw9714_probe(struct i2c_client *client)
 	if (IS_ERR(dw9714_dev->vcc))
 		return PTR_ERR(dw9714_dev->vcc);
 
+	dw9714_dev->powerdown_gpio = devm_gpiod_get_optional(&client->dev,
+							     "powerdown",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(dw9714_dev->powerdown_gpio))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(dw9714_dev->powerdown_gpio),
+				     "could not get powerdown gpio\n");
+
 	rval = dw9714_power_up(dw9714_dev);
 	if (rval)
 		return dev_err_probe(&client->dev, rval,
-- 
2.51.0




