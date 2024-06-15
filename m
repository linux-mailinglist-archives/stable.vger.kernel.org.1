Return-Path: <stable+bounces-52268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F990973C
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344352849F8
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950722F19;
	Sat, 15 Jun 2024 09:28:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8241BC40
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443703; cv=none; b=DwZJSTHCkCQh4XxB1N7r0mTNQ83WtPaME9/T6EfvXGw8kHTo3mE9ZFvDD5rAnMwVXYTVS4baOP1OkBxt7RT72nm5WOVEZyQbFyZXFxqTkrJhIKOKA3UL9Nko1awDTSu24mKcKMaUMdgDEHvrEV21NbhNznjTGxJlezhPKCaPRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443703; c=relaxed/simple;
	bh=grOGKGkw+/uNK+7uWdF4SP1sNs8MdHIo22dvOhfEqXg=;
	h=From:Date:Subject:To:Cc:Message-Id; b=TkWe/NjSGaMxJ7Y7QW0fw/RpKK0DCSTPqKvtFtxdR0dRmogGrrCUZMeGtrllgQ/iq2RF8kiLQrtRcpvGNgk9xUM3ekdIyOhpP5FBrXwWx/yrwUTbGZ5tHD+McraBI9L0dBVmRagkoH4l+45QeVu4Hl4rZK3OJco1/BXKP2n4lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sIPYV-0005jy-18;
	Sat, 15 Jun 2024 09:18:39 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sat, 15 Jun 2024 09:16:39 +0000
Subject: [git:media_stage/master] media: i2c: alvium: Move V4L2_CID_GAIN to V4L2_CID_ANALOG_GAIN
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Tommaso Merciai <tomm.merciai@gmail.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sIPYV-0005jy-18@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: alvium: Move V4L2_CID_GAIN to V4L2_CID_ANALOG_GAIN
Author:  Tommaso Merciai <tomm.merciai@gmail.com>
Date:    Mon Jun 10 10:10:34 2024 +0200

Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.

Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
Cc: stable@vger.kernel.org
Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/alvium-csi2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

---

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index c27c6fcaede4..5ddfd3dcb188 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1998,7 +1998,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	int val;
 
 	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
+	case V4L2_CID_ANALOGUE_GAIN:
 		val = alvium_get_gain(alvium);
 		if (val < 0)
 			return val;
@@ -2030,7 +2030,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
 		return 0;
 
 	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
+	case V4L2_CID_ANALOGUE_GAIN:
 		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
 		break;
 	case V4L2_CID_AUTOGAIN:
@@ -2159,7 +2159,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 
 	if (alvium->avail_ft.gain) {
 		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
-						V4L2_CID_GAIN,
+						V4L2_CID_ANALOGUE_GAIN,
 						alvium->min_gain,
 						alvium->max_gain,
 						alvium->inc_gain,

