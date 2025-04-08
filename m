Return-Path: <stable+bounces-128896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7CFA7FB3D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BCD3A6227
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D6261593;
	Tue,  8 Apr 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbkdhXdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA4215066
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106878; cv=none; b=eT0hAYYSz0e0oLrgPB0OlBRACTa8tyYhSc88XgHM7d+YL9nbihGMU/EfE+9yrm5iNKvxy1sgB31sY9JuQwYaxKwj4NyBiacinGM/I7MQO1VvOTmmtmBjXCO7N7TS33kS+GfxzZc0Q209dPgfiDttyLdKD+xCVdCZDb38iEwOaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106878; c=relaxed/simple;
	bh=mMhDGJi8mtRBEnXdeDZiG+z1KdyJIRrHt6PoObzOE1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hThs/CFCNGRVCre4XXkgrSI8QksLRpmQVAIrColXd/Ueyy3Q9JFxoMQpcaslJlS0Pfogt+qfDdl5LK5kAekSPbnm1vvetCvgSnIOrTXTnI1OcU6YAKJWsTvMoGZtFLVe+cFwgW9T9D3c8fHHq8kCSWihxbczFzBCuFLctxecubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbkdhXdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD74DC4CEE5;
	Tue,  8 Apr 2025 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106878;
	bh=mMhDGJi8mtRBEnXdeDZiG+z1KdyJIRrHt6PoObzOE1U=;
	h=Subject:To:Cc:From:Date:From;
	b=VbkdhXdW/uS2dqWaom6sDIMKEnBsOQg42jRBaIC87cUL80/fmWYSTdDKGOZTiCY6n
	 yJgVtYr72MHufMslRYQqj6xw9b0DS6HSmvzJteRIoSjU0ugeoD2Rj8nVmq1w3iJlCV
	 37ZZaTbAMrYeEuOT4b9uiuDpfjC4lemngNp3xw98=
Subject: FAILED: patch "[PATCH] media: streamzap: fix race between device disconnection and" failed to apply to 5.15-stable tree
To: m.masimov@mt-integration.ru,hverkuil@xs4all.nl,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:06:25 +0200
Message-ID: <2025040825-taunt-stencil-d364@gregkh>
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
git cherry-pick -x f656cfbc7a293a039d6a0c7100e1c846845148c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040825-taunt-stencil-d364@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


