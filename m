Return-Path: <stable+bounces-184147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE12BD206C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE8FB4EE628
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367C42F2902;
	Mon, 13 Oct 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbFXrNCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8442EC0B7
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343819; cv=none; b=TipJhwC28ICs0seQj/6fxjIcypjE8uXdtUH0NQ3zYTEzvu6sR9wvf91pKCVOzOUJW/rhcBBySpxuQSL1P8FQT0/IfBfbYVZ7iCuLVl9AZ9gP/A+E8b8RXIxykzEQIPyVx9A7kS7syIt1nZVJcOJP2IYaOowVIEE+6Eb5z87O5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343819; c=relaxed/simple;
	bh=Ws5p1fAR6aCmkr3XR3fLfO27JblGjT4wsqGK44b6DXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JviSBmdJb0lDxSt0DailgqlnNu2XPDVj+TnWK1JwWLhvzYDp8zDpPPMOKNTvsrkSq5xJ0Ql1UBpvLLYN0aOu6UgKCWo7Vd3GyFPXesPD0mezxupjXpBqBW7udpCTkPXzzfAMHug+GT1wMscRnNtDRQlg7GKqYJPYVWpmOZ/HkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbFXrNCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C3CC4CEE7;
	Mon, 13 Oct 2025 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343818;
	bh=Ws5p1fAR6aCmkr3XR3fLfO27JblGjT4wsqGK44b6DXk=;
	h=Subject:To:Cc:From:Date:From;
	b=MbFXrNCwdfP15/N3Vnr3amsdcjresn8i4i5nCz0jTWdeHp/fYvXGv9Z/OiSLT2j0h
	 rPIA8MvK3CdL2hJC7JjNzms77Er2MpWxtZqKuOGv0TfGCipAzXsJK/4h1h29XAPqRL
	 jfXJFTk4ZepaHaHRxJ4sYszBJRxapOD27Y9r5x5w=
Subject: FAILED: patch "[PATCH] media: mc: Clear minor number before put device" failed to apply to 6.17-stable tree
To: eadavis@qq.com,hverkuil+cisco@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:23:35 +0200
Message-ID: <2025101335-script-feeble-03de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 8cfc8cec1b4da88a47c243a11f384baefd092a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101335-script-feeble-03de@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cfc8cec1b4da88a47c243a11f384baefd092a50 Mon Sep 17 00:00:00 2001
From: Edward Adam Davis <eadavis@qq.com>
Date: Wed, 10 Sep 2025 09:15:27 +0800
Subject: [PATCH] media: mc: Clear minor number before put device

The device minor should not be cleared after the device is released.

Fixes: 9e14868dc952 ("media: mc: Clear minor number reservation at unregistration time")
Cc: stable@vger.kernel.org
Reported-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=031d0cfd7c362817963f
Tested-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 0d01cbae98f2..6daa7aa99442 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -276,13 +276,10 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
-
-	mutex_lock(&media_devnode_lock);
-	clear_bit(devnode->minor, media_devnode_nums);
-	mutex_unlock(&media_devnode_lock);
 }
 
 /*


