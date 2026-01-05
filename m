Return-Path: <stable+bounces-204671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35AACF31DE
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CAF63007498
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0832F5487;
	Mon,  5 Jan 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ys+yQqAx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC9242D88
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610896; cv=none; b=YCTYCqeutA+d497rQofR+OOnwAR7ShNGz0E5VRD9/Ndss9JxB6giiOoP+ncjwn7to6gccgIFTdltnxRHJlpHdvbr+v8SVIEtdG2DZ0SoR1Oz8XeG3TKdM9SIfYSkJGMSof8greyWkZ6zJNV1YkUb2uHzstIdhfqwQwZnbnxwjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610896; c=relaxed/simple;
	bh=Xns+3EGsVaSQRDGjGA6goPtS1KsxP1yobLBmfMJ51GI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hn8kOjwoYnNF5jO9DeDuRzsEUK9ODPBdm0YzuyLp+4eghq+yspP5ZBxgI8/K+EmlHT2bv2sz22mgVL9gqiArgxFKpfcAT2x+UbOX96ul7OV47XMEKufx0ODGr0Tc9TQsSLoDr4WRkB/vZED6KgyxgMPmKsiKpZjO0kE5pYwPFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ys+yQqAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5370C116D0;
	Mon,  5 Jan 2026 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610896;
	bh=Xns+3EGsVaSQRDGjGA6goPtS1KsxP1yobLBmfMJ51GI=;
	h=Subject:To:Cc:From:Date:From;
	b=Ys+yQqAxmL9A/3nu6CZZDeDHp8KiR9NtUoZJxKhK36ZpaE9kGyIq5P0hKE2jJDP7J
	 3U+hLwdpgctUQUd7htFv8s0MPG/wLL1Y8qEqcgBcY2ZjkV8ntRydSk+wxOdpAtK4XY
	 WqNEgjC3oF7uWZfoERty1rJ/sQhnhIoovF39ehyA=
Subject: FAILED: patch "[PATCH] media: mediatek: vcodec: Fix a reference leak in" failed to apply to 5.15-stable tree
To: haoxiang_li2024@163.com,angelogioacchino.delregno@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com,tzungbi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:01:24 +0100
Message-ID: <2026010524-rarity-cardboard-387f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cdd0f118ef87db8a664fb5ea366fd1766d2df1cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010524-rarity-cardboard-387f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cdd0f118ef87db8a664fb5ea366fd1766d2df1cd Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Mon, 15 Sep 2025 20:09:38 +0800
Subject: [PATCH] media: mediatek: vcodec: Fix a reference leak in
 mtk_vcodec_fw_vpu_init()

vpu_get_plat_device() increases the reference count of the returned
platform device. However, when devm_kzalloc() fails, the reference
is not released, causing a reference leak.

Fix this by calling put_device() on fw_pdev->dev before returning
on the error path.

Fixes: e25a89f743b1 ("media: mtk-vcodec: potential dereference of null pointer")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 223fb2294894..3632037f78f5 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -119,8 +119,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_enc_handler, priv, rst_id);
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		put_device(&fw_pdev->dev);
 		return ERR_PTR(-ENOMEM);
+	}
 	fw->type = VPU;
 	fw->ops = &mtk_vcodec_vpu_msg;
 	fw->pdev = fw_pdev;


