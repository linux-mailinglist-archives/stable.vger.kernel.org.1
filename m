Return-Path: <stable+bounces-128898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED27A7FB3F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F86A3A6F09
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3F227EBD;
	Tue,  8 Apr 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJ+KJLzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CC3C0C
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106889; cv=none; b=lQF9Up/FGr+Sp0hEl62R+mGF7bPFHofM8GtDLHsmJpyW2BBnzvGZrJlPH+1n9eDC5am+FPMPbepQPKzt5vrWmSSJ6dGIo9ph+VU6wDftfN/0fXsXJwhGSQ5p2wSLY1M5PFEAtwQ2j0XMFPkW6QgzQn3TTmdZvvGpS0u+kzS2gCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106889; c=relaxed/simple;
	bh=wEOu0Z79vF6qJF4MPSKMRfRKy6KFLD+PXcU0yl8r+rw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R6KDfs4xEe+RfEF7YaRkg48v06S0YcNgQGtO81a5VdzI2CVQSQQXx8kMy/1SSJO4a3yODbpZiMg6VhlTxWreTOUXwabzwi3GpZtPlhEl86BZh0xXp4K4Sr94pxgqSk7EJiAOYXlEm6xR/xbBh5gb1TRlPi4sco2N6LzJ74vojsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJ+KJLzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB2FC4CEEA;
	Tue,  8 Apr 2025 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106889;
	bh=wEOu0Z79vF6qJF4MPSKMRfRKy6KFLD+PXcU0yl8r+rw=;
	h=Subject:To:Cc:From:Date:From;
	b=TJ+KJLzILbHFMHxRgdcbPKCdTfMZgApLYSec1WgPI+Hv6jOOfuBRKNmVXCLUR7p04
	 8QAZp8tIESlaXuqQfVe03VDCh31Re1E7CIw9mGeTe0IompQ+fK9iDFFTCaOdxQ57BC
	 gJNyl7fcBCtpbLApcIeMg9w1qNRewF+aD8t7QvWU=
Subject: FAILED: patch "[PATCH] media: streamzap: fix race between device disconnection and" failed to apply to 5.4-stable tree
To: m.masimov@mt-integration.ru,hverkuil@xs4all.nl,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:06:26 +0200
Message-ID: <2025040826-roving-harmony-dcd6@gregkh>
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
git cherry-pick -x f656cfbc7a293a039d6a0c7100e1c846845148c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040826-roving-harmony-dcd6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f656cfbc7a293a039d6a0c7100e1c846845148c1 Mon Sep 17 00:00:00 2001
From: Murad Masimov <m.masimov@mt-integration.ru>
Date: Mon, 13 Jan 2025 13:51:30 +0300
Subject: [PATCH] media: streamzap: fix race between device disconnection and
 urb callback

Syzkaller has reported a general protection fault at function
ir_raw_event_store_with_filter(). This crash is caused by a NULL pointer
dereference of dev->raw pointer, even though it is checked for NULL in
the same function, which means there is a race condition. It occurs due
to the incorrect order of actions in the streamzap_disconnect() function:
rc_unregister_device() is called before usb_kill_urb(). The dev->raw
pointer is freed and set to NULL in rc_unregister_device(), and only
after that usb_kill_urb() waits for in-progress requests to finish.

If rc_unregister_device() is called while streamzap_callback() handler is
not finished, this can lead to accessing freed resources. Thus
rc_unregister_device() should be called after usb_kill_urb().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8e9e60640067 ("V4L/DVB: staging/lirc: port lirc_streamzap to ir-core")
Cc: stable@vger.kernel.org
Reported-by: syzbot+34008406ee9a31b13c73@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 9b209e687f25..2ce62fe5d60f 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -385,8 +385,8 @@ static void streamzap_disconnect(struct usb_interface *interface)
 	if (!sz)
 		return;
 
-	rc_unregister_device(sz->rdev);
 	usb_kill_urb(sz->urb_in);
+	rc_unregister_device(sz->rdev);
 	usb_free_urb(sz->urb_in);
 	usb_free_coherent(usbdev, sz->buf_in_len, sz->buf_in, sz->dma_in);
 


