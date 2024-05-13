Return-Path: <stable+bounces-43632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97478C41A5
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463D5B23F60
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC91527A6;
	Mon, 13 May 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scCUvrXh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1CF152525
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606236; cv=none; b=J/NA1W7/V2BwMt9I8kPiPnXasgZ6kGgYv9LTieqOtVhvt+VZG3kx5tmdi4lKM4ymjvvyr7kHNzJTtuQR2L2+VorOBgjER4IGZzhb8eT146wBmw3vKqCTCSTEut6tEDo27CfCfaicx2le9AsVSQUFRaHvqdaBWexZWPkZHkSbi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606236; c=relaxed/simple;
	bh=2JWcmM4EelCOypSGUfl06lCP0+n4FWT88mPl3FsbHhY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k2YrmCWhR9Af8pBcY2tzfD33+57rSiUnnSBVGtf98QibHhX5K2wSDRkuS/Qv8826GV9jpvpvaAfIOMuVYLZqVWFORlD6ThjimyZz3S/AjOu0ZRMinZX1tvPUarCJ/VoIP1/WT1tQwbHoqzgpyT2DQH8UdXJ2q3HEbwbBHjvf9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scCUvrXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847B5C32786;
	Mon, 13 May 2024 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606235;
	bh=2JWcmM4EelCOypSGUfl06lCP0+n4FWT88mPl3FsbHhY=;
	h=Subject:To:Cc:From:Date:From;
	b=scCUvrXhR1pST0/mXo3fs70YSCnai1EKEP1c/ujQPq38vtERyViKz/ZspAZaBGDrM
	 cf5yKQMkTFvRWa1d1O5BxdzUe38BzJWcGiA2wL0IRj8Vb6P6EaFTGl5LHBVjZUv6Uh
	 be6BfdepKzP1woibN62E4hB5Bc9oQ/6j9XFAgwQw=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Fix race between aio_cancel() and AIO" failed to apply to 5.4-stable tree
To: quic_wcheng@quicinc.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:17:06 +0200
Message-ID: <2024051305-stillness-skirmish-11b0@gregkh>
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
git cherry-pick -x 24729b307eefcd7c476065cd7351c1a018082c19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051305-stillness-skirmish-11b0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

24729b307eef ("usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete")
b566d38857fc ("usb: gadget: f_fs: use io_data->status consistently")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24729b307eefcd7c476065cd7351c1a018082c19 Mon Sep 17 00:00:00 2001
From: Wesley Cheng <quic_wcheng@quicinc.com>
Date: Mon, 8 Apr 2024 18:40:59 -0700
Subject: [PATCH] usb: gadget: f_fs: Fix race between aio_cancel() and AIO
 request complete

FFS based applications can utilize the aio_cancel() callback to dequeue
pending USB requests submitted to the UDC.  There is a scenario where the
FFS application issues an AIO cancel call, while the UDC is handling a
soft disconnect.  For a DWC3 based implementation, the callstack looks
like the following:

    DWC3 Gadget                               FFS Application
dwc3_gadget_soft_disconnect()              ...
  --> dwc3_stop_active_transfers()
    --> dwc3_gadget_giveback(-ESHUTDOWN)
      --> ffs_epfile_async_io_complete()   ffs_aio_cancel()
        --> usb_ep_free_request()            --> usb_ep_dequeue()

There is currently no locking implemented between the AIO completion
handler and AIO cancel, so the issue occurs if the completion routine is
running in parallel to an AIO cancel call coming from the FFS application.
As the completion call frees the USB request (io_data->req) the FFS
application is also referencing it for the usb_ep_dequeue() call.  This can
lead to accessing a stale/hanging pointer.

commit b566d38857fc ("usb: gadget: f_fs: use io_data->status consistently")
relocated the usb_ep_free_request() into ffs_epfile_async_io_complete().
However, in order to properly implement locking to mitigate this issue, the
spinlock can't be added to ffs_epfile_async_io_complete(), as
usb_ep_dequeue() (if successfully dequeuing a USB request) will call the
function driver's completion handler in the same context.  Hence, leading
into a deadlock.

Fix this issue by moving the usb_ep_free_request() back to
ffs_user_copy_worker(), and ensuring that it explicitly sets io_data->req
to NULL after freeing it within the ffs->eps_lock.  This resolves the race
condition above, as the ffs_aio_cancel() routine will not continue
attempting to dequeue a request that has already been freed, or the
ffs_user_copy_work() not freeing the USB request until the AIO cancel is
done referencing it.

This fix depends on
  commit b566d38857fc ("usb: gadget: f_fs: use io_data->status
  consistently")

Fixes: 2e4c7553cd6f ("usb: gadget: f_fs: add aio support")
Cc: stable <stable@kernel.org>	# b566d38857fc ("usb: gadget: f_fs: use io_data->status consistently")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240409014059.6740-1-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index f855f1fc8e5e..aa80c2a6b8e0 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -852,6 +852,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 						   work);
 	int ret = io_data->status;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
+	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
 		kthread_use_mm(io_data->mm);
@@ -864,6 +865,11 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd);
 
+	spin_lock_irqsave(&io_data->ffs->eps_lock, flags);
+	usb_ep_free_request(io_data->ep, io_data->req);
+	io_data->req = NULL;
+	spin_unlock_irqrestore(&io_data->ffs->eps_lock, flags);
+
 	if (io_data->read)
 		kfree(io_data->to_free);
 	ffs_free_buffer(io_data);
@@ -877,7 +883,6 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
 	struct ffs_data *ffs = io_data->ffs;
 
 	io_data->status = req->status ? req->status : req->actual;
-	usb_ep_free_request(_ep, req);
 
 	INIT_WORK(&io_data->work, ffs_user_copy_worker);
 	queue_work(ffs->io_completion_wq, &io_data->work);


