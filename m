Return-Path: <stable+bounces-172157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF32B2FD7B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C216ACFD
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C02DF711;
	Thu, 21 Aug 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBLKVVBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE742DF6FB
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787645; cv=none; b=nYZPu4FbVsaDxZe9ft1NXkOJPTIrqop4YTd/NWtiht3xrQ3t4zfFbyn7YCVDSfumUcw9HIVzFMm669iYpY/SyN5HLVXYtv3OR+d7+zfTgWWj0RIv6kLmzns0ozMkzoJh+EVEsmG0HZszuO3+MmUW/62i0JMeHnGSFMedBbrCK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787645; c=relaxed/simple;
	bh=3fCtqZig2kKYuFTO8cTvLwVx4U6mBQ9Vt4BvjSnXsX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bh52CTAC1jDkrrQsmlTVfBSEDr2crD4s28nm1QCKS+GLnO6xhr0vaHBtjZF7YczByEWkNnAYKsG7fTEl0UFIw9QQn+EwD1XBxOyZYtQed0GIEkLmsr4sCyOW98nPYO8EIoAspWMSB40jaf+GoOZzqTw0tvRRaXY3rxhhOJl5jXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBLKVVBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D5EC4CEEB;
	Thu, 21 Aug 2025 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755787645;
	bh=3fCtqZig2kKYuFTO8cTvLwVx4U6mBQ9Vt4BvjSnXsX4=;
	h=Subject:To:Cc:From:Date:From;
	b=kBLKVVBD4EoQTrWhuwl8lFe4/1RvJNPQ4YdJjP5i2ZA8Lp+EOUyfaG5YblZyElWn4
	 CgrSHUISbLa2fruS1tg2a+Y7UM9tUaTMQLwoTxzgqqTdMqfMCdp/3+LnIh9e/CIkc/
	 R0U5YRLh7LAjgNmne7pRgHhE4Xkohvx6ZljivQTg=
Subject: FAILED: patch "[PATCH] media: venus: venc: Clamp param smaller than 1fps and bigger" failed to apply to 5.4-stable tree
To: ribalda@chromium.org,bod@kernel.org,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:45:11 +0200
Message-ID: <2025082111-undesired-module-2392@gregkh>
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
git cherry-pick -x 417c01b92ec278a1118a05c6ad8a796eaa0c9c52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082111-undesired-module-2392@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 417c01b92ec278a1118a05c6ad8a796eaa0c9c52 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Jun 2025 15:29:15 +0000
Subject: [PATCH] media: venus: venc: Clamp param smaller than 1fps and bigger
 than 240

The driver uses "whole" fps in all its calculations (e.g. in
load_per_instance()). Those calculation expect an fps bigger than 1, and
not big enough to overflow.

Clamp the param if the user provides a value that will result in an invalid
fps.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/linux-media/f11653a7-bc49-48cd-9cdb-1659147453e4@xs4all.nl/T/#m91cd962ac942834654f94c92206e2f85ff7d97f0
Fixes: aaaa93eda64b ("[media] media: venus: venc: add video encoder files")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
[bod: Change "parm" to "param"]
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index c7f8e37dba9b..b9ccee870c3d 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -411,11 +411,10 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->timeperframe = *timeperframe;
 	inst->fps = fps;


