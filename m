Return-Path: <stable+bounces-172118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3FCB2FAF1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380D718838F2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D6341AB5;
	Thu, 21 Aug 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwHRnJ9L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C79341AAB
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783357; cv=none; b=eoKvuy0LLPe/G0PAjxOwECOq/gvSxOvOk9UY3jtlr0Uz88AAyExMSCvWNfsvaHgIAYJcxRLT95/DE3BeKx2PsFzmXEgn6giv/k08tLSMCbqp4BqzF7ula41bCyp8HjuaOWQ6OrECSN5fpvKKHO5xAjUCYBQ8P4xln6EEYqBEnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783357; c=relaxed/simple;
	bh=VxnjW3wUMm4KZqP+504H2V+g4YzoSTS/xGdayg0dmBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pbNOZr3atV/TkbVQckH1U5kMBkxcTvLhLsSCYiGX8DUW2WCtxMxikq+HGlllq7Tl6lBZYbPe/BfheJCXqKrFHJxnqRKq37QcRFxr4igLhrlkwYC6Xt5VBq8ht8u4df8NAA31LH86G8TaLajzT13y4T6tY61EqRWvFSwTH2BuW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwHRnJ9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C33C116C6;
	Thu, 21 Aug 2025 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783356;
	bh=VxnjW3wUMm4KZqP+504H2V+g4YzoSTS/xGdayg0dmBc=;
	h=Subject:To:Cc:From:Date:From;
	b=JwHRnJ9LbOSC9PbdRjYocLqf2ug0nWISefqdOe19+vQ+3SJdFRavMKubr0E5TRxRm
	 uNmOdEfyDaCisOfZpk9Kr5NftT+jEeyjkYzzJSmSPHRDpkBqyAqgUPZrh5C7eOBSEf
	 e8PtEnBfimCJUQ0sIYVtCQU24CyxSL+lwcnZXHtE=
Subject: FAILED: patch "[PATCH] media: v4l2-ctrls: Don't reset handler's error in" failed to apply to 5.10-stable tree
To: sakari.ailus@linux.intel.com,hverkuil@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:35:53 +0200
Message-ID: <2025082153-curliness-sitting-639b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5a0400aca5fa7c6b8ba456c311a460e733571c88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082153-curliness-sitting-639b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


