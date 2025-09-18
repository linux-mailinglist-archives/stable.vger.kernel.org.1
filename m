Return-Path: <stable+bounces-175428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A1B36865
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB72D1C24F53
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83351352FC1;
	Tue, 26 Aug 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HS1qUC7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE72FDC5C;
	Tue, 26 Aug 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217016; cv=none; b=Zargy+bRJoAX0PBbEgNDC/S6h97uKrdRaU1q3H8ZLmdFfBzaFfsMlaMjYjxyJs+nlle79B4YKEGyoZ/x6LYD2Of555TPKr0l/viKVhblwZSBlYtQugR0Ql+h1bvFhmekwpJvjg59VvEUyHC0eQJTqJdR37Da6qI3jf/OGHQQze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217016; c=relaxed/simple;
	bh=vt2C1eB2aGzyyc7xo1yGtqI+vCxc3crNrEXKM/J45I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9x7ZrXVjpuFtoNL+KFMNkq3MEvTaU+HPNDMawYCDjvxKfpVk7a8+wA0U9s+uQYO1ydLUEyFZCg83tvVZfYeCaLMlNUdVNEswpFmW4DJ7NKdEBFO16YDxUDQp47azf2IsJPqVtqtE0l/kA2OX1SKMwAlzsM7Uxam2fxc7PUFUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HS1qUC7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6046C4CEF1;
	Tue, 26 Aug 2025 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217016;
	bh=vt2C1eB2aGzyyc7xo1yGtqI+vCxc3crNrEXKM/J45I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HS1qUC7bEE4hwaM/C2ELqszMFyKTeeNK2FvpzA4UzEbmcQkhujz4I7ByutnhDLZ7O
	 ZZWnHRxeFro9yc1eGHYIS5ZDhYcDoJCVewRKCDjwVA9JvIfBU4vtQebatFN6TsqWr3
	 jHcgrIFiGYs21+rtLEokJTWXZIGNb3iOkhOxujRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baihan Li <libaihan@huawei.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 627/644] drm/hisilicon/hibmc: fix the hibmc loaded failed bug
Date: Tue, 26 Aug 2025 13:11:58 +0200
Message-ID: <20250826111002.094737325@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baihan Li <libaihan@huawei.com>

[ Upstream commit 93a08f856fcc5aaeeecad01f71bef3088588216a ]

When hibmc loaded failed, the driver use hibmc_unload to free the
resource, but the mutexes in mode.config are not init, which will
access an NULL pointer. Just change goto statement to return, because
hibnc_hw_init() doesn't need to free anything.

Fixes: b3df5e65cc03 ("drm/hibmc: Drop drm_vblank_cleanup")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250813094238.3722345-5-shiyongbang@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 610fc8e135f9..7d0edecfc495 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -268,12 +268,12 @@ static int hibmc_load(struct drm_device *dev)
 
 	ret = hibmc_hw_init(priv);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0), priv->fb_size);
 	if (ret) {
 		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = hibmc_kms_init(priv);
-- 
2.50.1




