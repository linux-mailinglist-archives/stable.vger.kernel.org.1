Return-Path: <stable+bounces-37970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69289F3D0
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C3628E019
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05BE15E7F3;
	Wed, 10 Apr 2024 13:16:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8F15DBA5
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754961; cv=none; b=NwnTImL/m3lVatYl8Of7LjxKwaHjJX+Td0LzKc3DXZpAzZmjf6G7p7VEiYAVEWM1Kly6GN0sTuYxLUQah2z/8MeNsEEOkn43bp9bD88VpOXqze6Iiu4WqBX1siG8tPcpRZQWIF2mTNvw/+iV682Y/vJCJhpx01evLMz6xbJilh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754961; c=relaxed/simple;
	bh=K0pcdaISmbT9WYyMKJ5HYlXKvrLiV/2CNd4+YoFj5R4=;
	h=From:Date:Subject:To:Cc:Message-Id; b=AHxC/hrjjTPGL4xQGkFiiB3Ewt10+YlwYWfUig67UC2wtWnB1Dty5Z/1qpsNtI0XHrgTrXuVXNO5w/c4qDERxL32YRenqPrecToVxlab7wa0Kr8O67IZjHSZc9sX9Egg3oKtAGgN19OuDyRwZ+fXP2Xu4r4OgONj+ELBc/kQDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXnz-0001Fl-06;
	Wed, 10 Apr 2024 13:15:59 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: ov2740: Fix LINK_FREQ and PIXEL_RATE control value reporting
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>, Hans de Goede <hdegoede@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXnz-0001Fl-06@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov2740: Fix LINK_FREQ and PIXEL_RATE control value reporting
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Wed Mar 27 10:57:31 2024 +0200

The driver dug the supported link frequency up from the V4L2 fwnode
endpoint and used it internally, but failed to report this in the
LINK_FREQ and PIXEL_RATE controls. Fix this.

Fixes: 0677a2d9b735 ("media: ov2740: Add support for 180 MHz link frequency")
Cc: stable@vger.kernel.org # for v6.8 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov2740.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

---

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 552935ccb4a9..57906df7be4e 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -768,14 +768,15 @@ static int ov2740_init_controls(struct ov2740 *ov2740)
 	cur_mode = ov2740->cur_mode;
 	size = ARRAY_SIZE(link_freq_menu_items);
 
-	ov2740->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr, &ov2740_ctrl_ops,
-						   V4L2_CID_LINK_FREQ,
-						   size - 1, 0,
-						   link_freq_menu_items);
+	ov2740->link_freq =
+		v4l2_ctrl_new_int_menu(ctrl_hdlr, &ov2740_ctrl_ops,
+				       V4L2_CID_LINK_FREQ, size - 1,
+				       ov2740->supported_modes->link_freq_index,
+				       link_freq_menu_items);
 	if (ov2740->link_freq)
 		ov2740->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
-	pixel_rate = to_pixel_rate(OV2740_LINK_FREQ_360MHZ_INDEX);
+	pixel_rate = to_pixel_rate(ov2740->supported_modes->link_freq_index);
 	ov2740->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &ov2740_ctrl_ops,
 					       V4L2_CID_PIXEL_RATE, 0,
 					       pixel_rate, 1, pixel_rate);

