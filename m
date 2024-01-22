Return-Path: <stable+bounces-12760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DF837289
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28313289B99
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B43E497;
	Mon, 22 Jan 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvJMY1Yk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB13E486
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951734; cv=none; b=qQSLjjck/WjQyvdYNNJgcYgb43uAIEhHlxzcrl9P7c+Ay/LTganh2RbzPQOxAoTkdPqjhv/OGMFcaxswjCilr/ZuCGXW/hdLuZb/+akQDaepGSB+b3iAOXV+1nxscOPMIcRC4V3fP1XN9cquhi5hH0hf8vf180dGDHpSPFDUMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951734; c=relaxed/simple;
	bh=62ltRT8u5YzKInK13QUkbIGwFft20zjKr+XPZQcHLRs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ogrcT1K/1qorTVcXrlErdOfmSQmo/j5z82aPJRluDYSSQc8544wtoaGH13Xs3rNTTzBbHddLg543/2FzYoR3QfOx9lvr8qKLtbJeNHglNCB4ETvQAsmWED8+nTpFAUqE0OCADhg5YvvwLqgC5l4fsJjAMzh40f8Hb7qdVZ0Lpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvJMY1Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8BFC43390;
	Mon, 22 Jan 2024 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705951734;
	bh=62ltRT8u5YzKInK13QUkbIGwFft20zjKr+XPZQcHLRs=;
	h=Subject:To:Cc:From:Date:From;
	b=MvJMY1YkpyVNTGvK1StB19Ieyj/N0UEeKSz17Lj7Au+owNU/AC4c83TpBgJ+YeF6B
	 GFiI0R/FJDEdynt0Vbsnmy5mjnD1iIfdzoNp3MFCj1Dx7kJ7BXmGilm3S2QRTe51nA
	 1AmvKICUzjnH1cSQ6H1EJge4QKVUnIdAuwAxzDME=
Subject: FAILED: patch "[PATCH] fbdev: flush deferred IO before closing" failed to apply to 5.10-stable tree
To: namcao@linutronix.de,bigeasy@linutronix.de,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:28:48 -0800
Message-ID: <2024012248-ascension-spinach-9273@gregkh>
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
git cherry-pick -x 33cd6ea9c0673517cdb06ad5c915c6f22e9615fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012248-ascension-spinach-9273@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
0b78f8bcf495 ("Revert "fb_defio: Remove custom address_space_operations"")
ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
9622349ea1b6 ("drm/fb-helper: Rename dirty worker to damage worker")
a102172c7f81 ("drm/fb-helper: Call dirty helper after writing to fbdev")
222ec45f4c69 ("drm/fb_helper: Support framebuffers in I/O memory")
a85955568939 ("drm/gem: Store client buffer mappings as struct dma_buf_map")
a745fb1c26d3 ("drm/gem: Update internal GEM vmap/vunmap interfaces to use struct dma_buf_map")
49a3f51dfeee ("drm/gem: Use struct dma_buf_map in GEM vmap ops and convert GEM backends")
1fc90559fdd5 ("drm/etnaviv: Remove empty etnaviv_gem_prime_vunmap()")

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


