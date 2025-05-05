Return-Path: <stable+bounces-140851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37DAAAC01
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA22188F992
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D302FA117;
	Mon,  5 May 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRy00zuz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265EA3839C7;
	Mon,  5 May 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486596; cv=none; b=l3RzC20ItiOVH11wjB+dyomKMijK5o3N5Y1yXsSRj73JObeEgBi5n2Fck7d8ZsnBtGWLDSABF/P6nyskktVqRz1NNudZ2OW+KmnraqV0Lt+fxSI8m+jtj20dtd6llbKU7a1kpX26J5WZw2AtNtGvsaDczmwRnjBhlUQCDr8Oc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486596; c=relaxed/simple;
	bh=aC4Ryb65PUyUcR1wICxIFf/qC97GYtcMuJPDYJvv43s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jo4eQQ0jD1qdIfxgl3LXp40CNZio1Ttsdv/vxiKQtGIjJrt494YsVPLXj0z6CXU+fQFZhQ5Di8M29cH52eX0hAs+HpPJRnT8Jydm/xj/vm75nxeb0ZMQlNPRctrK85vTqx6hrS952mfRmO5cFzUNGKMOYb2hrIx8/7snjjEaeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRy00zuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE44C4CEF1;
	Mon,  5 May 2025 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486595;
	bh=aC4Ryb65PUyUcR1wICxIFf/qC97GYtcMuJPDYJvv43s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRy00zuz1OT0enbdh6S/02IpMfXM6AWBVwh0A/0NzT1IZEJejLgwDb80p1HSdKI7u
	 8NVwCVaPtgLlR0GXhFe9vWlU6mAP7WkEJVkeZlI1nxOlGbx/2eJIl9AOTjTVSu7r3G
	 0Wx0fK7YjybojS8aTcY1PShE5DmEXSFa7ZnXVmjWpdZaZZvvT52b7je7T4xUVWgzzJ
	 rWpiLksQUG9I7gQd6ryk52tbf6jO5jBV6SNf2N9w1JbPCH/hTG2J28u5aWYEoTUXgZ
	 4fFeJRkW8/9kgmSvorjMSdlyi4zxvB3dnJYdzrQujbMLa6fGVetUAgmXO3FJ3Yb2oi
	 nJDi4uLR4KLeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>,
	Sasha Levin <sashal@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 108/212] soc: apple: rtkit: Use high prio work queue
Date: Mon,  5 May 2025 19:04:40 -0400
Message-Id: <20250505230624.2692522-108-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Janne Grunau <j@jannau.net>

[ Upstream commit 22af2fac88fa5dbc310bfe7d0b66d4de3ac47305 ]

rtkit messages as communication with the DCP firmware for framebuffer
swaps or input events are time critical so use WQ_HIGHPRI to prevent
user space CPU load to increase latency.
With kwin_wayland 6's explicit sync mode user space load was able to
delay the IOMFB rtkit communication enough to miss vsync for surface
swaps. Minimal test scenario is constantly resizing a glxgears
Xwayland window.

Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Link: https://lore.kernel.org/r/20250226-apple-soc-misc-v2-3-c3ec37f9021b@svenpeter.dev
Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 8ec74d7539eb4..1ec0c3ba0be22 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -731,7 +731,7 @@ static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox_cl.rx_callback = &apple_rtkit_rx;
 	rtk->mbox_cl.tx_done = &apple_rtkit_tx_done;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;
-- 
2.39.5


