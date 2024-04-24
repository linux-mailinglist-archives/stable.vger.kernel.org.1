Return-Path: <stable+bounces-41407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30138B1B0C
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8613A2840B1
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C459155;
	Thu, 25 Apr 2024 06:29:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1124502E
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026545; cv=none; b=C6baV+Tij8YZChmKmSkFlzmHn3DMBWm2xtqDT7s1LigUCFT/G5c+1FND+HmUm3bjhJRwnHc6UbwPnrqs3wre2s0qi2nHffRMYIbATAkNbJbXnhtM1vk97njHIycWmqMximzAXXxI9UagmZ5XJXWJBqbgjUKTkax/0P6Ansjkp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026545; c=relaxed/simple;
	bh=XmmPjMB8Mboxj1o0EVbKYz0bx1nldfdLxsHQiC69L/U=;
	h=From:Date:Subject:To:Cc:Message-Id; b=pftF+dAbqXux+jM4TsgiHyURIyJnKKGdEHErN0/GxniPaHAw/0Yoav9Uq4bVAjM5mHs2mKXrhXVp07Inlza9DKpLjzhSJUdFy+mM2NVqXapxfpXdlQBbGEg73jawQOV1nJIKjxMulM7ldVCVr1VlYGB7XE94UO43UvL/Kqp50JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rzsbO-0006x5-0G;
	Thu, 25 Apr 2024 06:29:02 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 24 Apr 2024 11:49:55 +0000
Subject: [git:media_stage/master] media: v4l2-core: hold videodev_lock until dev reg, finishes
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rzsbO-0006x5-0G@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: v4l2-core: hold videodev_lock until dev reg, finishes
Author:  Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:    Fri Feb 23 09:45:36 2024 +0100

After the new V4L2 device node was registered, some additional
initialization was done before the device node was marked as
'registered'. During the time between creating the device node
and marking it as 'registered' it was possible to open the
device node, which would return -ENODEV since the 'registered'
flag was not yet set.

Hold the videodev_lock mutex from just before the device node
is registered until the 'registered' flag is set. Since v4l2_open
will take the same lock, it will wait until this registration
process is finished. This resolves this race condition.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: <stable@vger.kernel.org>      # for vi4.18 and up

 drivers/media/v4l2-core/v4l2-dev.c | 3 +++
 1 file changed, 3 insertions(+)

---

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index e39e9742fdb5..be2ba7ca5de2 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1039,8 +1039,10 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
+	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
+		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
 		goto cleanup;
 	}
@@ -1060,6 +1062,7 @@ int __video_register_device(struct video_device *vdev,
 
 	/* Part 6: Activate this minor. The char device can now be used. */
 	set_bit(V4L2_FL_REGISTERED, &vdev->flags);
+	mutex_unlock(&videodev_lock);
 
 	return 0;
 

