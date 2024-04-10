Return-Path: <stable+bounces-37969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADD989F3CF
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8147C1F21E4B
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD415E7EF;
	Wed, 10 Apr 2024 13:16:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64EA15E203
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754961; cv=none; b=X/24XWvmBRqQvTWtjFujgNEYUIT+WDTKjGE5dAIebdXcE0Ki39oDxSRe9stAK9ZxaTWj5bPB7mkK2JQhm7FyZ8SEn8mAFl4q58xJcvKxSBqKvzb6ag0/WU1e/7FEp1UDeTQaGLnHVS1DC/UbbbI4sZikOoKXmclDFvCHgtuk2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754961; c=relaxed/simple;
	bh=bM1BJggbzJDxbPrejO0zGg+Gmp3q7tYh5LSfAmJYjD8=;
	h=From:Date:Subject:To:Cc:Message-Id; b=ap5dGoFzgsTD2QQICKvHRxpFLYyL5GSru6tmGxRNmsPJOH9IoyvozlVnbsyNc7DoOr0160ekuKIs4+wm57ihEM06v0Vodio3a4r+IpWaH2vZDeCm081O9pTbh9u5u91lgjtyUB4/qTwdkiVWgwnkT8QhfrNZhMe/p+iXFodtBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXnz-0001GR-0t;
	Wed, 10 Apr 2024 13:15:59 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: v4l: async: Don't set notifier's V4L2 device if registering fails
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXnz-0001GR-0t@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: v4l: async: Don't set notifier's V4L2 device if registering fails
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Fri Mar 8 15:07:45 2024 +0200

The V4L2 device used to be set when the notifier was registered but this
has been moved to the notifier initialisation. Don't touch the V4L2 device
if registration fails.

Fixes: b8ec754ae4c5 ("media: v4l: async: Set v4l2_device and subdev in async notifier init")
Cc: <stable@vger.kernel.org> # for 6.6 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/v4l2-core/v4l2-async.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

---

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 6a7dcf43d712..2ff35d5d60f2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -620,16 +620,10 @@ err_unlock:
 
 int v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
 {
-	int ret;
-
 	if (WARN_ON(!notifier->v4l2_dev == !notifier->sd))
 		return -EINVAL;
 
-	ret = __v4l2_async_nf_register(notifier);
-	if (ret)
-		notifier->v4l2_dev = NULL;
-
-	return ret;
+	return __v4l2_async_nf_register(notifier);
 }
 EXPORT_SYMBOL(v4l2_async_nf_register);
 

