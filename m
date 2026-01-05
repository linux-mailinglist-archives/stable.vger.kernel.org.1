Return-Path: <stable+bounces-204670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69ECF322E
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E448305D9BC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A631ED95;
	Mon,  5 Jan 2026 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpFYuEUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D274314A65
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610887; cv=none; b=oWJ1vyz/n2r6HGMfXI+mNjl5Tau/gHhkwLyWJ32LY7mjngRrcvY9ul68Ii8vFgzC7R0B07t2pYwfMu59SYBz+lh1ec5v5/Qg/aZs28AzB/l2iQU05KNK2nOVEkH/kUQNu17du8y1we4VDZ7L4RDzxmdPrqgG6gWfZoLIn5yCl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610887; c=relaxed/simple;
	bh=NC7IKAlZC6qBJ0LxPdJcJ2HRz+HvdJIfjRA3rz1m70U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NgMzYL7a9pesNF0USaLuLfKqqfItPchh92p2t9hd77r1S0dGk99fYA4fHGgmZmDIdGW0fr95Rss8BWZgzAyzrkEghKPJROQRiIavG+r8IwjDNXd3FDQu34f4+d25ltdosFw3nZ1twzmB2WyDE4GE0fXAS9d2JFBTEHeF1Xxvqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpFYuEUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC93C116D0;
	Mon,  5 Jan 2026 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610887;
	bh=NC7IKAlZC6qBJ0LxPdJcJ2HRz+HvdJIfjRA3rz1m70U=;
	h=Subject:To:Cc:From:Date:From;
	b=VpFYuEUL8SAAgisrcBfJpXdooij2iK90stGqMqlhcpivifyRsSg1v2OzSd9QaMKo+
	 37PmhNPgiMHgAdlMKOC4+dA8CGlvKfvE9+IMrP88eBptF7eU49alBluBxPsOkonupr
	 5dzalFlHKmGtzzb8vzLEZ81g6P0AVTL+Df8VC7AQ=
Subject: FAILED: patch "[PATCH] media: mediatek: vcodec: Fix a reference leak in" failed to apply to 6.1-stable tree
To: haoxiang_li2024@163.com,angelogioacchino.delregno@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com,tzungbi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:01:24 +0100
Message-ID: <2026010524-anthem-unpainted-c766@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cdd0f118ef87db8a664fb5ea366fd1766d2df1cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010524-anthem-unpainted-c766@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


