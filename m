Return-Path: <stable+bounces-204655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E150BCF3204
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02653073FA7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2A32E14D;
	Mon,  5 Jan 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPnEFref"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAF32D452
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610726; cv=none; b=tIgv+e9pEf2y8k+kYOTu1chjAsJEvk3f4oRgvReC4eDQMyRvcBJLc89fRi2AOWd8etq3/6E+uMIK48xkCD6yF5YXWgpTk6jgbp07nZ8TdOoGD5mH6XUij4yINx/W7+w/QKSwbLBqFLaMYPO4yfQ4oBAxwc4yXCW0ttp9w1T9kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610726; c=relaxed/simple;
	bh=s5iW98Gsa+cBDL/p+VUJSsKK1AY9OyWFTJ91hp9ZlDY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tpPi1L1EphFjeWgxSK3u0XDTjEo+8ZWVCyxmflk19Zg+cYceZ5XWCXcw/hCY2jIuRK8y5+Dgr/FOUjDudxRfHy9EZ2870lGHqtUCs9eCENcY/CWEWabjTsZ7BNBF5yqO9xFNlSDzazwe4OC2Aug501xTb6k/Dlztsyi/w0TINeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPnEFref; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BD7C116D0;
	Mon,  5 Jan 2026 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610725;
	bh=s5iW98Gsa+cBDL/p+VUJSsKK1AY9OyWFTJ91hp9ZlDY=;
	h=Subject:To:Cc:From:Date:From;
	b=JPnEFrefW2EQ3NxNsRiT3F0Eo10oxUTHUJrXl8dYvwO/xz3L/3KsNg4vYxokas+2p
	 fR9ZTB4Ibdgm/CA3AJ5iy6UfWnnnxLZiagW3adFOQfnoG9Wi8xCl7Mf22WEH0oBQOa
	 ps+0aDHFL8mx62KUtfp6EIj7LC4xEkpINAa+gBQs=
Subject: FAILED: patch "[PATCH] media: samsung: exynos4-is: fix potential ABBA deadlock on" failed to apply to 5.15-stable tree
To: m.szyprowski@samsung.com,hverkuil+cisco@kernel.org,s.nawrocki@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:58:42 +0100
Message-ID: <2026010542-mockup-flagstone-535a@gregkh>
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
git cherry-pick -x 17dc8ccd6dd5ffe30aa9b0d36e2af1389344ce2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010542-mockup-flagstone-535a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17dc8ccd6dd5ffe30aa9b0d36e2af1389344ce2b Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Tue, 14 Oct 2025 12:46:43 +0200
Subject: [PATCH] media: samsung: exynos4-is: fix potential ABBA deadlock on
 init

v4l2_device_register_subdev_nodes() must called without taking
media_dev->graph_mutex to avoid potential AB-BA deadlock on further
subdevice driver initialization.

Fixes: fa91f1056f17 ("[media] exynos4-is: Add support for asynchronous subdevices registration")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index d6f7601de597..bc7087eb761a 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1399,12 +1399,14 @@ static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
 	mutex_lock(&fmd->media_dev.graph_mutex);
 
 	ret = fimc_md_create_links(fmd);
-	if (ret < 0)
-		goto unlock;
+	if (ret < 0) {
+		mutex_unlock(&fmd->media_dev.graph_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&fmd->media_dev.graph_mutex);
 
 	ret = v4l2_device_register_subdev_nodes(&fmd->v4l2_dev);
-unlock:
-	mutex_unlock(&fmd->media_dev.graph_mutex);
 	if (ret < 0)
 		return ret;
 


