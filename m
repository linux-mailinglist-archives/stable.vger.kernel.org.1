Return-Path: <stable+bounces-141395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB7AAB31B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9623117B3EA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B76218580;
	Tue,  6 May 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgMepI4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086138AC6C;
	Mon,  5 May 2025 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486067; cv=none; b=sgZ8CuTl+bKL0fuh/FIEpY6FI9QrfcgtonORonhCjFCN4ZvCmVKvFSGFxPeWcg2Cns2voFfdWQxTMs33JSEdkG/gplJlh+kVwjSdbIZ9HxlJhxrgWn195LNx4LVkFoRIachh/o++df/2+MnZzYoTzJihhFZjZ3QWibP+4/KxhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486067; c=relaxed/simple;
	bh=5yO9rPWl3hIFnTuUWhLDF/4xFnNTBhL48tCp6o5L4sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlLuz/BKfuh3AW9K6fQYA5uL6wXxdbtRNgEwuJAa8kBs8JE2FZ/7+iy0MqGZcEHTFP8pwAWKw2NKXU72M3Q6l8sIIgrkcpVjROYgwh7gTV2SoWgB9QJGkHPHGNg3x90SnOftyYJQSR7T+KfvOHRmeqlU22ogc6Xy9i6qX20Fxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgMepI4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAEFC4CEF5;
	Mon,  5 May 2025 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486067;
	bh=5yO9rPWl3hIFnTuUWhLDF/4xFnNTBhL48tCp6o5L4sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgMepI4F+tf4SB4itda1omNx27oY6rJpuHNxoqvTeL3pDWl8aYDODTaHfyATrhEYX
	 E6p1Qimna5dmVMgPRG4914FQ7sBtWoYp9arztd5eYlZwMR9J85pZOhkqIecD//XgVn
	 bUvmr7HzTRgBmR5a1jxtBuNZuSdq6xRpBAxfxoTqKE/wz7FEucK0WqzDZaN9Sc0J7k
	 WilZZQDRI17GLk9l+88W1kwyRoubY7bPg4rO4KNPXPOr1Qe3bJ3fBnRtX9zCqTNb7s
	 QVhW86HhsmbKl079xFbH2mDjKEHHtMcvAfB0j3D+rpGXJ1SilfJ4fIfYBiDF80u4dP
	 VepnWYktqsZYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>,
	Sasha Levin <sashal@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 137/294] soc: apple: rtkit: Use high prio work queue
Date: Mon,  5 May 2025 18:53:57 -0400
Message-Id: <20250505225634.2688578-137-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index d9f19dc99da5e..b9c5281c445ee 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -744,7 +744,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox_cl.rx_callback = &apple_rtkit_rx;
 	rtk->mbox_cl.tx_done = &apple_rtkit_tx_done;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;
-- 
2.39.5


