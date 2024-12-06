Return-Path: <stable+bounces-99099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D99E7034
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508A51886C17
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4514EC60;
	Fri,  6 Dec 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2FjQjyaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF214D6E1;
	Fri,  6 Dec 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495994; cv=none; b=XWK2UEKzWojrnWy+OIoSnfXyp56i2yidsiP9Wt7EvshSv9GcPUqSN0vrq+tUISv9yc3HTOWK6icKs1hRRnLcYuf0hPHAbp5urOVesIGNDW9DhV9Q6ne7IdWr6zMFYpc3MFHsLpZMO5e9V5DZ6DBZ2ysuEYGiGc4vL/HsHbFW5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495994; c=relaxed/simple;
	bh=IQha/wV6w3EU/XN6FOhxrWPhvbrtwfyE6kSEjxktVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toAfdBItbuQ35sat2ZHjfJ32FclqG0XDrJgkukNbbaUqePB9MrO2TyiIzJbXYXkk0jIo3Fbx+zsIx1ZVW5pjb4uhsJrF0JakfcQTsEBgC1qznnPai1BBQZWVW5FSUGaDUVSpyom9QwPMe+B5E42gnTvwawsKupnR9+jPvVPp3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2FjQjyaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61913C4CED1;
	Fri,  6 Dec 2024 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733495993;
	bh=IQha/wV6w3EU/XN6FOhxrWPhvbrtwfyE6kSEjxktVvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2FjQjyaIgXdgqGPxWr4NI3X9mwCZpt9PP3jhlcqOOagy7fHUuAiPPXpHs1hXSyz3B
	 n9HdO5Kt0pMxYxm4jgc5uKYpT6lkb73PPGO+jKT1EZJfjdWu9UfE7foV1mUkBhDlDU
	 Hps5LuOBPuGPq0HAqDADMjdPWcVXNE7rMVwlrLDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guoqing Jiang <guoqing.jiang@canonical.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.12 022/146] media: mtk-jpeg: Fix null-ptr-deref during unload module
Date: Fri,  6 Dec 2024 15:35:53 +0100
Message-ID: <20241206143528.521436287@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
References: <20241206143527.654980698@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Guoqing Jiang <guoqing.jiang@canonical.com>

commit 17af2b39daf12870cac61ffc360e62bc35798afb upstream.

The workqueue should be destroyed in mtk_jpeg_core.c since commit
09aea13ecf6f ("media: mtk-jpeg: refactor some variables"), otherwise
the below calltrace can be easily triggered.

[  677.862514] Unable to handle kernel paging request at virtual address dfff800000000023
[  677.863633] KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
...
[  677.879654] CPU: 6 PID: 1071 Comm: modprobe Tainted: G           O       6.8.12-mtk+gfa1a78e5d24b+ #17
...
[  677.882838] pc : destroy_workqueue+0x3c/0x770
[  677.883413] lr : mtk_jpegdec_destroy_workqueue+0x70/0x88 [mtk_jpeg_dec_hw]
[  677.884314] sp : ffff80008ad974f0
[  677.884744] x29: ffff80008ad974f0 x28: ffff0000d7115580 x27: ffff0000dd691070
[  677.885669] x26: ffff0000dd691408 x25: ffff8000844af3e0 x24: ffff80008ad97690
[  677.886592] x23: ffff0000e051d400 x22: ffff0000dd691010 x21: dfff800000000000
[  677.887515] x20: 0000000000000000 x19: 0000000000000000 x18: ffff800085397ac0
[  677.888438] x17: 0000000000000000 x16: ffff8000801b87c8 x15: 1ffff000115b2e10
[  677.889361] x14: 00000000f1f1f1f1 x13: 0000000000000000 x12: ffff7000115b2e4d
[  677.890285] x11: 1ffff000115b2e4c x10: ffff7000115b2e4c x9 : ffff80000aa43e90
[  677.891208] x8 : 00008fffeea4d1b4 x7 : ffff80008ad97267 x6 : 0000000000000001
[  677.892131] x5 : ffff80008ad97260 x4 : ffff7000115b2e4d x3 : 0000000000000000
[  677.893054] x2 : 0000000000000023 x1 : dfff800000000000 x0 : 0000000000000118
[  677.893977] Call trace:
[  677.894297]  destroy_workqueue+0x3c/0x770
[  677.894826]  mtk_jpegdec_destroy_workqueue+0x70/0x88 [mtk_jpeg_dec_hw]
[  677.895677]  devm_action_release+0x50/0x90
[  677.896211]  release_nodes+0xe8/0x170
[  677.896688]  devres_release_all+0xf8/0x178
[  677.897219]  device_unbind_cleanup+0x24/0x170
[  677.897785]  device_release_driver_internal+0x35c/0x480
[  677.898461]  device_release_driver+0x20/0x38
...
[  677.912665] ---[ end trace 0000000000000000 ]---

Fixes: 09aea13ecf6f ("media: mtk-jpeg: refactor some variables")
Cc: <stable@vger.kernel.org>
Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   10 ++++++++++
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |   11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1293,6 +1293,11 @@ static int mtk_jpeg_single_core_init(str
 	return 0;
 }
 
+static void mtk_jpeg_destroy_workqueue(void *data)
+{
+	destroy_workqueue(data);
+}
+
 static int mtk_jpeg_probe(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg;
@@ -1337,6 +1342,11 @@ static int mtk_jpeg_probe(struct platfor
 							  | WQ_FREEZABLE);
 		if (!jpeg->workqueue)
 			return -EINVAL;
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       mtk_jpeg_destroy_workqueue,
+					       jpeg->workqueue);
+		if (ret)
+			return ret;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -578,11 +578,6 @@ static int mtk_jpegdec_hw_init_irq(struc
 	return 0;
 }
 
-static void mtk_jpegdec_destroy_workqueue(void *data)
-{
-	destroy_workqueue(data);
-}
-
 static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 {
 	struct mtk_jpegdec_clk *jpegdec_clk;
@@ -606,12 +601,6 @@ static int mtk_jpegdec_hw_probe(struct p
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       mtk_jpegdec_destroy_workqueue,
-				       master_dev->workqueue);
-	if (ret)
-		return ret;
-
 	spin_lock_init(&dev->hw_lock);
 	dev->hw_state = MTK_JPEG_HW_IDLE;
 



