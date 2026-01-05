Return-Path: <stable+bounces-204672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1DCF31EF
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D445301B11A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAF27A907;
	Mon,  5 Jan 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UE4RtWrc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9222B5A5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610900; cv=none; b=Y8wc6Ff+zFdy05w+iBKDizurt2exOvI31rRUCDsb5ee3DqvhxcOYmcp7mXc8yQLB0GfANM/y46h9I/AoW5Gw5oA1qOZzbSmuFf4s1387z2S47XnEuVQ+qaRAB9bPswBNF9egvlLK9m0L54IfiG7p2AWMM51t5wikCCeOwTNyQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610900; c=relaxed/simple;
	bh=BeR+vBDqah0G62oDYYFCDAIXuAlGMpczB/S16m9e8u8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LZ+UkgGfOC83hV8GZgc6oJR1DBI4IsKSc+r9onn88utRb3oNwnhkWEQfWWZsRtI52sp6/o0HvOFr64v2Naz4gg3Ck3dNk1J82VzJgd6RPbeKfxJMstYIhPKurgbiFadFVd2AER4IM1hW2o/bUE0SrqnAqe7cT6bHYecwYY9WEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UE4RtWrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3B4C116D0;
	Mon,  5 Jan 2026 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610899;
	bh=BeR+vBDqah0G62oDYYFCDAIXuAlGMpczB/S16m9e8u8=;
	h=Subject:To:Cc:From:Date:From;
	b=UE4RtWrcW/V2bODw4ig8DDzw66h2i8aco+kkcnKaD513kiclqbFcCX9oXC/GAYVNz
	 +CMyQl1bRzKsgiPKkcVJuDzr3nUwf4tFbgWC0D2KZI3XhnbMo8r3YuV+puDbw3GDwi
	 Mf1rZ1J3Au/HQVJ2w8GIyCyN6J43t/lZ1hrGVykA=
Subject: FAILED: patch "[PATCH] media: mediatek: vcodec: Fix a reference leak in" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,angelogioacchino.delregno@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com,tzungbi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:01:25 +0100
Message-ID: <2026010525-dismiss-bootleg-46f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cdd0f118ef87db8a664fb5ea366fd1766d2df1cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010525-dismiss-bootleg-46f2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


