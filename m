Return-Path: <stable+bounces-17580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FA84585E
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43651C2139C
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B08663B;
	Thu,  1 Feb 2024 13:01:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BE53365
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792500; cv=none; b=r2P0rm33PbJ1qTj0a1BS+cY+QGYd5Wsxozezx4b2CG1/KfEgYwJrCX87BQ3Hiy6iPMD1BLRwzjdyYAsY4Iv+ajULwLvy6TiCbNfiYZ6IfxgsR7p18kV2iM4nTkQ6j+yVuOGWxKwRcAF24srMv9QQ3hezfyiskjtTZe26Dg2z1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792500; c=relaxed/simple;
	bh=TZP3e5q0xkTb4dHdmoaGAsHjV0MPkKU0QyCFSryNmTw=;
	h=From:Date:Subject:To:Cc:Message-Id; b=a3Q3dUX25lL7M7WvlH2bfZxyh2Mmj+FcBk9hkt2J3TFv4Xd+DBLVhBBxSD+E5pIdZXC+KVNZjS0sw85Rfmb0po9wbKBwFFkqmOZfVw6BUAScEEhV+9BroJiJWdNYTm3iEhi+plBkT46BJ5QMOmKGGpKpDkTS0/N3cRgCON6TA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1rVWSZ-0006hB-03;
	Thu, 01 Feb 2024 12:46:27 +0000
From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Thu, 01 Feb 2024 12:20:40 +0000
Subject: [git:media_stage/master] media: tc358743: register v4l2 async device only after successful setup
To: linuxtv-commits@linuxtv.org
Cc: Robert Foss <rfoss@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Alexander Stein <alexander.stein@ew.tq-group.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rVWSZ-0006hB-03@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: tc358743: register v4l2 async device only after successful setup
Author:  Alexander Stein <alexander.stein@ew.tq-group.com>
Date:    Wed Jan 10 10:01:11 2024 +0100

Ensure the device has been setup correctly before registering the v4l2
async device, thus allowing userspace to access.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Fixes: 4c5211a10039 ("[media] tc358743: register v4l2 asynchronous subdevice")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

 drivers/media/i2c/tc358743.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

---

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 2785935da497..558152575d10 100644
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
 

