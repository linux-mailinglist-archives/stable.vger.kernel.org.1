Return-Path: <stable+bounces-49194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D68FEC46
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF75B23193
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CE1AED52;
	Thu,  6 Jun 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G786Ri0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB09196DB4;
	Thu,  6 Jun 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683348; cv=none; b=ZbSJolfQ+fxtQYc05skXeN7rLDOrFkIdun6n7sVZgq9dNDOnbzgRkUvEm5rkwF6CXCUzIeuTM4zixKYlOVjW5GsIDd8NlIvhIaa8Nqb8xIKW7Me8aXDpm1k7WdabA4qAlE+uG6S9FS0tAOMbSWfQvdCkdlEAvhPv7N79y7ojVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683348; c=relaxed/simple;
	bh=gKNO321xs9oPsK4JEQdKlPRv9x46YcES/PR49haCKp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8gfmwy9SyXTdlKWcz1aOPRxmhri2lPSsM6hZIcNLFcGoh9kcW2oL9AU7ZYit3fk2KDwmFFLHXS6sDgFNT1mlvtqo4hrFbeWZwJCObkl5DYOU+n6ue90uIjs0+rm2ZzccyZZrzSYOHBvTEdrQ/BhNEl4oBazCIf61bGtf95uwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G786Ri0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5D7C32781;
	Thu,  6 Jun 2024 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683347;
	bh=gKNO321xs9oPsK4JEQdKlPRv9x46YcES/PR49haCKp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G786Ri0WqgNDte+T/2rMbou8IqRAAZo2tzAEEmEtnqvOwEIVTGiGw9+jgv5Qz08Ie
	 Rb1iK6i1JRZ3LbXjv43FUJ3cWKRfwjHD4JdOClG8DGOFGQgHGkmZ6e+KVDdQT1Ds+3
	 q8CzEmO+jESPnSPy+l4A4i8E/uxSl6C7ZY9b5oZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Green <greenjustin@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 288/744] drm/mediatek: Add 0 size check to mtk_drm_gem_obj
Date: Thu,  6 Jun 2024 15:59:20 +0200
Message-ID: <20240606131741.642027693@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Green <greenjustin@chromium.org>

[ Upstream commit 1e4350095e8ab2577ee05f8c3b044e661b5af9a0 ]

Add a check to mtk_drm_gem_init if we attempt to allocate a GEM object
of 0 bytes. Currently, no such check exists and the kernel will panic if
a userspace application attempts to allocate a 0x0 GBM buffer.

Tested by attempting to allocate a 0x0 GBM buffer on an MT8188 and
verifying that we now return EINVAL.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Justin Green <greenjustin@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240307180051.4104425-1-greenjustin@chromium.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 4f2e3feabc0f8..1bf229615b018 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -38,6 +38,9 @@ static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
 
 	size = round_up(size, PAGE_SIZE);
 
+	if (size == 0)
+		return ERR_PTR(-EINVAL);
+
 	mtk_gem_obj = kzalloc(sizeof(*mtk_gem_obj), GFP_KERNEL);
 	if (!mtk_gem_obj)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0




