Return-Path: <stable+bounces-40372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB58AC925
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 11:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29681282031
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE504C622;
	Mon, 22 Apr 2024 09:41:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B64AEFE
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778898; cv=none; b=PwLoX2g00HxNdf2oNBl3Oeu4O8FtgObBIV48d+Wm0qqxZzgYeIXi6jADE5La/4UbSCu9SEMClReqMwjT1SU9O/Tv+q4cmg3XLLfn6w6cFYnclCfCXQS/yEme9al6bCjnMry2KJQcYJho9Ew1O7lABAfCKr8oQEtWx0EL12xLisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778898; c=relaxed/simple;
	bh=EUeIc1kS5BUehW8r3H39rgf0La+oE6eYROFwC8XrQ20=;
	h=From:Date:Subject:To:Cc:Message-Id; b=uKJqKGyzai9ZVt+h+ilcuB4jHUBvSzzFAJ/up1S6wRrZIxx8ea2y0RSZ+W9UmTXQllLjwiG5xUT2K+S7SL/DaXD1L66MapRTJdM+BkDfPvig1DgFWt1d25eKicykSfKeQdc7d4jLZh7/Z5zff0TjJoLqgJqwqPr90fw8Vv0kowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ryqB5-0004LL-0a;
	Mon, 22 Apr 2024 09:41:35 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 22 Apr 2024 09:41:04 +0000
Subject: [git:media_stage/master] media: mc: mark the media devnode as registered from the, start
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ryqB5-0004LL-0a@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: mc: mark the media devnode as registered from the, start
Author:  Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:    Fri Feb 23 09:46:19 2024 +0100

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

 drivers/media/mc/mc-devnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

---

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

