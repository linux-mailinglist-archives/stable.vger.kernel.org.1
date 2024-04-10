Return-Path: <stable+bounces-37971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE089F3D1
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4231E28E034
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A015DBA5;
	Wed, 10 Apr 2024 13:16:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409315E205
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754961; cv=none; b=EdMbiKf/ZvqkOW/AEKryH5oykcPQTlthnhS47KysT4wZe+7oWPwuKGSU993oV53ESRIze2J7fjX40i/j+YVUppgkszhzp8odRsfNQeJjRPIgh7ZrlyR5UQ3hy5EKa+etDxscWPZfxQbJVtwV9NiBFLd9mhztVOy0rq6MHN+7gpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754961; c=relaxed/simple;
	bh=tQyKqBX+i2j/3DVVhTkKSPhn7pr9qXVOUjFP8xYcTJw=;
	h=From:Date:Subject:To:Cc:Message-Id; b=dSm2oeSY0GbC73xhC9rsyS3BlaqmuiD4hKqZL8Ix1vmNDpQt5vPGHELhDFT/6AxqjcRJUQpqRV7JFj5hBvxPKurvbYuE0SbdhCg1E3zxTRA2oFwXI3MQO/WCFgl5ohawHXDL7nbI+VwHvYiCQomZ55Y5C3PVyLg+kgr11xnUvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXnz-0001Gm-1C;
	Wed, 10 Apr 2024 13:15:59 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: v4l: async: Fix notifier list entry init
To: linuxtv-commits@linuxtv.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXnz-0001Gm-1C@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: v4l: async: Fix notifier list entry init
Author:  Alexander Stein <alexander.stein@ew.tq-group.com>
Date:    Thu Mar 7 15:24:51 2024 +0100

struct v4l2_async_notifier has several list_head members, but only
waiting_list and done_list are initialized. notifier_entry was kept
'zeroed' leading to an uninitialized list_head.
This results in a NULL-pointer dereference if csi2_async_register() fails,
e.g. node for remote endpoint is disabled, and returns -ENOTCONN.
The following calls to v4l2_async_nf_unregister() results in a NULL
pointer dereference.
Add the missing list head initializer.

Fixes: b8ec754ae4c5 ("media: v4l: async: Set v4l2_device and subdev in async notifier init")
Cc: <stable@vger.kernel.org> # for 6.6 and later
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/v4l2-core/v4l2-async.c | 2 ++
 1 file changed, 2 insertions(+)

---

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 3ec323bd528b..6a7dcf43d712 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -563,6 +563,7 @@ void v4l2_async_nf_init(struct v4l2_async_notifier *notifier,
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->v4l2_dev = v4l2_dev;
 }
 EXPORT_SYMBOL(v4l2_async_nf_init);
@@ -572,6 +573,7 @@ void v4l2_async_subdev_nf_init(struct v4l2_async_notifier *notifier,
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->sd = sd;
 }
 EXPORT_SYMBOL_GPL(v4l2_async_subdev_nf_init);

