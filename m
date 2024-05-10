Return-Path: <stable+bounces-43525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2168C20C0
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEDE1C21EE9
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585815FA9E;
	Fri, 10 May 2024 09:20:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D614901F
	for <stable@vger.kernel.org>; Fri, 10 May 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332853; cv=none; b=oZWBpRp/ftcXh3AAxTsotiqKydC4DQZdccg+3T1qOb8j8WHokdX1Lm5OhJ5tJgTNdQ5QFwdg/AMRz8FqXeY8j1jzeTkbSr9ifuZPj4Jch8++WSlrn0weXiA4qQ8vY7N6nd/aBLcPKKFBFiVFps6sfEB97q9VxGxNeyhrRMyxIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332853; c=relaxed/simple;
	bh=15O9G0hnnVNYa+Z+k7dOkuVsEqMSJY1UXOF5E0DFcvc=;
	h=From:Date:Subject:To:Cc:Message-Id; b=pKCoFwcI41ePnLfzsjYBJjeRgwTCRjIGdI57WEgCZxr5ZhcERO65jjjMoqqvOZqNUe0rYUSpJDoNeJEwVbUBFoxnW6X9DDfQuAITBUXLdnnh2z1mv6GYRF93OZZPwVe8+7fqth4RR3RpU1U2p1aYlkz84AXsAwStSqn89hSWy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1s5MQt-0008JI-0N;
	Fri, 10 May 2024 09:20:51 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Fri, 10 May 2024 09:20:02 +0000
Subject: [git:media_stage/master] Revert "media: v4l2-ctrls: show all owned controls in log_status"
To: linuxtv-commits@linuxtv.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1s5MQt-0008JI-0N@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: Revert "media: v4l2-ctrls: show all owned controls in log_status"
Author:  Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:    Fri May 10 09:11:46 2024 +0200

This reverts commit 9801b5b28c6929139d6fceeee8d739cc67bb2739.

This patch introduced a potential deadlock scenario:

[Wed May  8 10:02:06 2024]  Possible unsafe locking scenario:

[Wed May  8 10:02:06 2024]        CPU0                    CPU1
[Wed May  8 10:02:06 2024]        ----                    ----
[Wed May  8 10:02:06 2024]   lock(vivid_ctrls:1620:(hdl_vid_cap)->_lock);
[Wed May  8 10:02:06 2024]                                lock(vivid_ctrls:1608:(hdl_user_vid)->_lock);
[Wed May  8 10:02:06 2024]                                lock(vivid_ctrls:1620:(hdl_vid_cap)->_lock);
[Wed May  8 10:02:06 2024]   lock(vivid_ctrls:1608:(hdl_user_vid)->_lock);

For now just revert.

Fixes: 9801b5b28c69 ("media: v4l2-ctrls: show all owned controls in log_status")
Cc: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

 drivers/media/v4l2-core/v4l2-ctrls-core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

---

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index c59dd691f79f..eeab6a5eb7ba 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -2507,8 +2507,7 @@ int v4l2_ctrl_handler_setup(struct v4l2_ctrl_handler *hdl)
 EXPORT_SYMBOL(v4l2_ctrl_handler_setup);
 
 /* Log the control name and value */
-static void log_ctrl(const struct v4l2_ctrl_handler *hdl,
-		     struct v4l2_ctrl *ctrl,
+static void log_ctrl(const struct v4l2_ctrl *ctrl,
 		     const char *prefix, const char *colon)
 {
 	if (ctrl->flags & (V4L2_CTRL_FLAG_DISABLED | V4L2_CTRL_FLAG_WRITE_ONLY))
@@ -2518,11 +2517,7 @@ static void log_ctrl(const struct v4l2_ctrl_handler *hdl,
 
 	pr_info("%s%s%s: ", prefix, colon, ctrl->name);
 
-	if (ctrl->handler != hdl)
-		v4l2_ctrl_lock(ctrl);
 	ctrl->type_ops->log(ctrl);
-	if (ctrl->handler != hdl)
-		v4l2_ctrl_unlock(ctrl);
 
 	if (ctrl->flags & (V4L2_CTRL_FLAG_INACTIVE |
 			   V4L2_CTRL_FLAG_GRABBED |
@@ -2541,7 +2536,7 @@ static void log_ctrl(const struct v4l2_ctrl_handler *hdl,
 void v4l2_ctrl_handler_log_status(struct v4l2_ctrl_handler *hdl,
 				  const char *prefix)
 {
-	struct v4l2_ctrl_ref *ref;
+	struct v4l2_ctrl *ctrl;
 	const char *colon = "";
 	int len;
 
@@ -2553,12 +2548,9 @@ void v4l2_ctrl_handler_log_status(struct v4l2_ctrl_handler *hdl,
 	if (len && prefix[len - 1] != ' ')
 		colon = ": ";
 	mutex_lock(hdl->lock);
-	list_for_each_entry(ref, &hdl->ctrl_refs, node) {
-		if (ref->from_other_dev ||
-		    (ref->ctrl->flags & V4L2_CTRL_FLAG_DISABLED))
-			continue;
-		log_ctrl(hdl, ref->ctrl, prefix, colon);
-	}
+	list_for_each_entry(ctrl, &hdl->ctrls, node)
+		if (!(ctrl->flags & V4L2_CTRL_FLAG_DISABLED))
+			log_ctrl(ctrl, prefix, colon);
 	mutex_unlock(hdl->lock);
 }
 EXPORT_SYMBOL(v4l2_ctrl_handler_log_status);

