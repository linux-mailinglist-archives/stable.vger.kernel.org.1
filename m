Return-Path: <stable+bounces-133910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91023A92916
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E777B80B6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70D257423;
	Thu, 17 Apr 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVdGyB1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA91EB1BF;
	Thu, 17 Apr 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914517; cv=none; b=WeDr1oTThCQupQQeHgWIYibE7FzydYXiRdrgyLleN+Uu3oXgk3Y5Jr0k08mnafgQIyVRQnKOYeYjMj4bamf/ULA6Iqz8KqoHN2EBDCmAhWpd3gKs3HPfX5TuruI7ZxOr8kW4PVUzss9rf1nE92bW3L20tBjo0SayWoAJrgcyq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914517; c=relaxed/simple;
	bh=m1NIboWVO3h6UiGtKKpYDBLD0v36X59dBiRJqwAHkUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0nQ3s7clrbeFAX41cWkoYJBAp0SdhMoRIp7m9ExpUaDKphNDendyNKsYwdY96ZuZZseJgccfkHsLgm4p7q2t5z076HA33oin54ebKMiS5vApWapTmi/07Y+ejfOuglyFm1Xt/n0BqXqwLHyMu/uslsKDsGGMdsbnz5GUWGI0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVdGyB1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85848C4CEE4;
	Thu, 17 Apr 2025 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914516;
	bh=m1NIboWVO3h6UiGtKKpYDBLD0v36X59dBiRJqwAHkUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVdGyB1VMbz6/UuvuTBIyZX+YWDy0Pb3sGUlznvuERz2NvW7yMrBpYupV6IxwRdpK
	 qW7N54sxbHOZR8yW+e0ASY+c3D3BFiEgGbjN9Rz3pRLa4BCJ5VRTQYGEFgtrx8D9Mm
	 b9i8WUihrFfT1hKePHWA8JuQdmIBe7+3c6umTSrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.13 240/414] media: i2c: imx214: Rectify probe error handling related to runtime PM
Date: Thu, 17 Apr 2025 19:49:58 +0200
Message-ID: <20250417175121.079281406@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit ccc888d1698b6f42d52ddf5cecfe50fe925c95e5 upstream.

There were multiple issues in the driver's probe function related to
error handling:

- Device's PM runtime status wasn't reverted to suspended on some errors
  in probe.

- Runtime PM was left enabled for the device on some probe errors.

- Device was left powered on if a probe failure happened or when it
  was removed when it was powered on.

- An extra pm_runtime_set_suspended() was issued in driver's remove
  function when the device was suspended.

Fix these bugs.

Fixes: 436190596241 ("media: imx214: Add imx214 camera sensor driver")
Cc: stable@vger.kernel.org # for >= v6.12
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: André Apitzsch <git@apitzsch.eu>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/imx214.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1075,10 +1075,6 @@ static int imx214_probe(struct i2c_clien
 	 */
 	imx214_power_on(imx214->dev);
 
-	pm_runtime_set_active(imx214->dev);
-	pm_runtime_enable(imx214->dev);
-	pm_runtime_idle(imx214->dev);
-
 	ret = imx214_ctrls_init(imx214);
 	if (ret < 0)
 		goto error_power_off;
@@ -1099,21 +1095,30 @@ static int imx214_probe(struct i2c_clien
 
 	imx214_entity_init_state(&imx214->sd, NULL);
 
+	pm_runtime_set_active(imx214->dev);
+	pm_runtime_enable(imx214->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&imx214->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
 		goto free_entity;
 	}
 
+	pm_runtime_idle(imx214->dev);
+
 	return 0;
 
 free_entity:
+	pm_runtime_disable(imx214->dev);
+	pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx214->sd.entity);
+
 free_ctrl:
 	mutex_destroy(&imx214->mutex);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
+
 error_power_off:
-	pm_runtime_disable(imx214->dev);
+	imx214_power_off(imx214->dev);
 
 	return ret;
 }
@@ -1126,11 +1131,12 @@ static void imx214_remove(struct i2c_cli
 	v4l2_async_unregister_subdev(&imx214->sd);
 	media_entity_cleanup(&imx214->sd.entity);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	mutex_destroy(&imx214->mutex);
+	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		imx214_power_off(imx214->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 }
 
 static const struct of_device_id imx214_of_match[] = {



