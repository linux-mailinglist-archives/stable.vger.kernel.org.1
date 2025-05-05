Return-Path: <stable+bounces-140037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC87AAA446
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4544E3BCD91
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D82FCA6A;
	Mon,  5 May 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCTZsPnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571A2FCA60;
	Mon,  5 May 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483957; cv=none; b=lbMGxHO8z+5ZMrE+QF6JscLZhpAjqhFQjH1BIW9uZRuPJh8WeRyAgc3MkMg0eORGiWZeE4SGR36reLK4XaRzveOLLCNN+CrEON/ipbzeM3ciAe98eSTdiF+KrTfZsw16GOXs8UxcACxMJ+ywOxFnySDbbrhOabnIMaD4FJJay/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483957; c=relaxed/simple;
	bh=ibdy/rtIaou04q3IrNpDo1noO5Avp/t2atPZu9N7z+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPnKjLfDCERd5giqALhUy+M0SHyZzXcBW7YUDcBz0sMtU2pUY8Trp3OlSMm/Z8O5nAawgXJoQQfMDbl4/XoO861nR9KXca/tBNJTeyOjykUoOtiNNrYr7Tqq8R4X7QlXCSUmJb7wAh3p9BJGCzRc6RO8sRzplfpl26nyg2CJji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCTZsPnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F675C4CEEF;
	Mon,  5 May 2025 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483957;
	bh=ibdy/rtIaou04q3IrNpDo1noO5Avp/t2atPZu9N7z+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCTZsPnZyaI0TQDf4PpQ2rvAJg9+mcoz9ebK0KvYAkU7U0jlKlO7G7YZaPXpS/oxI
	 FuMI7D0cIV4FeQPi8/x/rV92lyIVdnRAuOEv1ipU2MpJ/coOQxyCwx0oblRo4cNaft
	 AHjbxnVQ+QePcWzbpw+Z5zocafGQiiBQQBoLzxIc7fbAQE6bswTSHL/FF5Sc0QsRz2
	 QtPRQxqVvMlLSz03aU+7DB1uNpxcvUwGcDangHEudCEs7ImasE+3wLWzZfUaJKZ1ry
	 HaW7b3kRWO3ZFxaBhXuBCiE1nefP2qEUEEhVqdfn6k7cJMsQZTYEbQAHiNgF+GuHET
	 ygSBEHZZmH+Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>,
	Sasha Levin <sashal@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 290/642] soc: apple: rtkit: Use high prio work queue
Date: Mon,  5 May 2025 18:08:26 -0400
Message-Id: <20250505221419.2672473-290-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e6d940292c9fb..00d59a81db88b 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -667,7 +667,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox->rx = apple_rtkit_rx;
 	rtk->mbox->cookie = rtk;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;
-- 
2.39.5


