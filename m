Return-Path: <stable+bounces-184149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2406BD205D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917BF3B0DE0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437012F28EE;
	Mon, 13 Oct 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hK73qCJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051B2D9EF9
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343825; cv=none; b=O+Rc6wgSvxcweWgWKMkjSg8/57N1n7s0AsoEK3pW/N5wp9eIGmcYgVFsLUOMzs9sZ3Q7ToetqObBkCr+SAgFtiLhx0wKhk78Kg7qIgpK4XPF6UBT9wAIou4GSSsNgU50ZdONq3St8TR/jf8bDk0EHq9ywHm1PZxuO2gHFzkGxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343825; c=relaxed/simple;
	bh=/cH/QXcicIc9gO1ifChA36np+1yBWZbv7DU6ajQGhrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ULgNpJjI5qpoNmllZBvNNUrkeqklhk+yxv/YhoOec30nj5ROYBpWEFZq3dESQmfNdczwjLcrr0RJKAT5T0JXXZoXyaKeV44dPD8EtTCgT0AIE6jgxFDFdAFh+Izq+YmZaZ5Yplpa4AUpAqsaE2XzGl0BtrRQLcnMPKewKfExen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hK73qCJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25916C4CEE7;
	Mon, 13 Oct 2025 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343824;
	bh=/cH/QXcicIc9gO1ifChA36np+1yBWZbv7DU6ajQGhrI=;
	h=Subject:To:Cc:From:Date:From;
	b=hK73qCJgRHXgup9RZ5rUdRMDfiSB2jF94klgjP6jgqFf7MKKIpIov68jHkYF7mEQx
	 Xn8iGp39ZiJm2XISDq2Lu/IGL6mImIFiQnh3JmtzvnRic7jO1VZF7OPHGZ/j93E/LO
	 occwqdhi1JkdmWVWFze4LC+t8FcMqTqNs9/Tu2ng=
Subject: FAILED: patch "[PATCH] media: mc: Clear minor number before put device" failed to apply to 6.6-stable tree
To: eadavis@qq.com,hverkuil+cisco@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:23:37 +0200
Message-ID: <2025101337-robust-deepness-48c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8cfc8cec1b4da88a47c243a11f384baefd092a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101337-robust-deepness-48c6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


