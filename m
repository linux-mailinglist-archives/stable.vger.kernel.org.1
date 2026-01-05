Return-Path: <stable+bounces-204656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6966CF320A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4313075F24
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DB32E12D;
	Mon,  5 Jan 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTGGIWTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E132D451
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610734; cv=none; b=Wom8jk7GDd/zFxpEhbj4K8IMfWJJzI1LHK/ZbrZ+6J2MR1w02UfdpcMaoPXQamZtQOlLnyKnBzpJONFa8pI9IMYdBeUr1uqnr2twbNY5hVK4KGMXm/WAjlW0mMG02sGAdXm5NIF9etWhM7EMOniub3zpfm9vXcxP3kaLV2Vk33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610734; c=relaxed/simple;
	bh=tgU3j94qif2jykHCv8YG9quwIlBaLtw9Jm50tDVKQrE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GK0cE1KFMeTI2dcwf+01KDlz1LrstOgWNgSbF9Zbs8lOSXPLYOmFckiTS0zQWCYZANWezdVoTn7AzwOJ+dIE7ltS6d2jVqcwYZNQN3nb5SD4YUnlPKH6tbjErNLT1+HS5EV8O7dOrx+A7i/p/S8jMsFiQVLZvGQQ3JWZKrooEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CTGGIWTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF05C116D0;
	Mon,  5 Jan 2026 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610733;
	bh=tgU3j94qif2jykHCv8YG9quwIlBaLtw9Jm50tDVKQrE=;
	h=Subject:To:Cc:From:Date:From;
	b=CTGGIWTwkvuNDeSsVPzpUDTfMtj2XRKjuE1IuFb+21F1lUXg82f198FupHwHoMukZ
	 hD37sbeVHwC6jSxXhzQr/v/YlQxnOBOT+2VTBXjxVe9Jf4tRKMnLItUfFjWG+Mp8KK
	 u4qvCYHL2Zrc0HWUlMa1veFjDFWQMKT2/thDdhXo=
Subject: FAILED: patch "[PATCH] media: samsung: exynos4-is: fix potential ABBA deadlock on" failed to apply to 5.10-stable tree
To: m.szyprowski@samsung.com,hverkuil+cisco@kernel.org,s.nawrocki@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:58:42 +0100
Message-ID: <2026010542-dastardly-curfew-2320@gregkh>
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
git cherry-pick -x 17dc8ccd6dd5ffe30aa9b0d36e2af1389344ce2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010542-dastardly-curfew-2320@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


