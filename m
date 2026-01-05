Return-Path: <stable+bounces-204917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72176CF5874
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E74D305575E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C71DF25C;
	Mon,  5 Jan 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYmyVq2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA5224FA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645099; cv=none; b=qlKg6pZTljYxZKC+ZVSrGXGwX2k4m6I2M0Zh3OXBGEaZyf3uMPfr+FGv7aCXAUYeHOVxIFxAyYIjomLxDmJh/jjtpOfpuzZOoht0IOX90xTMwDp08cgYl7eUTEAc8MkPpHZw0NXuwOZV7ze9aCHrX8YiWpWzq6cZ5yX1OllWbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645099; c=relaxed/simple;
	bh=n451obAN2PYyHGlkLqiA0jLD5OjhlKPl3cnGINH3CRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1TXTtzs9fePpqvOG7ta+4QskJPFvNd2GAy4t+/qmO8Ij9K+wRVOtGqVfX5TgqUTTLGng+NN/7yYCSu+bjuXACBYhBLaCAK/NXyEZKfzq+GYF8chhxYxk7NepKvYRC2Sn2XaHyRmRi0lkM2QIT63saOu3f2PMwZ7hXcWEAW4+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYmyVq2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213AC116D0;
	Mon,  5 Jan 2026 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645099;
	bh=n451obAN2PYyHGlkLqiA0jLD5OjhlKPl3cnGINH3CRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYmyVq2sRZRjZnL1YWUFSbg5zndqLcYZBGw7ooq+olAOIsdcEOJ5vlo+RzsopAhAf
	 CApVSuWlk7h1FvEEmzMZw5tvIrVocTkZt+UL5m390WZ625JwXP+Ivi0g1l74QjwmQQ
	 chMBRUsSQbQ7BD6lww9nas++68cbZyQd0p8IUKEO7aQ++wSlrP1p5jWLq38ga/rNju
	 VXItleNCLmnsF8RNW3QGqQ4i1DGeIzm/VJnAsvutWdbaYAuVDZN+G5rW/hxIgTBjUx
	 38WXUSHy820JsHyH1nIuJMnAV/e3P5L+ot8KtFbO/nuXUfQ/nSHGQpg+Nq/82MVveH
	 NhWzqW1v74lcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: samsung: exynos4-is: fix potential ABBA deadlock on init
Date: Mon,  5 Jan 2026 15:31:36 -0500
Message-ID: <20260105203136.2780656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010542-mockup-flagstone-535a@gregkh>
References: <2026010542-mockup-flagstone-535a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 17dc8ccd6dd5ffe30aa9b0d36e2af1389344ce2b ]

v4l2_device_register_subdev_nodes() must called without taking
media_dev->graph_mutex to avoid potential AB-BA deadlock on further
subdevice driver initialization.

Fixes: fa91f1056f17 ("[media] exynos4-is: Add support for asynchronous subdevices registration")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/exynos4-is/media-dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index b19d7c8ddc06..63868d1ae0d0 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1411,12 +1411,14 @@ static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
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
 
-- 
2.51.0


