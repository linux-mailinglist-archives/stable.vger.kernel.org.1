Return-Path: <stable+bounces-37968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AA89F3CE
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A598F1F21C8F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AD15E7E3;
	Wed, 10 Apr 2024 13:16:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561715DBA9
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754961; cv=none; b=bnR/2gn05m55s2udnad/ss9q60SOGLv6vtHsJxBbyQkEFYgIgzNTjiz2+kWmWoiQIe+nsB1KireMuK7ajZ0Mmi3THmEKAI0elUbnTQMtOd4vcz6Du4rIfRiWeHjKWqrDI9TVphBX/pbrX6Gmdn6mbwoowkOng/t7c79fVivpOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754961; c=relaxed/simple;
	bh=sMaa+q8H7JX2wWDBto+Vk53J/Q1JC+gHYjHDSDegeUE=;
	h=From:Date:Subject:To:Cc:Message-Id; b=DP+oEpoJwHDk1FyC+VKluaaPxp9+z8mhKuUXbCZW9kwHkujDMSZ/0Q1pco1XeBxFf64+BpjxVi5PjmDPeYCqOJRR8XbblUqxcZlnVICoSBixpl8rmDqyh2AgJm0GoCP26MoEAwVnIRmmDkUPWx4a8lamDJfqoiNm4u5G4/vF8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXnz-0001G6-0Y;
	Wed, 10 Apr 2024 13:15:59 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: v4l: async: Properly re-initialise notifier entry in unregister
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXnz-0001G6-0Y@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: v4l: async: Properly re-initialise notifier entry in unregister
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Fri Mar 8 15:06:13 2024 +0200

The notifier_entry of a notifier is not re-initialised after unregistering
the notifier. This leads to dangling pointers being left there so use
list_del_init() to return the notifier_entry an empty list.

Fixes: b8ec754ae4c5 ("media: v4l: async: Set v4l2_device and subdev in async notifier init")
Cc: <stable@vger.kernel.org> # for 6.6 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/v4l2-core/v4l2-async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2ff35d5d60f2..4bb073587817 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -635,7 +635,7 @@ __v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)
 
 	v4l2_async_nf_unbind_all_subdevs(notifier);
 
-	list_del(&notifier->notifier_entry);
+	list_del_init(&notifier->notifier_entry);
 }
 
 void v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)

