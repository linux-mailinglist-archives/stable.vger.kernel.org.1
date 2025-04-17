Return-Path: <stable+bounces-132940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B477A91889
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF3461203
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A722618F;
	Thu, 17 Apr 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/a+4aeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5B14900F
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884011; cv=none; b=q3sje2zAyWZMEM3n46goNBJRNUXvxQd5PaU/QQAVZj8vR7AgNv5v/gYRlTWu7DOgI52UQByRso7zLapNkbpVgHYQIlTNuRXi5WcAefiDqhR0HMbFvKH6xsC/6BQAbDOotEb8ZFKQyWhVEZyBIeaa63nURFLCJMQpmxpDpU3DL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884011; c=relaxed/simple;
	bh=d6+G0YpgMAIcsOP103h6vzqNqfDv1TJ/d8LUnyRoEB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RqD7QMC4lAK0ZUwX7gmieaCaeoh806NUpD+UQIvHXFeRwIR1zt+502GVDBB5IVCXJ/5UQkZVEEx4braDMWPErWy3GYzqvQOVtP1vvCuqcGh6KE+3XGbvd196U9AVJEmMz0IVvuThlAaihDCxuEldCG6CjCrDlGWHxHg4KBWjZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/a+4aeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1872C4CEE4;
	Thu, 17 Apr 2025 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884011;
	bh=d6+G0YpgMAIcsOP103h6vzqNqfDv1TJ/d8LUnyRoEB4=;
	h=Subject:To:Cc:From:Date:From;
	b=D/a+4aeWJVTs/8w17MYno3VjmrwZfLzw7bF7yR8iDcp8WLTwP8SAtfZtZZ8u6WVPD
	 VK55g7J3TdlxBYNZ5iXmJyoKPVO7MzYu2Hm6mw9nKb0yhaY7Jr5DJDVNa5v/vMRU9V
	 gariZcTGKUHSjDAEc/irQfaoLZqk6U0UXIGJu4tU=
Subject: FAILED: patch "[PATCH] media: vim2m: print device name after registering device" failed to apply to 5.4-stable tree
To: mattwmajewski@gmail.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:00:08 +0200
Message-ID: <2025041708-precook-music-f22d@gregkh>
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
git cherry-pick -x 143d75583f2427f3a97dba62413c4f0604867ebf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041708-precook-music-f22d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 143d75583f2427f3a97dba62413c4f0604867ebf Mon Sep 17 00:00:00 2001
From: Matthew Majewski <mattwmajewski@gmail.com>
Date: Wed, 19 Feb 2025 14:05:01 -0500
Subject: [PATCH] media: vim2m: print device name after registering device

Move the v4l2_info() call displaying the video device name after the
device is actually registered.

This fixes a bug where the driver was always displaying "/dev/video0"
since it was reading from the vfd before it was registered.

Fixes: cf7f34777a5b ("media: vim2m: Register video device after setting up internals")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 6c24dcf27eb0..0fe97e208c02 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1314,9 +1314,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1343,6 +1340,9 @@ static int vim2m_probe(struct platform_device *pdev)
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);


