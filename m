Return-Path: <stable+bounces-184153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814ABD2063
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B513BF0BF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D92EB5C9;
	Mon, 13 Oct 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtfRP6Bi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101E2D9EF9
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343838; cv=none; b=blyOCJ48xL1aTkzNmQQj23ODImfVCW7nG1aq8c2QGGWxkL8SAHRm2GRqAqapGrgUz4dlAFICWmEFnIhhYaPke6BWgQcfPsAlVpvrpWA5bkQ/bjDW7XWmyMutwTk3rm9LxYAPgGblxZ24SpUHDV890ZZVnkXpIFgUmgCtoWFkYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343838; c=relaxed/simple;
	bh=cMhqyg3I0abOJIyvN68huP+M02anUMdFkY1Mf+cKA4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uYBsaUie5YpqhIxJJQr2IEovkTBPL5b7FeUU6wMeDVB4QzlWP4SYIDtPbrBTzUglwH5X76Fw2ntOjF3S9840EKcUnhxpeeND4J9Cn5vJc+XyvPBbg/rg69ywdCNnax8eUef8d46sOeJYMHXz6RRa2ZKE5VgMlhf/L+ju9qA3Pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtfRP6Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80DEC4CEE7;
	Mon, 13 Oct 2025 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343838;
	bh=cMhqyg3I0abOJIyvN68huP+M02anUMdFkY1Mf+cKA4E=;
	h=Subject:To:Cc:From:Date:From;
	b=dtfRP6BijSLFyH7F01k2g0CQCBnV3cjO0/hs1EeGFgDGjZunGZCrQ8Xs+/T9mRcPa
	 R6f0id78NFMM1oZUn8nFp7mQHCNBgbEdD4P1zP3Fy6tJDDqg47IrKiaa6AdBN36Prq
	 Mcjk5M+8fDNQwr2r/2CtY193N2ZrauGEAgz+IPAY=
Subject: FAILED: patch "[PATCH] media: mc: Clear minor number before put device" failed to apply to 5.4-stable tree
To: eadavis@qq.com,hverkuil+cisco@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:23:40 +0200
Message-ID: <2025101340-boned-upright-7693@gregkh>
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
git cherry-pick -x 8cfc8cec1b4da88a47c243a11f384baefd092a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101340-boned-upright-7693@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


