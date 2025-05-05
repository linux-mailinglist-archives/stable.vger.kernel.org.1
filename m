Return-Path: <stable+bounces-140601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538CAAAE50
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D9116BAED
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3132D3808;
	Mon,  5 May 2025 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omo0CiHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00752D3806;
	Mon,  5 May 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485241; cv=none; b=H43kmUCslqyyhEmXkXZ+ZTCGkP9eb1wbuaQMa5A7kuqLpli6Z8DoxYATmEAtb2zAJQYm/AvM4UJ72Sn0EsuHni6ab9XPYyHS9/zMAjFBtpLVyhiIUq56PG/E8oyCtoqI1ymRsnW++xFC7RqnYw4BYThj2Z30D6Bub3E4l/paKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485241; c=relaxed/simple;
	bh=ibdy/rtIaou04q3IrNpDo1noO5Avp/t2atPZu9N7z+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhL6eH/6ySicP2BhCYdPsby2FZaFbwFlz3J7EmLWZGUKk7dOZDPg2oxiWucaMs1T5Lk/J7pdSU5s3xehg8MJzok0h975Xbo4nAAsWS8IGo756W+h0GqH1g8sdmwgqAmfOBjxv7/vpcl86n/4xHNP82+KlVfU59hq3Z7sMRIXIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omo0CiHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED419C4CEE4;
	Mon,  5 May 2025 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485239;
	bh=ibdy/rtIaou04q3IrNpDo1noO5Avp/t2atPZu9N7z+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Omo0CiHWdBxm11fRMEf6gFqOBHMDylgYa6rhaWJ9M+PGVqOvkECYjm57KlYK+GLtj
	 +0YdSaofWdy2xU8nVw4sOoF7GtSczxCBVFmKGcah93dGqEoKKNhCfu6SvsBF1+r2K1
	 Ep1DW17oepupKbLshB+lk5X8Pj3qskr37L7uuWxtY0X1w9bGxzHzMleHqeDCHxgiZ2
	 Xos53BNmxjz/B2UZdc2OWTjde94Nfc7u+lukcsTAwnjdoDdc08rvwaIg8OSdzjMeDk
	 w3eGv7aORB5IzAwbEPT4vf1u6MwjsMfDj+gVU2J6uVIZ24EbNWHbMGB5m6Mi5hIGDF
	 tVAa3D4KCBIeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>,
	Sasha Levin <sashal@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 229/486] soc: apple: rtkit: Use high prio work queue
Date: Mon,  5 May 2025 18:35:05 -0400
Message-Id: <20250505223922.2682012-229-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


