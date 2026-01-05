Return-Path: <stable+bounces-204922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071ECF58C3
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40AF302D3B9
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9827F756;
	Mon,  5 Jan 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz5NhrQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595513FEE
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645641; cv=none; b=mQ/XrCej03mtUXJPFOOSRP3lukEu7HCcNHDcHNLyjU8b6rIXuBJ6okv05RQiGfDN+caTiKxT5Lsa7DmpcYTuCaGKXYmBZIZkA5ZGwXiSK5TU9DkGjj4nreh5EC4j390kKyGGXpuifNg6DAesuiLbeJosfpm57Dt5+W00Ri9DaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645641; c=relaxed/simple;
	bh=G3W3qj/RFkmH0HNF1AQ2PRQwXnZu1MEly9kZ21rnPSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecVs3xux8By9eLSvKtmXKZCSknLLEwdmJfIAcfwLyGc7IjPcB3Yu8rGF7icwvPabEI6WgAs17ItO5kWsMw8EiBCoDXj6VxFE5kMjmg8onaI7iptkvmUTXEL7sBgsU1sIHjQC4DR998TX1alD32GU/yWSsUyr9Zy8QIFPD52leeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz5NhrQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD02C116D0;
	Mon,  5 Jan 2026 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645640;
	bh=G3W3qj/RFkmH0HNF1AQ2PRQwXnZu1MEly9kZ21rnPSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tz5NhrQMQ7hpH2Czhq72OGrjNgGsABSSwlI3TBoqeTP+/MVP8VvIBymGvb0bH2XuX
	 BSrlGXs3R6+09Qta6Fm4gv5iQMFJluJaMPDD9U1wifUQHRcrT0ItyJNZx337LltSY6
	 IM48GnMwLITx3hb+oophQn+8xW4eBgkSObacussjwNcZ2zNBz+U1XUl7ls/xRZ4v9k
	 NQb29pbhbZynShklBKmh1RmKDDaoshNV6jAov1jldRG7cFubJ1NTgvG+B6/8i21zo6
	 m4qaNNK8/Ss/AeC5NnJvSQc7krvB5k1fwX8J4QFnYfEKaXe2x/P8I97UsA4bcttj/W
	 syIn6rvBXWjag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: samsung: exynos4-is: fix potential ABBA deadlock on init
Date: Mon,  5 Jan 2026 15:40:38 -0500
Message-ID: <20260105204038.2787172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010542-dastardly-curfew-2320@gregkh>
References: <2026010542-dastardly-curfew-2320@gregkh>
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
index bd37011fb671..2ae2a0aada0d 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1409,12 +1409,14 @@ static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
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


