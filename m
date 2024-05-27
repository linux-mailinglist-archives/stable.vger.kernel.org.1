Return-Path: <stable+bounces-47376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F58D0DBB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370F41F21911
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26113AD05;
	Mon, 27 May 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHlPE3zL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DA17727;
	Mon, 27 May 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838390; cv=none; b=mcDeEZURl95X1mng5RVA3Md4ljRva5oV8Ievfx9JBZEYcY/xQaYxXMGzFUiZ/6KTxoXL+OOT8lElD+AkThCH8hZgie9ct5pVcMAmHeGH05CnEJhQVEJsojhPAszM1qzWO6PkK97seIpM19L11V1pPBwXQ0Q+VhjQNBtwn/M7E0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838390; c=relaxed/simple;
	bh=n5tgwrA58kOgr0fyflpO2pNO4qpTgejlmyObSnycTE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t21hl5hwMQ3bVRy/Izhh+yEGZmJMk4H/+j5kQNQsjnp+3xfIc3Y+1gXDm8wVjCj8EkOlAKKxDpR6lO5rtD//SsbfrsFKb8lT9IcqW6hgQZynrPTwrdZAkTZdIA3d249LOlZYKrCsxydXCJ6IIzYOMIsZUUzb0VeMKSkP/Zvn7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHlPE3zL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1ABC2BBFC;
	Mon, 27 May 2024 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838390;
	bh=n5tgwrA58kOgr0fyflpO2pNO4qpTgejlmyObSnycTE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHlPE3zLFqGNy+vb8YkVX7Iz6elG3yrcbjXpxLLtA1h8mwqB2Su3VjbiedMC8+t8d
	 WWbLtxddKtUDxv3cw2zVFCAPq/xq6c+kESGzIwMCZmnXBgxcG55R2Y0/nX+KkGf+Uj
	 tdIVzTx+LZ/yBSN9AnTKZMHtRimHlMYvAqncWomg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 374/493] drm/mediatek: Init `ddp_comp` with devm_kcalloc()
Date: Mon, 27 May 2024 20:56:16 +0200
Message-ID: <20240527185642.510155631@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 01a2c5123e27b3c4685bf2fc4c2e879f6e0c7b33 ]

In the case where `conn_routes` is true we allocate an extra slot in
the `ddp_comp` array but mtk_drm_crtc_create() never seemed to
initialize it in the test case I ran. For me, this caused a later
crash when we looped through the array in mtk_drm_crtc_mode_valid().
This showed up for me when I booted with `slub_debug=FZPUA` which
poisons the memory initially. Without `slub_debug` I couldn't
reproduce, presumably because the later code handles the value being
NULL and in most cases (not guaranteed in all cases) the memory the
allocator returned started out as 0.

It really doesn't hurt to initialize the array with devm_kcalloc()
since the array is small and the overhead of initting a handful of
elements to 0 is small. In general initting memory to zero is a safer
practice and usually it's suggested to only use the non-initting alloc
functions if you really need to.

Let's switch the function to use an allocation function that zeros the
memory. For me, this avoids the crash.

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 3d17de34d72bd..d398fa1871165 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -992,10 +992,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 	mtk_crtc->mmsys_dev = priv->mmsys_dev;
 	mtk_crtc->ddp_comp_nr = path_len;
-	mtk_crtc->ddp_comp = devm_kmalloc_array(dev,
-						mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
-						sizeof(*mtk_crtc->ddp_comp),
-						GFP_KERNEL);
+	mtk_crtc->ddp_comp = devm_kcalloc(dev,
+					  mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
+					  sizeof(*mtk_crtc->ddp_comp),
+					  GFP_KERNEL);
 	if (!mtk_crtc->ddp_comp)
 		return -ENOMEM;
 
-- 
2.43.0




