Return-Path: <stable+bounces-41682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B98B5746
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F6B207C2
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA453381;
	Mon, 29 Apr 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+B/XZEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B43524D9
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391995; cv=none; b=IJUH+UqOIyVnaupktuF8kYCaZc9Rcp0Amx64sJZo6Y4HaK6MnZMvMTegFlGwpzB5P1PwCs7sLIRWBwF8OgWSBp3kxGK97RJgSbhXEEiL3/lzbm/A2o4IuPHXPiuJrAqdmCXAv1CCfn+iRAeetiIRplcSEuSG/jDCVDeaBArueqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391995; c=relaxed/simple;
	bh=lmZ80jeR1IsX8SVEtaBo8VUHwHRwc+CgREn2KHjwHYs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o7+jWOGtFYfZyS/lCOR1xgYAKgWAFRGrdNmNWdauScYAYVuvuXOSJ+i7n7Yvb54Ypr7tvGoZHzHH1+hJbgCrLVzRdSp2m6kPBnrMTxqHH9PxhsLV1SGmpjJOHa9KO/9e/KWFLAHpdgYLFxNFah27PC5s/1ZyXFE1+EctZsokqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+B/XZEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A46C113CD;
	Mon, 29 Apr 2024 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714391995;
	bh=lmZ80jeR1IsX8SVEtaBo8VUHwHRwc+CgREn2KHjwHYs=;
	h=Subject:To:Cc:From:Date:From;
	b=o+B/XZEz6VPHr9xzsVH5RLYGpel3O/7Bs60RFQC7iDd3T3pzmQ7niNSvx7g0SqyjT
	 WKtbbyZITA0UPR3DfJGyaVqg/IZoXJLglu74nEruJwj3I9c9ng7UyLhXn6V6vWxXN2
	 ghU2VENLfRfGBcrNUwyQBrk9KVMooaImQNmMu+0A=
Subject: FAILED: patch "[PATCH] fbdev: fix incorrect address computation in deferred IO" failed to apply to 5.15-stable tree
To: namcao@linutronix.de,harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:59:51 +0200
Message-ID: <2024042951-barbell-aeration-a1ce@gregkh>
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
git cherry-pick -x 78d9161d2bcd442d93d917339297ffa057dbee8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042951-barbell-aeration-a1ce@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

78d9161d2bcd ("fbdev: fix incorrect address computation in deferred IO")
3ed3811283dd ("fbdev: Refactor implementation of page_mkwrite")
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

From 78d9161d2bcd442d93d917339297ffa057dbee8c Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Tue, 23 Apr 2024 13:50:53 +0200
Subject: [PATCH] fbdev: fix incorrect address computation in deferred IO

With deferred IO enabled, a page fault happens when data is written to the
framebuffer device. Then driver determines which page is being updated by
calculating the offset of the written virtual address within the virtual
memory area, and uses this offset to get the updated page within the
internal buffer. This page is later copied to hardware (thus the name
"deferred IO").

This offset calculation is only correct if the virtual memory area is
mapped to the beginning of the internal buffer. Otherwise this is wrong.
For example, if users do:
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);

Then the virtual memory area will mapped at offset 0xff000 within the
internal buffer. This offset 0xff000 is not accounted for, and wrong page
is updated.

Correct the calculation by using vmf->pgoff instead. With this change, the
variable "offset" will no longer hold the exact offset value, but it is
rounded down to multiples of PAGE_SIZE. But this is still correct, because
this variable is only used to calculate the page offset.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com
Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240423115053.4490-1-namcao@linutronix.de

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index dae96c9f61cf..806ecd32219b 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -196,7 +196,7 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
 {
-	unsigned long offset = vmf->address - vmf->vma->vm_start;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);


