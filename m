Return-Path: <stable+bounces-66042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAE94BE68
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540A41C256E9
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888D18E021;
	Thu,  8 Aug 2024 13:16:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993818E02D
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123012; cv=none; b=XdQphBsJchmj9eUbHHFJ7vc9xrkyCt77sUjynn4JgxgCpRkKHzdioZfxs1wNoa7axgqaEgmELG7a7kPwJmjacfxYezIzewM8qCxuyQfsFzbpWYvXHzBM/JJFxV7KRnjnzbXO2oBYVj603TUo4ibQj0EaT3BQn0xh0pVPo23UCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123012; c=relaxed/simple;
	bh=wjiqXfL628YyWNlEKkvz++JNzMtDbSqcg+R3HwVEMVk=;
	h=From:Date:Subject:To:Cc:Message-Id; b=nukGD+SJnjzFQHSXIzR8E3AU3ki9HfhNGnbkFSTaoqJoOZl7DVlPPd3fB1XTzYGaj76zYnHh+GbYdbfvUnOSisH2sJtkAC+AHXIYh3OXjGgVmVqmrxfE0YO3aNjc2gxvs6jpDNz6uyYehEN0ol90Po8fB78pMkE9V3+8HIkCTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sc30b-0003OE-0R;
	Thu, 08 Aug 2024 13:16:49 +0000
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Jul 2024 12:22:20 +0000
Subject: [git:media_tree/master] media: uvcvideo: Fix custom control mapping probing
To: linuxtv-commits@linuxtv.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sc30b-0003OE-0R@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: uvcvideo: Fix custom control mapping probing
Author:  Ricardo Ribalda <ribalda@chromium.org>
Date:    Mon Jul 22 11:52:26 2024 +0000

Custom control mapping introduced a bug, where the filter function was
applied to every single control.

Fix it so it is only applied to the matching controls.

The following dmesg errors during probe are now fixed:

usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
usb 1-5: Failed to query (GET_CUR) UVC control 2 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 3 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 6 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 7 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 8 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 9 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 10 on unit 2: -75 (exp. 1).

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-media/518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de/T/#t
Cc: stable@vger.kernel.org
Fixes: 8f4362a8d42b ("media: uvcvideo: Allow custom control mapping")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20240722-fix-filter-mapping-v2-1-7ed5bb6c1185@chromium.org
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

 drivers/media/usb/uvc/uvc_ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

---

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0136df5732ba..4fe26e82e3d1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2680,6 +2680,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); ++i) {
 		const struct uvc_control_mapping *mapping = &uvc_ctrl_mappings[i];
 
+		if (!uvc_entity_match_guid(ctrl->entity, mapping->entity) ||
+		    ctrl->info.selector != mapping->selector)
+			continue;
+
 		/* Let the device provide a custom mapping. */
 		if (mapping->filter_mapping) {
 			mapping = mapping->filter_mapping(chain, ctrl);
@@ -2687,9 +2691,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 				continue;
 		}
 
-		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
-		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+		__uvc_ctrl_add_mapping(chain, ctrl, mapping);
 	}
 }
 

