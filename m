Return-Path: <stable+bounces-116747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF1A39B70
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844461895316
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9E23C8DC;
	Tue, 18 Feb 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoFk0Q9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDC239563
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879434; cv=none; b=YkbV/FzfcFfFIFaXxphAUhrXAUGnkOthKESTbVArIPhJwXuM/HIoQxon2oqNuXAq66unMBjpHLrWvUG8TKcadaUU10t5d3hPaVfqyjBYOFwsh1JXv3loUNeCOr7mhw3DR+ALfzTlP8xwGRbJAjmQHjwheDCYwqPQPd2nIYv9tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879434; c=relaxed/simple;
	bh=kQnm9bmoibOQL5eGodmBOLi7F/cz29HfAc3hZCJZ51A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HgeYbq/COJIwwk8iYsU28lC725U3KXvcGJqqUI6I/4jr6XriWSu0wGE/yAp7ctiZIiSmO4QSCd5Wld3mqQVg+GEH4GBdnGBDRHcYmIJ+b2RLRYB6Ry+DIitIq0FVXSaluPRkiC/c3N/JruInHKO+gSkPoCXuSjI4CChh6a59yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoFk0Q9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00E8C4CEE2;
	Tue, 18 Feb 2025 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739879434;
	bh=kQnm9bmoibOQL5eGodmBOLi7F/cz29HfAc3hZCJZ51A=;
	h=Subject:To:Cc:From:Date:From;
	b=xoFk0Q9xTQGJqEEEXz7vvTRtqOV4pe6BC1zbl5ijnYjfHHwO0lVRxsuyDuvHKXvJN
	 p3psW1tPbEDBJVT3gyDzQz/djXfTKScV/LOB9zQh4f++X1qtIZs399XYOaJ7scvH7e
	 BeoE++5af+htVQpiKLTTlbIcT5maSU5mmwfVHi8I=
Subject: FAILED: patch "[PATCH] usb: gadget: uvc: Fix unstarted kthread worker" failed to apply to 6.13-stable tree
To: frederic@kernel.org,gregkh@linuxfoundation.org,m.grzeschik@pengutronix.de,oliver.sang@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:50:31 +0100
Message-ID: <2025021831-mushiness-herbs-d06c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x e5644be4079750a0a0a5a7068fd90b97bf6fac55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021831-mushiness-herbs-d06c@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5644be4079750a0a0a5a7068fd90b97bf6fac55 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 12 Feb 2025 14:55:14 +0100
Subject: [PATCH] usb: gadget: uvc: Fix unstarted kthread worker

The behaviour of kthread_create_worker() was recently changed to align
with the one of kthread_create(). The kthread worker is created but not
awaken by default. This is to allow the use of kthread_affine_preferred()
and kthread_bind[_mask]() with kthread workers. In order to keep the
old behaviour and wake the kthread up, kthread_run_worker() must be
used. All the pre-existing users have been converted, except for UVC
that was introduced in the same merge window as the API change.

This results in hangs:

	INFO: task UVCG:82 blocked for more than 491 seconds.
	Tainted: G                T  6.13.0-rc2-00014-gb04e317b5226 #1
	task:UVCG            state:D stack:0     pid:82
	 Call Trace:
	 __schedule
	 schedule
	 schedule_preempt_disabled
	 kthread
	 ? kthread_flush_work
	 ret_from_fork
	 ret_from_fork_asm
	 entry_INT80_32

Fix this with converting UVCG kworker to the new API.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502121025.55bfa801-lkp@intel.com
Fixes: f0bbfbd16b3b ("usb: gadget: uvc: rework to enqueue in pump worker from encoded queue")
Cc: stable <stable@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20250212135514.30539-1-frederic@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 79e223713d8b..fb77b0b21790 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -818,7 +818,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 		return -EINVAL;
 
 	/* Allocate a kthread for asynchronous hw submit handler. */
-	video->kworker = kthread_create_worker(0, "UVCG");
+	video->kworker = kthread_run_worker(0, "UVCG");
 	if (IS_ERR(video->kworker)) {
 		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
 		return PTR_ERR(video->kworker);


