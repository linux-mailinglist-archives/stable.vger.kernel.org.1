Return-Path: <stable+bounces-134341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100EA92AA1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F04E1B64968
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E36257426;
	Thu, 17 Apr 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaN67WHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EB1B4153;
	Thu, 17 Apr 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915835; cv=none; b=f30a0QDicI1trc6rodIR0kC2fXoX8UsIDREhQoO5ixNl7BwhVzalqD92BQYuPy/QNH9Btt/1S1PCwLkHt9OfQfV4cDbq/TtEDr9/N4IRTzUGv0D5IV4t7YWAdS/8W5Ng4kpT1Z4245lJ36iBIQx1We/UEsnP5y2Pp5qZzgDZ3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915835; c=relaxed/simple;
	bh=RU2t0Zk5C1sanvOiGGMZndT42gkOieE6ywG5VypPzUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcCfGxJBUfD82E2dMKtNK3FdGQ/Q50VI4mA9D0rugKFm6Ie4XvFgZp1VTOjtjAtlU1wzjvkAR29/Px3oN+CScAIgCjHxDEPPwecGm14gKwu+CugtdGQAH66mjZSEbpFPETJQg4+o1xCHY2S84LDban+Kl2MhxrFKg1tVKPudqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaN67WHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49889C4CEE4;
	Thu, 17 Apr 2025 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915834;
	bh=RU2t0Zk5C1sanvOiGGMZndT42gkOieE6ywG5VypPzUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaN67WHOdSaP/DoF8fBxwwO9TC4B/XglypQY6wj+k23Sb8vZzwrkq9Yom67xIyOPM
	 Or5o3hfvbUxyToIGq3hiWHS0+R83nNDoQO36AeQe3ZPgkCEqL2fuHB4mVGMoNNmhv4
	 KPmUWV7ltZ+H5GV/6l6ZYd9m75IINAeZCGk7zAyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.12 226/393] media: i2c: imx319: Rectify runtime PM handling probe and remove
Date: Thu, 17 Apr 2025 19:50:35 +0200
Message-ID: <20250417175116.675723552@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 5f5ffd3bc62b2e6c478061918b10473d8b90ac2d upstream.

Idle the device only after the async sub-device has been successfully
registered. In error handling, set the device's runtime PM status to
suspended only if it has been set to active previously in probe.

Also set the device's runtime PM status to suspended in remove only if it
wasn't so already.

Fixes: 8a89dc62f28c ("media: add imx319 camera sensor driver")
Cc: stable@vger.kernel.org # for >= v6.12
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/imx319.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/media/i2c/imx319.c
+++ b/drivers/media/i2c/imx319.c
@@ -2442,17 +2442,19 @@ static int imx319_probe(struct i2c_clien
 	if (full_power)
 		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
-	pm_runtime_idle(&client->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx319->sd);
 	if (ret < 0)
 		goto error_media_entity_pm;
 
+	pm_runtime_idle(&client->dev);
+
 	return 0;
 
 error_media_entity_pm:
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	if (full_power)
+		pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx319->sd.entity);
 
 error_handler_free:
@@ -2474,7 +2476,8 @@ static void imx319_remove(struct i2c_cli
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		pm_runtime_set_suspended(&client->dev);
 
 	mutex_destroy(&imx319->mutex);
 }



