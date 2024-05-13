Return-Path: <stable+bounces-43629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D58C419D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18C91C22D3C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD201514E2;
	Mon, 13 May 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nW0/8gDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBD59164
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606225; cv=none; b=PTgGShHeZTuyH4wJRretUvZMA/GzzSjViIkROXVKEN8E4KXNuN8jMuY6MrZ173KBhrN8FI4U98r/jfhzUTxVSQgO5RUUiF4xue0gE6VoaTjtZtQDo7l3VOOrhXbqTg+U3RDzl4py1Ch41Kyul0dZv66ZCnViHt9IUu+68Eda8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606225; c=relaxed/simple;
	bh=wbcW+qUR+9v8sNd6lGPtEJzs4h9vntceDwvKG4mCxQY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZwhZ2w/c2VJVxmefh1KA/cyv0qAFDb3Gg50NY9VLsrg7ajBZI3NxKO4xDcZIWc18b2ErXDN9y38s7BWpiYxGT4Pf8G5t65EK+SoS8nBMlUO5bq5vtOVw4OTMXeCzEOcOjj4jtrhXI3+9CVrzWK/uoIU+2kmSFHoYleL5BmrTHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nW0/8gDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9074C113CC;
	Mon, 13 May 2024 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606225;
	bh=wbcW+qUR+9v8sNd6lGPtEJzs4h9vntceDwvKG4mCxQY=;
	h=Subject:To:Cc:From:Date:From;
	b=nW0/8gDqJtiZoq2J31y467wi4c2RFQwnNlPmgC33CwQcZ6Zl+3a2JxbEiO0ZCnJgv
	 rBPQkN0z1WUOVpvIwjtkg37NcMP9nx24JnmIHdYnlLN4dgRKkQZMZ095bAhigqqPQW
	 uf3cV6+KQ1gFa7/GhLGcv7GlX6sr9jln/2f0V8SQ=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Fix race between aio_cancel() and AIO" failed to apply to 6.1-stable tree
To: quic_wcheng@quicinc.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:17:02 +0200
Message-ID: <2024051302-basin-buffed-b0cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 24729b307eefcd7c476065cd7351c1a018082c19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051302-basin-buffed-b0cd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


