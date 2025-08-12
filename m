Return-Path: <stable+bounces-168574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723DB235B7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902521A246F1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC412ECE85;
	Tue, 12 Aug 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z2rUXylI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF4247287;
	Tue, 12 Aug 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024629; cv=none; b=BRWdFcu6Q5d3Pw/kxNcRMQtG9mqr+WG+uOOg8HSwpKpux4DT89FlgfKq2/1GY6micIfq9aqZzFhaFOAEb40paqwrj0mjnM8PXmpUdAYljIwW40eInXQzgVFhV3s5gtm3PkmDPmSqxgZpNC9Xj1tV3ZZ1K+bT/3AWiEoNHxnhKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024629; c=relaxed/simple;
	bh=V1KIyN8OxyxTgwVJl+Hx6dkQqkUyijbBxfcKlQfgl4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/KI2d7qliSOljpn0F8QZ96vShJrOSZeeooMMTokUmefql63uH9agrdd0w+aA6pD1+6i+j5P6U3fWD9Va4yqBcnf8oYmvmqEFP4rDjm0fP95K3OuCJ2tMNS0eico2+ZLSA+zfLh7vLrWZRkQT92BdZg9rsADjnNpxKvmzg3L7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z2rUXylI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECE6C4CEF0;
	Tue, 12 Aug 2025 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024628;
	bh=V1KIyN8OxyxTgwVJl+Hx6dkQqkUyijbBxfcKlQfgl4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2rUXylI4u3HiKitGomute/its7imSfpo7fgjCqzH5FO5wnm8znef6HVINBgIXpkD
	 aXdRjViwsfgHlwQPNBOuuH2QxKS+tYTCsvMXUuyvyc5BjVuM/pHlTkl/71kufsocX/
	 hcgQy5F10sIQaIPa+kBWJY+GGkTr9snMk6guMZJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 430/627] fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref
Date: Tue, 12 Aug 2025 19:32:05 +0200
Message-ID: <20250812173435.628909589@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit da11e6a30e0bb8e911288bdc443b3dc8f6a7cac7 ]

fb_add_videomode() can fail with -ENOMEM when its internal kmalloc() cannot
allocate a struct fb_modelist.  If that happens, the modelist stays empty but
the driver continues to register.  Add a check for its return value to prevent
poteintial null-ptr-deref, which is similar to the commit 17186f1f90d3 ("fbdev:
Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var").

Fixes: 1b6c79361ba5 ("video: imxfb: Add DT support")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imxfb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index f30da32cdaed..a077bf346bdf 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -996,8 +996,13 @@ static int imxfb_probe(struct platform_device *pdev)
 	info->fix.smem_start = fbi->map_dma;
 
 	INIT_LIST_HEAD(&info->modelist);
-	for (i = 0; i < fbi->num_modes; i++)
-		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+	for (i = 0; i < fbi->num_modes; i++) {
+		ret = fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add videomode\n");
+			goto failed_cmap;
+		}
+	}
 
 	/*
 	 * This makes sure that our colour bitfield
-- 
2.39.5




