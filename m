Return-Path: <stable+bounces-205531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF5CF9FF5
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14CF32E3B99
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BC238D52;
	Tue,  6 Jan 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9QL3Ya1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB1229B12;
	Tue,  6 Jan 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721002; cv=none; b=A2fz4VCb636pTn5sByngBsJg6SwAIXDRkE8ScgZWghJCeUGbEv5wHLztfDZ3Q1zbsLsb3DQdg08gIf0LoZYRuaKz6O+rEojL9XuoVARUElKqTLVIUax46ra2t8A3Sr8eXWOhp41smq0gHtZIljHQA5DQu/Foe3s/G6QOrMns2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721002; c=relaxed/simple;
	bh=55vX05IW+n7bGrPV0O0hefSQaqPa3oNYS2X8o7+RgBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0QU2jXb5SctnUZMIGuNHH4/bOg6JG+t5itjWgfpzy+xn+zsRf1NnqavRJa4q84Ydm/eaUoNjwwBPQvrfO4K+I4jVXS922w3eYLv/ktd6I5T/3sCoX4kBmjr9tmc5uyDqExV8jJaD0TT2mKUVxirLbCW9KtpLeDjw22mp7ESFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9QL3Ya1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B3C16AAE;
	Tue,  6 Jan 2026 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721002;
	bh=55vX05IW+n7bGrPV0O0hefSQaqPa3oNYS2X8o7+RgBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9QL3Ya1rMKoiFw3IyNORfXl4CeJ0fFtGBvsqedY3rF+4lJxVfMdSYh83IpGIZOeG
	 Z9xWGjUezRboz9BqCaW9ExUTgS30fuDq7nXQamG9ZfBOlYc8hg/SsOz7aJsBSv7u2O
	 0/7RMnRUQLwShc/ZoJMDwniGRy+C9OFgGacWzJu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 406/567] media: samsung: exynos4-is: fix potential ABBA deadlock on init
Date: Tue,  6 Jan 2026 18:03:08 +0100
Message-ID: <20260106170506.362165364@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 17dc8ccd6dd5ffe30aa9b0d36e2af1389344ce2b upstream.

v4l2_device_register_subdev_nodes() must called without taking
media_dev->graph_mutex to avoid potential AB-BA deadlock on further
subdevice driver initialization.

Fixes: fa91f1056f17 ("[media] exynos4-is: Add support for asynchronous subdevices registration")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/samsung/exynos4-is/media-dev.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1410,12 +1410,14 @@ static int subdev_notifier_complete(stru
 	mutex_lock(&fmd->media_dev.graph_mutex);
 
 	ret = fimc_md_create_links(fmd);
-	if (ret < 0)
-		goto unlock;
+	if (ret < 0) {
+		mutex_unlock(&fmd->media_dev.graph_mutex);
+		return ret;
+	}
 
-	ret = v4l2_device_register_subdev_nodes(&fmd->v4l2_dev);
-unlock:
 	mutex_unlock(&fmd->media_dev.graph_mutex);
+
+	ret = v4l2_device_register_subdev_nodes(&fmd->v4l2_dev);
 	if (ret < 0)
 		return ret;
 



