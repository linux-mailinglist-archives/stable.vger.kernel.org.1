Return-Path: <stable+bounces-19042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C894884C398
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 05:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076D11C25526
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F710A20;
	Wed,  7 Feb 2024 04:28:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6E15E8B
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 04:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280083; cv=none; b=YffGwlwX5shXQC5fjmb11IqnrIXnqBAlUsi9kVKe2uoidiAPJap/f6NtANRc13BXHhWqEw+5YjB/xKKrZsMriWNcZJoV2Jhuqmg42QztC7Bw4frIod3BzxBW0DKc16t0XRGnpugqpKGDfL9wQQNlSBzypb2b+3A11GxmDrUYlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280083; c=relaxed/simple;
	bh=TZP3e5q0xkTb4dHdmoaGAsHjV0MPkKU0QyCFSryNmTw=;
	h=From:Date:Subject:To:Cc:Message-Id; b=rkbIOzxMqa3Gpje/erN8MXor+wjj7YcoAvwrZproobPv74Ayeyn1447Lv1gyHP5WuR6KvuMK2VdK5qtdn5YP24UdqHaiHv7Id9SHb9rIZrPxvw9REhl2+WgQO89ixJzCLj+Z9pzJhwOcBEuWCbaz0+grCeA7rbuuUPuVvzFndm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1rXZXV-0006qA-18;
	Wed, 07 Feb 2024 04:28:01 +0000
From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Thu, 01 Feb 2024 12:20:40 +0000
Subject: [git:media_tree/master] media: tc358743: register v4l2 async device only after successful setup
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Robert Foss <rfoss@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Alexander Stein <alexander.stein@ew.tq-group.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rXZXV-0006qA-18@linuxtv.org>
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
 

