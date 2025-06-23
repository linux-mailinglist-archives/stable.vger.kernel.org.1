Return-Path: <stable+bounces-157397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4DCAE53C9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E8A4460DB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1822258C;
	Mon, 23 Jun 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6vaq/E3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BC2222C2;
	Mon, 23 Jun 2025 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715766; cv=none; b=l9Rtc9+lc2iLgxfIA7mfrz76XAruhClxlmGEMNwdq7qcuz0mHk+tZYNTTHpqldCvFm61+4j1/vBox+YZ9IyXvaC8GRXyT8jJrR/OnmlHKyzYfIlOKmduZzCyU+wcN0KLTxk2dMwmmFe7/9bcK05LLeRwgPP3+u3HHMvtO8p2US8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715766; c=relaxed/simple;
	bh=/MiIW3GAaxtvI+Gh74cBLukQQo+Xs2weFXTLxWmBBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpHiufn4ajXqC2EgYSrBF1CKiFq7KGsOZ0Y8GFCDN6K2uCwDTV7KALRG4O/dJWvvcOYrW0295orCGia8u/tuXlgk5nMIEEPoBp55TO+Ul0NNaDfSL2ujzVO1iwJM1I5Ril90gYww76omMbTKedQ5pAVnZV3mMpneRybo2qXRa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6vaq/E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C63C4CEEA;
	Mon, 23 Jun 2025 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715765;
	bh=/MiIW3GAaxtvI+Gh74cBLukQQo+Xs2weFXTLxWmBBuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6vaq/E3BcdcwrWtc/LcS45qDWNeT541KbMfQWGDNC4JXydpqjCyCSTuxCpw14sxp
	 YvHWEyB59T0ZzU5EOmwQefqyCf7KLZZZqiTIidNRVYDjc7qevQdcDJdxXbmiusClYv
	 3bzS0Lt8tuRbm+loGGx16CcvRwlMhIwWuZsfOxpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 277/411] media: i2c: imx334: Enable runtime PM before sub-device registration
Date: Mon, 23 Jun 2025 15:07:01 +0200
Message-ID: <20250623130640.625255679@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

From: Tarang Raval <tarang.raval@siliconsignals.io>

[ Upstream commit 01dfdf6a80c57151af0589af0db7adbbdd1361c7 ]

Runtime PM is fully initialized before calling
v4l2_async_register_subdev_sensor(). Moving the runtime PM initialization
earlier prevents potential access to an uninitialized or powered-down
device.

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx334.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 062125501788a..57b7416bbfab3 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -1058,6 +1058,9 @@ static int imx334_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
+	pm_runtime_set_active(imx334->dev);
+	pm_runtime_enable(imx334->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&imx334->sd);
 	if (ret < 0) {
 		dev_err(imx334->dev,
@@ -1065,13 +1068,13 @@ static int imx334_probe(struct i2c_client *client)
 		goto error_media_entity;
 	}
 
-	pm_runtime_set_active(imx334->dev);
-	pm_runtime_enable(imx334->dev);
 	pm_runtime_idle(imx334->dev);
 
 	return 0;
 
 error_media_entity:
+	pm_runtime_disable(imx334->dev);
+	pm_runtime_set_suspended(imx334->dev);
 	media_entity_cleanup(&imx334->sd.entity);
 error_handler_free:
 	v4l2_ctrl_handler_free(imx334->sd.ctrl_handler);
-- 
2.39.5




