Return-Path: <stable+bounces-184152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E6BD2078
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3C574EEAA8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082652F2902;
	Mon, 13 Oct 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RceQyvSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80F2F28F6
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343835; cv=none; b=J4O6YxsRIDSOvGKSPZOeE3LfPaWstiBNZ2JmtVOlxxsEiqQSoVAp8PZEs4EnZfDq+Wp51ZCByK1WCoIdj7dk1OTdyGyGY27oFiidHdGc42gK70lTwQKSEr9ReC8771P+7vOvMAj4dM/vR9S5k7MD/3uYNXuia2h4eCaWF40rl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343835; c=relaxed/simple;
	bh=pUIlbihDoDefkR0iM8DncQQHnnwQL/uvsen+dAtzvlA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pC0eJbuBBIN5U2X06h2SchcFpwGhuLTzLpclX1EIWl3YOyaSseL0DmjKU1XbmMZ4YB/+XUb1BG3ukW2DvpCLhrseQ/5tP43I7YNyLgIC9EfJw5U2nZk+fxiW3Cz3nLIi80vvMP384//Z932eooDvGmjBb/5KAy2npHGQK73b2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RceQyvSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70EC4CEE7;
	Mon, 13 Oct 2025 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343835;
	bh=pUIlbihDoDefkR0iM8DncQQHnnwQL/uvsen+dAtzvlA=;
	h=Subject:To:Cc:From:Date:From;
	b=RceQyvSye/PHV7nettSDK8Z1TwuXHScugYd7nT5vL2rPi0Rv/Fglyj6N2zIYBiGoM
	 sXu2wbTJKXoft6p7eUBTmASv9dqReUsu/C5gTztguEgN5OozTePUrcNyt0gXVxQ9y2
	 W2Utr3Hw/H9WIhbjlKCvydMyck8K2MEGfoe/MtFQ=
Subject: FAILED: patch "[PATCH] media: mc: Clear minor number before put device" failed to apply to 5.10-stable tree
To: eadavis@qq.com,hverkuil+cisco@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:23:39 +0200
Message-ID: <2025101339-polygraph-crept-0130@gregkh>
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
git cherry-pick -x 8cfc8cec1b4da88a47c243a11f384baefd092a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101339-polygraph-crept-0130@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


