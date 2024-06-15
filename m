Return-Path: <stable+bounces-52270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606AB90973E
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA591F2262B
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36022F19;
	Sat, 15 Jun 2024 09:29:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C527208D1
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443742; cv=none; b=GFoyA6b3yAFAhjoWywHMUyMdC8Izy81H5iu4QcEu8ciBZC1QoI7809H5pcoFRj8DytXUxQzEKRIE8wL7nlFdalg566cbMBPrKQepg2GpiYCfTR0p+qcNCAAU9zI3G2mROOagKHhZcsi7QXicA/m0cIWIHsqzlmr1T8nIKE+gqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443742; c=relaxed/simple;
	bh=Z0WMat5tF3TuOOx8mAv+QQCmDOt3728n/2k1UY2Veco=;
	h=From:Date:Subject:To:Cc:Message-Id; b=LGsasBFxcdHMkESo4a2dWfbFAGiWXlHNECDRm2vtkG58rWqmQ/gRD/IDoI4mpnM2Zr6kRwiFt18ZR5RBJOIdQH+83u29aBcI/CEtZLT6lteq3nOZoCbMkXCA5Pmv79Yo1cri5bgAXsBVvVKvNV7MMGtIvpGHmSSXOKbHXVOICD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sIPYX-0005lp-2T;
	Sat, 15 Jun 2024 09:18:41 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sat, 15 Jun 2024 09:16:39 +0000
Subject: [git:media_stage/master] media: ivsc: csi: add separate lock for v4l2 control handler
To: linuxtv-commits@linuxtv.org
Cc: Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sIPYX-0005lp-2T@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ivsc: csi: add separate lock for v4l2 control handler
Author:  Wentong Wu <wentong.wu@intel.com>
Date:    Fri Jun 7 21:25:46 2024 +0800

There're possibilities that privacy status change notification happens
in the middle of the ongoing mei command which already takes the command
lock, but v4l2_ctrl_s_ctrl() would also need the same lock prior to this
patch, so this may results in circular locking problem. This patch adds
one dedicated lock for v4l2 control handler to avoid described issue.

Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
Cc: stable@vger.kernel.org # for 6.6 and later
Reported-by: Hao Yao <hao.yao@intel.com>
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/pci/intel/ivsc/mei_csi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

---

diff --git a/drivers/media/pci/intel/ivsc/mei_csi.c b/drivers/media/pci/intel/ivsc/mei_csi.c
index f04a89584334..c6d8f72e4eec 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -126,6 +126,8 @@ struct mei_csi {
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *freq_ctrl;
 	struct v4l2_ctrl *privacy_ctrl;
+	/* lock for v4l2 controls */
+	struct mutex ctrl_lock;
 	unsigned int remote_pad;
 	/* start streaming or not */
 	int streaming;
@@ -559,11 +561,13 @@ static int mei_csi_init_controls(struct mei_csi *csi)
 	u32 max;
 	int ret;
 
+	mutex_init(&csi->ctrl_lock);
+
 	ret = v4l2_ctrl_handler_init(&csi->ctrl_handler, 2);
 	if (ret)
 		return ret;
 
-	csi->ctrl_handler.lock = &csi->lock;
+	csi->ctrl_handler.lock = &csi->ctrl_lock;
 
 	max = ARRAY_SIZE(link_freq_menu_items) - 1;
 	csi->freq_ctrl = v4l2_ctrl_new_int_menu(&csi->ctrl_handler,
@@ -755,6 +759,7 @@ err_entity:
 
 err_ctrl_handler:
 	v4l2_ctrl_handler_free(&csi->ctrl_handler);
+	mutex_destroy(&csi->ctrl_lock);
 	v4l2_async_nf_unregister(&csi->notifier);
 	v4l2_async_nf_cleanup(&csi->notifier);
 
@@ -774,6 +779,7 @@ static void mei_csi_remove(struct mei_cl_device *cldev)
 	v4l2_async_nf_unregister(&csi->notifier);
 	v4l2_async_nf_cleanup(&csi->notifier);
 	v4l2_ctrl_handler_free(&csi->ctrl_handler);
+	mutex_destroy(&csi->ctrl_lock);
 	v4l2_async_unregister_subdev(&csi->subdev);
 	v4l2_subdev_cleanup(&csi->subdev);
 	media_entity_cleanup(&csi->subdev.entity);

