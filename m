Return-Path: <stable+bounces-172119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E53B2FAFA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9732C5E2CF8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CD341AD6;
	Thu, 21 Aug 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d89nd5lc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779B34166E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783366; cv=none; b=lfIoB7EDg0PUW/KCKepS8pQenFoQXbopMFAMDPfDybYtSQLnyeOWGPYZ1EZYQghBX1NmnyekMrXYkT+ySMhIXviwJJEjq+bNjUycK1ggVyOQogKwoQHRtpwpT6BdjzBN4WlWVlwpM7Eze0JHqZflFlI6VVSciZJTq7zza8h6vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783366; c=relaxed/simple;
	bh=CaiZ8wKS0Drh9ST8HlDnM7LLAUMs1Idjo54GDH3VobE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=unmMkUIyTDRksMwfqahItt/CCaqdEqQI87Bgag2tE4wMpEoSPEpZQkdd2XR1Llt7MvwCPZ3CyTDEqnnk568Du9fMvCS7CuG4V7pO9CR8yVKWCmrjiZcsOnNV3KR2pyqlLnR20j45h/cfeCjcdRr/l7NUd0/yRHGBYaT2D8U6plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d89nd5lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09763C4CEED;
	Thu, 21 Aug 2025 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783365;
	bh=CaiZ8wKS0Drh9ST8HlDnM7LLAUMs1Idjo54GDH3VobE=;
	h=Subject:To:Cc:From:Date:From;
	b=d89nd5lcYpXVD/k+updXp801B3cmTdHpgq5uGrNntZ97f7L0Fp3kZ0DI1PqBV0FkW
	 H6rUPRhZqWmZrWytw5fY2ToVXOlrBcQOV+d8vj5UOm2gm9FfrQUtOJDVQXsqo6Mn6K
	 YkrSQbE5mixz0ohl+6cYNiEjB7HrpZ5NTtx2FuxQ=
Subject: FAILED: patch "[PATCH] media: v4l2-ctrls: Don't reset handler's error in" failed to apply to 5.4-stable tree
To: sakari.ailus@linux.intel.com,hverkuil@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:35:54 +0200
Message-ID: <2025082154-botany-sandstone-7eeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5a0400aca5fa7c6b8ba456c311a460e733571c88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082154-botany-sandstone-7eeb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a0400aca5fa7c6b8ba456c311a460e733571c88 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Thu, 8 May 2025 18:55:38 +0300
Subject: [PATCH] media: v4l2-ctrls: Don't reset handler's error in
 v4l2_ctrl_handler_free()

It's a common pattern in drivers to free the control handler's resources
and then return the handler's error code on drivers' error handling paths.
Alas, the v4l2_ctrl_handler_free() function also zeroes the error field,
effectively indicating successful return to the caller.

There's no apparent need to touch the error field while releasing the
control handler's resources and cleaning up stale pointers. Not touching
the handler's error field is a more certain way to address this problem
than changing all the users, in which case the pattern would be likely to
re-emerge in new drivers.

Do just that, don't touch the control handler's error field in
v4l2_ctrl_handler_free().

Fixes: 0996517cf8ea ("V4L/DVB: v4l2: Add new control handling framework")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index b45809a82f9a..d28596c720d8 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1661,7 +1661,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }


