Return-Path: <stable+bounces-98964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7709E6A8B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7B16CB5C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3EC1EF0B3;
	Fri,  6 Dec 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfXHkRdg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7A1F6681
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477925; cv=none; b=E8IbMU4I64jyRJw2pO6/qTTvN95KEKTS3S/lX1dEXPATRBEBPKrIFn83PZXpug968AG9CKJ61Od5GCjjc3n9M+2/H8c+TAUx4E8/paOdr+xehmL71y6eEtMBB/onfB4L9a6KXHMs6CMFJIJfxS1T8RsSzhHv9NFQ5mN/pbMfoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477925; c=relaxed/simple;
	bh=0ycRC1y1lB6tAemEgu5iVxQKZLSnVsOPLqiJ+socHfs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wa68xlKDB9xiiDw3TTQ8eYb5RjZWNBq4cETbU8Rjv8L1XMZhre+6Uz9wMeAc/b8HcnvBpJNm+WAV35CvJDzw4kHMF9j2UF09nFFyrmX1bPhZJo3k0I0clS+26J4GX2+So0JUgOQCGbNIaaJYK+TZaiocUpOJygnBjJs9VfoM6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfXHkRdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBCCC4CEDE;
	Fri,  6 Dec 2024 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477925;
	bh=0ycRC1y1lB6tAemEgu5iVxQKZLSnVsOPLqiJ+socHfs=;
	h=Subject:To:Cc:From:Date:From;
	b=mfXHkRdgT+/TRmdVDp8O7hWEKIHOmzC0iRBU0nF68lWRMfRUslLuV4kFw/EaCKRwo
	 USTmmvksTGxkDYSrURyfqdxCoJG3DSiSwU0dl6l2nEjBCPHedQr1gIJJknreGmsaFg
	 eb7m3QYrOWJA7BU25DsYS1XlpkxiSTZI2xAp38Lg=
Subject: FAILED: patch "[PATCH] md/raid5: Wait sync io to finish before changing group cnt" failed to apply to 6.6-stable tree
To: xni@redhat.com,song@kernel.org,yukuai3@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 10:38:41 +0100
Message-ID: <2024120641-carat-unwired-140a@gregkh>
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
git cherry-pick -x fa1944bbe6220eb929e2c02e5e8706b908565711
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120641-carat-unwired-140a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa1944bbe6220eb929e2c02e5e8706b908565711 Mon Sep 17 00:00:00 2001
From: Xiao Ni <xni@redhat.com>
Date: Wed, 6 Nov 2024 17:51:24 +0800
Subject: [PATCH] md/raid5: Wait sync io to finish before changing group cnt

One customer reports a bug: raid5 is hung when changing thread cnt
while resync is running. The stripes are all in conf->handle_list
and new threads can't handle them.

Commit b39f35ebe86d ("md: don't quiesce in mddev_suspend()") removes
pers->quiesce from mddev_suspend/resume. Before this patch, mddev_suspend
needs to wait for all ios including sync io to finish. Now it's used
to only wait normal io.

Fix this by calling raid5_quiesce from raid5_store_group_thread_cnt
directly to wait all sync requests to finish before changing the group
cnt.

Fixes: b39f35ebe86d ("md: don't quiesce in mddev_suspend()")
Cc: stable@vger.kernel.org
Signed-off-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20241106095124.74577-1-xni@redhat.com
Signed-off-by: Song Liu <song@kernel.org>

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f5ac81dd21b2..f09e7677ee9f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7176,6 +7176,8 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
+	raid5_quiesce(mddev, true);
+
 	conf = mddev->private;
 	if (!conf)
 		err = -ENODEV;
@@ -7197,6 +7199,8 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 			kfree(old_groups);
 		}
 	}
+
+	raid5_quiesce(mddev, false);
 	mddev_unlock_and_resume(mddev);
 
 	return err ?: len;


