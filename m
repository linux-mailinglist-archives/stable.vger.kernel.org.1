Return-Path: <stable+bounces-185930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713FBE247B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3412B3535CE
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0B253B5C;
	Thu, 16 Oct 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XtTM1BpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB15257853
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605340; cv=none; b=OU7CrzV//e5q4fTpXggwJzLjJvck9kKJDVEefVUkRquqillyFbYG/MkdUtIQ1NFIqdxu0VZRBPb9TDsA4AaCenp6PI3nXQPbIb6VS6BfMqFaKKpHJiFEn4QQ5CZdZqKNM9pBNEg2X5l1kVhkizENjcK3YYB1BpXWW8AmpDhSXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605340; c=relaxed/simple;
	bh=Xd8k80ZPiwFs1DZ4vY7ZmMKQfmh2rEaYz2Bufr2h5/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WJ+rnqurAR8bpudbm/NsQ6m9cUpaQzbCuz+YV5JEdWfzkzFD8ysabLG7tjuAnffeEDjNxjhdMVgpmpJl4629nSPLJ8DsxG6/Wjc6WNOxHCfvSTq/e7vWaMHZqsWSDtHlqp6j0fu0RjICUWq+KfLecXyKdXdSSuJt7l0thgcfm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XtTM1BpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9EDC4CEF1;
	Thu, 16 Oct 2025 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605339;
	bh=Xd8k80ZPiwFs1DZ4vY7ZmMKQfmh2rEaYz2Bufr2h5/M=;
	h=Subject:To:Cc:From:Date:From;
	b=XtTM1BpAdzWwpTxgMAePpRCFmlt61p4T8FJ2ulNKCd5p9/H/lYFFd56JDGe5SB7mc
	 xhTJxu3zOXYs95y8MQjU9yqfiB9uo9d4m43sSyCumHQnbIG6w3tUm7ORANxadprnKp
	 KtShucQkRKPJdjYpBcgHykw7o5lpzV3jJhsPZ3jE=
Subject: FAILED: patch "[PATCH] media: lirc: Fix error handling in lirc_register()" failed to apply to 5.4-stable tree
To: make24@iscas.ac.cn,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:02:08 +0200
Message-ID: <2025101607-contend-gentleman-9ae0@gregkh>
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
git cherry-pick -x 4f4098c57e139ad972154077fb45c3e3141555dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-contend-gentleman-9ae0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f4098c57e139ad972154077fb45c3e3141555dd Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Fri, 18 Jul 2025 17:50:54 +0800
Subject: [PATCH] media: lirc: Fix error handling in lirc_register()

When cdev_device_add() failed, calling put_device() to explicitly
release dev->lirc_dev. Otherwise, it could cause the fault of the
reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a6ddd4fecbb0 ("media: lirc: remove last remnants of lirc kapi")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index a2257dc2f25d..7d4942925993 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -736,11 +736,11 @@ int lirc_register(struct rc_dev *dev)
 
 	cdev_init(&dev->lirc_cdev, &lirc_fops);
 
+	get_device(&dev->dev);
+
 	err = cdev_device_add(&dev->lirc_cdev, &dev->lirc_dev);
 	if (err)
-		goto out_ida;
-
-	get_device(&dev->dev);
+		goto out_put_device;
 
 	switch (dev->driver_type) {
 	case RC_DRIVER_SCANCODE:
@@ -764,7 +764,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }


