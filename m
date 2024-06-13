Return-Path: <stable+bounces-51521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9490704A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B50C1C23B7A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17A144D20;
	Thu, 13 Jun 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LYtIl0qL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE80143747;
	Thu, 13 Jun 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281539; cv=none; b=aX/8ADV4j8MV8Jlox3eEpewl30OuP/TPg6Nkn5M5B4HMmC95shuGUoRIUxDkf2hXQY4d90q2U2mevqxWIZcn7rgZan15ij6/5AZ2SrJWPxHgbLFAduNqU4QsRLbKnFF8ZrI3m5gKaqlkPlt3x7dMs2IA3asq+3gkGI3rdd993Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281539; c=relaxed/simple;
	bh=LYz3j0DmuSNqL+Tdz++MDyGo3ajZnd77zkOpnRyYYvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8uwQ1DuI7JE6w4Wfi9ANGi+CWOhTHKbq48EuEZ28oxhJA3WbFp3FUxJAHuivj8lDFKMGKgkPrGook3XJLwy5vo+UcQREtqxOi7PKEi8TkeSkXVgDkfdnWFPhra9Vey0id15umghyIM9JdAg8JEuDMNbH2LBAkV+HAgFePo932w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LYtIl0qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06288C2BBFC;
	Thu, 13 Jun 2024 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281539;
	bh=LYz3j0DmuSNqL+Tdz++MDyGo3ajZnd77zkOpnRyYYvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYtIl0qLIiO+P/KSLwRkwGVpiiq/o+GGKCrtajNJdAoaeL+4pJtXT19fNCO4aSy6o
	 gG3VzKZWTJRTWltaOQ4VPh08NuNa/LwwvFRH766Q0GMYhtXinQgPcX30Zjt0JXWO7t
	 t1ZXUUJTJRPZGSJuK2uleeTNy56kDbOb29wB4M8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 5.10 289/317] media: v4l2-core: hold videodev_lock until dev reg, finishes
Date: Thu, 13 Jun 2024 13:35:07 +0200
Message-ID: <20240613113258.731879582@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 1ed4477f2ea4743e7c5e1f9f3722152d14e6eeb1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1030,8 +1030,10 @@ int __video_register_device(struct video
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
@@ -1051,6 +1053,7 @@ int __video_register_device(struct video
 
 	/* Part 6: Activate this minor. The char device can now be used. */
 	set_bit(V4L2_FL_REGISTERED, &vdev->flags);
+	mutex_unlock(&videodev_lock);
 
 	return 0;
 



