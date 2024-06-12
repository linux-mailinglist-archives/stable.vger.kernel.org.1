Return-Path: <stable+bounces-50316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A0905AA8
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7665A1C21929
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF638FB6;
	Wed, 12 Jun 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8vCmI4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE0383A5
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216411; cv=none; b=np5T2dl0GaSH3bDDXxrHEfXKiDOIi2Jv86tzpQTgfXIF30g+GpQ4VAbiQlD6OQ9QNKv6ThHtowNAkbX6VbFAt2OVPn/Trb0J74BjzrL57jPeAowuG587U1E2od7oeoLPFgFcEJxla9KRA6GrtLkeJCJ2Ihok3zNqqO9YwuDHeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216411; c=relaxed/simple;
	bh=VYPTQnRo/AJ1fkMVaTcUW6mZXuJW5XEQ9WVplK8nXVU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZFCMWEU6whJmSUIE5TQReJlmA/akSoyNB2q1lVEY55OY7zASSq4GvHUnUQS6Exqj85vTI3eFsH9HUZ/xJ6xVczE4tiLEEr6b5BOGfVkVgE//rjV9grFq8s/YmxdNxE95B/2NBZ5DLXQjCbK6PJHar5o/KDwj09X3fyavtzlpFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w8vCmI4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6709CC116B1;
	Wed, 12 Jun 2024 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216410;
	bh=VYPTQnRo/AJ1fkMVaTcUW6mZXuJW5XEQ9WVplK8nXVU=;
	h=Subject:To:Cc:From:Date:From;
	b=w8vCmI4NJ0mwjF6kqUtHsjvVblw9y6DRbuAAfixUfVY+AXSKo2I/ldewRzUbwSBok
	 KKOcYgfRXLm+Xd/6nLvE+yKVDZc0RndyTlIlA0RBr3QgP2lYA+RD++mc3aGbOwqYdH
	 0S8QR6rewaxqGA0ig1HGC17hB9rE2IKaNd/RKdQM=
Subject: FAILED: patch "[PATCH] media: mc: mark the media devnode as registered from the," failed to apply to 4.19-stable tree
To: hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 20:20:07 +0200
Message-ID: <2024061207-grooving-scholar-3378@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4bc60736154bc9e0e39d3b88918f5d3762ebe5e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061207-grooving-scholar-3378@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4bc60736154b ("media: mc: mark the media devnode as registered from the, start")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4bc60736154bc9e0e39d3b88918f5d3762ebe5e0 Mon Sep 17 00:00:00 2001
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Fri, 23 Feb 2024 09:46:19 +0100
Subject: [PATCH] media: mc: mark the media devnode as registered from the,
 start

First the media device node was created, and if successful it was
marked as 'registered'. This leaves a small race condition where
an application can open the device node and get an error back
because the 'registered' flag was not yet set.

Change the order: first set the 'registered' flag, then actually
register the media device node. If that fails, then clear the flag.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: cf4b9211b568 ("[media] media: Media device node support")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 7f67825c8757..318e267e798e 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -245,15 +245,14 @@ int __must_check media_devnode_register(struct media_device *mdev,
 	kobject_set_name(&devnode->cdev.kobj, "media%d", devnode->minor);
 
 	/* Part 3: Add the media and char device */
+	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 	ret = cdev_device_add(&devnode->cdev, &devnode->dev);
 	if (ret < 0) {
+		clear_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 		pr_err("%s: cdev_device_add failed\n", __func__);
 		goto cdev_add_error;
 	}
 
-	/* Part 4: Activate this minor. The char device can now be used. */
-	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
-
 	return 0;
 
 cdev_add_error:


