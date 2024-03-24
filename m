Return-Path: <stable+bounces-30097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467B888F7D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A4D1F2A409
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760E25B326;
	Sun, 24 Mar 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0GEc2+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63113957A;
	Sun, 24 Mar 2024 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321633; cv=none; b=U4M6OaI+DRLNCo9iIrv8a5z/ATAgZtjxt9g7CRVE2Av28VrdoYo5YEw8Jn67eE3zuWjHars5CXRMlz7Rfdt7uT/8jLrvH0WOc3nJbjhNpHxbXXDkYE+k9zkUqtRc95Yi2a3o7/u0GugU6xNL+dPUy0MWiKR+7acuCzqFHhW8OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321633; c=relaxed/simple;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv4WvgC3bjKhGpxBu8fvBYaheEKFqNd+/eMpHwlRox5f1d3mG/gkFYtcRbXAvrOeCplZ0VKY1QCZTSh0LijNVbXQo0H+9aTWBY9+5ZYSWHQ5U/snnvSauab9F0L4V96NImrkB0LPxGIvI47TqjahoItcIrfvA9RbwEn+w3SYMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0GEc2+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B96C43390;
	Sun, 24 Mar 2024 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321631;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0GEc2+jsQvt2+8cKFddXuqOPXWuNh02mNhQyqScxj6KEIiVT1yDwumqhjhGGtXAx
	 UWX8NbaqKTSwiab9EcWc3uRVOpMHU5dO8heqKP+BCe7L2jilrKkf5u8wUwys4sXAdN
	 cfFDtpKIZTO+Hg7A4uEQR7jbRNcoxNG3/XHNAp/iQLTBwpun4Fiv1H6fMtTncBkVK8
	 mYrX4Ct6I1L1cjr0FV1YFl9qNrcUfqD4BwEPgJPO/oGWcoDkECruHSMnDAC82W63Sf
	 Enbr8sUSFoYOqIQuMbfm0qiGcjju4iU/OyA0Ygzo0Oo2KYSPBKVaUPTlu0aFYzkE2s
	 NoTKXwgVP1rAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 362/638] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 18:56:39 -0400
Message-ID: <20240324230116.1348576-363-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 87399f1ff92203d65f1febf5919429f4bb613a02 ]

Ensure the device has been setup correctly before registering the v4l2
async device, thus allowing userspace to access.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Fixes: 4c5211a10039 ("[media] tc358743: register v4l2 asynchronous subdevice")
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240110090111.458115-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358743.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 2785935da497b..558152575d102 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2091,9 +2091,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2151,6 +2148,10 @@ static int tc358743_probe(struct i2c_client *client)
 	if (err)
 		goto err_work_queues;
 
+	err = v4l2_async_register_subdev(sd);
+	if (err < 0)
+		goto err_work_queues;
+
 	v4l2_info(sd, "%s found @ 0x%x (%s)\n", client->name,
 		  client->addr << 1, client->adapter->name);
 
-- 
2.43.0


