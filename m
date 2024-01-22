Return-Path: <stable+bounces-12759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AC8372D6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C51B23959
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0FF3DBB7;
	Mon, 22 Jan 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHG7ET5C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2C3D553
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951730; cv=none; b=Q7oXODi4b2ZAKAuRMQfDL0wxElDIfACtzgD6f6R5bXaf6MML+onCpFTy3wt6vpiCjM8W4bt5YOZNVeOjKbEBRgkQoA7UNdeCf+OdJHZEXVXmBWQ8aVpairLk/LGPL+a4lqfATvE58el+BU6HtvpxYncXIcRGyUWQ8Ldk7vAyKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951730; c=relaxed/simple;
	bh=6JPqKDkvDl/mijpvTG6BUrgTgGIF6wr3FgMoOU+NO10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lA1Nwbl7Vf1wBT7Hb05BTcBCOKBGUeXUwnMtJTSecn5tEQilivvTvwf2Ua+mktyWkUB0bXQKdGL3nJzDv8nIVdS3fJ8G5iRf2EnLRb94Wyq9etRxobNaQwzX1drk5geGv+G8qkw0Hu+xUoApfjQj3ntrRTBFcsX+HH7snXKizhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHG7ET5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B421C433F1;
	Mon, 22 Jan 2024 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705951729;
	bh=6JPqKDkvDl/mijpvTG6BUrgTgGIF6wr3FgMoOU+NO10=;
	h=Subject:To:Cc:From:Date:From;
	b=KHG7ET5CRtuf735xU4uI17nz6WGZEzwHmkDMWhpBQoDv4wwt/I5X8pz0+dvMrUYaD
	 Z5gRG2o89lHPurma+dTuv35IIVHSL1y5LBuhYxP3oiFjndnUt99pG8NZ+0s9JSmWbM
	 jwd/5mEhgM2HHOVV3HBFrIL0/dXHqLOXvtjC66bo=
Subject: FAILED: patch "[PATCH] fbdev: flush deferred IO before closing" failed to apply to 5.15-stable tree
To: namcao@linutronix.de,bigeasy@linutronix.de,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:28:46 -0800
Message-ID: <2024012246-snowdrop-antelope-7598@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 33cd6ea9c0673517cdb06ad5c915c6f22e9615fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012246-snowdrop-antelope-7598@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

33cd6ea9c067 ("fbdev: flush deferred IO before closing")
fe9ae05cfbe5 ("fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()")
3efc61d95259 ("fbdev: Fix invalid page access after closing deferred I/O devices")
e80eec1b871a ("fbdev: Rename pagelist to pagereflist for deferred I/O")
56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
856082f021a2 ("fbdev: defio: fix the pagelist corruption")
8c30e2d81bfd ("fbdev: Don't sort deferred-I/O pages by default")
105a940416fc ("fbdev/defio: Early-out if page is already enlisted")
67b723f5b742 ("drm/fb-helper: Calculate damaged area in separate helper")
aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")
a3c286dcef7f ("drm/fb-helper: Fix clip rectangle height")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33cd6ea9c0673517cdb06ad5c915c6f22e9615fc Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Mon, 18 Dec 2023 10:57:31 +0100
Subject: [PATCH] fbdev: flush deferred IO before closing

When framebuffer gets closed, the queued deferred IO gets cancelled. This
can cause some last display data to vanish. This is problematic for users
who send a still image to the framebuffer, then close the file: the image
may never appear.

To ensure none of display data get lost, flush the queued deferred IO
first before closing.

Another possible solution is to delete the cancel_delayed_work_sync()
instead. The difference is that the display may appear some time after
closing. However, the clearing of page mapping after this needs to be
removed too, because the page mapping is used by the deferred work. It is
not completely obvious whether it is okay to not clear the page mapping.
For a patch intended for stable trees, go with the simple and obvious
solution.

Fixes: 60b59beafba8 ("fbdev: mm: Deferred IO support")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 6c8b81c452f0..1ae1d35a5942 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -313,7 +313,7 @@ static void fb_deferred_io_lastclose(struct fb_info *info)
 	struct page *page;
 	int i;
 
-	cancel_delayed_work_sync(&info->deferred_work);
+	flush_delayed_work(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
 	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {


