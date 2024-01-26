Return-Path: <stable+bounces-15944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469CF83E4E3
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA85E1F21C66
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD725547;
	Fri, 26 Jan 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJFVQS6q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E14250F0
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307120; cv=none; b=Pkuo0VJksu2d1te+WcLOProEI+X5vUX/ca1HFImqU9Pfn6u2GrVWqeGoHf4W7x6r/JwXk7TSzq7nP5e5wu1ssfFGNBvlXHehux6UoXkfxDgtKNC1dFvvvIyCx8g3RttfksPwVqj/mgjloghq/sHMIWDz6ZCMGi+tXQvRsoWwavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307120; c=relaxed/simple;
	bh=CHVoHsYBotXYliq1iN9EmEpkHAMgKwqEpi7jOzmUqW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BGCDG33LxusESy1Mp5SgOhE3hQAny1xlbSyC7i7rcvaifUzqerdo0tmPS1Ils592pmsqVXHxCH6YPT30VYWRtBgQLok8OqR6s19tQuo1Nmq/8w8Hd2rnKP1g8nIAPE5FvD54ZqTEWEIWMTBIjzwWVuR07YIvtTay3egMb1VSdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJFVQS6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB16C43390;
	Fri, 26 Jan 2024 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307120;
	bh=CHVoHsYBotXYliq1iN9EmEpkHAMgKwqEpi7jOzmUqW4=;
	h=Subject:To:Cc:From:Date:From;
	b=kJFVQS6q6ZiAmN6F4MMw8bFVCa/As2g9PzCkipYkbILVC+65w32pBR7a23/4/9veA
	 aumldsU+je5aWE4JJw6dkQPO8mKkLNHp++X6En40C/hgKI0kMhdfCS0lna+lwfN+fy
	 lKCz7PVGkjauFIF3PRs2oRkD74pXiGUnduswWueo=
Subject: FAILED: patch "[PATCH] media: ov13b10: Enable runtime PM before registering async" failed to apply to 6.1-stable tree
To: bingbu.cao@intel.com,hverkuil-cisco@xs4all.nl,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:11:59 -0800
Message-ID: <2024012659-opacity-greedy-0493@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7b0454cfd8edb3509619407c3b9f78a6d0dee1a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012659-opacity-greedy-0493@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7b0454cfd8ed ("media: ov13b10: Enable runtime PM before registering async sub-device")
1af2f618acc1 ("media: ov13b10: Support device probe in non-zero ACPI D state")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b0454cfd8edb3509619407c3b9f78a6d0dee1a5 Mon Sep 17 00:00:00 2001
From: Bingbu Cao <bingbu.cao@intel.com>
Date: Wed, 22 Nov 2023 17:46:08 +0800
Subject: [PATCH] media: ov13b10: Enable runtime PM before registering async
 sub-device

As the sensor device maybe accessible right after its async sub-device is
registered, such as ipu-bridge will try to power up sensor by sensor's
client device's runtime PM from the async notifier callback, if runtime PM
is not enabled, it will fail.

So runtime PM should be ready before its async sub-device is registered
and accessible by others.

Fixes: 7ee850546822 ("media: Add sensor driver support for the ov13b10 camera.")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
index c06411d5ee2b..73c844aa5697 100644
--- a/drivers/media/i2c/ov13b10.c
+++ b/drivers/media/i2c/ov13b10.c
@@ -1554,24 +1554,27 @@ static int ov13b10_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&ov13b->sd);
-	if (ret < 0)
-		goto error_media_entity;
 
 	/*
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
 	 */
-
 	/* Set the device's state to active if it's in D0 state. */
 	if (full_power)
 		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
+	ret = v4l2_async_register_subdev_sensor(&ov13b->sd);
+	if (ret < 0)
+		goto error_media_entity_runtime_pm;
+
 	return 0;
 
-error_media_entity:
+error_media_entity_runtime_pm:
+	pm_runtime_disable(&client->dev);
+	if (full_power)
+		pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&ov13b->sd.entity);
 
 error_handler_free:
@@ -1594,6 +1597,7 @@ static void ov13b10_remove(struct i2c_client *client)
 	ov13b10_free_controls(ov13b);
 
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(ov13b10_pm_ops, ov13b10_suspend,


