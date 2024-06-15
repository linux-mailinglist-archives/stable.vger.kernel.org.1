Return-Path: <stable+bounces-52269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD190973D
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86328492E
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F422F19;
	Sat, 15 Jun 2024 09:28:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA61BC40
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443727; cv=none; b=sbPQB8vvocCOuiCk7PIRQnef4piepFftnbbg8pKAMioyabB3T15QvyLIoKlXsr1vXU42xvzY/QdLPfyoxvVk2Qk8/9ikvolQo3hp97ivy/CZ/r9nkoLOzL2GkjwJc5fG++LfA85zcL/YF/rhrLeC5I+Kcoc9UL/thev50tkJ0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443727; c=relaxed/simple;
	bh=8CPTRfwOlWiu0qHx6YL6s//GG92U8jfjJpL+SppXr3E=;
	h=From:Date:Subject:To:Cc:Message-Id; b=K1qyJ5dD0vUfdasL0lxtpktZMqNiR1cEZKYRkE8/GeLtWBeh0x9OHBVn1m+DIZD0+gvI5FVCa+ibBbJ04DtuPqeoI/zmj73zjin2qA9ap1RJAL1wHpgEbDGxzO6rO5j+zaDVpIb1EuDFjaehLRGddIj17+zEStwLrJq4FmSanb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sIPYX-0005lX-1s;
	Sat, 15 Jun 2024 09:18:41 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sat, 15 Jun 2024 09:16:39 +0000
Subject: [git:media_stage/master] media: ivsc: csi: don't count privacy on as error
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sIPYX-0005lX-1s@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ivsc: csi: don't count privacy on as error
Author:  Wentong Wu <wentong.wu@intel.com>
Date:    Fri Jun 7 21:25:45 2024 +0800

Prior to the ongoing command privacy is on, it would return -1 to
indicate the current privacy status, and the ongoing command would
be well executed by firmware as well, so this is not error. This
patch changes its behavior to notify privacy on directly by V4L2
privacy control instead of reporting error.

Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
Cc: stable@vger.kernel.org # for 6.6 and later
Reported-by: Hao Yao <hao.yao@intel.com>
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/pci/intel/ivsc/mei_csi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

---

diff --git a/drivers/media/pci/intel/ivsc/mei_csi.c b/drivers/media/pci/intel/ivsc/mei_csi.c
index c6d8f72e4eec..16791a7f4f15 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -192,7 +192,11 @@ static int mei_csi_send(struct mei_csi *csi, u8 *buf, size_t len)
 
 	/* command response status */
 	ret = csi->cmd_response.status;
-	if (ret) {
+	if (ret == -1) {
+		/* notify privacy on instead of reporting error */
+		ret = 0;
+		v4l2_ctrl_s_ctrl(csi->privacy_ctrl, 1);
+	} else if (ret) {
 		ret = -EINVAL;
 		goto out;
 	}

